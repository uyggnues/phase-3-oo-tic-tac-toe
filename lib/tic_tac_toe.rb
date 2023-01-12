require 'pry'

class TicTacToe
    def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1 # this is when we recieve a position from a player to correct the index position
  end

  def move(index, sign)
    @board[index] = sign # assigning what sign(X or O) should go in the position(index) 
  end

  def position_taken?(index)
    @board[index] != " " # returning true if the position of the board (based on the index) is not equal to " "
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0,8) # flipping the boolean value of position_taken? and seeing if it is between the @board boundaries
  end

  def turn_count
    @board.count{|square| square != " " } # counting whatever "square" is not an " " and returning a number
  end

  def current_player
    turn_count.even? ? "X" : "O" # if the turn_count is evem then it is "X" turn if not "O" turn
  end

  def turn
    puts "Please enter a number 1-9: " # asks player where to put their sign 
    input = gets.strip # gets the input and strips it ex) "1\n" => "1"
    index = input_to_index(input) # input_to_index turns the human position to computer position
    if valid_move?(index) # if it is a vaild move
        sign = current_player # then assign the sign  to "X" or "O" according to current_player
        move(index, sign) # then run move(index, sign)
    else
        turn # then asks the question again for the next player
    end
    display_board # displays the board
  end

  def won?
    WIN_COMBINATIONS.any? do |combo| # look thru WIN_COMBINATIONS and check if any of them return true when ran by the code below
        if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]] # if when combo[index] in ran thru position_taken? and return true and the first position in the combo in the board's sign == to the secong position in the combo in the board'd sign AND the second position in the combo in the in the board's sign  == to the third position in the combo in the board's sign then return TRUE
            return combo # if returned yes then display the winning combo
        end
    end
  end

  def full?
    @board.all?{|square| square != " " }
  end

  def draw?
    !won? && full?
  end

  def over?
    draw? || won?
  end

  def winner
    if combo = won?
        @board[combo[0]]
    end
  end

  def play
    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end
end

# binding.pry
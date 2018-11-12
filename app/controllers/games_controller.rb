require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = []
    10.times { @grid << Array('A'..'Z').sample }
    @grid
  end

  def dictionary?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    open_url = open(url).read
    json_reply = JSON.parse(open_url)
    json_reply["found"]
  end

  def score
    @word = params[:word]
    @grid = params[:grid]
    validation =  @word.upcase.chars.all? { |letter| @word.upcase.count(letter) <= @grid.count(letter) }
    if validation && dictionary?(@word)
      @result = "Congratulations #{@word} is a valid English word"
    elsif dictionary?(@word) == false
      @result = "Sorry but #{@word} is not an english word"
    else
      @result = "Sorry but #{@word} can't be built out of #{@grid}"
    end
  end
end

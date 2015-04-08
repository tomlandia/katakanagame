english = $('#english')
katakana = $('#katakana')
togo_text = $('#togo')
togo = 50
starttime = 0

kanadict = {}
randomwords = []
$.getJSON 'kanadict.json', (response) ->
    kanadict = response
    randomwords = Object.keys(kanadict)
    #shuffle
    for i in [randomwords.length-1..1]
        j = Math.floor Math.random() * (i + 1)
        [randomwords[i], randomwords[j]] = [randomwords[j], randomwords[i]]

nextword = ->
    togo_text.text("#{togo} to go")
    english.val('')
    english.focus()
    katakana.unbind('mouseenter mouseleave') #gonna fight rikai*?
    katakana.text(randomwords.pop())

submit = ->
    switch english.val().toLowerCase().replace(' ', '')
        when 'start' then [togo, starttime] = [50, new Date().getTime()]
        when kanadict[katakana.text()] then togo = togo - 1
        else togo = togo + 2
    if togo == 0
        time_ellapsed = Math.round((new Date().getTime() - starttime) / 1000)
        togo_text.text("Done in #{time_ellapsed} seconds!")
    else
        nextword()
    return

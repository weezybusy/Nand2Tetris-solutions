// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

(RESET)
	@SCREEN   // read screen starting point address
	D=A

	@register // set register to the starting point of the screen
	M=D

(CHECK_KBD)
	@KBD      // listen to keyboard for input
	D=M

	@WHITEN   // if (no input) goto WHITEN, else goto BLACKEN
	D;JEQ

(BLACKEN)
	@color    // set color to black
	M=-1

	@SET      // goto SET and apply the color
	0;JMP

(WHITEN)
	@color    // set color to white
	M=0

	@SET      // goto SET and apply the color
	0;JMP

(SET)
	@color    // read color
	D=M

	@register // paint the current register
	A=M
	M=D

	@register // increment register
	MD=M+1

	@KBD      // check if we're not out of the screen memory
	D=A-D

	@SET      // if (not out of memory) paint next register
	D;JGT

	@RESET    // else goto RESET and set screen to starting point
	0;JMP

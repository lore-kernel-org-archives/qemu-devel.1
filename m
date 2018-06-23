Received: from eggs.gnu.org ([2001:4830:134:3::10]:41327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWqXT-0007CF-Uz
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWqXP-0003ZQ-OO
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:57:48 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWqXP-0003Yv-K2
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 17:57:43 -0400
Received: by mail-qk0-x242.google.com with SMTP id b66-v6so127998qkj.1
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 14:57:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180623215313.1252-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2f6b05fd-afb3-cc8d-6b3d-011e2fd87c47@amsat.org>
Date: Sat, 23 Jun 2018 18:57:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180623215313.1252-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add debian-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 06/23/2018 06:53 PM, Philippe Mathieu-Daudé wrote:
> Xtensa cpu supported:
> - dc232b
> - dc233c
> - csp
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> based on http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06782.html
> 
> Max: Do we need to use the overlay configuration?
> 
> This image allow the build of your dc232b tests (using [1]):
> 
> $ make check-tcg
> ...
>   CC      vl.o
>   CC      qmp.o
>   LINK    xtensa-softmmu/qemu-system-xtensa
>   BUILD   debian-xtensa-cross
>   BUILD   TCG tests for xtensa-softmmu
>   CHECK   debian-xtensa-cross
>   BUILD   xtensa guest-tests with docker qemu:debian-xtensa-cross
>   RUN     TCG tests for xtensa-softmmu
>   CHECK   debian-xtensa-cross
>   BUILD   xtensa guest-tests with docker qemu:debian-xtensa-cross
> $ file xtensa-softmmu/tests/*tst
> xtensa-softmmu/tests/test_bi.tst:        ELF 32-bit LSB executable, Tensilica Xtensa, version 1 (SYSV), statically linked, not stripped
> xtensa-softmmu/tests/test_break.tst:     ELF 32-bit LSB executable, Tensilica Xtensa, version 1 (SYSV), statically linked, not stripped
> ...
> xtensa-softmmu/tests/test_timer.tst:     ELF 32-bit LSB executable, Tensilica Xtensa, version 1 (SYSV), statically linked, not stripped
> xtensa-softmmu/tests/test_windowed.tst:  ELF 32-bit LSB executable, Tensilica Xtensa, version 1 (SYSV), statically linked, not stripped
> 
> [1]: https://github.com/philmd/qemu/tree/testing/gcov-and-other-build-tweaks-v1c

Max, some tests never end, is that normal?

$ make check-tcg
...
  CC      vl.o
  CC      qmp.o
  LINK    xtensa-softmmu/qemu-system-xtensa
  BUILD   debian-xtensa-cross
  BUILD   TCG tests for xtensa-softmmu
  CHECK   debian-xtensa-cross
  BUILD   xtensa guest-tests with docker qemu:debian-xtensa-cross
  RUN     TCG tests for xtensa-softmmu
  CHECK   debian-xtensa-cross
  BUILD   xtensa guest-tests with docker qemu:debian-xtensa-cross
  RUN     tests for xtensa
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) info registers
PC=00007fff

        LBEG=d0001b1c         LEND=d0001b26       LCOUNT=00000000
  SAR=00000000
     LITBASE=00000000    SCOMPARE1=00000000        ACCLO=00000000
ACCHI=00000000
         MR0=00000000          MR1=00000000          MR2=00000000
  MR3=00000000
 WINDOW_BASE=00000000 WINDOW_START=00000001     PTEVADDR=80000000
 MMID=00000000
       RASID=04030201      ITLBCFG=00000000      DTLBCFG=00000000
IBREAKENABLE=00000000
      MEMCTL=00000000          DDR=00000000     IBREAKA0=00000000
IBREAKA1=00000000
    DBREAKA0=00000000     DBREAKA1=00000000     DBREAKC0=00000000
DBREAKC1=00000000
   CONFIGID0=c56307fe         EPC1=000019f9         EPC2=00000000
 EPC3=00000000
        EPC4=00000000         EPC5=00000000         EPC6=00000000
 EPC7=00000000
        DEPC=d000128a         EPS2=00000000         EPS3=00000000
 EPS4=00000000
        EPS5=00000000         EPS6=00000000         EPS7=00000000
CONFIGID1=0d40beef
    EXCSAVE1=0004004f     EXCSAVE2=00000000     EXCSAVE3=00000000
EXCSAVE4=00000000
    EXCSAVE5=00000000     EXCSAVE6=00000000     EXCSAVE7=00000000
CPENABLE=00000000
      INTSET=00000000     INTCLEAR=00000000    INTENABLE=00000000
   PS=0004000f
     VECBASE=d0000000     EXCCAUSE=00000018   DEBUGCAUSE=00000000
CCOUNT=00000000
        PRID=00000000       ICOUNT=00000000  ICOUNTLEVEL=00000000
EXCVADDR=00400001
   CCOMPARE0=00000000    CCOMPARE1=00000000    CCOMPARE2=00000000
MISC0=00000000
       MISC1=00000000        MISC2=00000000        MISC3=00000000

EXPSTATE=00000000 THREADPTR=00000000

 A00=d000058d  A01=00000018  A02=00007fff  A03=00008000
 A04=00000006  A05=00000000  A06=00000000  A07=00000000
 A08=00000000  A09=00000000  A10=00000000  A11=00000000
 A12=00000000  A13=00000000  A14=00000000  A15=00000000

AR00=d000058d AR01=00000018 AR02=00007fff AR03=00008000 <=
AR04=00000006 AR05=00000000 AR06=00000000 AR07=00000000
AR08=00000000 AR09=00000000 AR10=00000000 AR11=00000000
AR12=00000000 AR13=00000000 AR14=00000000 AR15=00000000
AR16=00000000 AR17=00000000 AR18=00000000 AR19=00000000
AR20=00000000 AR21=00000000 AR22=00000000 AR23=00000000
AR24=00000000 AR25=00000000 AR26=00000000 AR27=00000000
AR28=00000000 AR29=00000000 AR30=00000000 AR31=00000000
# on another terminal: killall -9 qemu-system-xtensa
make[2]: *** [/source/qemu/tests/tcg/xtensa/Makefile.system:76:
run-test_mmu.tst] Killed
make[1]: *** [/source/qemu/tests/tcg/Makefile.include:76:
run-guest-tests] Error 2
make: *** [/source/qemu/tests/Makefile.include:946:
run-tcg-tests-xtensa-softmmu] Error 2

This one works:

xtensa-softmmu/tests$ ../qemu-system-xtensa -M sim -cpu dc232b
-nographic -semihosting -icount 6 -kernel test_mul32.tst -d in_asm
QEMU 2.12.50 monitor - type 'help' for more information
(qemu) ----------------
IN:
0xfe000000:  j	0xfe000008

----------------
IN:
0xfe000008:  l32r	a2, 0xfe000004
0xfe00000b:  jx	a2

----------------
IN:
0xd0000404:  movi.n	a2, 1
0xd0000406:  wsr.windowstart	a2

----------------
IN:
0xd0000409:  movi.n	a2, 0
0xd000040b:  wsr.windowbase	a2

----------------
IN:
0xd000040e:  l32r	a1, 0xd00003e8
0xd0000411:  l32r	a2, 0xd00003ec
0xd0000414:  wsr.ps	a2

----------------
IN:
0xd0000417:  isync
0xd000041a:  call0	0xd0000424

----------------
IN:
0xd0000424:  l32r	a2, 0xd00003f0
0xd0000427:  mov.n	a3, a2
0xd0000429:  l32r	a4, 0xd00003f4
0xd000042c:  l32r	a6, 0xd00003f8
0xd000042f:  mull	a5, a2, a4
0xd0000432:  beq	a5, a6, 0xd0000442

----------------
IN:
0xd0000442:  nop.n
0xd0000444:  mull	a2, a2, a4
0xd0000447:  beq	a2, a6, 0xd0000458

----------------
IN:
0xd0000458:  nop.n
0xd000045a:  mull	a3, a4, a3
0xd000045d:  beq	a3, a6, 0xd000046d

----------------
IN:
0xd000046d:  nop.n
0xd000046f:  l32r	a2, 0xd00003ec
0xd0000472:  wsr.ps	a2

----------------
IN:
0xd0000475:  isync
0xd0000478:  l32r	a2, 0xd00003fc
0xd000047b:  l32i.n	a3, a2, 0
0xd000047d:  addi.n	a3, a3, 1
0xd000047f:  s32i.n	a3, a2, 0
0xd0000481:  l32r	a2, 0xd00003ec
0xd0000484:  wsr.ps	a2

----------------
IN:
0xd0000487:  isync
0xd000048a:  l32r	a0, 0xd00003fc
0xd000048d:  l32i	a2, a0, 0
0xd0000490:  l32r	a0, 0xd0000400
0xd0000493:  sub	a2, a2, a0
0xd0000496:  movi	a3, 0
0xd0000499:  loopnez	a2, 0xd00004a4

----------------
IN:
0xd000049c:  l8ui	a2, a0, 0
0xd000049f:  or	a3, a3, a2
0xd00004a2:  addi.n	a0, a0, 1

----------------
IN:
0xd00004a4:  movi.n	a2, 1
0xd00004a6:  simcall
0xd00004a9:  ill

exit(0) simcall


But this one for example never exit:

xtensa-softmmu/tests$ ../qemu-system-xtensa -M sim -cpu dc232b
-nographic -semihosting -icount 6 -kernel ./test_mmu.tst -d in_asm
...
----------------
IN:
0xd0001b0a:  wdtlb	a2, a3

----------------
IN:
0xd0001b0d:  l32r	a2, 0xd0000540
0xd0001b10:  l32r	a3, 0xd0000544
0xd0001b13:  l32r	a4, 0xd0000534
0xd0001b16:  sub	a4, a4, a3
0xd0001b19:  loop	a4, 0xd0001b26

----------------
IN:
0xd0001b1c:  l8ui	a5, a3, 0
0xd0001b1f:  s8i	a5, a2, 0
0xd0001b22:  addi.n	a2, a2, 1
0xd0001b24:  addi.n	a3, a3, 1

----------------
IN:
0xd0001b26:  l32r	a2, 0xd0000540
0xd0001b29:  l32r	a3, 0xd000053c
0xd0001b2c:  jx	a2

----------------
IN:
0x00007fff:  l32i	a2, a3, 0

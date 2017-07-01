Received: from eggs.gnu.org ([2001:4830:134:3::10]:44280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRKai-0007Gj-BM
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dRKaf-0007kY-7X
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:45:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:41194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dRKae-0007jq-RN
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 11:45:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dRKad-0005fY-Ka
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 15:45:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9035C2E8194
	for <qemu-devel@nongnu.org>; Sat,  1 Jul 2017 15:45:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Jul 2017 15:35:58 -0000
From: Bruno Haible <bruno@clisp.org>
Reply-To: Bug 1701821 <1701821@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149892335854.26587.4297865975090837425.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701821] [NEW] floating-point operation bugs in
 qemu-sh4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

When running the gnulib testsuite, I'm seeing test failures in the tests fo=
r libm functions
  asinf
  cbrtf
  copysignf
  coshf
  expm1f
  fabsf
  floor
  fmaf
  ldexpf
  logbf
  round
  roundf
  sinhf
  tanhf

How to reproduce:
- Using gnulib, run ./gnulib-tool --create-testdir --dir=3D../testdir-math =
--single-configure asinf cbrtf copysignf coshf expm1f fabsf floor fma fmaf =
fmal ldexpf logbf round roundf sinhf tanhf
- Set environment variables for using qemu-sh4.
- cd testdir-math; mkdir build-sh4; cd build-sh4; ./configure --host=3Dsh4-=
linux; make; make check

Here are the failures (from the file testdir-math/build-sh4/gltests
/test-suite.log):


FAIL: test-asinf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0xf6751cdc sr=3D0x00000101 pr=3D0xf6758e86 fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6751cd6 fpul=3D0x3f19999a
r0=3D0xf6751d88 r1=3D0x00000000 r2=3D0x00080000 r3=3D0x00000000
r4=3D0xf6ffe21c r5=3D0xf6ffe230 r6=3D0xf6ffe2fc r7=3D0x00000000
r8=3D0x3f19999a r9=3D0x3f19999a r10=3D0x00000000 r11=3D0x00000000
r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe230
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
Unhandled trap: 0x180
FAIL test-asinf (exit status: 1)

FAIL: test-cbrtf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0x00400980 sr=3D0x00000001 pr=3D0x00400684 fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x00400960 fpul=3D0x00000000
r0=3D0x00400ae8 r1=3D0x00412070 r2=3D0x3f19999a r3=3D0xf6ffe2c0
r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
r8=3D0x00412064 r9=3D0x00400960 r10=3D0x00000000 r11=3D0x00000000
r12=3D0xf671dc58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe21c
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
Unhandled trap: 0x180
FAIL test-cbrtf (exit status: 1)

FAIL: test-copysignf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0x004004ce sr=3D0x00000001 pr=3D0xf668d28c fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf6674678 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x004004d2 fpul=3D0x00000000
r0=3D0x80000000 r1=3D0x3f4ccccd r2=3D0xf6674284 r3=3D0xf6ffe2b0
r4=3D0x00000001 r5=3D0xf6ffe2e4 r6=3D0xf6ffe2ec r7=3D0x00000000
r8=3D0x00411088 r9=3D0x00411084 r10=3D0x00000000 r11=3D0x00000000
r12=3D0xf67a8c58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe240
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
in conditional delay slot (delayed_pc=3D0x004004d2)
Unhandled trap: 0x1a0
FAIL test-copysignf (exit status: 1)

FAIL: test-coshf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0xf675223a sr=3D0x00000101 pr=3D0xf675223c fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf675231c fpul=3D0x3f19999a
r0=3D0x3f19999a r1=3D0x3f19999a r2=3D0x000000e0 r3=3D0xf6ffe2c0
r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
r8=3D0x00400734 r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe240
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
in delay slot (delayed_pc=3D0xf675231c)
Unhandled trap: 0x1a0
FAIL test-coshf (exit status: 1)

FAIL: test-expm1f
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0xf6757e08 sr=3D0x00000000 pr=3D0x004005ce fpscr=3D0x00081000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6757dfe fpul=3D0x00000000
r0=3D0xf6757fb0 r1=3D0x00001000 r2=3D0x00080000 r3=3D0x3eb17218
r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
r8=3D0x00400514 r9=3D0x00000064 r10=3D0x00400514 r11=3D0x00000000
r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe234
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
Unhandled trap: 0x180
FAIL test-expm1f (exit status: 1)

FAIL: test-fabsf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0x00400504 sr=3D0x00000001 pr=3D0xf660228c fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x004004ec fpul=3D0x00000000
r0=3D0x00400640 r1=3D0x00412074 r2=3D0x00000000 r3=3D0x00412078
r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00080000
r8=3D0x004007ac r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
r12=3D0xf671dc58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe260
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
Unhandled trap: 0x180
FAIL test-fabsf (exit status: 1)

FAIL: test-floor2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

../../gltests/test-floor2.c:130: assertion 'correct_result_p (x, reference)=
' failed
qemu: uncaught target signal 6 (Aborted) - core dumped
FAIL test-floor2 (exit status: 134)

FAIL: test-fmaf2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0xf675f5ac sr=3D0x00000101 pr=3D0xf675f5a6 fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf675f5a6 fpul=3D0x01800000
r0=3D0xf675f4a4 r1=3D0x000065b0 r2=3D0x00080000 r3=3D0x3f800000
r4=3D0x01800000 r5=3D0x00000000 r6=3D0xffffffe9 r7=3D0x7f800000
r8=3D0xffffff6b r9=3D0xf6ffe1e4 r10=3D0xf6ffe1e8 r11=3D0xffffff6b
r12=3D0xf67ab008 r13=3D0xf6ffe1d8 r14=3D0x004004dc r15=3D0xf6ffe18c
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
Unhandled trap: 0x180
FAIL test-fmaf2 (exit status: 1)

FAIL: test-ldexpf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0xf669efa0 sr=3D0x00000001 pr=3D0xf669ef9a fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf6674678 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf669ef9a fpul=3D0x3f99999a
r0=3D0xfffffdc6 r1=3D0x000c9d70 r2=3D0x00080000 r3=3D0x3f19999a
r4=3D0x0019999a r5=3D0x3f19999a r6=3D0xffffffe9 r7=3D0x7f800000
r8=3D0x00000001 r9=3D0x0040041c r10=3D0xf6ffe23c r11=3D0x00000000
r12=3D0xf67a8c58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe218
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
Unhandled trap: 0x180
FAIL test-ldexpf (exit status: 1)

FAIL: test-logbf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0xf675842c sr=3D0x00000001 pr=3D0x00400664 fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6758422 fpul=3D0x00000000
r0=3D0xf6758480 r1=3D0x00000000 r2=3D0x00080000 r3=3D0x00080000
r4=3D0x00000000 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
r8=3D0xf6ffe24c r9=3D0x0040054c r10=3D0x00000000 r11=3D0x00000000
r12=3D0xf671dc58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe244
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
Unhandled trap: 0x180
FAIL test-logbf (exit status: 1)

FAIL: test-round2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

FAIL test-round2 (exit status: 1)

FAIL: test-roundf2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

FAIL test-roundf2 (exit status: 1)

FAIL: test-sinhf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0xf675581c sr=3D0x00000101 pr=3D0xf675a784 fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6755858 fpul=3D0x3f19999a
r0=3D0xf6755930 r1=3D0x317fffff r2=3D0x3f19999a r3=3D0xf6ffe2c0
r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
r8=3D0x3f19999a r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe238
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
in conditional delay slot (delayed_pc=3D0xf6755858)
Unhandled trap: 0x1a0
FAIL test-sinhf (exit status: 1)

FAIL: test-tanhf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

pc=3D0xf6758ca4 sr=3D0x00000100 pr=3D0x0040057c fpscr=3D0x00080000
spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6758c9a fpul=3D0x3f19999a
r0=3D0xf6758d00 r1=3D0x00000000 r2=3D0x00080000 r3=3D0xf6ffe2c0
r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
r8=3D0x3f19999a r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe254
r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
Unhandled trap: 0x180
FAIL test-tanhf (exit status: 1)


I don't have access to sh4 hardware, so I cannot provide this as a comparis=
on point.
But most of the test failures don't look like "merely" a wrong computation =
by glibc.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "testdir-math.tar.bz2"
   https://bugs.launchpad.net/bugs/1701821/+attachment/4907417/+files/testd=
ir-math.tar.bz2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701821

Title:
  floating-point operation bugs in qemu-sh4

Status in QEMU:
  New

Bug description:
  When running the gnulib testsuite, I'm seeing test failures in the tests =
for libm functions
    asinf
    cbrtf
    copysignf
    coshf
    expm1f
    fabsf
    floor
    fmaf
    ldexpf
    logbf
    round
    roundf
    sinhf
    tanhf

  How to reproduce:
  - Using gnulib, run ./gnulib-tool --create-testdir --dir=3D../testdir-mat=
h --single-configure asinf cbrtf copysignf coshf expm1f fabsf floor fma fma=
f fmal ldexpf logbf round roundf sinhf tanhf
  - Set environment variables for using qemu-sh4.
  - cd testdir-math; mkdir build-sh4; cd build-sh4; ./configure --host=3Dsh=
4-linux; make; make check

  Here are the failures (from the file testdir-math/build-sh4/gltests
  /test-suite.log):

  =

  FAIL: test-asinf
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0xf6751cdc sr=3D0x00000101 pr=3D0xf6758e86 fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6751cd6 fpul=3D0x3f1999=
9a
  r0=3D0xf6751d88 r1=3D0x00000000 r2=3D0x00080000 r3=3D0x00000000
  r4=3D0xf6ffe21c r5=3D0xf6ffe230 r6=3D0xf6ffe2fc r7=3D0x00000000
  r8=3D0x3f19999a r9=3D0x3f19999a r10=3D0x00000000 r11=3D0x00000000
  r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe230
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  Unhandled trap: 0x180
  FAIL test-asinf (exit status: 1)

  FAIL: test-cbrtf
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0x00400980 sr=3D0x00000001 pr=3D0x00400684 fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x00400960 fpul=3D0x000000=
00
  r0=3D0x00400ae8 r1=3D0x00412070 r2=3D0x3f19999a r3=3D0xf6ffe2c0
  r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
  r8=3D0x00412064 r9=3D0x00400960 r10=3D0x00000000 r11=3D0x00000000
  r12=3D0xf671dc58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe21c
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  Unhandled trap: 0x180
  FAIL test-cbrtf (exit status: 1)

  FAIL: test-copysignf
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0x004004ce sr=3D0x00000001 pr=3D0xf668d28c fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf6674678 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x004004d2 fpul=3D0x000000=
00
  r0=3D0x80000000 r1=3D0x3f4ccccd r2=3D0xf6674284 r3=3D0xf6ffe2b0
  r4=3D0x00000001 r5=3D0xf6ffe2e4 r6=3D0xf6ffe2ec r7=3D0x00000000
  r8=3D0x00411088 r9=3D0x00411084 r10=3D0x00000000 r11=3D0x00000000
  r12=3D0xf67a8c58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe240
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  in conditional delay slot (delayed_pc=3D0x004004d2)
  Unhandled trap: 0x1a0
  FAIL test-copysignf (exit status: 1)

  FAIL: test-coshf
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0xf675223a sr=3D0x00000101 pr=3D0xf675223c fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf675231c fpul=3D0x3f1999=
9a
  r0=3D0x3f19999a r1=3D0x3f19999a r2=3D0x000000e0 r3=3D0xf6ffe2c0
  r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
  r8=3D0x00400734 r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
  r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe240
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  in delay slot (delayed_pc=3D0xf675231c)
  Unhandled trap: 0x1a0
  FAIL test-coshf (exit status: 1)

  FAIL: test-expm1f
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0xf6757e08 sr=3D0x00000000 pr=3D0x004005ce fpscr=3D0x00081000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6757dfe fpul=3D0x000000=
00
  r0=3D0xf6757fb0 r1=3D0x00001000 r2=3D0x00080000 r3=3D0x3eb17218
  r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
  r8=3D0x00400514 r9=3D0x00000064 r10=3D0x00400514 r11=3D0x00000000
  r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe234
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  Unhandled trap: 0x180
  FAIL test-expm1f (exit status: 1)

  FAIL: test-fabsf
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0x00400504 sr=3D0x00000001 pr=3D0xf660228c fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0x004004ec fpul=3D0x000000=
00
  r0=3D0x00400640 r1=3D0x00412074 r2=3D0x00000000 r3=3D0x00412078
  r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00080000
  r8=3D0x004007ac r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
  r12=3D0xf671dc58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe260
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  Unhandled trap: 0x180
  FAIL test-fabsf (exit status: 1)

  FAIL: test-floor2
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  ../../gltests/test-floor2.c:130: assertion 'correct_result_p (x, referenc=
e)' failed
  qemu: uncaught target signal 6 (Aborted) - core dumped
  FAIL test-floor2 (exit status: 134)

  FAIL: test-fmaf2
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0xf675f5ac sr=3D0x00000101 pr=3D0xf675f5a6 fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf675f5a6 fpul=3D0x018000=
00
  r0=3D0xf675f4a4 r1=3D0x000065b0 r2=3D0x00080000 r3=3D0x3f800000
  r4=3D0x01800000 r5=3D0x00000000 r6=3D0xffffffe9 r7=3D0x7f800000
  r8=3D0xffffff6b r9=3D0xf6ffe1e4 r10=3D0xf6ffe1e8 r11=3D0xffffff6b
  r12=3D0xf67ab008 r13=3D0xf6ffe1d8 r14=3D0x004004dc r15=3D0xf6ffe18c
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  Unhandled trap: 0x180
  FAIL test-fmaf2 (exit status: 1)

  FAIL: test-ldexpf
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0xf669efa0 sr=3D0x00000001 pr=3D0xf669ef9a fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf6674678 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf669ef9a fpul=3D0x3f9999=
9a
  r0=3D0xfffffdc6 r1=3D0x000c9d70 r2=3D0x00080000 r3=3D0x3f19999a
  r4=3D0x0019999a r5=3D0x3f19999a r6=3D0xffffffe9 r7=3D0x7f800000
  r8=3D0x00000001 r9=3D0x0040041c r10=3D0xf6ffe23c r11=3D0x00000000
  r12=3D0xf67a8c58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe218
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  Unhandled trap: 0x180
  FAIL test-ldexpf (exit status: 1)

  FAIL: test-logbf
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0xf675842c sr=3D0x00000001 pr=3D0x00400664 fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6758422 fpul=3D0x000000=
00
  r0=3D0xf6758480 r1=3D0x00000000 r2=3D0x00080000 r3=3D0x00080000
  r4=3D0x00000000 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
  r8=3D0xf6ffe24c r9=3D0x0040054c r10=3D0x00000000 r11=3D0x00000000
  r12=3D0xf671dc58 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe244
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  Unhandled trap: 0x180
  FAIL test-logbf (exit status: 1)

  FAIL: test-round2
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  FAIL test-round2 (exit status: 1)

  FAIL: test-roundf2
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  FAIL test-roundf2 (exit status: 1)

  FAIL: test-sinhf
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0xf675581c sr=3D0x00000101 pr=3D0xf675a784 fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6755858 fpul=3D0x3f1999=
9a
  r0=3D0xf6755930 r1=3D0x317fffff r2=3D0x3f19999a r3=3D0xf6ffe2c0
  r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
  r8=3D0x3f19999a r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
  r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe238
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  in conditional delay slot (delayed_pc=3D0xf6755858)
  Unhandled trap: 0x1a0
  FAIL test-sinhf (exit status: 1)

  FAIL: test-tanhf
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  pc=3D0xf6758ca4 sr=3D0x00000100 pr=3D0x0040057c fpscr=3D0x00080000
  spc=3D0x00000000 ssr=3D0x00000000 gbr=3D0xf65e98e8 vbr=3D0x00000000
  sgr=3D0x00000000 dbr=3D0x00000000 delayed_pc=3D0xf6758c9a fpul=3D0x3f1999=
9a
  r0=3D0xf6758d00 r1=3D0x00000000 r2=3D0x00080000 r3=3D0xf6ffe2c0
  r4=3D0x00000001 r5=3D0xf6ffe2f4 r6=3D0xf6ffe2fc r7=3D0x00000000
  r8=3D0x3f19999a r9=3D0x00000000 r10=3D0x00000000 r11=3D0x00000000
  r12=3D0xf67ab008 r13=3D0x00000000 r14=3D0x00000000 r15=3D0xf6ffe254
  r16=3D0x00000000 r17=3D0x00000000 r18=3D0x00000000 r19=3D0x00000000
  r20=3D0x00000000 r21=3D0x00000000 r22=3D0x00000000 r23=3D0x00000000
  Unhandled trap: 0x180
  FAIL test-tanhf (exit status: 1)

  =

  I don't have access to sh4 hardware, so I cannot provide this as a compar=
ison point.
  But most of the test failures don't look like "merely" a wrong computatio=
n by glibc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701821/+subscriptions

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmc-0008O3-K5
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEZmX-00082u-O8
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33223 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEZmX-000813-BE
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 08:58:05 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 22 Oct 2018 14:57:23 +0200
Message-Id: <1540213077-15211-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 00/34] MIPS queue for October 2018 - part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

The following changes since commit b312532fd03413d0e6ae6767ec793a3e30f487b8:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-19 19:01:07 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-2

for you to fetch changes up to 2ec219776c633df9e43c5fa1557f70ee4f735f9d:

  target/mips: Fix decoding of ALIGN and DALIGN instructions (2018-10-22 14:41:47 +0200)

----------------------------------------------------------------
MIPS queue for October 2018 - part 2

Limited support for R5900 ISA, MMI ASE, and two misc fixes.

----------------------------------------------------------------

Aleksandar Markovic (2):
  target/mips: Fix the title of translate.c
  target/mips: Fix decoding of ALIGN and DALIGN instructions

Fredrik Noring (32):
  target/mips: Define R5900 ISA, MMI ASE, and R5900 CPU preprocessor
    constants
  disas/mips: Define R5900 disassembly constants
  target/mips: R5900 Multimedia Instruction overview note
  target/mips: Define R5900 MMI class, and LQ and SQ opcode constants
  target/mips: Define R5900 MMI{0, 1, 2, 3} subclasses and MMI opcode
    constants
  target/mips: Define R5900 MMI0 opcode constants
  target/mips: Define R5900 MMI1 opcode constants
  target/mips: Define R5900 MMI2 opcode constants
  target/mips: Define R5900 MMI3 opcode constants
  target/mips: Placeholder for R5900 SQ, handle user mode RDHWR
  target/mips: Placeholder for R5900 LQ
  target/mips: Placeholder for R5900 MMI instruction class
  target/mips: Placeholder for R5900 MMI0 instruction subclass
  target/mips: Placeholder for R5900 MMI1 instruction subclass
  target/mips: Placeholder for R5900 MMI2 instruction subclass
  target/mips: Placeholder for R5900 MMI3 instruction subclass
  target/mips: Support R5900 three-operand MULT and MULTU instructions
  target/mips: Support R5900 three-operand MULT1 and MULTU1 instructions
  target/mips: Support R5900 MFLO1, MTLO1, MFHI1 and MTHI1 instructions
  target/mips: Support R5900 DIV1 and DIVU1 instructions
  target/mips: Support R5900 MOVN, MOVZ and PREF instructions from MIPS
    IV
  target/mips: R5900 DMULT[U], DDIV[U], LL[D] and SC[D] are user only
  tests/tcg/mips: Test R5900 three-operand MULT
  tests/tcg/mips: Test R5900 three-operand MULTU
  tests/tcg/mips: Test R5900 three-operand MULT1
  tests/tcg/mips: Test R5900 three-operand MULTU1
  tests/tcg/mips: Test R5900 MFLO1 and MFHI1
  tests/tcg/mips: Test R5900 MTLO1 and MTHI1
  tests/tcg/mips: Test R5900 DIV1
  tests/tcg/mips: Test R5900 DIVU1
  target/mips: Define the R5900 CPU
  linux-user/mips: Recognise the R5900 CPU model

 disas/mips.c                       |  16 +
 linux-user/mips/target_elf.h       |   3 +
 target/mips/mips-defs.h            |   3 +
 target/mips/translate.c            | 865 ++++++++++++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c   |  59 +++
 tests/tcg/mips/mipsr5900/Makefile  |  30 ++
 tests/tcg/mips/mipsr5900/div1.c    |  73 ++++
 tests/tcg/mips/mipsr5900/divu1.c   |  48 ++
 tests/tcg/mips/mipsr5900/mflohi1.c |  35 ++
 tests/tcg/mips/mipsr5900/mtlohi1.c |  40 ++
 tests/tcg/mips/mipsr5900/mult.c    |  76 ++++
 tests/tcg/mips/mipsr5900/multu.c   |  68 +++
 12 files changed, 1297 insertions(+), 19 deletions(-)
 create mode 100644 tests/tcg/mips/mipsr5900/Makefile
 create mode 100644 tests/tcg/mips/mipsr5900/div1.c
 create mode 100644 tests/tcg/mips/mipsr5900/divu1.c
 create mode 100644 tests/tcg/mips/mipsr5900/mflohi1.c
 create mode 100644 tests/tcg/mips/mipsr5900/mtlohi1.c
 create mode 100644 tests/tcg/mips/mipsr5900/mult.c
 create mode 100644 tests/tcg/mips/mipsr5900/multu.c

-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQI-0004ru-Cb
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFJQD-0001ky-6E
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:09 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48971 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFJQB-0001GU-Pu
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 09:42:04 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 15:40:14 +0200
Message-Id: <1540388447-27062-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/33] MIPS queue for October 2018 - part 2 -
 v2
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

The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966b=
a3:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22=
' into staging (2018-10-23 17:20:23 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-2-v2

for you to fetch changes up to 373ecd3823f949fd550ec49685299e287af5753e:

  target/mips: Fix decoding of ALIGN and DALIGN instructions (2018-10-24 =
15:20:32 +0200)

----------------------------------------------------------------
MIPS queue for October 2018 - part 2 - v2

v1->v2:
  - disassembler for R5900 feature removed (one whole patch and
      parts of several other patches are excluded)
  - amended R5900 CPU definition with respect to ASE_MMI
  - minor improvements of patch titles, commit messages and comments

----------------------------------------------------------------

Aleksandar Markovic (2):
  target/mips: Fix the title of translate.c
  target/mips: Fix decoding of ALIGN and DALIGN instructions

Fredrik Noring (31):
  target/mips: Define R5900 ISA, MMI ASE, and R5900 CPU preprocessor
    constants
  target/mips: Add R5900 Multimedia Instruction overview note
  target/mips: Define R5900 MMI class, and LQ and SQ opcode constants
  target/mips: Define R5900 MMI<0|1|2|3> subclasses and opcode constants
  target/mips: Define R5900 MMI0 opcode constants
  target/mips: Define R5900 MMI1 opcode constants
  target/mips: Define R5900 MMI2 opcode constants
  target/mips: Define R5900 MMI3 opcode constants
  target/mips: Add a placeholder for R5900 SQ, handle user mode RDHWR
  target/mips: Add a placeholder for R5900 LQ
  target/mips: Add a placeholder for R5900 MMI instruction class
  target/mips: Add a placeholder for R5900 MMI0 instruction subclass
  target/mips: Add a placeholder for R5900 MMI1 instruction subclass
  target/mips: Add a placeholder for R5900 MMI2 instruction subclass
  target/mips: Add a placeholder for R5900 MMI3 instruction subclass
  target/mips: Support R5900 three-operand MULT and MULTU instructions
  target/mips: Support R5900 three-operand MULT1 and MULTU1 instructions
  target/mips: Support R5900 MFLO1, MTLO1, MFHI1 and MTHI1 instructions
  target/mips: Support R5900 DIV1 and DIVU1 instructions
  target/mips: Support R5900 MOVN, MOVZ and PREF instructions from MIPS
    IV
  target/mips: Make R5900 DMULT[U], DDIV[U], LL[D] and SC[D] user only
  tests/tcg/mips: Add tests for R5900 three-operand MULT
  tests/tcg/mips: Add tests for R5900 three-operand MULTU
  tests/tcg/mips: Add tests for R5900 three-operand MULT1
  tests/tcg/mips: Add tests for R5900 three-operand MULTU1
  tests/tcg/mips: Add tests for R5900 MFLO1 and MFHI1
  tests/tcg/mips: Add tests for R5900 MTLO1 and MTHI1
  tests/tcg/mips: Add tests for R5900 DIV1
  tests/tcg/mips: Add tests for R5900 DIVU1
  target/mips: Define the R5900 CPU
  linux-user/mips: Recognize the R5900 CPU model

 linux-user/mips/target_elf.h       |   3 +
 target/mips/mips-defs.h            |   3 +
 target/mips/translate.c            | 865 +++++++++++++++++++++++++++++++=
+++++-
 target/mips/translate_init.inc.c   |  59 +++
 tests/tcg/mips/mipsr5900/Makefile  |  30 ++
 tests/tcg/mips/mipsr5900/div1.c    |  73 ++++
 tests/tcg/mips/mipsr5900/divu1.c   |  48 ++
 tests/tcg/mips/mipsr5900/mflohi1.c |  35 ++
 tests/tcg/mips/mipsr5900/mtlohi1.c |  40 ++
 tests/tcg/mips/mipsr5900/mult.c    |  76 ++++
 tests/tcg/mips/mipsr5900/multu.c   |  68 +++
 11 files changed, 1281 insertions(+), 19 deletions(-)
 create mode 100644 tests/tcg/mips/mipsr5900/Makefile
 create mode 100644 tests/tcg/mips/mipsr5900/div1.c
 create mode 100644 tests/tcg/mips/mipsr5900/divu1.c
 create mode 100644 tests/tcg/mips/mipsr5900/mflohi1.c
 create mode 100644 tests/tcg/mips/mipsr5900/mtlohi1.c
 create mode 100644 tests/tcg/mips/mipsr5900/mult.c
 create mode 100644 tests/tcg/mips/mipsr5900/multu.c

--=20
2.7.4

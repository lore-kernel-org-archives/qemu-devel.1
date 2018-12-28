Received: from eggs.gnu.org ([208.118.235.92]:47739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoP3-0000Vq-14
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcoOz-000344-Rt
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:26:00 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49030 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcoOz-0002zL-Dw
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 04:25:57 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 28 Dec 2018 10:25:07 +0100
Message-Id: <1545989148-13582-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/41] MIPS pull request for December 2018
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

The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606fd=
ea:

  Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' in=
to staging (2018-12-22 11:25:31 +0000)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-december-2018

for you to fetch changes up to fc10cf1fa2ade8f314f6b3600844d2f3c41830bf:

  tests/tcg: mips: Test R5900 three-operand MADDU1 (2018-12-27 21:31:44 +=
0100)

----------------------------------------------------------------
MIPS queue for December 2018

  - this queue contains various amendments to MIPS code
  - there are three checkpatch warnings that should be ingnored
    in given circumstances
  - most of the patches are not yet visible/noticeable to the end
    user, just a single note related to Paul's patch will be added
    to ChangeLog

----------------------------------------------------------------

Aleksandar Markovic (33):
  MAINTAINERS: target/mips: Add MIPS files under default-configs
    directory
  MAINTAINERS: target/mips: Add filter for mips in email subjects
  MAINTAINERS: target/mips: Reorder items alphabetically
  MAINTAINERS: Add Aleksandar Rikalo as a reviewer for MIPS content
  target/mips: MXU: Add missing opcodes/decoding for LX* instructions
  target/mips: MXU: Add generic naming for optn2 constants
  target/mips: MXU: Improve the comment containing MXU overview
  disas: nanoMIPS: Fix preamble text in nanomips.* files
  disas: nanoMIPS: Remove functions that are not used
  disas: nanoMIPS: Fix a function misnomer
  disas: nanoMIPS: Fix order of some invocations
  disas: nanoMIPS: Name some functions in a more descriptive way
  disas: nanoMIPS: Fix an FP-related misnomer 1
  disas: nanoMIPS: Fix an FP-related misnomer 2
  disas: nanoMIPS: Fix an FP-related misnomer 3
  disas: nanoMIPS: Name more functions in a more descriptive way
  disas: nanoMIPS: Fix order of more invocations
  disas: nanoMIPS: Rename the decoder of 'gpr3' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr3' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr3.src.store' gpr encoding
    type
  disas: nanoMIPS: Comment the decoder of 'gpr3.src.store' gpr encoding
    type
  disas: nanoMIPS: Rename the decoder of 'gpr4' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr4' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr4.zero' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr4.zero' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr2.reg1' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr2.reg1' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr2.reg2' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr2.reg2' gpr encoding type
  disas: nanoMIPS: Rename the decoder of 'gpr1' gpr encoding type
  disas: nanoMIPS: Comment the decoder of 'gpr1' gpr encoding type
  disas: nanoMIPS: Reorder declarations and definitions of gpr decoders
  disas: nanoMIPS: Add a note on documentation

Fredrik Noring (5):
  target/mips: Support R5900 three-operand MADD1 and MADDU1 instructions
  tests/tcg: mips: Test R5900 three-operand MADD
  tests/tcg: mips: Test R5900 three-operand MADD1
  tests/tcg: mips: Test R5900 three-operand MADDU
  tests/tcg: mips: Test R5900 three-operand MADDU1

Paul Burton (1):
  atomics: Set ATOMIC_REG_SIZE=3D8 for MIPS n32

Philippe Mathieu-Daud=C3=A9 (1):
  target/mips: Support R5900 three-operand MADD and MADDU instructions

Stefan Weil (1):
  disas: nanoMIPS: Fix types and format strings

 MAINTAINERS                       |   21 +-
 disas/nanomips.cpp                | 2155 ++++++++++++++++++-------------=
------
 disas/nanomips.h                  |  125 +--
 include/qemu/atomic.h             |    5 +-
 target/mips/translate.c           |  287 +++--
 tests/tcg/mips/mipsr5900/Makefile |    2 +
 tests/tcg/mips/mipsr5900/madd.c   |   78 ++
 tests/tcg/mips/mipsr5900/maddu.c  |   70 ++
 8 files changed, 1509 insertions(+), 1234 deletions(-)
 create mode 100644 tests/tcg/mips/mipsr5900/madd.c
 create mode 100644 tests/tcg/mips/mipsr5900/maddu.c

--=20
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2k-0001ib-9q
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gCl2f-0006bw-Fa
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:18 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36527 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gCl2f-00050J-3V
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:35:13 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 17 Oct 2018 14:33:28 +0200
Message-Id: <1539779635-15445-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/27]MIPS pull request for October 2018 - part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20181012-pull-requ=
est' into staging (2018-10-12 16:45:51 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-oct-2018-part-1

for you to fetch changes up to 5eb2c6f2a5cc56a84ac73b0025cc006064606f73:

  target/mips: Add opcodes for nanoMIPS EVA instructions (2018-10-17 13:4=
4:56 +0200)

----------------------------------------------------------------
MIPS queue October 2018, part 1

Variety of MIPS fixes and improvements.
----------------------------------------------------------------
Aleksandar Markovic (7):
  mailmap: Add an item for Yongbok Kim
  target/mips: Add a comment with an overview of CP0 registers
  target/mips: Add a comment before each CP0 register section in cpu.h
  target/mips: Add basic description of MXU ASE
  target/mips: Add assembler mnemonics list for MXU ASE
  target/mips: Add organizational chart of MXU ASE
  target/mips: Add opcode values of MXU ASE

Dimitrije Nikolic (1):
  target/mips: Add opcodes for nanoMIPS EVA instructions

Matthew Fortune (1):
  target/mips: Fix emulation of microMIPS R6 <SELEQZ|SELNEZ>.<D|S>

Philippe Mathieu-Daud=C3=A9 (2):
  target/mips: Increase 'supported ISAs/ASEs' flag holder size
  target/mips: Reorganize bit definitions for insn_flags (ISAs/ASEs
    flags)

Stefan Markovic (10):
  elf: Fix PT_MIPS_XXX constants
  elf: Add MIPS_ABI_FP_XXX constants
  elf: Add Mips_elf_abiflags_v0 structure
  linux-user: Add MIPS-specific prctl() options
  linux-user: Add infrastructure for handling MIPS-specific prctl()
  target/mips: Add bit definitions for DSP R3 ASE
  target/mips: Add availability control for DSP R3 ASE
  target/mips: Improve DSP R2/R3-related naming
  target/mips: Add CP0 Config2 to DisasContext
  target/mips: Fix misplaced 'break' in handling of NM_SHRA_R_PH

Yongbok Kim (6):
  target/mips: Add CP0 PWBase register
  target/mips: Add CP0 PWField register
  target/mips: Add CP0 PWSize register
  target/mips: Add CP0 PWCtl register
  target/mips: Add reset state for PWSize and PWField registers
  target/mips: Implement hardware page table walker for MIPS32

 .mailmap                           |   1 +
 include/elf.h                      |  31 +-
 linux-user/mips/target_syscall.h   |   4 +
 linux-user/mips64/target_syscall.h |   4 +
 linux-user/syscall.c               |   8 +
 target/mips/cpu.h                  | 241 +++++++++-
 target/mips/helper.c               | 365 ++++++++++++++-
 target/mips/helper.h               |   3 +
 target/mips/internal.h             |  34 +-
 target/mips/machine.c              |   8 +-
 target/mips/mips-defs.h            |  79 ++--
 target/mips/op_helper.c            |  88 +++-
 target/mips/translate.c            | 900 +++++++++++++++++++++++++++++++=
+-----
 target/mips/translate_init.inc.c   |   9 +-
 14 files changed, 1615 insertions(+), 160 deletions(-)

--=20
2.7.4

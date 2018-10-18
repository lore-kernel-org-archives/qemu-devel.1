Received: from eggs.gnu.org ([2001:4830:134:3::10]:44369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDMO-0000dH-G5
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDDMF-0005dY-3S
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:24 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56657 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDDM6-00043a-Qw
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 14:49:13 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 18 Oct 2018 20:47:25 +0200
Message-Id: <1539888473-16340-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/28] MIPS queue October 2018, part 1, v2
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

The following changes since commit 77f7c747193662edfadeeb3118d63eed0eac51=
a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
8-10-17' into staging (2018-10-18 13:40:19 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-october-2018-part1-v2

for you to fetch changes up to 0d30b3bbc5fed12da8f8d1bfd28f2803d65a4cb0:

  target/mips: Add opcodes for nanoMIPS EVA instructions (2018-10-18 20:3=
7:20 +0200)

----------------------------------------------------------------
MIPS queue October 2018, part1, v2

v1->v2:
- fixed clang build error
- a small patch forgotten in v1 included now
- MXU patches slightly improved (fixed typos etc.)
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

Fredrik Noring (1):
  elf: Fix comments to EF_MIPS_MACH_xxx constants

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
 include/elf.h                      |  35 +-
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
 target/mips/translate.c            | 901 +++++++++++++++++++++++++++++++=
+-----
 target/mips/translate_init.inc.c   |   9 +-
 14 files changed, 1618 insertions(+), 162 deletions(-)

--=20
2.7.4

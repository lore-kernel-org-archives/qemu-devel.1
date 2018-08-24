Received: from eggs.gnu.org ([2001:4830:134:3::10]:35685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1ftEW1-0006gs-V2
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1ftEVy-0002ZA-NJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:00:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:44501 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1ftEVy-0001nC-Az
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:00:46 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 24 Aug 2018 17:59:34 +0200
Message-Id: <1535126374-5471-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 00/45] MIPS queue August 2018 v6
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

The following changes since commit 1dfb85a8755096beecf182a617493d539259cbea:

  Merge remote-tracking branch 'remotes/juanquintela/tags/check/20180822' into staging (2018-08-24 14:46:31 +0100)

are available in the git repository at:

  https://github.com/AMarkovic/qemu tags/mips-queue-aug-2018

for you to fetch changes up to d45942d908edee175a90f915ab92ac302eedf33a:

  target/mips: Add definition of nanoMIPS I7200 CPU (2018-08-24 17:51:59 +0200)

----------------------------------------------------------------
MIPS queue August 2018 v6

----------------------------------------------------------------

Aleksandar Markovic (5):
  target/mips: Add preprocessor constants for nanoMIPS
  target/mips: Add placeholder and invocation of decode_nanomips_opc()
  target/mips: Add nanoMIPS decoding and extraction utilities
  elf: Relax MIPS' elf_check_arch() to accept EM_NANOMIPS too
  elf: Don't check FCR31_NAN2008 bit for nanoMIPS

Aleksandar Rikalo (4):
  target/mips: Implement emulation of nanoMIPS LLWP/SCWP pair
  target/mips: Fix pre-nanoMIPS MT ASE instructions availability control
  elf: Add EM_NANOMIPS value as a valid one for e_machine field
  elf: On elf loading, treat both EM_MIPS and EM_NANOMIPS as legal for
    MIPS

Dimitrije Nikolic (2):
  target/mips: Add CP0 Config3 and Config5 fields to DisasContext
    structure
  target/mips: Add availability control via bit NMS

James Hogan (1):
  target/mips: Implement emulation of nanoMIPS EXTW instruction

Matthew Fortune (2):
  target/mips: Implement emulation of nanoMIPS ROTX instruction
  mips_malta: Add basic nanoMIPS boot code for Malta board

Paul Burton (1):
  mips_malta: Add setting up GT64120 BARs to the nanoMIPS bootloader

Stefan Markovic (15):
  target/mips: Add nanoMIPS DSP ASE opcodes
  target/mips: Prevent switching mode related to Config3 ISA bit for
    nanoMIPS
  target/mips: Add emulation of nanoMIPS 16-bit branch instructions
  target/mips: Add emulation of nanoMIPS 16-bit save and restore
    instructions
  target/mips: Add emulation of nanoMIPS 32-bit branch instructions
  target/mips: Implement MT ASE support for nanoMIPS
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 1
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 2
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 3
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 4
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 5
  target/mips: Add emulation of DSP ASE for nanoMIPS - part 6
  target/mips: Add updating BadInstr and BadInstrX for nanoMIPS
  mips_malta: Fix semihosting argument passing for nanoMIPS bare metal
  target/mips: Add definition of nanoMIPS I7200 CPU

Yongbok Kim (15):
  target/mips: Add nanoMIPS base instruction set opcodes
  target/mips: Add emulation of nanoMIPS 16-bit arithmetic instructions
  target/mips: Add emulation of nanoMIPS 16-bit shift instructions
  target/mips: Add emulation of nanoMIPS 16-bit misc instructions
  target/mips: Add emulation of nanoMIPS 16-bit load and store
    instructions
  target/mips: Add emulation of nanoMIPS 16-bit logic instructions
  target/mips: Add emulation of some common nanoMIPS 32-bit instructions
  target/mips: Add emulation of nanoMIPS instructions MOVE.P and
    MOVE.PREV
  target/mips: Add emulation of nanoMIPS 48-bit instructions
  target/mips: Add emulation of nanoMIPS FP instructions
  target/mips: Add emulation of misc nanoMIPS instructions (pool32a0)
  target/mips: Add emulation of misc nanoMIPS instructions (pool32axf)
  target/mips: Add emulation of misc nanoMIPS instructions (p_lsx)
  target/mips: Add emulation of nanoMIPS 32-bit load and store
    instructions
  target/mips: Fix ERET/ERETNC behavior related to ADEL exception

 hw/mips/mips_malta.c             |  212 +-
 include/elf.h                    |    2 +
 include/hw/elf_ops.h             |    8 +
 linux-user/elfload.c             |    2 +
 linux-user/mips/cpu_loop.c       |   28 +-
 target/mips/cpu.h                |    2 +
 target/mips/helper.c             |   16 +
 target/mips/helper.h             |    2 +
 target/mips/mips-defs.h          |    4 +
 target/mips/op_helper.c          |   98 +-
 target/mips/translate.c          | 4981 +++++++++++++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c |   39 +
 12 files changed, 5316 insertions(+), 78 deletions(-)

-- 
2.7.4

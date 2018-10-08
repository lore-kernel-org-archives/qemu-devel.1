Received: from eggs.gnu.org ([2001:4830:134:3::10]:45621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9Wyy-00041b-SF
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g9Wyu-0005Bn-Ow
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:58:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39967 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g9Wyu-0004P9-Fb
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:58:00 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  8 Oct 2018 16:56:24 +0200
Message-Id: <1539010596-30858-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 00/12] Misc MIPS fixes and improvements for
 October 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series contains support for MIPS ABI flags in elf.h, DSP R3
availability control, and emulation of nanoMIPS EVA instructions.
MIPS ABI flags will be used in near future for linux user mode
support for certain MIPS-specific parts of prctl() system call.

This series also contains support for WatchHi, MemoryMapID, SAARI,
and SAAR registers, ITU updates, implementation of DRAM, and I6500
core configuration.

All patches were developed a while ago, but were not submitted to
this list for various reasons.

v2->v3:

  - added patch on extending WatchHi registers
  - added patch on MemoryMapID, SAARI, and SAAR registers
  - added patch on ITU updates wrt SAAR
  - added patch on Data Scratch Pad RAM
  - added patch on I6500 core configuration
  - corrected the patch on nanoMIPS EVA opcodes

v1->v2:

  - added three patches on MIPS-specifics in elf.h


Dimitrije Nikolic (2):
  target/mips: Add opcodes for nanoMIPS EVA instructions
  target/mips: Implement emulation of nanoMIPS EVA instructions

Stefan Markovic (5):
  elf: Fix PT_MIPS_XXX constants
  elf: Add MIPS_ABI_FP_XXX constants
  elf: Add Mips_elf_abiflags_v0 structure
  target/mips: Add bit definitions for DSP R3 ASE
  target/mips: Add availability control for DSP R3 ASE

Yongbok Kim (5):
  target/mips: Extend WatchHi registers
  target/mips: Implement MemoryMapID, SAARI, and SAAR registers
  hw/mips: Update ITU to utilise SAARI/SAAR registers
  hw/mips: Add Data Scratch Pad RAM
  target/mips: Add I6500 core configuration

 default-configs/mips-softmmu-common.mak |   1 +
 hw/mips/cps.c                           |   9 ++
 hw/mips/mips_malta.c                    |  31 ++++
 hw/misc/Makefile.objs                   |   1 +
 hw/misc/mips_itu.c                      |  72 +++++++++-
 include/elf.h                           |  30 +++-
 include/hw/mips/cps.h                   |   2 +
 include/hw/misc/mips_itu.h              |   7 +
 target/mips/cpu.h                       |  21 ++-
 target/mips/helper.h                    |   9 ++
 target/mips/internal.h                  |  14 +-
 target/mips/machine.c                   |   8 +-
 target/mips/mips-defs.h                 |   1 +
 target/mips/op_helper.c                 |  98 ++++++++++++-
 target/mips/translate.c                 | 241 +++++++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c        |  46 +++++-
 16 files changed, 568 insertions(+), 23 deletions(-)

-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g8Ruz-0008AC-Sy
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g8Ruk-0006Cz-Oz
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:21:21 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40415 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g8Ruk-0005TY-HT
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:21:14 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  5 Oct 2018 17:19:46 +0200
Message-Id: <1538752793-6875-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 0/7] Misc MIPS fixes and improvements for
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

All patches were developed a while ago, but were not submitted to
this list for various reasons.

Dimitrije Nikolic (2):
  target/mips: Add opcodes for nanoMIPS EVA instructions
  target/mips: Implement emulation of nanoMIPS EVA instructions

Stefan Markovic (5):
  elf: Fix PT_MIPS_XXX constants
  elf: Add MIPS_ABI_FP_XXX constants
  elf: Add Mips_elf_abiflags_v0 structure
  target/mips: Add bit definitions for DSP R3 ASE
  target/mips: Add availability control for DSP R3 ASE

 include/elf.h                    |  30 ++++++++++-
 target/mips/cpu.h                |   1 +
 target/mips/internal.h           |  11 ++--
 target/mips/mips-defs.h          |   1 +
 target/mips/translate.c          | 108 ++++++++++++++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c |   3 +-
 6 files changed, 147 insertions(+), 7 deletions(-)

-- 
2.7.4

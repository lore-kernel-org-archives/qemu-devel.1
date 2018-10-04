Received: from eggs.gnu.org ([2001:4830:134:3::10]:53839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g82rV-0004ql-HW
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1g82rS-0006rp-JU
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:36:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34894 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1g82rS-0005gI-Bl
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:36:10 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  4 Oct 2018 14:34:47 +0200
Message-Id: <1538656491-22950-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/4] Misc MIPS fixes and improvements for
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
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, dnikolic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This series contains support for DSP R3 availability control and
emulation of nanoMIPS EVA instructions.

Dimitrije Nikolic (2):
  target/mips: Add opcodes for nanoMIPS EVA instructions
  target/mips: Implement emulation of nanoMIPS EVA instructions

Stefan Markovic (2):
  target/mips: Add bit definitions for DSP R3 ASE
  target/mips: Add availability control for DSP R3 ASE

 target/mips/cpu.h                |   1 +
 target/mips/internal.h           |  11 ++--
 target/mips/mips-defs.h          |   1 +
 target/mips/translate.c          | 108 ++++++++++++++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c |   3 +-
 5 files changed, 119 insertions(+), 5 deletions(-)

-- 
2.7.4

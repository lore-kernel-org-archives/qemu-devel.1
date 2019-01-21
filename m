Received: from eggs.gnu.org ([209.51.188.92]:40172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1glexB-0001gB-Rl
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1glexB-0004EA-7B
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:49 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50391 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1glexA-0003lU-5E
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:48 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 21 Jan 2019 20:08:12 +0100
Message-Id: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/6] target/mips: Misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

A collection of misc fixes for MIPS.

Aleksandar Markovic (6):
  target/mips: nanoMIPS: Remove duplicate macro definitions
  target/mips: nanoMIPS: Remove an unused macro
  target/mips: nanoMIPS: Rename macros for extracting 3-bit GPR codes
  target/mips: Correct the second argument type of cpu_supports_isa()
  target/mips: Extend gen_scwp() functionality to support EVA
  disas: nanoMIPS: Amend DSP instructions related comments

 disas/nanomips.cpp      | 119 ++++++++++++++++++++++++++++++------------------
 target/mips/cpu.h       |   2 +-
 target/mips/translate.c |  49 ++++++++------------
 3 files changed, 96 insertions(+), 74 deletions(-)

-- 
2.7.4

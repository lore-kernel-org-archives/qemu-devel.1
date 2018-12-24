Received: from eggs.gnu.org ([208.118.235.92]:44867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gbTuZ-0003pw-KW
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 12:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gbTuW-0003tH-Vt
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 12:21:03 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:55011 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gbTuU-0002JT-V1
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 12:21:00 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 24 Dec 2018 18:19:25 +0100
Message-Id: <1545671976-13630-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 00/11] disas: nanoMIPS: Clean up several
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up several misc issues in nanoMIPS disassembler. There are
more issues to be cleaned, and this is meant to be just the first
phase. Complete cleanup should happen over the course of next
few months.

All these changes should not and do not affect any functionality.

v3->v4:

  - added patch "Name more functions in a more descriptive way"
  - added patch "Fix order of more invocations"
  - added patch "Fix comments for 48-bit instructions"
  - minor cleanups of previous commit messages

v2->v3:

  - added three patches that fix function misnomers.
  - minor changes in commit messages.

v1->v2:

  - patch 5 was somehow lost in v1, now should be fine.

Aleksandar Markovic (11):
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
  disas: nanoMIPS: Fix comments for 48-bit instructions

 disas/nanomips.cpp | 1825 +++++++++++++++++++++++-----------------------------
 disas/nanomips.h   |  100 ++-
 2 files changed, 848 insertions(+), 1077 deletions(-)

-- 
2.7.4

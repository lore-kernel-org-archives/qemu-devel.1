Received: from eggs.gnu.org ([2001:4830:134:3::10]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gZisU-00046y-Q9
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gZisR-0007RM-DK
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:55:38 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43920 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gZisR-0006qa-1e
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 15:55:35 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 19 Dec 2018 21:54:13 +0100
Message-Id: <20181219205421.4537-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 0/8] disas: nanoMIPS: Clean up several issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up several misc issues in nanoMIPS disassembler. There are
more issues to be cleaned, and this is meant to be just the first
phase. Complete cleanup should happen over the course of next
few months.

All these changes should not and do not affect any functionality.

v2->v3:

  - added three patches that fix function misnomers.
  - minor changes in commit messages.

v1->v2:

  - patch 5 was somehow lost in v1, now should be fine.

Aleksandar Markovic (8):
  disas: nanoMIPS: Fix preamble text in nanomips.* files
  disas: nanoMIPS: Remove functions that are not used
  disas: nanoMIPS: Fix a function misnomer
  disas: nanoMIPS: Fix order of some invocations
  disas: nanoMIPS: Name some function in a more descriptive way
  disas: nanoMIPS: Fix an FP-related misnomer 1
  disas: nanoMIPS: Fix an FP-related misnomer 2
  disas: nanoMIPS: Fix an FP-related misnomer 3

 disas/nanomips.cpp | 1441 +++++++++++++++++++-------------------------
 disas/nanomips.h   |   72 +--
 2 files changed, 641 insertions(+), 872 deletions(-)

-- 
2.17.1

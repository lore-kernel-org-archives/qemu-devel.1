Received: from eggs.gnu.org ([2001:4830:134:3::10]:48506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYvXv-00046e-Oe
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYvXq-00044p-01
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:07 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36744 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYvXo-0003Uj-J4
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:00 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 17:13:42 +0100
Message-Id: <20181217161347.4270-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/5] disas: nanoMIPS: Clean up several issues
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
phase. Complete cleanup should happen in next few months.

Aleksandar Markovic (5):
  disas: nanoMIPS: Fix preamble text
  disas: nanoMIPS: Remove functions that are not used
  disas: nanoMIPS: Fix a function misnomer
  disas: nanoMIPS: Fix order of some invocations
  disas: nanoMIPS: Name some function in a more descriptive way

 disas/nanomips.cpp | 1111 ++++++++++++++++++--------------------------
 disas/nanomips.h   |   66 +--
 2 files changed, 473 insertions(+), 704 deletions(-)

-- 
2.17.1

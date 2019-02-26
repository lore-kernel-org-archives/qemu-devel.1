Received: from eggs.gnu.org ([209.51.188.92]:57075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyblu-0007Bu-FM
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyblr-00071k-ER
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:42 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:43211 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gybln-0006wd-M3
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 07:23:37 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Tue, 26 Feb 2019 13:23:11 +0100
Message-Id: <1551183797-13570-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 0/6] target/mips: Add emulation of data
 communication MMI instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

This series adds emulation of PCPYH, PCPYLD, and PCPYUD MMI
instructions.

v2:

  - The patch for PCPYH is split into two patches
  - Cleaned up handler for PCPYH
  - Fixed bugs and cleaned up in handler for PCPYLD 
  - Fixed bugs and cleaned up in handler for PCPYUD
  - Added handler for MMI instruction PEXCH
  - Added handler for MMI instruction PEXCW

Mateja Marjanovic (6):
  target/mips: Preparing for adding MMI instructions
  target/mips: Add emulation of MMI instruction PCPYH
  target/mips: Add emulation of MMI instruction PCPYLD
  target/mips: Add emulation of MMI instruction PCPYUD
  target/mips: Add emulation of MMI instruction PEXCH
  target/mips: Add emulation of MMI instruction PEXCW

 target/mips/translate.c | 365 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 358 insertions(+), 7 deletions(-)

-- 
2.7.4

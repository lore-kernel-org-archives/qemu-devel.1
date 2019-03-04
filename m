Received: from eggs.gnu.org ([209.51.188.92]:57092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIb-0003z9-Ri
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1h0pIa-0007na-TX
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:37 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:39135 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1h0pIa-0006Kk-Jc
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:14:36 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon,  4 Mar 2019 16:13:12 +0100
Message-Id: <1551712405-2530-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 00/13] target/mips: Add emulation of data
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

v3:
  - Added MMI instructions PEXEH, PEXEW, PEXTLB, PEXTLH, PEXTLW,
  PEXTUB, PEXTUH, and PEXTUW
  - Minor bugs fixed from previous patches

v2:

  - The patch for PCPYH is split into two patches
  - Cleaned up handler for PCPYH
  - Fixed bugs and cleaned up in handler for PCPYLD 
  - Fixed bugs and cleaned up in handler for PCPYUD
  - Added handler for MMI instruction PEXCH
  - Added handler for MMI instruction PEXCW

Mateja Marjanovic (13):
  target/mips: Add emulation of MMI instruction PCPYH
  target/mips: Add emulation of MMI instruction PCPYLD
  target/mips: Add emulation of MMI instruction PCPYUD
  target/mips: Add emulation of MMI instruction PEXCH
  target/mips: Add emulation of MMI instruction PEXCW
  target/mips: Add emulation of MMI instruction PEXEH
  target/mips: Add emulation of MMI instruction PEXEW
  target/mips: Add emulation of MMI instruction PEXTLB
  target/mips: Add emulation of MMI instruction PEXTLH
  target/mips: Add emulation of MMI instruction PEXTLW
  target/mips: Add emulation of MMI instruction PEXTUB
  target/mips: Add emulation of MMI instruction PEXTUH
  target/mips: Add emulation of MMI instruction PEXTUW

 target/mips/translate.c | 909 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 896 insertions(+), 13 deletions(-)

-- 
2.7.4

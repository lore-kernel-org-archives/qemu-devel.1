Received: from eggs.gnu.org ([209.51.188.92]:52472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyIrV-0000WJ-03
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1gyIrU-0003Hg-D8
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:12:12 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53603 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1gyIrU-0002cZ-5v
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:12:12 -0500
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Mon, 25 Feb 2019 17:10:34 +0100
Message-Id: <1551111037-23411-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 0/3] target/mips: Add emulation of three MMI
 instructions
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

Mateja Marjanovic (3):
  target/mips: Add emulation of MMI instruction PCPYH
  target/mips: Add emulation of MMI instruction PCPYLD
  target/mips: Add emulation of MMI instruction PCPYUD

 target/mips/translate.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 194 insertions(+), 5 deletions(-)

-- 
2.7.4

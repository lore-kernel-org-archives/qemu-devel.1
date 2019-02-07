Received: from eggs.gnu.org ([209.51.188.92]:35101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1greHo-0002Od-LI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1greHm-0008LD-EU
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:39:52 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:35755)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1greHk-0008H7-Bd
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 02:39:49 -0500
From: David Brenken <david.brenken@efs-auto.org>
Date: Thu,  7 Feb 2019 08:39:26 +0100
Message-Id: <20190207073928.4048-1-david.brenken@efs-auto.org>
Subject: [Qemu-devel] [PATCH 0/2] tricore: fixes for CADD and CADDN
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
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>

From: David Brenken <david.brenken@efs-auto.de>

Hello,

this patch series contains a fix for the RCR CADD and RCR CADDN instruction of the TriCore.
The r4 and r3 registers were swapped.

Best regards

David Brenken

David Brenken (2):
  tricore: fixed RCR_CADD instruction
  tricore: fixed RCR_CADDN instruction

 target/tricore/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPqe1-0003K2-MV
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPqdw-0000C3-NG
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:11:53 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 22 Nov 2018 16:11:40 +0100
Message-Id: <1542899500-23346-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add nios2-related files to the
 Nios2 section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

nios2_iic.c and the default-configs/nios2-softmmu.mak file are
currently "unmaintained" according to the get_maintainers.pl script.
Move them to the Nios2 section where they obviously belong to.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1291c07..33245b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -226,7 +226,9 @@ M: Marek Vasut <marex@denx.de>
 S: Maintained
 F: target/nios2/
 F: hw/nios2/
+F: hw/intc/nios2_iic.c
 F: disas/nios2.c
+F: default-configs/nios2-softmmu.mak
 
 OpenRISC
 M: Stafford Horne <shorne@gmail.com>
-- 
1.8.3.1

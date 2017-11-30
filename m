Received: from eggs.gnu.org ([2001:4830:134:3::10]:42536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKo7U-0001ri-TO
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKo77-0000q7-GS
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:24:56 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 30 Nov 2017 20:12:34 +0100
Message-Id: <1512069154-16814-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12] hw/ide: Remove duplicated definitions
 from ahci_internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>

The same definitions can also be found in include/hw/ide/ahci.h
so let's remove these #defines from ahci_internal.h.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ide/ahci_internal.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index ce2e818..1080a34 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -375,11 +375,4 @@ void ahci_uninit(AHCIState *s);
 
 void ahci_reset(AHCIState *s);
 
-#define TYPE_SYSBUS_AHCI "sysbus-ahci"
-#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBUS_AHCI)
-
-#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
-#define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
-                       TYPE_ALLWINNER_AHCI)
-
 #endif /* HW_IDE_AHCI_H */
-- 
1.8.3.1

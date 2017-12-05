Received: from eggs.gnu.org ([2001:4830:134:3::10]:58153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eM7ND-0000HY-7R
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eM7NC-0002Xr-D8
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:10:35 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  5 Dec 2017 08:10:25 +0100
Message-Id: <1512457825-3847-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2] hw/ide: Remove duplicated definitions from
 ahci_internal.h
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
 v2: Also remove TYPE_ICH9_AHCI as suggested by John

 hw/ide/ahci_internal.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index ce2e818..e3e3ed2 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -311,11 +311,6 @@ struct AHCIPCIState {
     AHCIState ahci;
 };
 
-#define TYPE_ICH9_AHCI "ich9-ahci"
-
-#define ICH_AHCI(obj) \
-    OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
-
 extern const VMStateDescription vmstate_ahci;
 
 #define VMSTATE_AHCI(_field, _state) {                               \
@@ -375,11 +370,4 @@ void ahci_uninit(AHCIState *s);
 
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

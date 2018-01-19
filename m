Received: from eggs.gnu.org ([2001:4830:134:3::10]:57665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecfCg-0007kv-U6
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecfCg-0005QQ-40
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ecfCf-0005NU-UZ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 17:32:06 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 17:31:59 -0500
Message-Id: <20180119223159.29890-5-jsnow@redhat.com>
In-Reply-To: <20180119223159.29890-1-jsnow@redhat.com>
References: <20180119223159.29890-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] hw/ide: Remove duplicated definitions from
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Thomas Huth <thuth@redhat.com>

The same definitions can also be found in include/hw/ide/ahci.h
so let's remove these #defines from ahci_internal.h.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 1512457825-3847-1-git-send-email-thuth@redhat.com
[Maintainer edit: publicize object names, privatize object macros.]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci_internal.h | 4 ----
 include/hw/ide/ahci.h  | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index ce2e818c8c..8c755d4ca1 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -311,8 +311,6 @@ struct AHCIPCIState {
     AHCIState ahci;
 };
 
-#define TYPE_ICH9_AHCI "ich9-ahci"
-
 #define ICH_AHCI(obj) \
     OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
 
@@ -375,10 +373,8 @@ void ahci_uninit(AHCIState *s);
 
 void ahci_reset(AHCIState *s);
 
-#define TYPE_SYSBUS_AHCI "sysbus-ahci"
 #define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBUS_AHCI)
 
-#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
 #define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
                        TYPE_ALLWINNER_AHCI)
 
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 5a06537e6b..b7bb2b02d6 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -54,14 +54,10 @@ typedef struct AHCIPCIState AHCIPCIState;
 
 #define TYPE_ICH9_AHCI "ich9-ahci"
 
-#define ICH_AHCI(obj) \
-    OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
-
 int32_t ahci_get_num_ports(PCIDevice *dev);
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
 
 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
-#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBUS_AHCI)
 
 typedef struct SysbusAHCIState {
     /*< private >*/
@@ -73,8 +69,6 @@ typedef struct SysbusAHCIState {
 } SysbusAHCIState;
 
 #define TYPE_ALLWINNER_AHCI "allwinner-ahci"
-#define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
-                       TYPE_ALLWINNER_AHCI)
 
 #define ALLWINNER_AHCI_MMIO_OFF  0x80
 #define ALLWINNER_AHCI_MMIO_SIZE 0x80
-- 
2.14.3

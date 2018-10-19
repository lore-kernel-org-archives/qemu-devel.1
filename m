Received: from eggs.gnu.org ([2001:4830:134:3::10]:43001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDE-0003lZ-TK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDNDD-0000Fw-PE
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:40 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDNDD-0008WP-DD
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:20:39 -0400
Received: by mail-pl1-x643.google.com with SMTP id bh10-v6so1967509plb.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:20:33 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 18 Oct 2018 22:20:08 -0700
Message-Id: <1539926412-21831-4-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
References: <1539926412-21831-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 3/7] vfio: drop TYPE_FOO MACRO in
 VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, philmd@redhat.com, Li Qiang <liq3ea@gmail.com>

As the vmstate structure names aren't related with
the QOM type names.
Per Peter's mail:
-->https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02175.html

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/vfio/amd-xgbe.c      | 2 +-
 hw/vfio/ap.c            | 2 +-
 hw/vfio/calxeda-xgmac.c | 2 +-
 hw/vfio/ccw.c           | 2 +-
 hw/vfio/platform.c      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index ee64a3b..1b06c0f 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -26,7 +26,7 @@ static void amd_xgbe_realize(DeviceState *dev, Error **errp)
 }
 
 static const VMStateDescription vfio_platform_amd_xgbe_vmstate = {
-    .name = TYPE_VFIO_AMD_XGBE,
+    .name = "vfio-amd-xgbe",
     .unmigratable = 1,
 };
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index b332395..35b01b3 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -147,7 +147,7 @@ static void vfio_ap_reset(DeviceState *dev)
 }
 
 static const VMStateDescription vfio_ap_vmstate = {
-    .name = TYPE_VFIO_AP_DEVICE,
+    .name = "vfio-ap",
     .unmigratable = 1,
 };
 
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index e7767c4..6cc608b 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -26,7 +26,7 @@ static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
 }
 
 static const VMStateDescription vfio_platform_calxeda_xgmac_vmstate = {
-    .name = TYPE_VFIO_CALXEDA_XGMAC,
+    .name = "vfio-calxeda-xgmac",
     .unmigratable = 1,
 };
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 9246729..4786d46 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -466,7 +466,7 @@ static Property vfio_ccw_properties[] = {
 };
 
 static const VMStateDescription vfio_ccw_vmstate = {
-    .name = TYPE_VFIO_CCW,
+    .name = "vfio-ccw",
     .unmigratable = 1,
 };
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 64c1af6..ba03dcd 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -697,7 +697,7 @@ out:
 }
 
 static const VMStateDescription vfio_platform_vmstate = {
-    .name = TYPE_VFIO_PLATFORM,
+    .name = "vfio-platform",
     .unmigratable = 1,
 };
 
-- 
1.8.3.1

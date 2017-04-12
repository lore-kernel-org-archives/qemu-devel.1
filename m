Received: from eggs.gnu.org ([2001:4830:134:3::10]:39670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cyM7p-00017M-Fy
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cyM7o-0001Ro-FC
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:32:13 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Apr 2017 19:32:03 +0200
Message-Id: <20170412173203.20072-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] arm: remove remaining
 cannot_destroy_with_object_finalize_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Antony Pavlov <antonynpavlov@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Laurent Vivier <lvivier@redhat.com>

With commit ce5b1bbf624b ("exec: move cpu_exec_init() calls to
realize functions"), we can now remove all the
remaining cannot_destroy_with_object_finalize_yet as
unsafe references have been moved to cpu_exec_realizefn().
(tested with QOM command provided by commit 4c315c27).

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/arm/allwinner-a10.c | 6 ------
 hw/arm/bcm2836.c       | 6 ------
 hw/arm/digic.c         | 6 ------
 hw/arm/fsl-imx25.c     | 5 -----
 hw/arm/fsl-imx31.c     | 5 -----
 hw/arm/fsl-imx6.c      | 5 -----
 hw/arm/xlnx-zynqmp.c   | 6 ------
 7 files changed, 39 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index ca15d1c..f62a9a3 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -118,12 +118,6 @@ static void aw_a10_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = aw_a10_realize;
-
-    /*
-     * Reason: creates an ARM CPU, thus use after free(), see
-     * arm_cpu_class_init()
-     */
-    dc->cannot_destroy_with_object_finalize_yet = true;
 }
 
 static const TypeInfo aw_a10_type_info = {
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8451190..8c43291 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -160,12 +160,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
 
     dc->props = bcm2836_props;
     dc->realize = bcm2836_realize;
-
-    /*
-     * Reason: creates an ARM CPU, thus use after free(), see
-     * arm_cpu_class_init()
-     */
-    dc->cannot_destroy_with_object_finalize_yet = true;
 }
 
 static const TypeInfo bcm2836_type_info = {
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index d60ea39..94f3263 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -101,12 +101,6 @@ static void digic_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = digic_realize;
-
-    /*
-     * Reason: creates an ARM CPU, thus use after free(), see
-     * arm_cpu_class_init()
-     */
-    dc->cannot_destroy_with_object_finalize_yet = true;
 }
 
 static const TypeInfo digic_type_info = {
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 2126f73..9056f27 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -290,11 +290,6 @@ static void fsl_imx25_class_init(ObjectClass *oc, void *data)
 
     dc->realize = fsl_imx25_realize;
 
-    /*
-     * Reason: creates an ARM CPU, thus use after free(), see
-     * arm_cpu_class_init()
-     */
-    dc->cannot_destroy_with_object_finalize_yet = true;
     dc->desc = "i.MX25 SOC";
 }
 
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index dd1c713..d7e2d83 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -262,11 +262,6 @@ static void fsl_imx31_class_init(ObjectClass *oc, void *data)
 
     dc->realize = fsl_imx31_realize;
 
-    /*
-     * Reason: creates an ARM CPU, thus use after free(), see
-     * arm_cpu_class_init()
-     */
-    dc->cannot_destroy_with_object_finalize_yet = true;
     dc->desc = "i.MX31 SOC";
 }
 
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 76dd8a4..6969e73 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -442,11 +442,6 @@ static void fsl_imx6_class_init(ObjectClass *oc, void *data)
 
     dc->realize = fsl_imx6_realize;
 
-    /*
-     * Reason: creates an ARM CPU, thus use after free(), see
-     * arm_cpu_class_init()
-     */
-    dc->cannot_destroy_with_object_finalize_yet = true;
     dc->desc = "i.MX6 SOC";
 }
 
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index bc4e66b..4f67158 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -439,12 +439,6 @@ static void xlnx_zynqmp_class_init(ObjectClass *oc, void *data)
 
     dc->props = xlnx_zynqmp_props;
     dc->realize = xlnx_zynqmp_realize;
-
-    /*
-     * Reason: creates an ARM CPU, thus use after free(), see
-     * arm_cpu_class_init()
-     */
-    dc->cannot_destroy_with_object_finalize_yet = true;
 }
 
 static const TypeInfo xlnx_zynqmp_type_info = {
-- 
2.9.3

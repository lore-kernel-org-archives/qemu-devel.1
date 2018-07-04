Received: from eggs.gnu.org ([2001:4830:134:3::10]:46257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fahDy-0007SZ-Iw
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fahDx-0000UC-Qx
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:49:34 -0400
From: Andrew Jones <drjones@redhat.com>
Date: Wed,  4 Jul 2018 14:49:18 +0200
Message-Id: <20180704124923.32483-2-drjones@redhat.com>
In-Reply-To: <20180704124923.32483-1-drjones@redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 1/6] hw/arm/virt: Add virt-3.1 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, imammedo@redhat.com, eric.auger@redhat.com, wei@redhat.com

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 281ddcdf6e26..880441275031 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1757,10 +1757,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-#define VIRT_COMPAT_2_12 \
-    HW_COMPAT_2_12
-
-static void virt_3_0_instance_init(Object *obj)
+static void virt_3_1_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1830,10 +1827,24 @@ static void virt_3_0_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
+static void virt_machine_3_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
+
+static void virt_3_0_instance_init(Object *obj)
+{
+    virt_3_1_instance_init(obj);
+}
+
 static void virt_machine_3_0_options(MachineClass *mc)
 {
+    virt_machine_3_1_options(mc);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(3, 0)
+DEFINE_VIRT_MACHINE(3, 0)
+
+#define VIRT_COMPAT_2_12 \
+    HW_COMPAT_2_12
 
 static void virt_2_12_instance_init(Object *obj)
 {
-- 
2.17.1

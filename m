Received: from eggs.gnu.org ([2001:4830:134:3::10]:40005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1degXu-0002C4-Ad
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1degXp-0006ma-Ii
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:50:06 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  7 Aug 2017 11:49:41 +0000
Message-Id: <1502106581-11714-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] hw/arm/virt: Add 2.10 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com

Add virt-2.10 machine type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 hw/arm/virt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 31739d7..6b7a0fe 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1639,7 +1639,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_2_9_instance_init(Object *obj)
+static void virt_2_10_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1699,10 +1699,25 @@ static void virt_2_9_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
+static void virt_machine_2_10_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(2, 10)
+
+#define VIRT_COMPAT_2_9 \
+    HW_COMPAT_2_9
+
+static void virt_2_9_instance_init(Object *obj)
+{
+    virt_2_10_instance_init(obj);
+}
+
 static void virt_machine_2_9_options(MachineClass *mc)
 {
+    virt_machine_2_10_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_9);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(2, 9)
+DEFINE_VIRT_MACHINE(2, 9)
 
 #define VIRT_COMPAT_2_8 \
     HW_COMPAT_2_8
-- 
1.9.1

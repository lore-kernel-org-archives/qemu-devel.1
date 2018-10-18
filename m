Received: from eggs.gnu.org ([2001:4830:134:3::10]:36164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Kw-0005sJ-HO
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Kv-0007IH-NG
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:42 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 18 Oct 2018 16:30:32 +0200
Message-Id: <20181018143042.29588-7-eric.auger@redhat.com>
In-Reply-To: <20181018143042.29588-1-eric.auger@redhat.com>
References: <20181018143042.29588-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 06/16] hw/arm/virt: Add virt-3.2 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

Add virt-3.2 machine type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9f677825f9..f920ef247b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1796,7 +1796,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_3_1_instance_init(Object *obj)
+static void virt_3_2_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1866,10 +1866,21 @@ static void virt_3_1_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
-static void virt_machine_3_1_options(MachineClass *mc)
+static void virt_machine_3_2_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
+DEFINE_VIRT_MACHINE_AS_LATEST(3, 2)
+
+static void virt_3_1_instance_init(Object *obj)
+{
+    virt_3_2_instance_init(obj);
+}
+
+static void virt_machine_3_1_options(MachineClass *mc)
+{
+    virt_machine_3_2_options(mc);
+}
+DEFINE_VIRT_MACHINE(3, 1)
 
 static void virt_3_0_instance_init(Object *obj)
 {
-- 
2.17.1

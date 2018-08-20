Received: from eggs.gnu.org ([2001:4830:134:3::10]:37060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUF-0003ql-2F
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUD-0005YD-3X
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUC-0005XU-QJ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUB-00039e-7R
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:31:59 +0100
Message-Id: <20180820103212.2810-13-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/25] hw/arm/virt: Add virt-3.1 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Jones <drjones@redhat.com>

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0807be985c0..0b57f87abcb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1791,10 +1791,7 @@ static void machvirt_machine_init(void)
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
@@ -1864,10 +1861,24 @@ static void virt_3_0_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
-static void virt_machine_3_0_options(MachineClass *mc)
+static void virt_machine_3_1_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(3, 0)
+DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
+
+static void virt_3_0_instance_init(Object *obj)
+{
+    virt_3_1_instance_init(obj);
+}
+
+static void virt_machine_3_0_options(MachineClass *mc)
+{
+    virt_machine_3_1_options(mc);
+}
+DEFINE_VIRT_MACHINE(3, 0)
+
+#define VIRT_COMPAT_2_12 \
+    HW_COMPAT_2_12
 
 static void virt_2_12_instance_init(Object *obj)
 {
-- 
2.18.0

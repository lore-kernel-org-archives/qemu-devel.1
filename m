Received: from eggs.gnu.org ([2001:4830:134:3::10]:37374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNu-0008Bi-Sc
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNt-0002py-UF
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:38 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ebRNt-0002gG-NS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:34:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ebRNk-0002qG-3e
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 13:34:28 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:33:58 +0000
Message-Id: <1516109659-1557-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
References: <1516109659-1557-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/24] hw/arm/virt: Add virt-2.12 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add virt-2.12 machine type.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 151592b..543f9bd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1618,7 +1618,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_2_11_instance_init(Object *obj)
+static void virt_2_12_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1678,10 +1678,25 @@ static void virt_2_11_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
+static void virt_machine_2_12_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(2, 12)
+
+#define VIRT_COMPAT_2_11 \
+    HW_COMPAT_2_11
+
+static void virt_2_11_instance_init(Object *obj)
+{
+    virt_2_12_instance_init(obj);
+}
+
 static void virt_machine_2_11_options(MachineClass *mc)
 {
+    virt_machine_2_12_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_11);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(2, 11)
+DEFINE_VIRT_MACHINE(2, 11)
 
 #define VIRT_COMPAT_2_10 \
     HW_COMPAT_2_10
-- 
2.7.4

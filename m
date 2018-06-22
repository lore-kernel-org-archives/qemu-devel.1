Received: from eggs.gnu.org ([2001:4830:134:3::10]:49814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcy-0003Q9-DH
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcx-000560-La
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLcx-00051P-EU
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLcw-0003u9-CP
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:57 +0100
Message-Id: <20180622125713.15303-13-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/28] hw/arm/virt: Add virt-3.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

Add virt-3.0 machine type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 1529072910-16156-10-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 933e60612dd..d8abf89e8c8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1745,7 +1745,7 @@ type_init(machvirt_machine_init);
 #define VIRT_COMPAT_2_12 \
     HW_COMPAT_2_12
 
-static void virt_2_12_instance_init(Object *obj)
+static void virt_3_0_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
@@ -1813,11 +1813,22 @@ static void virt_2_12_instance_init(Object *obj)
     vms->irqmap = a15irqmap;
 }
 
+static void virt_machine_3_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(3, 0)
+
+static void virt_2_12_instance_init(Object *obj)
+{
+    virt_3_0_instance_init(obj);
+}
+
 static void virt_machine_2_12_options(MachineClass *mc)
 {
+    virt_machine_3_0_options(mc);
     SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(2, 12)
+DEFINE_VIRT_MACHINE(2, 12)
 
 #define VIRT_COMPAT_2_11 \
     HW_COMPAT_2_11
-- 
2.17.1

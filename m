Received: from eggs.gnu.org ([2001:4830:134:3::10]:35390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZk-0002B3-Il
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZj-0001Fk-Og
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:04 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZj-0001FV-Iv
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:03 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZi-0003tM-OJ
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:02 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:02 +0000
Message-Id: <1482852077-19397-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/25] hw/arm/virt: add 2.9 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 include/hw/compat.h |  3 +++
 hw/arm/virt.c       | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 8dfc7a3..4fe44d1 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_8 \
+    /* empty */
+
 #define HW_COMPAT_2_7 \
     {\
         .driver   = "virtio-pci",\
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d04e4ac..11c53a5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1525,7 +1525,7 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_2_8_instance_init(Object *obj)
+static void virt_2_9_instance_init(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
@@ -1558,10 +1558,25 @@ static void virt_2_8_instance_init(Object *obj)
                                     "Valid values are 2, 3 and host", NULL);
 }
 
+static void virt_machine_2_9_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(2, 9)
+
+#define VIRT_COMPAT_2_8 \
+    HW_COMPAT_2_8
+
+static void virt_2_8_instance_init(Object *obj)
+{
+    virt_2_9_instance_init(obj);
+}
+
 static void virt_machine_2_8_options(MachineClass *mc)
 {
+    virt_machine_2_9_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_8);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(2, 8)
+DEFINE_VIRT_MACHINE(2, 8)
 
 #define VIRT_COMPAT_2_7 \
     HW_COMPAT_2_7
-- 
2.7.4

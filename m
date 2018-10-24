Received: from eggs.gnu.org ([2001:4830:134:3::10]:56343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gFEy1-0007EL-CO
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 04:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gFExs-00031i-PW
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 04:56:39 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 24 Oct 2018 10:56:02 +0200
Message-Id: <20181024085602.16611-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/virt: Set VIRT_COMPAT_3_0 compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: drjones@redhat.com

We are missing the VIRT_COMPAT_3_0 definition and setting.
Let's add them.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9f677825f9..a2b8d8f7c2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1871,6 +1871,9 @@ static void virt_machine_3_1_options(MachineClass *mc)
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
 
+#define VIRT_COMPAT_3_0 \
+    HW_COMPAT_3_0
+
 static void virt_3_0_instance_init(Object *obj)
 {
     virt_3_1_instance_init(obj);
@@ -1879,6 +1882,7 @@ static void virt_3_0_instance_init(Object *obj)
 static void virt_machine_3_0_options(MachineClass *mc)
 {
     virt_machine_3_1_options(mc);
+    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_0);
 }
 DEFINE_VIRT_MACHINE(3, 0)
 
-- 
2.17.2

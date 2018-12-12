Received: from eggs.gnu.org ([2001:4830:134:3::10]:43546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Er-000684-EH
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Ep-0006Xv-DN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:33 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 12 Dec 2018 10:55:15 +0100
Message-Id: <20181212095519.6390-3-cohuck@redhat.com>
In-Reply-To: <20181212095519.6390-1-cohuck@redhat.com>
References: <20181212095519.6390-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] s390x: introduce 4.0 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a0615a8b35..fd9d0b0542 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -651,6 +651,9 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+#define CCW_COMPAT_3_1 \
+        HW_COMPAT_3_1
+
 #define CCW_COMPAT_3_0 \
         HW_COMPAT_3_0
 
@@ -742,14 +745,26 @@ bool css_migration_enabled(void)
             .value    = "0",\
         },
 
+static void ccw_machine_4_0_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_4_0_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(4_0, "4.0", true);
+
 static void ccw_machine_3_1_instance_options(MachineState *machine)
 {
+    ccw_machine_4_0_instance_options(machine);
 }
 
 static void ccw_machine_3_1_class_options(MachineClass *mc)
 {
+    ccw_machine_4_0_class_options(mc);
+    SET_MACHINE_COMPAT(mc, CCW_COMPAT_3_1);
 }
-DEFINE_CCW_MACHINE(3_1, "3.1", true);
+DEFINE_CCW_MACHINE(3_1, "3.1", false);
 
 static void ccw_machine_3_0_instance_options(MachineState *machine)
 {
-- 
2.17.2

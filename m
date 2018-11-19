Received: from eggs.gnu.org ([2001:4830:134:3::10]:60807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gOhNP-0008J7-3y
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gOhNL-0005rr-Hk
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:05:59 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 19 Nov 2018 12:05:48 +0100
Message-Id: <20181119110548.812-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0] s390x: introduce 4.0 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
 include/hw/compat.h        |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

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
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 6f4d5fc647..70958328fe 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_3_1 \
+    /* empty */
+
 #define HW_COMPAT_3_0 \
     /* empty */
 
-- 
2.17.2

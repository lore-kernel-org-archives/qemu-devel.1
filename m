Received: from eggs.gnu.org ([2001:4830:134:3::10]:33965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5u-0004Ia-Sz
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEV5r-00071Q-Jt
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:25:30 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 May 2018 09:25:00 +0200
Message-Id: <20180504072514.8450-2-cohuck@redhat.com>
In-Reply-To: <20180504072514.8450-1-cohuck@redhat.com>
References: <20180504072514.8450-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] s390x: introduce 2.13 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 435f7c99e7..c84098dd17 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -671,6 +671,9 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+#define CCW_COMPAT_2_12 \
+        HW_COMPAT_2_12
+
 #define CCW_COMPAT_2_11 \
         HW_COMPAT_2_11 \
         {\
@@ -756,14 +759,26 @@ bool css_migration_enabled(void)
             .value    = "0",\
         },
 
+static void ccw_machine_2_13_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_2_13_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(2_13, "2.13", true);
+
 static void ccw_machine_2_12_instance_options(MachineState *machine)
 {
+    ccw_machine_2_13_instance_options(machine);
 }
 
 static void ccw_machine_2_12_class_options(MachineClass *mc)
 {
+    ccw_machine_2_13_class_options(mc);
+    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_12);
 }
-DEFINE_CCW_MACHINE(2_12, "2.12", true);
+DEFINE_CCW_MACHINE(2_12, "2.12", false);
 
 static void ccw_machine_2_11_instance_options(MachineState *machine)
 {
-- 
2.14.3

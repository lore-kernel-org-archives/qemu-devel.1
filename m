Received: from eggs.gnu.org ([2001:4830:134:3::10]:37035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4iD-0000rN-3h
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fL4iC-0004l5-2x
	for qemu-devel@nongnu.org; Tue, 22 May 2018 06:40:13 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 11:39:58 +0100
Message-Id: <20180522104000.9044-4-peter.maydell@linaro.org>
In-Reply-To: <20180522104000.9044-1-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/5] hw/s390x: Rename 2.13 machines to 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

Rename the 2.13 machines to match the number we're going to
use for the next release.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e548d341a0..7ae5fb38dd 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -812,23 +812,23 @@ bool css_migration_enabled(void)
             .value    = "0",\
         },
 
-static void ccw_machine_2_13_instance_options(MachineState *machine)
+static void ccw_machine_3_0_instance_options(MachineState *machine)
 {
 }
 
-static void ccw_machine_2_13_class_options(MachineClass *mc)
+static void ccw_machine_3_0_class_options(MachineClass *mc)
 {
 }
-DEFINE_CCW_MACHINE(2_13, "2.13", true);
+DEFINE_CCW_MACHINE(3_0, "3.0", true);
 
 static void ccw_machine_2_12_instance_options(MachineState *machine)
 {
-    ccw_machine_2_13_instance_options(machine);
+    ccw_machine_3_0_instance_options(machine);
 }
 
 static void ccw_machine_2_12_class_options(MachineClass *mc)
 {
-    ccw_machine_2_13_class_options(mc);
+    ccw_machine_3_0_class_options(mc);
     SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_12);
 }
 DEFINE_CCW_MACHINE(2_12, "2.12", false);
-- 
2.17.0

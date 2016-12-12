Received: from eggs.gnu.org ([2001:4830:134:3::10]:44894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGHsv-0004Ef-Uw
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 23:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGHss-0004kj-QC
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 23:06:41 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 12 Dec 2016 15:05:59 +1100
Message-Id: <20161212040603.27295-2-david@gibson.dropbear.id.au>
In-Reply-To: <20161212040603.27295-1-david@gibson.dropbear.id.au>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv3 1/5] pseries: Add pseries-2.9 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: paulus@samba.org, sjitindarsingh@gmail.com
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c      | 23 +++++++++++++++++++++--
 include/hw/compat.h |  3 +++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cfadc46..0f25e83 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2761,18 +2761,37 @@ static const TypeInfo spapr_machine_info = {
     type_init(spapr_machine_register_##suffix)
 
 /*
+ * pseries-2.9
+ */
+static void spapr_machine_2_9_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_2_9_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(2_9, "2.9", true);
+
+/*
  * pseries-2.8
  */
+#define SPAPR_COMPAT_2_8                            \
+    HW_COMPAT_2_8
+
 static void spapr_machine_2_8_instance_options(MachineState *machine)
 {
+    spapr_machine_2_9_instance_options(machine);
 }
 
 static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_2_9_class_options(mc);
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
 }
 
-DEFINE_SPAPR_MACHINE(2_8, "2.8", true);
+DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
 
 /*
  * pseries-2.7
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 0f06e11..f8b8354 100644
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
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jo-0007M6-I9
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jk-0003h0-GG
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:13:31 +1100
Message-Id: <20170202051445.5735-34-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 033/107] pseries: Add pseries-2.9 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f2edbd0..a175609 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2774,18 +2774,37 @@ static const TypeInfo spapr_machine_info = {
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
-- 
2.9.3

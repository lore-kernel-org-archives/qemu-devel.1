Received: from eggs.gnu.org ([2001:4830:134:3::10]:55865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2THw-0001Fh-Gm
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2THv-0003H8-Mn
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:42 +1000
Message-Id: <20170424015927.8933-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/47] pseries: Add pseries-2.10 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 35db949..de5db75 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3158,18 +3158,37 @@ static const TypeInfo spapr_machine_info = {
     type_init(spapr_machine_register_##suffix)
 
 /*
+ * pseries-2.10
+ */
+static void spapr_machine_2_10_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_2_10_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(2_10, "2.10", true);
+
+/*
  * pseries-2.9
  */
+#define SPAPR_COMPAT_2_9                                               \
+    HW_COMPAT_2_9
+
 static void spapr_machine_2_9_instance_options(MachineState *machine)
 {
+    spapr_machine_2_10_instance_options(machine);
 }
 
 static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_2_10_class_options(mc);
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
 }
 
-DEFINE_SPAPR_MACHINE(2_9, "2.9", true);
+DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
 
 /*
  * pseries-2.8
-- 
2.9.3

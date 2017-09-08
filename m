Received: from eggs.gnu.org ([2001:4830:134:3::10]:58754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe8-0002Bg-9Y
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqGe2-0003Gz-D6
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:36:24 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  8 Sep 2017 20:35:31 +1000
Message-Id: <20170908103558.31632-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170908103558.31632-1-david@gibson.dropbear.id.au>
References: <20170908103558.31632-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/40] spapr: add pseries-2.11 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sam.bobroff@au1.ibm.com, imammedo@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 954fd1a747..a0c5923776 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3563,18 +3563,36 @@ static const TypeInfo spapr_machine_info = {
     type_init(spapr_machine_register_##suffix)
 
 /*
+ * pseries-2.11
+ */
+static void spapr_machine_2_11_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_2_11_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
+
+/*
  * pseries-2.10
  */
+#define SPAPR_COMPAT_2_10                                              \
+    HW_COMPAT_2_10                                                     \
+
 static void spapr_machine_2_10_instance_options(MachineState *machine)
 {
 }
 
 static void spapr_machine_2_10_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_2_11_class_options(mc);
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
 }
 
-DEFINE_SPAPR_MACHINE(2_10, "2.10", true);
+DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
 
 /*
  * pseries-2.9
-- 
2.13.5

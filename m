Received: from eggs.gnu.org ([2001:4830:134:3::10]:59906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzac-0002EW-7O
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaa-0002L7-Nn
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:50 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:02 +1000
Message-Id: <20180427092126.24812-26-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 25/49] spapr: Introduce pseries-2.13 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c      | 23 +++++++++++++++++++++--
 include/hw/compat.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 92194a9a53..b92dad2273 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3984,19 +3984,38 @@ static const TypeInfo spapr_machine_info = {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-2.13
+ */
+static void spapr_machine_2_13_instance_options(MachineState *machine)
+{
+}
+
+static void spapr_machine_2_13_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(2_13, "2.13", true);
+
 /*
  * pseries-2.12
  */
+#define SPAPR_COMPAT_2_12                                              \
+    HW_COMPAT_2_12
+
 static void spapr_machine_2_12_instance_options(MachineState *machine)
 {
+    spapr_machine_2_13_instance_options(machine);
 }
 
 static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_2_13_class_options(mc);
+    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
 }
 
-DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
+DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
 
 static void spapr_machine_2_12_sxxm_instance_options(MachineState *machine)
 {
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 13242b831a..4681c2719a 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,8 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_12
+
 #define HW_COMPAT_2_11 \
     {\
         .driver   = "hpet",\
-- 
2.14.3

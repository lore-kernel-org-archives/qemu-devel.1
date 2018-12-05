Received: from eggs.gnu.org ([2001:4830:134:3::10]:59444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUeGS-0008Ju-6e
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:59:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gUeGN-0003au-Mz
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:59:24 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed,  5 Dec 2018 18:58:26 -0200
Message-Id: <20181205205827.19387-5-ehabkost@redhat.com>
In-Reply-To: <20181205205827.19387-1-ehabkost@redhat.com>
References: <20181205205827.19387-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 4/5] spapr: Delete instance_options
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

Now that all instance_options functions for spapr are empty,
delete them.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/ppc/spapr.c | 85 --------------------------------------------------
 1 file changed, 85 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0c3b27a8cc..523e5d83f8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3939,16 +3939,10 @@ static const TypeInfo spapr_machine_info = {
             mc->is_default = 1;                                      \
         }                                                            \
     }                                                                \
-    static void spapr_machine_##suffix##_instance_init(Object *obj)  \
-    {                                                                \
-        MachineState *machine = MACHINE(obj);                        \
-        spapr_machine_##suffix##_instance_options(machine);          \
-    }                                                                \
     static const TypeInfo spapr_machine_##suffix##_info = {          \
         .name = MACHINE_TYPE_NAME("pseries-" verstr),                \
         .parent = TYPE_SPAPR_MACHINE,                                \
         .class_init = spapr_machine_##suffix##_class_init,           \
-        .instance_init = spapr_machine_##suffix##_instance_init,     \
     };                                                               \
     static void spapr_machine_register_##suffix(void)                \
     {                                                                \
@@ -3959,10 +3953,6 @@ static const TypeInfo spapr_machine_info = {
 /*
  * pseries-4.0
  */
-static void spapr_machine_4_0_instance_options(MachineState *machine)
-{
-}
-
 static void spapr_machine_4_0_class_options(MachineClass *mc)
 {
     /* Defaults for the latest behaviour inherited from the base class */
@@ -3976,11 +3966,6 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
 #define SPAPR_COMPAT_3_1                                              \
     HW_COMPAT_3_1
 
-static void spapr_machine_3_1_instance_options(MachineState *machine)
-{
-    spapr_machine_4_0_instance_options(machine);
-}
-
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
     spapr_machine_3_1_class_options(mc);
@@ -3995,11 +3980,6 @@ DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
 #define SPAPR_COMPAT_3_0                                              \
     HW_COMPAT_3_0
 
-static void spapr_machine_3_0_instance_options(MachineState *machine)
-{
-    spapr_machine_3_1_instance_options(machine);
-}
-
 static void spapr_machine_3_0_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
@@ -4029,11 +4009,6 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
         .value    = "on",                                              \
     },
 
-static void spapr_machine_2_12_instance_options(MachineState *machine)
-{
-    spapr_machine_3_0_instance_options(machine);
-}
-
 static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
@@ -4051,11 +4026,6 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
 
-static void spapr_machine_2_12_sxxm_instance_options(MachineState *machine)
-{
-    spapr_machine_2_12_instance_options(machine);
-}
-
 static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
@@ -4074,11 +4044,6 @@ DEFINE_SPAPR_MACHINE(2_12_sxxm, "2.12-sxxm", false);
 #define SPAPR_COMPAT_2_11                                              \
     HW_COMPAT_2_11
 
-static void spapr_machine_2_11_instance_options(MachineState *machine)
-{
-    spapr_machine_2_12_instance_options(machine);
-}
-
 static void spapr_machine_2_11_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
@@ -4096,11 +4061,6 @@ DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
 #define SPAPR_COMPAT_2_10                                              \
     HW_COMPAT_2_10
 
-static void spapr_machine_2_10_instance_options(MachineState *machine)
-{
-    spapr_machine_2_11_instance_options(machine);
-}
-
 static void spapr_machine_2_10_class_options(MachineClass *mc)
 {
     spapr_machine_2_11_class_options(mc);
@@ -4120,11 +4080,6 @@ DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
         .value    = "on",                                              \
     },                                                                 \
 
-static void spapr_machine_2_9_instance_options(MachineState *machine)
-{
-    spapr_machine_2_10_instance_options(machine);
-}
-
 static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
@@ -4149,11 +4104,6 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
         .value    = "off",                                      \
     },
 
-static void spapr_machine_2_8_instance_options(MachineState *machine)
-{
-    spapr_machine_2_9_instance_options(machine);
-}
-
 static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
     spapr_machine_2_9_class_options(mc);
@@ -4238,11 +4188,6 @@ static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
      */
 }
 
-static void spapr_machine_2_7_instance_options(MachineState *machine)
-{
-    spapr_machine_2_8_instance_options(machine);
-}
-
 static void spapr_machine_2_7_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
@@ -4267,11 +4212,6 @@ DEFINE_SPAPR_MACHINE(2_7, "2.7", false);
         .value    = stringify(off),\
     },
 
-static void spapr_machine_2_6_instance_options(MachineState *machine)
-{
-    spapr_machine_2_7_instance_options(machine);
-}
-
 static void spapr_machine_2_6_class_options(MachineClass *mc)
 {
     spapr_machine_2_7_class_options(mc);
@@ -4292,11 +4232,6 @@ DEFINE_SPAPR_MACHINE(2_6, "2.6", false);
         .value    = "off", \
     },
 
-static void spapr_machine_2_5_instance_options(MachineState *machine)
-{
-    spapr_machine_2_6_instance_options(machine);
-}
-
 static void spapr_machine_2_5_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
@@ -4314,11 +4249,6 @@ DEFINE_SPAPR_MACHINE(2_5, "2.5", false);
 #define SPAPR_COMPAT_2_4 \
         HW_COMPAT_2_4
 
-static void spapr_machine_2_4_instance_options(MachineState *machine)
-{
-    spapr_machine_2_5_instance_options(machine);
-}
-
 static void spapr_machine_2_4_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
@@ -4341,11 +4271,6 @@ DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
             .value    = "off",\
         },
 
-static void spapr_machine_2_3_instance_options(MachineState *machine)
-{
-    spapr_machine_2_4_instance_options(machine);
-}
-
 static void spapr_machine_2_3_class_options(MachineClass *mc)
 {
     spapr_machine_2_4_class_options(mc);
@@ -4365,11 +4290,6 @@ DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
             .value    = "0x20000000",\
         },
 
-static void spapr_machine_2_2_instance_options(MachineState *machine)
-{
-    spapr_machine_2_3_instance_options(machine);
-}
-
 static void spapr_machine_2_2_class_options(MachineClass *mc)
 {
     spapr_machine_2_3_class_options(mc);
@@ -4384,11 +4304,6 @@ DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
 #define SPAPR_COMPAT_2_1 \
         HW_COMPAT_2_1
 
-static void spapr_machine_2_1_instance_options(MachineState *machine)
-{
-    spapr_machine_2_2_instance_options(machine);
-}
-
 static void spapr_machine_2_1_class_options(MachineClass *mc)
 {
     spapr_machine_2_2_class_options(mc);
-- 
2.18.0.rc1.1.g3f1ff2140

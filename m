Received: from eggs.gnu.org ([2001:4830:134:3::10]:50979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ediEc-0007QV-Ks
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ediEb-00021r-Pt
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:58:26 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ediEb-00021S-HL
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 14:58:25 -0500
Received: by mail-lf0-x241.google.com with SMTP id a204so12136510lfa.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 11:58:25 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 22 Jan 2018 11:58:03 -0800
Message-Id: <1516651083-14706-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 08/10] target/xtensa: allow different
 default CPU for MMU/noMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Define default core for noMMU configurations and use that core as
machine default with noMMU XTFPGA machines.
This is done to avoid offering non-working configuration (MMU core on a
noMMU machine) as a default.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- use fsf core for both MMU and noMMU in qemu-system-xtensaeb

 hw/xtensa/xtfpga.c  | 16 ++++++++--------
 target/xtensa/cpu.h |  7 ++++++-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 74ba8ba22996..76ea9702150b 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -584,10 +584,10 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "lx60 noMMU EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
+    mc->desc = "lx60 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
     mc->init = xtfpga_lx60_nommu_init;
     mc->max_cpus = 4;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
 }
 
 static const TypeInfo xtfpga_lx60_nommu_type = {
@@ -616,10 +616,10 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "lx200 noMMU EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
+    mc->desc = "lx200 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
     mc->init = xtfpga_lx200_nommu_init;
     mc->max_cpus = 4;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
 }
 
 static const TypeInfo xtfpga_lx200_nommu_type = {
@@ -648,10 +648,10 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "ml605 noMMU EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
+    mc->desc = "ml605 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
     mc->init = xtfpga_ml605_nommu_init;
     mc->max_cpus = 4;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
 }
 
 static const TypeInfo xtfpga_ml605_nommu_type = {
@@ -680,10 +680,10 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "kc705 noMMU EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
+    mc->desc = "kc705 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
     mc->init = xtfpga_kc705_nommu_init;
     mc->max_cpus = 4;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
 }
 
 static const TypeInfo xtfpga_kc705_nommu_type = {
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index d9404aa50ab5..f300c02c07c8 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -503,10 +503,15 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 
 #ifdef TARGET_WORDS_BIGENDIAN
 #define XTENSA_DEFAULT_CPU_MODEL "fsf"
+#define XTENSA_DEFAULT_CPU_NOMMU_MODEL "fsf"
 #else
 #define XTENSA_DEFAULT_CPU_MODEL "dc232b"
+#define XTENSA_DEFAULT_CPU_NOMMU_MODEL "de212"
 #endif
-#define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)
+#define XTENSA_DEFAULT_CPU_TYPE \
+    XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)
+#define XTENSA_DEFAULT_CPU_NOMMU_TYPE \
+    XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_NOMMU_MODEL)
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
 
-- 
2.1.4

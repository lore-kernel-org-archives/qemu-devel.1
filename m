Received: from eggs.gnu.org ([2001:4830:134:3::10]:55623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuX-0005S9-Hq
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuW-00008z-KS
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47855)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuW-000080-C2
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:56 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:29 +0100
Message-Id: <1516203816-19374-18-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 17/24] xtensa: cpu: rename
 XTENSA_DEFAULT_CPU_TYPE to TARGET_DEFAULT_CPU_TYPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>

so naming would be in line with other targets and null-machine.c which
uses the later would compile.

Later it also would be used as default for *-user targets which is
currently bogus cpu model 'any', that errors out.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h | 2 +-
 hw/xtensa/sim.c     | 2 +-
 hw/xtensa/xtfpga.c  | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index d9404aa..537e151 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -506,7 +506,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 #else
 #define XTENSA_DEFAULT_CPU_MODEL "dc232b"
 #endif
-#define XTENSA_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)
+#define TARGET_DEFAULT_CPU_TYPE XTENSA_CPU_TYPE_NAME(XTENSA_DEFAULT_CPU_MODEL)
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_XTENSA_CPU, cpu_model)
 
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 2bb883b..58a79bd 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -128,7 +128,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->init = xtensa_sim_init;
     mc->max_cpus = 4;
     mc->no_serial = 1;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
 }
 
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 1971ecf..c2b0aa4 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -449,7 +449,7 @@ static void xtensa_lx60_class_init(ObjectClass *oc, void *data)
     mc->desc = "lx60 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_lx60_init;
     mc->max_cpus = 4;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
 }
 
 static const TypeInfo xtensa_lx60_type = {
@@ -465,7 +465,7 @@ static void xtensa_lx200_class_init(ObjectClass *oc, void *data)
     mc->desc = "lx200 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_lx200_init;
     mc->max_cpus = 4;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
 }
 
 static const TypeInfo xtensa_lx200_type = {
@@ -481,7 +481,7 @@ static void xtensa_ml605_class_init(ObjectClass *oc, void *data)
     mc->desc = "ml605 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_ml605_init;
     mc->max_cpus = 4;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
 }
 
 static const TypeInfo xtensa_ml605_type = {
@@ -497,7 +497,7 @@ static void xtensa_kc705_class_init(ObjectClass *oc, void *data)
     mc->desc = "kc705 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtensa_kc705_init;
     mc->max_cpus = 4;
-    mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
 }
 
 static const TypeInfo xtensa_kc705_type = {
-- 
2.7.4

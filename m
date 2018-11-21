Received: from eggs.gnu.org ([2001:4830:134:3::10]:48447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPXhy-0002Q8-Md
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPXhw-00073A-C0
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:58:42 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gPXhv-0006ts-Oa
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 13:58:40 -0500
Received: by mail-lf1-x144.google.com with SMTP id a16so4780039lfg.3
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 10:58:25 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 21 Nov 2018 10:58:10 -0800
Message-Id: <20181121185810.24647-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] target/xtensa: xtfpga: provide default
 memory sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

Provide default RAM sizes for all XTFPGA boards, so that when started
without -m option they do the right thing.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Changes v2->v3:
- add XTFPGA_MMU_RESERVED_MEMORY_SIZE definition and express Xilinx board
  memory sizes using it as suggested by Philippe;

Changes v1->v2:
- fix memory sizes for ml605 and kc705 with MMU


 hw/xtensa/xtfpga.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index b3161de32093..21094319a659 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -446,6 +446,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     }
 }
 
+#define XTFPGA_MMU_RESERVED_MEMORY_SIZE (128 * MiB)
+
 static const hwaddr xtfpga_mmu_io[2] = {
     0xf0000000,
 };
@@ -568,6 +570,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_lx60_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size = 64 * MiB;
 }
 
 static const TypeInfo xtfpga_lx60_type = {
@@ -584,6 +587,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_lx60_nommu_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size = 64 * MiB;
 }
 
 static const TypeInfo xtfpga_lx60_nommu_type = {
@@ -600,6 +604,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_lx200_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size = 96 * MiB;
 }
 
 static const TypeInfo xtfpga_lx200_type = {
@@ -616,6 +621,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_lx200_nommu_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size = 96 * MiB;
 }
 
 static const TypeInfo xtfpga_lx200_nommu_type = {
@@ -632,6 +638,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_ml605_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size = 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
 }
 
 static const TypeInfo xtfpga_ml605_type = {
@@ -648,6 +655,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_ml605_nommu_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size = 256 * MiB;
 }
 
 static const TypeInfo xtfpga_ml605_nommu_type = {
@@ -664,6 +672,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_kc705_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size = 1 * GiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
 }
 
 static const TypeInfo xtfpga_kc705_type = {
@@ -680,6 +689,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_kc705_nommu_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size = 256 * MiB;
 }
 
 static const TypeInfo xtfpga_kc705_nommu_type = {
-- 
2.11.0

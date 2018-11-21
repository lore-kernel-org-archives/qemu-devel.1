Received: from eggs.gnu.org ([2001:4830:134:3::10]:42715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPRdH-0002a9-6z
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPRdF-00076d-9V
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:29:27 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gPRdD-0006zR-BN
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:29:25 -0500
Received: by mail-pl1-x644.google.com with SMTP id b5-v6so5353327pla.6
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 04:29:21 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 21 Nov 2018 04:29:10 -0800
Message-Id: <20181121122910.20631-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2] target/xtensa: xtfpga: provide default
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
---
Changes v1->v2:
- fix memory sizes for ml605 and kc705 with MMU

 hw/xtensa/xtfpga.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index b3161de32093..f9d41c5d1875 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -568,6 +568,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_lx60_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size = 64 * MiB;
 }
 
 static const TypeInfo xtfpga_lx60_type = {
@@ -584,6 +585,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_lx60_nommu_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size = 64 * MiB;
 }
 
 static const TypeInfo xtfpga_lx60_nommu_type = {
@@ -600,6 +602,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_lx200_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size = 96 * MiB;
 }
 
 static const TypeInfo xtfpga_lx200_type = {
@@ -616,6 +619,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_lx200_nommu_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size = 96 * MiB;
 }
 
 static const TypeInfo xtfpga_lx200_nommu_type = {
@@ -632,6 +636,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_ml605_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size = 384 * MiB;
 }
 
 static const TypeInfo xtfpga_ml605_type = {
@@ -648,6 +653,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_ml605_nommu_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size = 256 * MiB;
 }
 
 static const TypeInfo xtfpga_ml605_nommu_type = {
@@ -664,6 +670,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_kc705_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->default_ram_size = 896 * MiB;
 }
 
 static const TypeInfo xtfpga_kc705_type = {
@@ -680,6 +687,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
     mc->init = xtfpga_kc705_nommu_init;
     mc->max_cpus = 4;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
+    mc->default_ram_size = 256 * MiB;
 }
 
 static const TypeInfo xtfpga_kc705_nommu_type = {
-- 
2.11.0

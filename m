Received: from eggs.gnu.org ([2001:4830:134:3::10]:50162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPCn2-0004Lo-QU
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gPCn0-0007ay-Nj
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:38:32 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gPCmy-0007Up-M0
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:38:30 -0500
Received: by mail-lj1-x243.google.com with SMTP id 83-v6so2818503ljf.10
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 12:38:26 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 20 Nov 2018 12:38:11 -0800
Message-Id: <20181120203811.18406-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: xtfpga: provide default memory
 sizes
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

Provide default RAM sizes for all XTFPGA boards, so that when started
without -m option they do the right thing.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index b3161de32093..7c1421d5beb4 100644
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
+    mc->default_ram_size = 256 * MiB;
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
+    mc->default_ram_size = 1 * GiB;
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

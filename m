Received: from eggs.gnu.org ([209.51.188.92]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnwVd-0008Vu-89
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:18:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnwVc-00015c-Fe
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:18:49 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:43623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gnwVc-00014z-8h
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:18:48 -0500
Received: by mail-lf1-x142.google.com with SMTP id u18so10666447lff.10
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 18:18:48 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 27 Jan 2019 18:18:35 -0800
Message-Id: <20190128021835.24451-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/xtensa: xtfpga: raise CPU number limit
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

MX PIC can support up to 32 CPUs on xtfpga boards, raise per-board
limit accordingly.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 792a225e03a2..1d21162a2773 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -599,7 +599,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "lx60 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtfpga_lx60_init;
-    mc->max_cpus = 4;
+    mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 64 * MiB;
 }
@@ -616,7 +616,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "lx60 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
     mc->init = xtfpga_lx60_nommu_init;
-    mc->max_cpus = 4;
+    mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 64 * MiB;
 }
@@ -633,7 +633,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "lx200 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtfpga_lx200_init;
-    mc->max_cpus = 4;
+    mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 96 * MiB;
 }
@@ -650,7 +650,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "lx200 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
     mc->init = xtfpga_lx200_nommu_init;
-    mc->max_cpus = 4;
+    mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 96 * MiB;
 }
@@ -667,7 +667,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "ml605 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtfpga_ml605_init;
-    mc->max_cpus = 4;
+    mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
 }
@@ -684,7 +684,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "ml605 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
     mc->init = xtfpga_ml605_nommu_init;
-    mc->max_cpus = 4;
+    mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
 }
@@ -701,7 +701,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "kc705 EVB (" XTENSA_DEFAULT_CPU_MODEL ")";
     mc->init = xtfpga_kc705_init;
-    mc->max_cpus = 4;
+    mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 1 * GiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
 }
@@ -718,7 +718,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "kc705 noMMU EVB (" XTENSA_DEFAULT_CPU_NOMMU_MODEL ")";
     mc->init = xtfpga_kc705_nommu_init;
-    mc->max_cpus = 4;
+    mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
 }
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiK-0002qe-Cg
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgIiH-0004SX-Vv
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgIiH-0004Rr-N5
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 17:15:13 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 23:14:52 +0100
Message-Id: <1487715299-21102-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/9] sparc: use sparc_graphic_* defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

This switches over sparc to use the new sparc_graphic_* defines.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/sparc/sun4m.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index f5b6efd..1aaad68 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -908,43 +908,43 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     ledma = sparc32_dma_init(hwdef->dma_base + 16ULL,
                              slavio_irq[16], iommu, &ledma_irq, 1);
 
-    if (graphic_depth != 8 && graphic_depth != 24) {
-        error_report("Unsupported depth: %d", graphic_depth);
+    if (sparc_graphic_depth != 8 && sparc_graphic_depth != 24) {
+        error_report("Unsupported depth: %d", sparc_graphic_depth);
         exit (1);
     }
     num_vsimms = 0;
     if (num_vsimms == 0) {
         if (vga_interface_type == VGA_CG3) {
-            if (graphic_depth != 8) {
-                error_report("Unsupported depth: %d", graphic_depth);
+            if (sparc_graphic_depth != 8) {
+                error_report("Unsupported depth: %d", sparc_graphic_depth);
                 exit(1);
             }
 
-            if (!(graphic_width == 1024 && graphic_height == 768) &&
-                !(graphic_width == 1152 && graphic_height == 900)) {
-                error_report("Unsupported resolution: %d x %d", graphic_width,
-                             graphic_height);
+            if (!(sparc_graphic_width == 1024 && sparc_graphic_height == 768) &&
+                !(sparc_graphic_width == 1152 && sparc_graphic_height == 900)) {
+                error_report("Unsupported resolution: %d x %d", sparc_graphic_width,
+                             sparc_graphic_height);
                 exit(1);
             }
 
             /* sbus irq 5 */
             cg3_init(hwdef->tcx_base, slavio_irq[11], 0x00100000,
-                     graphic_width, graphic_height, graphic_depth);
+                     sparc_graphic_width, sparc_graphic_height, sparc_graphic_depth);
         } else {
             /* If no display specified, default to TCX */
-            if (graphic_depth != 8 && graphic_depth != 24) {
-                error_report("Unsupported depth: %d", graphic_depth);
+            if (sparc_graphic_depth != 8 && sparc_graphic_depth != 24) {
+                error_report("Unsupported depth: %d", sparc_graphic_depth);
                 exit(1);
             }
 
-            if (!(graphic_width == 1024 && graphic_height == 768)) {
+            if (!(sparc_graphic_width == 1024 && sparc_graphic_height == 768)) {
                 error_report("Unsupported resolution: %d x %d",
-                             graphic_width, graphic_height);
+                             sparc_graphic_width, sparc_graphic_height);
                 exit(1);
             }
 
             tcx_init(hwdef->tcx_base, slavio_irq[11], 0x00100000,
-                     graphic_width, graphic_height, graphic_depth);
+                     sparc_graphic_width, sparc_graphic_height, sparc_graphic_depth);
         }
     }
 
@@ -1025,7 +1025,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
 
     nvram_init(nvram, (uint8_t *)&nd_table[0].macaddr, machine->kernel_cmdline,
                machine->boot_order, machine->ram_size, kernel_size,
-               graphic_width, graphic_height, graphic_depth,
+               sparc_graphic_width, sparc_graphic_height, sparc_graphic_depth,
                hwdef->nvram_machine_id, "Sun4m");
 
     if (hwdef->ecc_base)
@@ -1037,9 +1037,9 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, hwdef->machine_id);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_DEPTH, graphic_depth);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_WIDTH, graphic_width);
-    fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_HEIGHT, graphic_height);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_DEPTH, sparc_graphic_depth);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_WIDTH, sparc_graphic_width);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_SUN4M_HEIGHT, sparc_graphic_height);
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, KERNEL_LOAD_ADDR);
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
     if (machine->kernel_cmdline) {
-- 
1.8.3.1

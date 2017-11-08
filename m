Received: from eggs.gnu.org ([2001:4830:134:3::10]:34094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLP-0007p6-Dw
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLM-000385-49
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:15 -0500
Received: from mail-by2nam01on0080.outbound.protection.outlook.com
	([104.47.34.80]:28357
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZLL-00036p-MO
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:12 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:56:59 -0800
Message-ID: <530b263ffcce137748560534ca5a802533ee1347.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 11/45] hw/display: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
V2:
 - Split hw patch into individual directories

 hw/display/blizzard.c      | 20 ++++++++++----------
 hw/display/omap_dss.c      | 14 +++++++-------
 hw/display/pl110.c         |  2 +-
 hw/display/pxa2xx_lcd.c    |  2 +-
 hw/display/qxl-render.c    |  7 +++----
 hw/display/qxl.c           | 10 +++++-----
 hw/display/tc6393xb.c      | 36 ++++++++++++++++++++----------------
 hw/display/virtio-gpu-3d.c |  4 ++--
 hw/display/vmware_vga.c    | 22 +++++++++++-----------
 9 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/hw/display/blizzard.c b/hw/display/blizzard.c
index 291abe6fca..0d12e078c4 100644
--- a/hw/display/blizzard.c
+++ b/hw/display/blizzard.c
@@ -474,7 +474,7 @@ static uint16_t blizzard_reg_read(void *opaque, uint8_t reg)
         return s->gpio_pdown;
 
     default:
-        fprintf(stderr, "%s: unknown register %02x\n", __func__, reg);
+        error_report("%s: unknown register %02x", __func__, reg);
         return 0;
     }
 }
@@ -501,7 +501,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
     case 0x0c:	/* PLL Mode Control 0 */
         s->pll_mode = value & 0x77;
         if ((value & 3) == 0 || (value & 3) == 3)
-            fprintf(stderr, "%s: wrong PLL Control bits (%i)\n",
+            error_report("%s: wrong PLL Control bits (%i)",
                     __func__, value & 3);
         break;
 
@@ -541,7 +541,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
     case 0x28:	/* LCD Panel Configuration */
         s->lcd_config = value & 0xff;
         if (value & (1 << 7))
-            fprintf(stderr, "%s: data swap not supported!\n", __func__);
+            error_report("%s: data swap not supported!", __func__);
         break;
 
     case 0x2a:	/* LCD Horizontal Display Width */
@@ -585,7 +585,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
     case 0x40:	/* High-speed Serial Interface Tx Configuration Port 1 */
         s->hssi_config[1] = value;
         if (((value >> 4) & 3) == 3)
-            fprintf(stderr, "%s: Illegal active-data-links value\n",
+            error_report("%s: Illegal active-data-links value",
                             __func__);
         break;
     case 0x42:	/* High-speed Serial Interface Tx Mode */
@@ -641,7 +641,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
         s->enable = value & 1;
         s->blank = (value >> 1) & 1;
         if (value & (1 << 4))
-            fprintf(stderr, "%s: Macrovision enable attempt!\n", __func__);
+            error_report("%s: Macrovision enable attempt!", __func__);
         break;
 
     case 0x6a:	/* Special Effects */
@@ -717,7 +717,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
         s->iformat = value & 0xf;
         s->bpp = blizzard_iformat_bpp[s->iformat];
         if (!s->bpp)
-            fprintf(stderr, "%s: Illegal or unsupported input format %x\n",
+            error_report("%s: Illegal or unsupported input format %x",
                             __func__, s->iformat);
         break;
     case 0x8e:	/* Data Source Select */
@@ -729,7 +729,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
                                         s->iy[1] != s->oy[1])) ||
                         !((s->ix[1] - s->ix[0]) & (s->iy[1] - s->iy[0]) &
                           (s->ox[1] - s->ox[0]) & (s->oy[1] - s->oy[0]) & 1))
-            fprintf(stderr, "%s: Illegal input/output window positions\n",
+            error_report("%s: Illegal input/output window positions",
                             __func__);
 
         blizzard_transfer_setup(s);
@@ -783,8 +783,8 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
     case 0xe6:	/* Power-save */
         s->pm = value & 0x83;
         if (value & s->mode & 1)
-            fprintf(stderr, "%s: The display must be disabled before entering "
-                            "Standby Mode\n", __func__);
+            error_report("%s: The display must be disabled before entering "
+                         "Standby Mode", __func__);
         break;
     case 0xe8:	/* Non-display Period Control / Status */
         s->status = value & 0x1b;
@@ -815,7 +815,7 @@ static void blizzard_reg_write(void *opaque, uint8_t reg, uint16_t value)
         break;
 
     default:
-        fprintf(stderr, "%s: unknown register %02x\n", __func__, reg);
+        error_report("%s: unknown register %02x", __func__, reg);
         break;
     }
 }
diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
index 601f178fdd..52d6e753d3 100644
--- a/hw/display/omap_dss.c
+++ b/hw/display/omap_dss.c
@@ -406,10 +406,10 @@ static void omap_disc_write(void *opaque, hwaddr addr,
         s->lcd.enable = (value >> 0) & 1;
         if (value & (1 << 12))			/* OVERLAY_OPTIMIZATION */
             if (!((s->dispc.l[1].attr | s->dispc.l[2].attr) & 1)) {
-                fprintf(stderr, "%s: Overlay Optimization when no overlay "
-                        "region effectively exists leads to "
-                        "unpredictable behaviour!\n", __func__);
-            }
+                error_report("%s: Overlay Optimization when no overlay "
+                             "region effectively exists leads to "
+                             "unpredictable behaviour!", __func__);
+           }
         if (value & (1 << 6)) {				/* GODIGITAL */
             /* XXX: Shadowed fields are:
              * s->dispc.config
@@ -525,8 +525,8 @@ static void omap_disc_write(void *opaque, hwaddr addr,
     case 0x0a0:	/* DISPC_GFX_ATTRIBUTES */
         s->dispc.l[0].attr = value & 0x7ff;
         if (value & (3 << 9))
-            fprintf(stderr, "%s: Big-endian pixel format not supported\n",
-                            __func__);
+            error_report("%s: Big-endian pixel format not supported",
+                         __func__);
         s->dispc.l[0].enable = value & 1;
         s->dispc.l[0].bpp = (value >> 1) & 0xf;
         s->dispc.invalidate = 1;
@@ -617,7 +617,7 @@ static void omap_rfbi_transfer_start(struct omap_dss_s *s)
     if (s->rfbi.control & (1 << 1)) {				/* BYPASS */
         /* TODO: in non-Bypass mode we probably need to just assert the
          * DRQ and wait for DMA to write the pixels.  */
-        fprintf(stderr, "%s: Bypass mode unimplemented\n", __func__);
+        error_report("%s: Bypass mode unimplemented", __func__);
         return;
     }
 
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 8c7dcc6f0a..b8b7903d36 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -174,7 +174,7 @@ static void pl110_update_display(void *opaque)
         dest_width = 4;
         break;
     default:
-        fprintf(stderr, "pl110: Bad color depth\n");
+        error_report("pl110: Bad color depth");
         exit(1);
     }
     if (s->cr & PL110_CR_BGR)
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index b83f80753a..ae3a365849 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -1050,7 +1050,7 @@ PXA2xxLCDState *pxa2xx_lcdc_init(MemoryRegion *sysmem,
         s->dest_width = 4;
         break;
     default:
-        fprintf(stderr, "%s: Bad color depth\n", __func__);
+        error_report("%s: Bad color depth", __func__);
         exit(1);
     }
 
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index e7ac4f8789..0cd07028a4 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -78,7 +78,7 @@ void qxl_render_resize(PCIQXLDevice *qxl)
         qxl->guest_primary.bits_pp = 32;
         break;
     default:
-        fprintf(stderr, "%s: unhandled format: %x\n", __func__,
+        error_report("%s: unhandled format: %x", __func__,
                 qxl->guest_primary.surface.format);
         qxl->guest_primary.bytes_pp = 4;
         qxl->guest_primary.bits_pp = 32;
@@ -247,7 +247,7 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
         }
         break;
     default:
-        fprintf(stderr, "%s: not implemented: type %d\n",
+        error_report("%s: not implemented: type %d",
                 __func__, cursor->header.type);
         goto fail;
     }
@@ -275,9 +275,8 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
     }
 
     if (qxl->debug > 1 && cmd->type != QXL_CURSOR_MOVE) {
-        fprintf(stderr, "%s", __func__);
+        error_report("%s", __func__);
         qxl_log_cmd_cursor(qxl, cmd, ext->group_id);
-        fprintf(stderr, "\n");
     }
     switch (cmd->type) {
     case QXL_CURSOR_SET:
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 99365c3e8f..2e3ae5b90c 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -875,7 +875,7 @@ static void interface_notify_update(QXLInstance *sin, uint32_t update_id)
      * Probably was at some earlier version that is prior to git start (2009),
      * and is still guest trigerrable.
      */
-    fprintf(stderr, "%s: deprecated\n", __func__);
+    error_report("%s: deprecated", __func__);
 }
 
 /* called from spice server thread context only */
@@ -905,7 +905,7 @@ static void interface_async_complete_io(PCIQXLDevice *qxl, QXLCookie *cookie)
 
     trace_qxl_interface_async_complete_io(qxl->id, current_async, cookie);
     if (!cookie) {
-        fprintf(stderr, "qxl: %s: error, cookie is NULL\n", __func__);
+        error_report("qxl: %s: error, cookie is NULL", __func__);
         return;
     }
     if (cookie && current_async != cookie->io) {
@@ -930,7 +930,7 @@ static void interface_async_complete_io(PCIQXLDevice *qxl, QXLCookie *cookie)
         qxl_spice_destroy_surface_wait_complete(qxl, cookie->u.surface_id);
         break;
     default:
-        fprintf(stderr, "qxl: %s: unexpected current_async %d\n", __func__,
+        error_report("qxl: %s: unexpected current_async %d", __func__,
                 current_async);
     }
     qxl_send_events(qxl, QXL_INTERRUPT_IO_CMD);
@@ -998,7 +998,7 @@ static void interface_async_complete(QXLInstance *sin, uint64_t cookie_token)
     case QXL_COOKIE_TYPE_POST_LOAD_MONITORS_CONFIG:
         break;
     default:
-        fprintf(stderr, "qxl: %s: unexpected cookie type %d\n",
+        error_report("qxl: %s: unexpected cookie type %d",
                 __func__, cookie->type);
         g_free(cookie);
     }
@@ -1875,7 +1875,7 @@ static void qxl_send_events(PCIQXLDevice *d, uint32_t events)
     trace_qxl_send_events(d->id, events);
     if (!qemu_spice_display_is_running(&d->ssd)) {
         /* spice-server tracks guest running state and should not do this */
-        fprintf(stderr, "%s: spice-server bug: guest stopped, ignoring\n",
+        error_report("%s: spice-server bug: guest stopped, ignoring",
                 __func__);
         trace_qxl_send_events_vm_stopped(d->id, events);
         return;
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 79f161740a..8b708a858b 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -159,7 +159,7 @@ void tc6393xb_gpio_out_set(TC6393xbState *s, int line,
                     qemu_irq handler)
 {
     if (line >= TC6393XB_GPIOS) {
-        fprintf(stderr, "TC6393xb: no GPIO pin %d\n", line);
+        error_report("TC6393xb: no GPIO pin %d", line);
         return;
     }
 
@@ -190,7 +190,7 @@ static void tc6393xb_l3v(void *opaque, int line, int level)
 {
     TC6393xbState *s = opaque;
     s->blank = !level;
-    fprintf(stderr, "L3V: %d\n", level);
+    error_report("L3V: %d", level);
 }
 
 static void tc6393xb_sub_irq(void *opaque, int line, int level) {
@@ -257,7 +257,7 @@ static uint32_t tc6393xb_scr_readb(TC6393xbState *s, hwaddr addr)
         SCR_REG_B(CONFIG);
         SCR_REG_B(DEBUG);
     }
-    fprintf(stderr, "tc6393xb_scr: unhandled read at %08x\n", (uint32_t) addr);
+    error_report("tc6393xb_scr: unhandled read at %08x", (uint32_t) addr);
     return 0;
 }
 #undef SCR_REG_B
@@ -318,8 +318,8 @@ static void tc6393xb_scr_writeb(TC6393xbState *s, hwaddr addr, uint32_t value)
         SCR_REG_B(CONFIG);
         SCR_REG_B(DEBUG);
     }
-    fprintf(stderr, "tc6393xb_scr: unhandled write at %08x: %02x\n",
-					(uint32_t) addr, value & 0xff);
+    error_report("tc6393xb_scr: unhandled write at %08x: %02x",
+                 (uint32_t) addr, value & 0xff);
 }
 #undef SCR_REG_B
 #undef SCR_REG_W
@@ -341,7 +341,7 @@ static uint32_t tc6393xb_nand_cfg_readb(TC6393xbState *s, hwaddr addr) {
         case NAND_CFG_BASE + 3:
             return s->nand_phys >> (addr - NAND_CFG_BASE);
     }
-    fprintf(stderr, "tc6393xb_nand_cfg: unhandled read at %08x\n", (uint32_t) addr);
+    error_report("tc6393xb_nand_cfg: unhandled read at %08x", (uint32_t) addr);
     return 0;
 }
 static void tc6393xb_nand_cfg_writeb(TC6393xbState *s, hwaddr addr, uint32_t value) {
@@ -357,7 +357,7 @@ static void tc6393xb_nand_cfg_writeb(TC6393xbState *s, hwaddr addr, uint32_t val
             s->nand_phys |= (value & 0xff) << ((addr - NAND_CFG_BASE) * 8);
             return;
     }
-    fprintf(stderr, "tc6393xb_nand_cfg: unhandled write at %08x: %02x\n",
+    error_report("tc6393xb_nand_cfg: unhandled write at %08x: %02x",
 					(uint32_t) addr, value & 0xff);
 }
 
@@ -377,12 +377,14 @@ static uint32_t tc6393xb_nand_readb(TC6393xbState *s, hwaddr addr) {
         case NAND_IMR:
             return s->nand.imr;
     }
-    fprintf(stderr, "tc6393xb_nand: unhandled read at %08x\n", (uint32_t) addr);
+    error_report("tc6393xb_nand: unhandled read at %08x", (uint32_t) addr);
     return 0;
 }
-static void tc6393xb_nand_writeb(TC6393xbState *s, hwaddr addr, uint32_t value) {
-//    fprintf(stderr, "tc6393xb_nand: write at %08x: %02x\n",
-//					(uint32_t) addr, value & 0xff);
+static void tc6393xb_nand_writeb(TC6393xbState *s, hwaddr addr, uint32_t value)
+{
+    /* error_report("tc6393xb_nand: write at %08x: %02x",
+     *              (uint32_t) addr, value & 0xff);
+     */
     switch (addr) {
         case NAND_DATA + 0:
         case NAND_DATA + 1:
@@ -420,7 +422,7 @@ static void tc6393xb_nand_writeb(TC6393xbState *s, hwaddr addr, uint32_t value)
             tc6393xb_nand_irq(s);
             return;
     }
-    fprintf(stderr, "tc6393xb_nand: unhandled write at %08x: %02x\n",
+    error_report("tc6393xb_nand: unhandled write at %08x: %02x",
 					(uint32_t) addr, value & 0xff);
 }
 
@@ -522,13 +524,15 @@ static uint64_t tc6393xb_readb(void *opaque, hwaddr addr,
     };
 
     if ((addr &~0xff) == s->nand_phys && s->nand_enable) {
-//        return tc6393xb_nand_readb(s, addr & 0xff);
+        /* return tc6393xb_nand_readb(s, addr & 0xff); */
         uint8_t d = tc6393xb_nand_readb(s, addr & 0xff);
-//        fprintf(stderr, "tc6393xb_nand: read at %08x: %02hhx\n", (uint32_t) addr, d);
+        /* error_report("tc6393xb_nand: read at %08x: %02hhx",
+         *              (uint32_t) addr, d);
+         */
         return d;
     }
 
-//    fprintf(stderr, "tc6393xb: unhandled read at %08x\n", (uint32_t) addr);
+    /* error_report("tc6393xb: unhandled read at %08x", (uint32_t) addr); */
     return 0;
 }
 
@@ -548,7 +552,7 @@ static void tc6393xb_writeb(void *opaque, hwaddr addr,
     if ((addr &~0xff) == s->nand_phys && s->nand_enable)
         tc6393xb_nand_writeb(s, addr & 0xff, value);
     else
-        fprintf(stderr, "tc6393xb: unhandled write at %08x: %02x\n",
+        error_report("tc6393xb: unhandled write at %08x: %02x",
                 (uint32_t) addr, (int)value & 0xff);
 }
 
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index 8c106a662d..88bc1c84a6 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -473,7 +473,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         return;
     }
     if (cmd->error) {
-        fprintf(stderr, "%s: ctrl 0x%x, error 0x%x\n", __func__,
+        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
                 cmd->cmd_hdr.type, cmd->error);
         virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
         return;
@@ -556,7 +556,7 @@ static void virtio_gpu_print_stats(void *opaque)
     VirtIOGPU *g = opaque;
 
     if (g->stats.requests) {
-        fprintf(stderr, "stats: vq req %4d, %3d -- 3D %4d (%5d)\n",
+        error_report("stats: vq req %4d, %3d -- 3D %4d (%5d)",
                 g->stats.requests,
                 g->stats.max_inflight,
                 g->stats.req_3d,
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index cdc3fed6ca..a8a2b470bc 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -293,45 +293,45 @@ static inline bool vmsvga_verify_rect(DisplaySurface *surface,
                                       int x, int y, int w, int h)
 {
     if (x < 0) {
-        fprintf(stderr, "%s: x was < 0 (%d)\n", name, x);
+        error_report("%s: x was < 0 (%d)", name, x);
         return false;
     }
     if (x > SVGA_MAX_WIDTH) {
-        fprintf(stderr, "%s: x was > %d (%d)\n", name, SVGA_MAX_WIDTH, x);
+        error_report("%s: x was > %d (%d)", name, SVGA_MAX_WIDTH, x);
         return false;
     }
     if (w < 0) {
-        fprintf(stderr, "%s: w was < 0 (%d)\n", name, w);
+        error_report("%s: w was < 0 (%d)", name, w);
         return false;
     }
     if (w > SVGA_MAX_WIDTH) {
-        fprintf(stderr, "%s: w was > %d (%d)\n", name, SVGA_MAX_WIDTH, w);
+        error_report("%s: w was > %d (%d)", name, SVGA_MAX_WIDTH, w);
         return false;
     }
     if (x + w > surface_width(surface)) {
-        fprintf(stderr, "%s: width was > %d (x: %d, w: %d)\n",
+        error_report("%s: width was > %d (x: %d, w: %d)",
                 name, surface_width(surface), x, w);
         return false;
     }
 
     if (y < 0) {
-        fprintf(stderr, "%s: y was < 0 (%d)\n", name, y);
+        error_report("%s: y was < 0 (%d)", name, y);
         return false;
     }
     if (y > SVGA_MAX_HEIGHT) {
-        fprintf(stderr, "%s: y was > %d (%d)\n", name, SVGA_MAX_HEIGHT, y);
+        error_report("%s: y was > %d (%d)", name, SVGA_MAX_HEIGHT, y);
         return false;
     }
     if (h < 0) {
-        fprintf(stderr, "%s: h was < 0 (%d)\n", name, h);
+        error_report("%s: h was < 0 (%d)", name, h);
         return false;
     }
     if (h > SVGA_MAX_HEIGHT) {
-        fprintf(stderr, "%s: h was > %d (%d)\n", name, SVGA_MAX_HEIGHT, h);
+        error_report("%s: h was > %d (%d)", name, SVGA_MAX_HEIGHT, h);
         return false;
     }
     if (y + h > surface_height(surface)) {
-        fprintf(stderr, "%s: update height > %d (y: %d, h: %d)\n",
+        error_report("%s: update height > %d (y: %d, h: %d)",
                 name, surface_height(surface), y, h);
         return false;
     }
@@ -529,7 +529,7 @@ static inline void vmsvga_cursor_define(struct vmsvga_state_s *s,
 #endif
         break;
     default:
-        fprintf(stderr, "%s: unhandled bpp %d, using fallback cursor\n",
+        error_report("%s: unhandled bpp %d, using fallback cursor",
                 __func__, c->bpp);
         cursor_put(qc);
         qc = cursor_builtin_left_ptr();
-- 
2.14.1

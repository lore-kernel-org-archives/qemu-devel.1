Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93179C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BCB2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BCB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmLB-0003zx-ES
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iDmCM-0002ew-TQ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iDmCG-0003VO-6n
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:05:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58121)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iDmC2-0002tw-3r; Fri, 27 Sep 2019 05:05:38 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MIMXC-1iPtgJ1mEO-00EPXv; Fri, 27 Sep 2019 11:05:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v13 6/9] hw/m68k: add Nubus macfb video card
Date: Fri, 27 Sep 2019 11:04:50 +0200
Message-Id: <20190927090453.24712-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927090453.24712-1-laurent@vivier.eu>
References: <20190927090453.24712-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:15WAuy6JTR1LeKV0LGtUBK4B9JSCgDQRUHsrqKDjsFKjPjOoX+k
 Gth6Y9rXmCoIUXuhxdc0r5yzdngRiIuG1oJqdkiu3guI6A/KVA4qKxBARtdK4YEMtV7koRF
 /2+bcQY66SvLE3Q3qO/Sqg+GN5vzYnmHvRuxh6Ya+SPCuM7kOHLVxrbHpoyD+4RtZGBR4Pt
 7RoCb9Jzx2sRLtiGF/qIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uVEfLVQeWsQ=:P1bwlEGCGHqiaauFcrqAb6
 R0bLQj+4tttt/na9urAJ5PVDPrgkuEzJhplXuEZ3gnFbmBknJHzeqsWUT9ahUQgXbri7EWKb1
 VF+K1Da/pD2PQ1psi26MPDARiPRTay4f8pzHQuSGuFjzgbQKhWV16GKcdBGTQBGfJ1kV8fyol
 wANp+G4dWzfBmQrHglfmPHM9XgENA3gXhzd6GzGMl+nBUljiT9NvtdG5k15EehRYK816TRrPZ
 xRr+8jlkbEFC/ZBdvgDU8H3RJrrg9sx3xTphzaEQkDxB0QlGYeX3iEoN4sICA2FLqJyuPga/2
 Xul4aArxojekIJEbs9mUFMPNXt5aKzmja/soYlSF9NSd0ae4k403tAYxRMukVoKyAwIMCqikG
 IR+2Fzh3hNaAdGCSIdAK4gBayiVvRoCTKliTFwoh3YFOWYWklDkt0iV5lWJj7d0sd7FCKtsK0
 enOd8UKwRmKx3bnhgXRG/k9X8sil1kqBhPcbxLp7Iy16QMVhkn8HMcQq8P4CifFz7rCqfoB9U
 tFVKJd4JnNCFiJ7sxxs7xxyZDlRME3GVjCFeDukdwydVAgafLkkmPEYkU1O7fxWZptA/OLhTg
 qUNO9LeH5bOxMzvQLSF0rUfXm5XDKpY0VVp3Hg+Ngl3tGxyVB/+veZgEiuCt6j3HYmm3OOeCc
 t4J1xTTxYglisNtIJEgl0yMA6w76cbNIm4edj899k/ITXM+29mszIwpW9bvSfnjyhvgFVDtFX
 dmncBKZIlAQYlhbiYzk0rnvmEtvpjG/WCrnG6o5tKiuk3z56Y9j9qfSPvByH4Y3ZiTQvnPyxI
 UyqiaZ1gL2hmSGSGeOY3R2+nclwN6GCV9m/nk0jwOObeETZ7mk97nmm3/HXMbtY8b1Zg/4/AJ
 5g2Lbn229yn8lUYmnFN5rJEvdbwFIXSBwRqkr8+z8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds support for a graphic framebuffer device.
This device can be added as a sysbus device or as a NuBus device.

It is accessed as a framebuffer but the color palette can be set.

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS                |   2 +
 arch_init.c                |   4 +
 hw/display/Kconfig         |   5 +
 hw/display/Makefile.objs   |   1 +
 hw/display/macfb.c         | 477 +++++++++++++++++++++++++++++++++++++
 hw/m68k/Kconfig            |   1 +
 include/hw/display/macfb.h |  64 +++++
 qemu-options.hx            |   2 +-
 vl.c                       |   3 +-
 9 files changed, 557 insertions(+), 2 deletions(-)
 create mode 100644 hw/display/macfb.c
 create mode 100644 include/hw/display/macfb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 547b82457e..f31fa3f469 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -922,8 +922,10 @@ M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: hw/misc/mac_via.c
 F: hw/nubus/*
+F: hw/display/macfb.c
 F: include/hw/misc/mac_via.h
 F: include/hw/nubus/*
+F: include/hw/display/macfb.h
 
 MicroBlaze Machines
 -------------------
diff --git a/arch_init.c b/arch_init.c
index 0a1531124c..705d0b94ad 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -38,6 +38,10 @@
 int graphic_width = 1024;
 int graphic_height = 768;
 int graphic_depth = 8;
+#elif defined(TARGET_M68K)
+int graphic_width = 800;
+int graphic_height = 600;
+int graphic_depth = 8;
 #else
 int graphic_width = 800;
 int graphic_height = 600;
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index cbdf7b1a67..c500d1fc6d 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -132,3 +132,8 @@ config ATI_VGA
     select VGA
     select BITBANG_I2C
     select DDC
+
+config MACFB
+    bool
+    select FRAMEBUFFER
+    depends on NUBUS
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 5a4066383b..f2182e3bef 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -26,6 +26,7 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_fimd.o
 common-obj-$(CONFIG_FRAMEBUFFER) += framebuffer.o
 obj-$(CONFIG_MILKYMIST) += milkymist-vgafb.o
 common-obj-$(CONFIG_ZAURUS) += tc6393xb.o
+common-obj-$(CONFIG_MACFB) += macfb.o
 
 obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
 milkymist-tmu2.o-cflags := $(X11_CFLAGS) $(OPENGL_CFLAGS)
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
new file mode 100644
index 0000000000..f4fa8e3206
--- /dev/null
+++ b/hw/display/macfb.c
@@ -0,0 +1,477 @@
+/*
+ * QEMU Motorola 680x0 Macintosh Video Card Emulation
+ *                 Copyright (c) 2012-2018 Laurent Vivier
+ *
+ * some parts from QEMU G364 framebuffer Emulator.
+ *                 Copyright (c) 2007-2011 Herve Poussineau
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "ui/console.h"
+#include "ui/pixel_ops.h"
+#include "hw/nubus/nubus.h"
+#include "hw/display/macfb.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
+#define VIDEO_BASE 0x00001000
+#define DAFB_BASE  0x00800000
+
+#define MACFB_PAGE_SIZE 4096
+#define MACFB_VRAM_SIZE (4 * MiB)
+
+#define DAFB_RESET      0x200
+#define DAFB_LUT        0x213
+
+
+typedef void macfb_draw_line_func(MacfbState *s, uint8_t *d, uint32_t addr,
+                                  int width);
+
+static inline uint8_t macfb_read_byte(MacfbState *s, uint32_t addr)
+{
+    return s->vram[addr & s->vram_bit_mask];
+}
+
+/* 1-bit color */
+static void macfb_draw_line1(MacfbState *s, uint8_t *d, uint32_t addr,
+                             int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        int bit = x & 7;
+        int idx = (macfb_read_byte(s, addr) >> (7 - bit)) & 1;
+        r = g = b  = ((1 - idx) << 7);
+        addr += (bit == 7);
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 2-bit color */
+static void macfb_draw_line2(MacfbState *s, uint8_t *d, uint32_t addr,
+                             int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        int bit = (x & 3);
+        int idx = (macfb_read_byte(s, addr) >> ((3 - bit) << 1)) & 3;
+        r = s->color_palette[idx * 3];
+        g = s->color_palette[idx * 3 + 1];
+        b = s->color_palette[idx * 3 + 2];
+        addr += (bit == 3);
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 4-bit color */
+static void macfb_draw_line4(MacfbState *s, uint8_t *d, uint32_t addr,
+                             int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        int bit = x & 1;
+        int idx = (macfb_read_byte(s, addr) >> ((1 - bit) << 2)) & 15;
+        r = s->color_palette[idx * 3];
+        g = s->color_palette[idx * 3 + 1];
+        b = s->color_palette[idx * 3 + 2];
+        addr += (bit == 1);
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 8-bit color */
+static void macfb_draw_line8(MacfbState *s, uint8_t *d, uint32_t addr,
+                             int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        r = s->color_palette[macfb_read_byte(s, addr) * 3];
+        g = s->color_palette[macfb_read_byte(s, addr) * 3 + 1];
+        b = s->color_palette[macfb_read_byte(s, addr) * 3 + 2];
+        addr++;
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 16-bit color */
+static void macfb_draw_line16(MacfbState *s, uint8_t *d, uint32_t addr,
+                              int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        uint16_t pixel;
+        pixel = (macfb_read_byte(s, addr) << 8) | macfb_read_byte(s, addr + 1);
+        r = ((pixel >> 10) & 0x1f) << 3;
+        g = ((pixel >> 5) & 0x1f) << 3;
+        b = (pixel & 0x1f) << 3;
+        addr += 2;
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+/* 24-bit color */
+static void macfb_draw_line24(MacfbState *s, uint8_t *d, uint32_t addr,
+                              int width)
+{
+    uint8_t r, g, b;
+    int x;
+
+    for (x = 0; x < width; x++) {
+        r = macfb_read_byte(s, addr);
+        g = macfb_read_byte(s, addr + 1);
+        b = macfb_read_byte(s, addr + 2);
+        addr += 3;
+
+        *(uint32_t *)d = rgb_to_pixel32(r, g, b);
+        d += 4;
+    }
+}
+
+
+enum {
+    MACFB_DRAW_LINE1,
+    MACFB_DRAW_LINE2,
+    MACFB_DRAW_LINE4,
+    MACFB_DRAW_LINE8,
+    MACFB_DRAW_LINE16,
+    MACFB_DRAW_LINE24,
+    MACFB_DRAW_LINE_NB,
+};
+
+static macfb_draw_line_func * const
+                              macfb_draw_line_table[MACFB_DRAW_LINE_NB] = {
+    macfb_draw_line1,
+    macfb_draw_line2,
+    macfb_draw_line4,
+    macfb_draw_line8,
+    macfb_draw_line16,
+    macfb_draw_line24,
+};
+
+static int macfb_check_dirty(MacfbState *s, DirtyBitmapSnapshot *snap,
+                             ram_addr_t addr, int len)
+{
+    return memory_region_snapshot_get_dirty(&s->mem_vram, snap, addr, len);
+}
+
+static void macfb_draw_graphic(MacfbState *s)
+{
+    DisplaySurface *surface = qemu_console_surface(s->con);
+    DirtyBitmapSnapshot *snap = NULL;
+    ram_addr_t page;
+    uint32_t v = 0;
+    int y, ymin;
+    int macfb_stride = (s->depth * s->width + 7) / 8;
+    macfb_draw_line_func *macfb_draw_line;
+
+    switch (s->depth) {
+    case 1:
+        v = MACFB_DRAW_LINE1;
+        break;
+    case 2:
+        v = MACFB_DRAW_LINE2;
+        break;
+    case 4:
+        v = MACFB_DRAW_LINE4;
+        break;
+    case 8:
+        v = MACFB_DRAW_LINE8;
+        break;
+    case 16:
+        v = MACFB_DRAW_LINE16;
+        break;
+    case 24:
+        v = MACFB_DRAW_LINE24;
+        break;
+    }
+
+    macfb_draw_line = macfb_draw_line_table[v];
+    assert(macfb_draw_line != NULL);
+
+    snap = memory_region_snapshot_and_clear_dirty(&s->mem_vram, 0x0,
+                                             memory_region_size(&s->mem_vram),
+                                             DIRTY_MEMORY_VGA);
+
+    ymin = -1;
+    page = 0;
+    for (y = 0; y < s->height; y++, page += macfb_stride) {
+        if (macfb_check_dirty(s, snap, page, macfb_stride)) {
+            uint8_t *data_display;
+
+            data_display = surface_data(surface) + y * surface_stride(surface);
+            macfb_draw_line(s, data_display, page, s->width);
+
+            if (ymin < 0) {
+                ymin = y;
+            }
+        } else {
+            if (ymin >= 0) {
+                dpy_gfx_update(s->con, 0, ymin, s->width, y - ymin);
+                ymin = -1;
+            }
+        }
+    }
+
+    if (ymin >= 0) {
+        dpy_gfx_update(s->con, 0, ymin, s->width, y - ymin);
+    }
+
+    g_free(snap);
+}
+
+static void macfb_invalidate_display(void *opaque)
+{
+    MacfbState *s = opaque;
+
+    memory_region_set_dirty(&s->mem_vram, 0, MACFB_VRAM_SIZE);
+}
+
+static void macfb_update_display(void *opaque)
+{
+    MacfbState *s = opaque;
+    DisplaySurface *surface = qemu_console_surface(s->con);
+
+    qemu_flush_coalesced_mmio_buffer();
+
+    if (s->width == 0 || s->height == 0) {
+        return;
+    }
+
+    if (s->width != surface_width(surface) ||
+        s->height != surface_height(surface)) {
+        qemu_console_resize(s->con, s->width, s->height);
+    }
+
+    macfb_draw_graphic(s);
+}
+
+static void macfb_reset(MacfbState *s)
+{
+    int i;
+
+    s->palette_current = 0;
+    for (i = 0; i < 256; i++) {
+        s->color_palette[i * 3] = 255 - i;
+        s->color_palette[i * 3 + 1] = 255 - i;
+        s->color_palette[i * 3 + 2] = 255 - i;
+    }
+    memset(s->vram, 0, MACFB_VRAM_SIZE);
+    macfb_invalidate_display(s);
+}
+
+static uint64_t macfb_ctrl_read(void *opaque,
+                                hwaddr addr,
+                                unsigned int size)
+{
+    return 0;
+}
+
+static void macfb_ctrl_write(void *opaque,
+                             hwaddr addr,
+                             uint64_t val,
+                             unsigned int size)
+{
+    MacfbState *s = opaque;
+    switch (addr) {
+    case DAFB_RESET:
+        s->palette_current = 0;
+        break;
+    case DAFB_LUT:
+        s->color_palette[s->palette_current++] = val;
+        if (s->palette_current % 3) {
+            macfb_invalidate_display(s);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps macfb_ctrl_ops = {
+    .read = macfb_ctrl_read,
+    .write = macfb_ctrl_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+};
+
+static int macfb_post_load(void *opaque, int version_id)
+{
+    macfb_invalidate_display(opaque);
+    return 0;
+}
+
+static const VMStateDescription vmstate_macfb = {
+    .name = "macfb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .post_load = macfb_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(color_palette, MacfbState, 256 * 3),
+        VMSTATE_UINT32(palette_current, MacfbState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const GraphicHwOps macfb_ops = {
+    .invalidate = macfb_invalidate_display,
+    .gfx_update = macfb_update_display,
+};
+
+static void macfb_common_realize(DeviceState *dev, MacfbState *s, Error **errp)
+{
+    DisplaySurface *surface;
+
+    if (s->depth != 1 && s->depth != 2 && s->depth != 4 && s->depth != 8 &&
+        s->depth != 16 && s->depth != 24) {
+        error_setg(errp, "unknown guest depth %d", s->depth);
+        return;
+    }
+
+    s->con = graphic_console_init(dev, 0, &macfb_ops, s);
+    surface = qemu_console_surface(s->con);
+
+    if (surface_bits_per_pixel(surface) != 32) {
+        error_setg(errp, "unknown host depth %d",
+                   surface_bits_per_pixel(surface));
+        return;
+    }
+
+    memory_region_init_io(&s->mem_ctrl, NULL, &macfb_ctrl_ops, s, "macfb-ctrl",
+                          0x1000);
+
+    memory_region_init_ram_nomigrate(&s->mem_vram, OBJECT(s), "macfb-vram",
+                                     MACFB_VRAM_SIZE, errp);
+    s->vram = memory_region_get_ram_ptr(&s->mem_vram);
+    s->vram_bit_mask = MACFB_VRAM_SIZE - 1;
+    vmstate_register_ram(&s->mem_vram, dev);
+    memory_region_set_coalescing(&s->mem_vram);
+}
+
+static void macfb_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    MacfbSysBusState *s = MACFB(dev);
+    MacfbState *ms = &s->macfb;
+
+    macfb_common_realize(dev, ms, errp);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &ms->mem_ctrl);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &ms->mem_vram);
+}
+
+const uint8_t macfb_rom[] = {
+    255, 0, 0, 0,
+};
+
+static void macfb_nubus_realize(DeviceState *dev, Error **errp)
+{
+    NubusDevice *nd = NUBUS_DEVICE(dev);
+    MacfbNubusState *s = NUBUS_MACFB(dev);
+    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_GET_CLASS(dev);
+    MacfbState *ms = &s->macfb;
+
+    ndc->parent_realize(dev, errp);
+
+    macfb_common_realize(dev, ms, errp);
+    memory_region_add_subregion(&nd->slot_mem, DAFB_BASE, &ms->mem_ctrl);
+    memory_region_add_subregion(&nd->slot_mem, VIDEO_BASE, &ms->mem_vram);
+
+    nubus_register_rom(nd, macfb_rom, sizeof(macfb_rom), 1, 9, 0xf);
+}
+
+static void macfb_sysbus_reset(DeviceState *d)
+{
+    MacfbSysBusState *s = MACFB(d);
+    macfb_reset(&s->macfb);
+}
+
+static void macfb_nubus_reset(DeviceState *d)
+{
+    MacfbNubusState *s = NUBUS_MACFB(d);
+    macfb_reset(&s->macfb);
+}
+
+static Property macfb_sysbus_properties[] = {
+    DEFINE_PROP_UINT32("width", MacfbSysBusState, macfb.width, 640),
+    DEFINE_PROP_UINT32("height", MacfbSysBusState, macfb.height, 480),
+    DEFINE_PROP_UINT8("depth", MacfbSysBusState, macfb.depth, 8),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property macfb_nubus_properties[] = {
+    DEFINE_PROP_UINT32("width", MacfbNubusState, macfb.width, 640),
+    DEFINE_PROP_UINT32("height", MacfbNubusState, macfb.height, 480),
+    DEFINE_PROP_UINT8("depth", MacfbNubusState, macfb.depth, 8),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = macfb_sysbus_realize;
+    dc->desc = "SysBus Macintosh framebuffer";
+    dc->reset = macfb_sysbus_reset;
+    dc->vmsd = &vmstate_macfb;
+    dc->props = macfb_sysbus_properties;
+}
+
+static void macfb_nubus_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_DEVICE_CLASS(klass);
+
+    device_class_set_parent_realize(dc, macfb_nubus_realize,
+                                    &ndc->parent_realize);
+    dc->desc = "Nubus Macintosh framebuffer";
+    dc->reset = macfb_nubus_reset;
+    dc->vmsd = &vmstate_macfb;
+    dc->props = macfb_nubus_properties;
+}
+
+static TypeInfo macfb_sysbus_info = {
+    .name          = TYPE_MACFB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MacfbSysBusState),
+    .class_init    = macfb_sysbus_class_init,
+};
+
+static TypeInfo macfb_nubus_info = {
+    .name          = TYPE_NUBUS_MACFB,
+    .parent        = TYPE_NUBUS_DEVICE,
+    .instance_size = sizeof(MacfbNubusState),
+    .class_init    = macfb_nubus_class_init,
+    .class_size    = sizeof(MacfbNubusDeviceClass),
+};
+
+static void macfb_register_types(void)
+{
+    type_register_static(&macfb_sysbus_info);
+    type_register_static(&macfb_nubus_info);
+}
+
+type_init(macfb_register_types)
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 947cd42c01..ef4917dee6 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -17,3 +17,4 @@ config Q800
     bool
     select MAC_VIA
     select NUBUS
+    select MACFB
diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
new file mode 100644
index 0000000000..26367ae2c4
--- /dev/null
+++ b/include/hw/display/macfb.h
@@ -0,0 +1,64 @@
+/*
+ * QEMU Motorola 680x0 Macintosh Video Card Emulation
+ *                 Copyright (c) 2012-2018 Laurent Vivier
+ *
+ * some parts from QEMU G364 framebuffer Emulator.
+ *                 Copyright (c) 2007-2011 Herve Poussineau
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef MACFB_H
+#define MACFB_H
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+#include "ui/console.h"
+
+typedef struct MacfbState {
+    MemoryRegion mem_vram;
+    MemoryRegion mem_ctrl;
+    QemuConsole *con;
+
+    uint8_t *vram;
+    uint32_t vram_bit_mask;
+    uint32_t palette_current;
+    uint8_t color_palette[256 * 3];
+    uint32_t width, height; /* in pixels */
+    uint8_t depth;
+} MacfbState;
+
+#define TYPE_MACFB "sysbus-macfb"
+#define MACFB(obj) \
+    OBJECT_CHECK(MacfbSysBusState, (obj), TYPE_MACFB)
+
+typedef struct {
+    SysBusDevice busdev;
+
+    MacfbState macfb;
+} MacfbSysBusState;
+
+#define MACFB_NUBUS_DEVICE_CLASS(class) \
+    OBJECT_CLASS_CHECK(MacfbNubusDeviceClass, (class), TYPE_NUBUS_MACFB)
+#define MACFB_NUBUS_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(MacfbNubusDeviceClass, (obj), TYPE_NUBUS_MACFB)
+
+typedef struct MacfbNubusDeviceClass {
+    DeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+} MacfbNubusDeviceClass;
+
+#define TYPE_NUBUS_MACFB "nubus-macfb"
+#define NUBUS_MACFB(obj) \
+    OBJECT_CHECK(MacfbNubusState, (obj), TYPE_NUBUS_MACFB)
+
+typedef struct {
+    NubusDevice busdev;
+
+    MacfbState macfb;
+} MacfbNubusState;
+
+#endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 2a04ca6ac5..9a7e6652ab 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1802,7 +1802,7 @@ ETEXI
 
 DEF("g", 1, QEMU_OPTION_g ,
     "-g WxH[xDEPTH]  Set the initial graphical resolution and depth\n",
-    QEMU_ARCH_PPC | QEMU_ARCH_SPARC)
+    QEMU_ARCH_PPC | QEMU_ARCH_SPARC | QEMU_ARCH_M68K)
 STEXI
 @item -g @var{width}x@var{height}[x@var{depth}]
 @findex -g
diff --git a/vl.c b/vl.c
index 630f5c5e9c..aa02e5b735 100644
--- a/vl.c
+++ b/vl.c
@@ -3270,7 +3270,8 @@ int main(int argc, char **argv, char **envp)
                     if (*p == 'x') {
                         p++;
                         depth = strtol(p, (char **)&p, 10);
-                        if (depth != 8 && depth != 15 && depth != 16 &&
+                        if (depth != 1 && depth != 2 && depth != 4 &&
+                            depth != 8 && depth != 15 && depth != 16 &&
                             depth != 24 && depth != 32)
                             goto graphic_error;
                     } else if (*p == '\0') {
-- 
2.21.0



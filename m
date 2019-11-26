Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9CEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D2E20659
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 07:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbTEgqAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D2E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZV2j-0003NM-6n
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 02:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSvM-0007Y6-JC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iZSvI-0006eY-NY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:58:04 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iZSvG-0006cI-O9
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 23:58:00 -0500
Received: by mail-pg1-x544.google.com with SMTP id k32so8346583pgl.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 20:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8qWoNKXwraUikv0BxToGdK3OVmow9NJF+jeOw58XFag=;
 b=QbTEgqADWo5QAfmhdfJyhKGMDm0WJsgeHdv7MM88ecEbFYsf1Adk6cbZGKVf7sLrXx
 p1dJQjrTInjXU/DFXYxuxoTqsuZWgt4Ef39IUJKphIy6MRO1ETz8IpLeW+quRcNzJa8h
 SBlDyIPnnz1hrTsbll5cQElPNbCDZ1vASZt3febW9VK/hXgDhb6Wwo0Rqq6y1G7LC5jf
 ol6nWIrUENlegc9sa3rHa1sA17OfuHE8uG8ssKwK0VWgd0wrMAoEFDnFf3N3twzUn1ou
 /sW7ccdJXhi4UCMWIOvrOgO8NL7w84nRFfdccn2Vkk/kb7fqmv+0ND+nCD74HJKnDcvS
 MMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8qWoNKXwraUikv0BxToGdK3OVmow9NJF+jeOw58XFag=;
 b=gOMWwHH6U+wlO9JBd3Mk+WfZFnTbA5tpTQ7/cayNidHLtqE4+NtV5uj5ol8REBFjkT
 AZc0Y88g4eOhL60bbYIvl1zp41KpflQE9Y4YZLG3LxJ1sbgWxD012LtIGmO0HpZuKVXq
 gt3aED9no9eJQxI4jrnnUJhGGD1jOBoqi6JWyqleqNj1aNB1w4FsXa64YNvNV3igiraS
 BlTExHsumlmc5kkFrbr6rcEa0/TPt1BIKKBYxxnGv2DqAD4AI4CSaN7ChN21HIGb1Ldw
 yI05Kn3TXsYG+Pl7emyJ3NImV/yFU/SehHjPweYklq41b0SeptX3i8fsWCXJR7ZJHyqQ
 sO/g==
X-Gm-Message-State: APjAAAV9roKmGHHm0JitTBxSpUuD1daKTgrJKLPERUUhnb2n1sC8gVzu
 1lX4J5umEs9XKQHNTL9HvEht8B9kUZ5OwMGv
X-Google-Smtp-Source: APXvYqyMT4WbipLdxYtqB77TLAnzlGEO2dBCs+4mJd3fHHIt+eghb6VUl4vEIieahzBJCiSrjy1L6A==
X-Received: by 2002:a65:5c48:: with SMTP id v8mr37580895pgr.419.1574744275614; 
 Mon, 25 Nov 2019 20:57:55 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:73:1f7e:c8d0:6181:5329:cc21])
 by smtp.gmail.com with ESMTPSA id
 z1sm1081328pju.27.2019.11.25.20.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 20:57:54 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 8/8] Got GPU init working. Stops at probing display
Date: Tue, 26 Nov 2019 10:26:21 +0530
Message-Id: <20191126045621.11344-9-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
References: <20191126045621.11344-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
X-Mailman-Approved-At: Tue, 26 Nov 2019 02:04:16 -0500
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
Cc: kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Dominick <aaron.zakhrov@gmail.com>

---
 hw/display/ati.c  |   9 +-
 hw/display/r300.c | 571 +++++++++++++++++++++++++++++++++++++---------
 hw/display/r300.h |  77 ++++++-
 3 files changed, 544 insertions(+), 113 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index db3b254316..1d36233163 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -44,7 +44,7 @@ enum { VGA_MODE, EXT_MODE };
 
 static void ati_vga_switch_mode(ATIVGAState *s)
 {
-    DPRINTF("%d -> %d\n",
+    qemu_log("%d -> %d\n",
             s->mode, !!(s->regs.crtc_gen_cntl & CRTC2_EXT_DISP_EN));
     if (s->regs.crtc_gen_cntl & CRTC2_EXT_DISP_EN) {
         /* Extended mode enabled */
@@ -88,7 +88,7 @@ static void ati_vga_switch_mode(ATIVGAState *s)
                 qemu_log_mask(LOG_UNIMP, "Unsupported bpp value\n");
             }
             assert(bpp != 0);
-            DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp, offs);
+            qemu_log("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp, offs);
             vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
             s->vga.big_endian_fb = (s->regs.config_cntl & APER_0_ENDIAN ||
@@ -111,14 +111,14 @@ static void ati_vga_switch_mode(ATIVGAState *s)
                 vbe_ioport_write_data(&s->vga, 0, stride);
                 stride *= bypp;
                 if (offs % stride) {
-                    DPRINTF("CRTC offset is not multiple of pitch\n");
+                    qemu_log("CRTC offset is not multiple of pitch\n");
                     vbe_ioport_write_index(&s->vga, 0,
                                            VBE_DISPI_INDEX_X_OFFSET);
                     vbe_ioport_write_data(&s->vga, 0, offs % stride / bypp);
                 }
                 vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFFSET);
                 vbe_ioport_write_data(&s->vga, 0, offs / stride);
-                DPRINTF("VBE offset (%d,%d), vbe_start_addr=%x\n",
+                qemu_log("VBE offset (%d,%d), vbe_start_addr=%x\n",
                         s->vga.vbe_regs[VBE_DISPI_INDEX_X_OFFSET],
                         s->vga.vbe_regs[VBE_DISPI_INDEX_Y_OFFSET],
                         s->vga.vbe_start_addr);
@@ -129,6 +129,7 @@ static void ati_vga_switch_mode(ATIVGAState *s)
         s->mode = VGA_MODE;
         vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
         vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
+        qemu_log("VGA MODE %d \n",s->mode);
     }
 }
 
diff --git a/hw/display/r300.c b/hw/display/r300.c
index 074dbf5b2d..5bd71142a8 100644
--- a/hw/display/r300.c
+++ b/hw/display/r300.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "r300.h"
 #include "r300_reg.h"
+#include "r100d.h"
 #include "radeon_reg.h"
 #include "vga-access.h"
 #include "hw/qdev-properties.h"
@@ -38,18 +39,20 @@ static const struct {
     uint16_t dev_id;
 } r300_model_aliases[] = {
     { "radeon9500", PCI_DEVICE_ID_ATI_RADEON_9500_PRO },
+    { "radeon9700", PCI_DEVICE_ID_ATI_RADEON_9700 }
 };
 
 enum { VGA_MODE, EXT_MODE };
 
 static void r300_vga_switch_mode(RADVGAState *s)
 {
-    DPRINTF("%d -> %d\n",
-            s->mode, !!(s->regs.crtc_gen_cntl & RADEON_CRTC_EXT_DISP_EN));
-    if (s->regs.crtc_gen_cntl & RADEON_CRTC_EXT_DISP_EN) {
+    qemu_log(" R300 %d -> %d\n",
+            s->mode, !(s->regs.crtc_gen_cntl & RADEON_CRTC_EN));
+    qemu_log("R300 RADEON_CRTC_EXT_DISP_EN = %08x CRTC_GEN_CNTL = %08x ",RADEON_CRTC_EN,s->regs.crtc_gen_cntl);
+    if (s->regs.crtc_gen_cntl & ~RADEON_CRTC_EN) {
         /* Extended mode enabled */
         s->mode = EXT_MODE;
-        if (s->regs.crtc_gen_cntl & RADEON_CRTC2_EN) {
+        if (s->regs.crtc_gen_cntl & ~RADEON_CRTC_EN) {
             /* CRT controller enabled, use CRTC values */
             /* FIXME Should these be the same as VGA CRTC regs? */
             uint32_t offs = s->regs.crtc_offset & 0x07ffffff;
@@ -65,32 +68,32 @@ static void r300_vga_switch_mode(RADVGAState *s)
             }
             h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
             v = (s->regs.crtc_v_total_disp >> 16) + 1;
-            // switch (s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_MODE_MASK) {
-            // // case RADEON_CRTC_PIX_WIDTH_4BPP:
-            // //     bpp = 4;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_8BPP:
-            // //     bpp = 8;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_15BPP:
-            // //     bpp = 15;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_16BPP:
-            // //     bpp = 16;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_24BPP:
-            // //     bpp = 24;
-            // //     break;
-            // // case RADEON_CRTC_PIX_WIDTH_32BPP:
-            // //     bpp = 32;
-            // //     break;
-            // default:
-            //     qemu_log_mask(LOG_UNIMP, "Unsupported bpp value\n");
-            //     qemu_log_mask(LOG_UNIMP,"%d",s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_MODE_MASK);
-            // }
-            bpp= 32;
+            switch (s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_MODE_MASK) {
+            // case RADEON_CRTC_PIX_WIDTH_4BPP:
+            //     bpp = 4;
+            //     break;
+            // case RADEON_CRTC_PIX_WIDTH_8BPP:
+            //     bpp = 8;
+            //     break;
+            // case RADEON_CRTC_PIX_WIDTH_15BPP:
+            //     bpp = 15;
+            //     break;
+            // case RADEON_CRTC_PIX_WIDTH_16BPP:
+            //     bpp = 16;
+            //     break;
+            case RADEON_CRTC_CUR_MODE_24BPP:
+                bpp = 24;
+                break;
+            // case RADEON_CRTC_PIX_WIDTH_32BPP:
+            //     bpp = 32;
+            //     break;
+            default:
+                qemu_log_mask(LOG_UNIMP, "Unsupported bpp value\n");
+                qemu_log_mask(LOG_UNIMP,"%d \n",s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_MODE_MASK);
+            }
+            bpp= 24;
             assert(bpp != 0);
-            DPRINTF("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp, offs);
+            qemu_log("Switching to %dx%d %d %d @ %x\n", h, v, stride, bpp, offs);
             vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
             vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
             s->vga.big_endian_fb = (s->regs.config_cntl & PDP_ENDIAN ||
@@ -113,14 +116,14 @@ static void r300_vga_switch_mode(RADVGAState *s)
                 vbe_ioport_write_data(&s->vga, 0, stride);
                 stride *= bypp;
                 if (offs % stride) {
-                    DPRINTF("CRTC offset is not multiple of pitch\n");
+                    qemu_log("CRTC offset is not multiple of pitch\n");
                     vbe_ioport_write_index(&s->vga, 0,
                                            VBE_DISPI_INDEX_X_OFFSET);
                     vbe_ioport_write_data(&s->vga, 0, offs % stride / bypp);
                 }
                 vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_Y_OFFSET);
                 vbe_ioport_write_data(&s->vga, 0, offs / stride);
-                DPRINTF("VBE offset (%d,%d), vbe_start_addr=%x\n",
+                qemu_log("VBE offset (%d,%d), vbe_start_addr=%x\n",
                         s->vga.vbe_regs[VBE_DISPI_INDEX_X_OFFSET],
                         s->vga.vbe_regs[VBE_DISPI_INDEX_Y_OFFSET],
                         s->vga.vbe_start_addr);
@@ -131,6 +134,7 @@ static void r300_vga_switch_mode(RADVGAState *s)
         s->mode = VGA_MODE;
         vbe_ioport_write_index(&s->vga, 0, VBE_DISPI_INDEX_ENABLE);
         vbe_ioport_write_data(&s->vga, 0, VBE_DISPI_DISABLED);
+          qemu_log("R300 VGA MODE %d \n",s->mode);
     }
 }
 
@@ -278,6 +282,8 @@ static uint64_t r300_mm_read(void *opaque, hwaddr addr, unsigned int size)
     uint64_t val = 0;
 
     switch (addr) {
+      case RADEON_MCLK_CNTL:
+      val = RADEON_FORCEON_MCLKA;
     case RADEON_MC_STATUS:
         val = s->regs.mc_status;
         break;
@@ -444,9 +450,6 @@ static uint64_t r300_mm_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     case RADEON_SRC_PITCH:
         val = s->regs.src_pitch;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            val &= s->regs.src_tile << RADEON_PITCH_SHIFT;
-        }
         break;
     case RADEON_DP_BRUSH_BKGD_CLR:
         val = s->regs.dp_brush_bkgd_clr;
@@ -474,11 +477,6 @@ static uint64_t r300_mm_read(void *opaque, hwaddr addr, unsigned int size)
         break;
     case RADEON_DEFAULT_OFFSET:
         val = s->regs.default_offset;
-        if (s->dev_id != PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            val >>= 10;
-            val |= s->regs.default_pitch << 16;
-            val |= s->regs.default_tile << 30;
-        }
         break;
     case RADEON_DEFAULT_PITCH:
         val = s->regs.default_pitch;
@@ -487,12 +485,182 @@ static uint64_t r300_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case RADEON_DEFAULT_SC_BOTTOM_RIGHT:
         val = s->regs.default_sc_bottom_right;
         break;
+        case R300_GB_ENABLE:
+            val = s->regs.r300_gb_enable;
+            break;
+        case R300_GB_TILE_CONFIG:
+                val= s->regs.r300_gb_tile_config;
+                break;
+        case R300_GB_FIFO_SIZE:
+                val =s->regs.r300_gb_fifo_size ;
+                break;
+        case RADEON_ISYNC_CNTL:
+                val =s->regs.isync_cntl;
+                break;
+      case R300_DST_PIPE_CONFIG:
+                val =s->regs.r300_dst_pipe_config;
+                break;
+      case R300_RB2D_DSTCACHE_MODE:
+                val = s->regs.r300_rb2d_dstcache_mode;
+                break;
+      case RADEON_WAIT_UNTIL:
+                val = s->regs.wait_until;
+                break;
+      case R300_GB_SELECT:
+                val = s->regs.r300_gb_select;
+                break;
+      case R300_RB3D_DSTCACHE_CTLSTAT:
+                val = s->regs.r300_rb3d_dstcache_ctlstat;
+                break;
+      case R300_RB3D_ZCACHE_CTLSTAT:
+                val = s->regs.r300_rb3d_zcache_ctlstat;
+                break;
+      case R300_GB_AA_CONFIG:
+                val = s->regs.r300_gb_aa_config;
+                break;
+      case R300_RE_SCISSORS_TL:
+                val = s->regs.r300_re_scissors_tl;
+                break;
+
+      case R300_RE_SCISSORS_BR:
+                val = s->regs.r300_re_scissors_br;
+                break;
+      case RADEON_HOST_PATH_CNTL:
+                val = s->regs.host_path_cntl;
+                break;
+
+      case R300_GB_MSPOS0:
+                val = s->regs.r300_gb_mpos_0;
+                break;
+
+      case R300_GB_MSPOS1:
+                val = s->regs.r300_gb_mpos_1;
+                break;
+
+                case RADEON_SURFACE_CNTL:
+                          val = s->regs.surface_cntl;
+                          break;
+                case RADEON_SURFACE0_INFO:
+                          val = s->regs.surface0_info;
+                          break;
+                case RADEON_SURFACE1_INFO:
+                          val = s->regs.surface1_info;
+                          break;
+
+                case RADEON_SURFACE2_INFO:
+                val = s->regs.surface2_info;
+                break;
+                case RADEON_SURFACE3_INFO:
+                val = s->regs.surface3_info;
+                break;
+                case RADEON_SURFACE4_INFO:
+                val = s->regs.surface4_info;
+                break;
+                case RADEON_SURFACE5_INFO:
+                val = s->regs.surface5_info;
+                break;
+                case RADEON_SURFACE6_INFO:
+                val = s->regs.surface6_info;
+                break;
+                case RADEON_SURFACE7_INFO:
+                val = s->regs.surface7_info;
+                break;
+                case RADEON_OV0_SCALE_CNTL:
+                val = s->regs.ov0_scale_cntl;
+                break;
+                case RADEON_SUBPIC_CNTL:
+                val = s->regs.subpic_cntl;
+                break;
+                case RADEON_VIPH_CONTROL:
+                val = s->regs.viph_control;
+                break;
+                case RADEON_I2C_CNTL_1:
+                val = s->regs.i2c_cntl_1;
+                break;
+                case RADEON_DVI_I2C_CNTL_1:
+                val = s->regs.dvi_i2c_cntl_1;
+                break;
+                case RADEON_CAP0_TRIG_CNTL:
+                val = s->regs.cap0_trig_cntl;
+                break;
+                case RADEON_CAP1_TRIG_CNTL:
+                val = s->regs.cap1_trig_cntl;
+                break;
+                case RADEON_CUR2_OFFSET:
+                val = s->regs.cur2_offset;
+                break;
+                case RADEON_CRTC2_GEN_CNTL:
+                val = s->regs.crtc2_gen_cntl;
+                break;
+                case RADEON_MEM_INTF_CNTL:
+                val = s->regs.mem_intf_cntl;
+                break;
+                case RADEON_AGP_BASE_2:
+                val = s->regs.agp_base_2;
+                break;
+                case RADEON_AGP_BASE:
+                val = s->regs.agp_base;
+                break;
+                case RADEON_MEM_ADDR_CONFIG:
+                val = s->regs.mem_addr_config;
+                break;
+                case RADEON_DISPLAY2_BASE_ADDR:
+                val = s->regs.r100_display_base_addr;
+                break;
+                case RADEON_SPLL_CNTL:
+                val = s->regs.spll_cntl;
+                break;
+                case RADEON_VCLK_ECP_CNTL:
+                val = s->regs.vclk_ecp_cntl;
+                break;
+
+
+                case RADEON_GENMO_WT:
+                      qemu_log("R100 VGA RESET READ \n");
+                      val = C_0003C2_VGA_RAM_EN;
+                      qemu_log("R100 VGA DATA 0x%08lx \n",val);
+                      break;
+                case RADEON_CP_CSQ_CNTL:
+                    val = s->regs.cp_csq_cntl;
+                      break;
+                case RADEON_SCRATCH_UMSK:
+                      val = s->regs.scratch_umask;
+                      break;
+                case R_00000D_SCLK_CNTL:
+                        val= s->regs.r100_sclk_cntl;
+                        break;
+                case R_00023C_DISPLAY_BASE_ADDR:
+                        val = s->regs.r100_display_base_addr;
+                        break;
+                case RADEON_MEM_CNTL:
+                    val = R300_MEM_NUM_CHANNELS_MASK & R300_MEM_USE_CD_CH_ONLY;
+                    break;
+                case RADEON_CP_RB_CNTL:
+                    val = RADEON_RB_NO_UPDATE;
+                    break;
+
+                    case R300_CRTC_TILE_X0_Y0:
+                    val = s->regs.tile_x0_y0;
+
+                    break;
+                    case R300_MC_INIT_MISC_LAT_TIMER:
+                    val = s->regs.r300_mc_init_misc_lat_timer;
+                    break;
+
+
+
+
+
+
+
     default:
+        qemu_log("READING FROM 0x%08lx \n",addr);
         break;
     }
     if (addr < RADEON_CUR_OFFSET || addr > RADEON_CUR_CLR1 || R300_DEBUG_HW_CURSOR) {
         trace_ati_mm_read(size, addr, r300_reg_name(addr & ~3ULL), val);
     }
+    qemu_log("R300 MM_READ ADDRESS 0x%08lx DATA 0x%08lx \n",addr,val);
     return val;
 }
 
@@ -512,15 +680,50 @@ static void r300_mm_write(void *opaque, hwaddr addr,
 {
     RADVGAState *s = opaque;
 
+    qemu_log("R300 MM_WRITE ADDRESS 0x%08lx DATA 0x%08lx \n",addr,data);
+
     if (addr < RADEON_CUR_OFFSET || addr > RADEON_CUR_CLR1 || R300_DEBUG_HW_CURSOR) {
         trace_ati_mm_write(size, addr, r300_reg_name(addr & ~3ULL), data);
     }
     switch (addr) {
+      case RADEON_GENMO_WT:
+            data &= 0xfc080effUL;
+            qemu_log("R100 VGA RESET 0x%08lx \n",data);
+            s->regs.vga_reset = data ;
+            // s->regs.crtc_gen_cntl = 0xDEADBEEF;
+            timer_del(&s->vblank_timer);
+            r300_vga_update_irq(s);
+            r300_vga_switch_mode(s);
+
+            // r300_vga_update_irq(s);
+            // s->regs.mc_status = R300_MC_IDLE;
+
+
+            //
+            // /* reset vga */
+            // vga_common_reset(&s->vga);
+            // s->mode = VGA_MODE;
+            break;
+      case RADEON_CP_CSQ_CNTL:
+            s->regs.cp_csq_cntl = data;
+            break;
+      case RADEON_SCRATCH_UMSK:
+            s->regs.scratch_umask = data;
+            break;
+      case R_00000D_SCLK_CNTL:
+              s->regs.r100_sclk_cntl = data;
+              break;
+      case R_00023C_DISPLAY_BASE_ADDR:
+              s->regs.r100_display_base_addr = data;
+              break;
+
       case RADEON_MC_STATUS:
+        qemu_log("RADEON_WRITE_MC \n");
         s->regs.mc_status = R300_MC_IDLE;
         s->regs.mc_status = data;
         break;
       case RADEON_RBBM_STATUS:
+      qemu_log("RADEON_WRITE_RBBM \n");
         s->regs.rbbm_status = data|= RADEON_RBBM_FIFOCNT_MASK;
         break;
     case RADEON_MM_INDEX:
@@ -528,6 +731,7 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         break;
     case RADEON_MM_DATA ... RADEON_MM_DATA + 3:
         /* indexed access to regs or memory */
+        qemu_log("RADEON_WRITE_MM_DATA_VGA_STUFF\n");
         if (s->regs.mm_index & BIT(31)) {
             uint32_t idx = s->regs.mm_index & ~BIT(31);
             if (idx <= s->vga.vram_size - size) {
@@ -539,15 +743,14 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         break;
     case RADEON_BIOS_0_SCRATCH ... RADEON_BUS_CNTL - 1:
     {
+      qemu_log("RADEON_WRITE_BIOS_SCRATCH \n");
         int i = (addr - RADEON_BIOS_0_SCRATCH) / 4;
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO && i > 3) {
-            break;
-        }
         r300_reg_write_offs(&s->regs.bios_scratch[i],
                            addr - (RADEON_BIOS_0_SCRATCH + i * 4), data, size);
         break;
     }
     case RADEON_GEN_INT_CNTL:
+    qemu_log("RADEON_WRITE_GEN_INT_CTL \n");
         s->regs.gen_int_cntl = data;
         if (data & RADEON_CRTC_VBLANK_MASK) {
             r300_vga_vblank_irq(s);
@@ -557,29 +760,33 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case RADEON_GEN_INT_STATUS:
+    qemu_log("RADEON_WRITE_GEN_INT_STATUS \n");
         data &= (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO);
         s->regs.gen_int_status &= ~data;
         r300_vga_update_irq(s);
         break;
     case RADEON_CRTC_GEN_CNTL ... RADEON_CRTC_GEN_CNTL + 3:
     {
+      qemu_log("RADEON_WRITE_CRTC_GEN \n");
         uint32_t val = s->regs.crtc_gen_cntl;
         r300_reg_write_offs(&s->regs.crtc_gen_cntl,
                            addr - RADEON_CRTC_GEN_CNTL, data, size);
-        if ((val & RADEON_CRTC2_CUR_EN) != (s->regs.crtc_gen_cntl & RADEON_CRTC2_CUR_EN)) {
+        if ((val & RADEON_CRTC_CUR_EN) != (s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_EN)) {
+          qemu_log("RADEON_WRITE_CRTC_GEN CURSOR \n");
             if (s->cursor_guest_mode) {
-                s->vga.force_shadow = !!(s->regs.crtc_gen_cntl & RADEON_CRTC2_CUR_EN);
+                s->vga.force_shadow = !!(s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_EN);
             } else {
-                if (s->regs.crtc_gen_cntl & RADEON_CRTC2_CUR_EN) {
+                if (s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_EN) {
                     r300_cursor_define(s);
                 }
                 dpy_mouse_set(s->vga.con, s->regs.cur_hv_pos >> 16,
                               s->regs.cur_hv_pos & 0xffff,
-                              (s->regs.crtc_gen_cntl & RADEON_CRTC2_CUR_EN) != 0);
+                              (s->regs.crtc_gen_cntl & RADEON_CRTC_CUR_EN) != 0);
             }
         }
-        if ((val & (RADEON_CRTC_EXT_DISP_EN | RADEON_CRTC2_EN)) !=
-            (s->regs.crtc_gen_cntl & (RADEON_CRTC_EXT_DISP_EN | RADEON_CRTC2_EN))) {
+        if ((val & (RADEON_CRTC_EXT_DISP_EN | RADEON_CRTC_EN)) !=
+            (s->regs.crtc_gen_cntl & (RADEON_CRTC_EXT_DISP_EN | RADEON_CRTC_EN))) {
+              qemu_log("RADEON_WRITE_CRTC_GEN NO_CURSOR \n");
             r300_vga_switch_mode(s);
         }
         break;
@@ -587,14 +794,14 @@ static void r300_mm_write(void *opaque, hwaddr addr,
     case RADEON_CRTC_EXT_CNTL ... RADEON_CRTC_EXT_CNTL + 3:
     {
         uint32_t val = s->regs.crtc_ext_cntl;
+        qemu_log("CRTC_EXT_CNTL 0x%08x RADEON_CRTC_DISPLAY_DIS 0x%08x \n",s->regs.crtc_ext_cntl,RADEON_CRTC_DISPLAY_DIS);
         r300_reg_write_offs(&s->regs.crtc_ext_cntl,
                            addr - RADEON_CRTC_EXT_CNTL, data, size);
         if (s->regs.crtc_ext_cntl & RADEON_CRTC_DISPLAY_DIS) {
-            DPRINTF("Display disabled\n");
+            qemu_log("Display disabled\n");
             s->vga.ar_index &= ~BIT(5);
         } else {
-            DPRINTF("Display enabled\n");
-            s->vga.ar_index |= BIT(5);
+            qemu_log("Display enabled\n");
             r300_vga_switch_mode(s);
         }
         if ((val & RADEON_CRTC_DISPLAY_DIS) !=
@@ -608,34 +815,33 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         s->vga.dac_8bit = !!(data & RADEON_DAC_8BIT_EN);
         break;
     case RADEON_GPIO_VGA_DDC:
-        if (s->dev_id != PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            /* FIXME: Maybe add a property to select VGA or DVI port? */
-        }
+        // if (s->dev_id != PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
+        //     /* FIXME: Maybe add a property to select VGA or DVI port? */
+        // }
         break;
     case RADEON_GPIO_DVI_DDC:
-        if (s->dev_id != PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
             s->regs.gpio_dvi_ddc = r300_i2c(&s->bbi2c, data, 0);
-        }
         break;
     case RADEON_GPIO_MONID ... RADEON_GPIO_MONID + 3:
         /* FIXME What does Radeon have here? */
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            r300_reg_write_offs(&s->regs.gpio_monid,
-                               addr - RADEON_GPIO_MONID, data, size);
-            /*
-             * Rage128p accesses DDC used to get EDID via these bits.
-             * Because some drivers access this via multiple byte writes
-             * we have to be careful when we send bits to avoid spurious
-             * changes in bitbang_i2c state. So only do it when mask is set
-             * and either the enable bits are changed or output bits changed
-             * while enabled.
-             */
+        // if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
+        //     r300_reg_write_offs(&s->regs.gpio_monid,
+        //                        addr - RADEON_GPIO_MONID, data, size);
+        //     /*
+        //      * Rage128p accesses DDC used to get EDID via these bits.
+        //      * Because some drivers access this via multiple byte writes
+        //      * we have to be careful when we send bits to avoid spurious
+        //      * changes in bitbang_i2c state. So only do it when mask is set
+        //      * and either the enable bits are changed or output bits changed
+        //      * while enabled.
+        //      */
             if ((s->regs.gpio_monid & BIT(25)) &&
                 ((addr <= RADEON_GPIO_MONID + 2 && addr + size > RADEON_GPIO_MONID + 2) ||
                  (addr == RADEON_GPIO_MONID && (s->regs.gpio_monid & 0x60000)))) {
                 s->regs.gpio_monid = r300_i2c(&s->bbi2c, s->regs.gpio_monid, 1);
             }
-        }
+
+        // s->regs.gpio_monid = r300_i2c(&s->bbi2c, s->regs.gpio_monid, 1);
         break;
     case RADEON_PALETTE_INDEX ... RADEON_PALETTE_INDEX + 3:
         if (size == 4) {
@@ -662,37 +868,37 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         s->regs.config_cntl = data;
         break;
     case RADEON_CRTC_H_TOTAL_DISP:
-        s->regs.crtc_h_total_disp = data & 0x07ff07ff;
+        s->regs.crtc_h_total_disp = data & 0x07ff;
         break;
     case RADEON_CRTC_H_SYNC_STRT_WID:
-        s->regs.crtc_h_sync_strt_wid = data & 0x17bf1fff;
+        s->regs.crtc_h_sync_strt_wid = data & 0x17bf;
         break;
     case RADEON_CRTC_V_TOTAL_DISP:
-        s->regs.crtc_v_total_disp = data & 0x0fff0fff;
+        s->regs.crtc_v_total_disp = data & 0x0fff;
         break;
     case RADEON_CRTC_V_SYNC_STRT_WID:
-        s->regs.crtc_v_sync_strt_wid = data & 0x9f0fff;
+        s->regs.crtc_v_sync_strt_wid = data & 0x9f0f;
         break;
     case RADEON_CRTC_OFFSET:
-        s->regs.crtc_offset = data & 0xc7ffffff;
+        s->regs.crtc_offset = data;
         break;
     case RADEON_CRTC_OFFSET_CNTL:
         s->regs.crtc_offset_cntl = data; /* FIXME */
         break;
     case RADEON_CRTC_PITCH:
-        s->regs.crtc_pitch = data & 0x07ff07ff;
+        s->regs.crtc_pitch = data & 0x07ff;
         break;
     case 0xf00 ... 0xfff:
         /* read-only copy of PCI config space so ignore writes */
         break;
     case RADEON_CUR_OFFSET:
-        if (s->regs.cur_offset != (data & 0x87fffff0)) {
-            s->regs.cur_offset = data & 0x87fffff0;
+        if (s->regs.cur_offset != (data & 0x87ff)) {
+            s->regs.cur_offset = data & 0x87ff;
             r300_cursor_define(s);
         }
         break;
     case RADEON_CUR_HORZ_VERT_POSN:
-        s->regs.cur_hv_pos = data & 0x3fff0fff;
+        s->regs.cur_hv_pos = data & 0x3fff;
         if (data & BIT(31)) {
             s->regs.cur_offset |= data & BIT(31);
         } else if (s->regs.cur_offset & BIT(31)) {
@@ -706,7 +912,7 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case RADEON_CUR_HORZ_VERT_OFF:
-        s->regs.cur_hv_offs = data & 0x3f003f;
+        s->regs.cur_hv_offs = data & 0x03ff;
         if (data & BIT(31)) {
             s->regs.cur_offset |= data & BIT(31);
         } else if (s->regs.cur_offset & BIT(31)) {
@@ -715,8 +921,8 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case RADEON_CUR_CLR0:
-        if (s->regs.cur_color0 != (data & 0xffffff)) {
-            s->regs.cur_color0 = data & 0xffffff;
+        if (s->regs.cur_color0 != (data & 0xffff)) {
+            s->regs.cur_color0 = data & 0xffff;
             r300_cursor_define(s);
         }
         break;
@@ -731,9 +937,9 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         break;
     case RADEON_DST_OFFSET:
         if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.dst_offset = data & 0xfffffff0;
+            s->regs.dst_offset = data & 0xffff;
         } else {
-            s->regs.dst_offset = data & 0xfffffc00;
+            s->regs.dst_offset = data & 0xfc00;
         }
         break;
     case RADEON_DST_PITCH:
@@ -765,23 +971,23 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         break;
     case RADEON_SRC_PITCH_OFFSET:
         if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.src_offset = (data & 0x1fffff) << 5;
-            s->regs.src_pitch = (data & 0x7fe00000) >> 21;
+            s->regs.src_offset = (data) << 5;
+            s->regs.src_pitch = (data ) >> 21;
             s->regs.src_tile = data >> 31;
         } else {
-            s->regs.src_offset = (data & 0x3fffff) << 10;
-            s->regs.src_pitch = (data & 0x3fc00000) >> 16;
+            s->regs.src_offset = (data ) << 10;
+            s->regs.src_pitch = (data) >> 16;
             s->regs.src_tile = (data >> 30) & 1;
         }
         break;
     case RADEON_DST_PITCH_OFFSET:
         if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.dst_offset = (data & 0x1fffff) << 5;
-            s->regs.dst_pitch = (data & 0x7fe00000) >> 21;
+            s->regs.dst_offset = (data) << 5;
+            s->regs.dst_pitch = (data) >> 21;
             s->regs.dst_tile = data >> 31;
         } else {
-            s->regs.dst_offset = (data & 0x3fffff) << 10;
-            s->regs.dst_pitch = (data & 0x3fc00000) >> 16;
+            s->regs.dst_offset = (data) << 10;
+            s->regs.dst_pitch = (data) >> 16;
             s->regs.dst_tile = data >> 30;
         }
         break;
@@ -834,12 +1040,9 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         }
         break;
     case RADEON_SRC_PITCH:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.src_pitch = data & 0x3fff;
-            s->regs.src_tile = (data >> 16) & 1;
-        } else {
+
             s->regs.src_pitch = data & 0x3ff0;
-        }
+
         break;
     case RADEON_DP_BRUSH_BKGD_CLR:
         s->regs.dp_brush_bkgd_clr = data;
@@ -860,23 +1063,19 @@ static void r300_mm_write(void *opaque, hwaddr addr,
         s->regs.dp_write_mask = data;
         break;
     case RADEON_DEFAULT_OFFSET:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.default_offset = data & 0xfffffff0;
-        } else {
             /* Radeon has DEFAULT_PITCH_OFFSET here like DST_PITCH_OFFSET */
-            s->regs.default_offset = (data & 0x3fffff) << 10;
-            s->regs.default_pitch = (data & 0x3fc00000) >> 16;
+            s->regs.default_offset = (data ) << 10;
+            s->regs.default_pitch = (data ) >> 16;
             s->regs.default_tile = data >> 30;
-        }
+
         break;
     case RADEON_DEFAULT_PITCH:
-        if (s->dev_id == PCI_DEVICE_ID_ATI_RADEON_9500_PRO) {
-            s->regs.default_pitch = data & 0x3fff;
-            s->regs.default_tile = (data >> 16) & 1;
-        }
+        s->regs.default_pitch = data;
+        s->regs.default_tile = (data >> 16) & 1;
+
         break;
     case RADEON_DEFAULT_SC_BOTTOM_RIGHT:
-        s->regs.default_sc_bottom_right = data & 0x3fff3fff;
+        s->regs.default_sc_bottom_right = data;
         break;
     case R300_GB_ENABLE:
         s->regs.r300_gb_enable = data;
@@ -887,9 +1086,159 @@ static void r300_mm_write(void *opaque, hwaddr addr,
     case R300_GB_FIFO_SIZE:
             s->regs.r300_gb_fifo_size = data;
             break;
+    case RADEON_ISYNC_CNTL:
+            s->regs.isync_cntl = data;
+            break;
+  case R300_DST_PIPE_CONFIG:
+            s->regs.r300_dst_pipe_config = data;
+            break;
+  case R300_RB2D_DSTCACHE_MODE:
+            s->regs.r300_rb2d_dstcache_mode = data;
+            break;
+  case RADEON_WAIT_UNTIL:
+            s->regs.wait_until = data;
+            break;
+  case R300_GB_SELECT:
+            s->regs.r300_gb_select = data;
+            break;
+  case R300_RB3D_DSTCACHE_CTLSTAT:
+            s->regs.r300_rb3d_dstcache_ctlstat = data;
+            break;
+  case R300_RB3D_ZCACHE_CTLSTAT:
+            s->regs.r300_rb3d_zcache_ctlstat = data;
+            break;
+  case R300_GB_AA_CONFIG:
+            s->regs.r300_gb_aa_config = data;
+            break;
+  case R300_RE_SCISSORS_TL:
+            s->regs.r300_re_scissors_tl = data;
+            break;
+
+  case R300_RE_SCISSORS_BR:
+            s->regs.r300_re_scissors_br = data;
+            break;
+  case RADEON_HOST_PATH_CNTL:
+            s->regs.host_path_cntl = data;
+            break;
+
+  case R300_GB_MSPOS0:
+            s->regs.r300_gb_mpos_0 = data;
+            break;
+
+  case R300_GB_MSPOS1:
+            s->regs.r300_gb_mpos_1 = data;
+            break;
+  case RADEON_SURFACE_CNTL:
+            s->regs.surface_cntl = data;
+            break;
+  case RADEON_SURFACE0_INFO:
+            s->regs.surface0_info = data;
+            break;
+  case RADEON_SURFACE1_INFO:
+            s->regs.surface1_info = data;
+            break;
+
+  case RADEON_SURFACE2_INFO:
+  s->regs.surface2_info = data;
+  break;
+  case RADEON_SURFACE3_INFO:
+  s->regs.surface3_info = data;
+  break;
+  case RADEON_SURFACE4_INFO:
+  s->regs.surface4_info = data;
+  break;
+  case RADEON_SURFACE5_INFO:
+  s->regs.surface5_info = data;
+  break;
+  case RADEON_SURFACE6_INFO:
+  s->regs.surface6_info = data;
+  break;
+  case RADEON_SURFACE7_INFO:
+  s->regs.surface7_info = data;
+  break;
+  case RADEON_OV0_SCALE_CNTL:
+  s->regs.ov0_scale_cntl = data;
+  break;
+  case RADEON_SUBPIC_CNTL:
+  s->regs.subpic_cntl = data;
+  break;
+  case RADEON_VIPH_CONTROL:
+  s->regs.viph_control = data;
+  break;
+  case RADEON_I2C_CNTL_1:
+  s->regs.i2c_cntl_1 = data;
+  break;
+  case RADEON_DVI_I2C_CNTL_1:
+  s->regs.dvi_i2c_cntl_1 = data;
+  break;
+  case RADEON_CAP0_TRIG_CNTL:
+  s->regs.cap0_trig_cntl = data;
+  break;
+  case RADEON_CAP1_TRIG_CNTL:
+  s->regs.cap1_trig_cntl = data;
+  break;
+  case RADEON_CUR2_OFFSET:
+  s->regs.cur2_offset = data;
+  break;
+  case RADEON_CRTC2_GEN_CNTL:
+  s->regs.crtc2_gen_cntl = data;
+  break;
+  case RADEON_MEM_INTF_CNTL:
+  s->regs.mem_intf_cntl = data;
+  break;
+  case RADEON_AGP_BASE_2:
+  s->regs.agp_base_2 = data;
+  break;
+  case RADEON_AGP_BASE:
+  s->regs.agp_base = data;
+  break;
+  case RADEON_MEM_ADDR_CONFIG:
+  s->regs.mem_addr_config = data;
+  break;
+  case RADEON_DISPLAY2_BASE_ADDR:
+  s->regs.display2_base_addr = data;
+  break;
+  case RADEON_SPLL_CNTL:
+  s->regs.spll_cntl = data;
+  break;
+  case RADEON_VCLK_ECP_CNTL:
+  s->regs.vclk_ecp_cntl = data;
+  break;
+  case RADEON_CP_RB_CNTL:
+  s->regs.cp_rb_cntl = data;
+  break;
+  case RADEON_MEM_CNTL:
+  s->regs.mem_cntl = data;
+  break;
+  case R300_CRTC_TILE_X0_Y0:
+  s->regs.tile_x0_y0 = data;
+
+  break;
+  case R300_MC_INIT_MISC_LAT_TIMER:
+  s->regs.r300_mc_init_misc_lat_timer = 0xDEADBEEF;
+  break;
+  case RADEON_AIC_CNTL:
+  s->regs.aic_cntl = data;
+  break;
+  case RADEON_DDA_CONFIG:
+  s->regs.dda_config = data;
+  break;
+
+
+
+
+
+
+
+
+
+
     default:
+    qemu_log("REGISTER NOT IMPLEMENTED 0x%08lx \n",addr);
+    s->regs.emu_register_stub[addr % 128] = data;
         break;
     }
+
 }
 
 static const MemoryRegionOps r300_mm_ops = {
@@ -903,7 +1252,10 @@ static void r300_vga_realize(PCIDevice *dev, Error **errp)
     RADVGAState *s = RAD_VGA(dev);
     VGACommonState *vga = &s->vga;
 
+    // s->regs.r300_mc_init_misc_lat_timer = 0xDEADBEEF;
+
     if (s->model) {
+        s->regs.vga_reset = 0x02;
         int i;
         for (i = 0; i < ARRAY_SIZE(r300_model_aliases); i++) {
             if (!strcmp(s->model, r300_model_aliases[i].name)) {
@@ -947,7 +1299,7 @@ static void r300_vga_realize(PCIDevice *dev, Error **errp)
 
     /* mmio register space */
     memory_region_init_io(&s->mm, OBJECT(s), &r300_mm_ops, s,
-                          "ati.mmregs", 0x4000);
+                          "ati.mmregs", RADEON_MIN_MMIO_SIZE);
     /* io space is alias to beginning of mmregs */
     memory_region_init_alias(&s->io, OBJECT(s), "ati.io", &s->mm, 0, 0x100);
 
@@ -955,8 +1307,11 @@ static void r300_vga_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mm);
 
+
     /* most interrupts are not yet emulated but MacOS needs at least VBlank */
-    dev->config[PCI_INTERRUPT_PIN] = 1;
+    // dev->config[PCI_INTERRUPT_PIN] = 1;
+    // pci_std_vga_mmio_region_init(vga,OBJECT(s),&s->mm,&s->mm,true,true);
+
     timer_init_ns(&s->vblank_timer, QEMU_CLOCK_VIRTUAL, r300_vga_vblank_irq, s);
 }
 
diff --git a/hw/display/r300.h b/hw/display/r300.h
index 19e3d97f8a..3084cc412a 100644
--- a/hw/display/r300.h
+++ b/hw/display/r300.h
@@ -27,6 +27,11 @@
 #define PCI_VENDOR_ID_ATI 0x1002
 /* Radeon 9500 PRO */
 #define PCI_DEVICE_ID_ATI_RADEON_9500_PRO 0x4e45
+/* Radeon 9500 PRO */
+#define PCI_DEVICE_ID_ATI_RADEON_9700 0x4e44
+
+#define RADEON_MIN_MMIO_SIZE 0x10000
+
 
 #define TYPE_RAD_VGA "rad-vga"
 #define RAD_VGA(obj) OBJECT_CHECK(RADVGAState, (obj), TYPE_RAD_VGA)
@@ -82,14 +87,80 @@ typedef struct RADVGARegs{
   uint32_t default_tile;
   uint32_t default_sc_bottom_right;
   uint32_t mc_status;
+  uint32_t isync_cntl;
+  uint32_t host_path_cntl;
+  uint32_t wait_until;
+  uint32_t cp_csq_cntl;
+  uint32_t scratch_umask;
+  uint32_t r100_display_base_addr;
+  uint32_t r100_sclk_cntl;
+
+
+
+  uint8_t vga_reset;
+  uint32_t tile_x0_y0;
+  uint32_t dda_config;
+  uint32_t aic_cntl;
+
+  uint32_t cp_rb_cntl;
+  uint32_t mem_cntl;
+
+
+  uint32_t surface_cntl;
+  uint32_t surface0_info;
+  uint32_t surface1_info;
+  uint32_t surface2_info;
+  uint32_t surface3_info;
+  uint32_t surface4_info;
+  uint32_t surface5_info;
+  uint32_t surface6_info;
+  uint32_t surface7_info;
+  uint32_t ov0_scale_cntl;
+  uint32_t i2c_cntl_1;
+  uint32_t dvi_i2c_cntl_1;
+  uint32_t subpic_cntl;
+  uint32_t viph_control;
+  uint32_t cap0_trig_cntl;
+  uint32_t cap1_trig_cntl;
+  uint32_t cur2_offset;
+
+  uint32_t crtc2_gen_cntl;
+
+  uint32_t mem_intf_cntl;
+  uint32_t agp_base_2;
+  uint32_t agp_base;
+
+  uint32_t mem_addr_config;
+  uint32_t display2_base_addr;
+  uint32_t spll_cntl;
+  uint32_t vclk_ecp_cntl;
+
+
+
+
+
+
+  //R300 DST registers
+
+  uint32_t r300_dst_pipe_config;
 
   //R300 GB Registers
   uint32_t r300_gb_enable;
   uint32_t r300_gb_tile_config;
   uint32_t r300_gb_fifo_size;
+  uint32_t r300_gb_select;
+  uint32_t r300_gb_aa_config;
+  uint32_t r300_gb_mpos_0;
+  uint32_t r300_gb_mpos_1;
 
+  // RE registers
+  uint32_t r300_re_scissors_tl;
+  uint32_t r300_re_scissors_br;
 
-//Color Buffer RB3D
+  // RB2D registers
+uint32_t r300_rb2d_dstcache_mode;
+
+// RB3D Registers
   uint32_t r300_rb3d_aaresolve_ctl;
   uint32_t r300_rb3d_aaresolve_offset;
   uint32_t r300_rb3d_aaresolve_pitch;
@@ -99,11 +170,15 @@ typedef struct RADVGARegs{
   uint32_t r300_rb3d_color_mask;
   uint32_t r300_rb3d_color_pitch[4];
   uint32_t r300_rb3d_color_offset[4];
+  uint32_t r300_rb3d_zcache_ctlstat;
+  uint32_t r300_rb3d_dstcache_ctlstat;
 
   uint32_t rbbm_gui_cntl;
   uint32_t rbbm_status;
   uint32_t rbbm_soft_reset;
 
+  uint32_t emu_register_stub[128];
+
 
 
 
-- 
2.24.0



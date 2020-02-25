Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA1C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B25621556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN89XC5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B25621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZUx-000574-Hs
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlM-0001yO-Ev
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlJ-0001fZ-W9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:32 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YlJ-0001ZL-OI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:29 -0500
Received: by mail-wm1-x341.google.com with SMTP id a9so2849601wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0pItt/zXBt8+9jJPlzltspuqXVmVEmugCzgbhMgtvSQ=;
 b=kN89XC5MOoEjsQe4hs4w0tzM11TrNFXnGjnMQ97ULCl663eeo0bjia1iOamThtL3J4
 FEP7ynMOjxZkDluItGtnKMs0QeDdw3IksNYxLbKw7OFjYT4xNMcVifBtrMdzo0eoBq/6
 qdE2nYV1215Fl0TOSQwkFmiaHf9JNiRYG2HCk4880wy5WOzs92rOMmClwHRpsb7m67Qq
 f2ELYc1ZwHW6dzce0vXOcqYcBAYDnVOIw1pUBiNM9VXoBhB4/UrqKp+uRCeGx+ZaGMg1
 th0UYB7Sr9LBPJvcsyCp5gn8h0u/fnq+FKhNsls/JCC2pKE1Eawxd9OvBxKBIRWZR3gT
 hptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0pItt/zXBt8+9jJPlzltspuqXVmVEmugCzgbhMgtvSQ=;
 b=rWvbNAGW3aMQwLeCuuFI7COGmU0w0S+aWB+mhhNkqNYy+VCY3qZnB0kuoN7K5wAfx1
 lADaGsqptq7htwKFBPdRnq5VBe7PxdJ7ZDAQ9qAHC3JLWAizUp38FgavY76ssVYYWYm+
 UwUIDXf2sLpwjuMwxiFMVW1uZTrHeQ9Ssn0o7v/Q3yebE78zk+892hOCzibKRZcv/cpo
 ggqv2icCEOxRkH3cuLJ9//7ot6CpmbUhNvKnJij2sJBvTkndZrLXBGm2hbgKaAblb2Na
 fv9Uocdbq5KPLiROKGqD7w6CpAv2EviezOTNNb2J8v5ISFKcUSuFkNNbykZgOFF97aRu
 fMig==
X-Gm-Message-State: APjAAAWHOU6CY5+NpWwsh7oLZZhc9z7YlJLrJoX+lT7J89e/sLDMqVc1
 2CqSL/+Y31hdJnp+AHp4zBx92ugl
X-Google-Smtp-Source: APXvYqzzeCeMdqhfRdAgHR2r2ev8Hxa2HJWDraoqFdXa/IDOc04/BwpiSazBrFNKZBVLD3Ub93rJuQ==
X-Received: by 2002:a05:600c:23cd:: with SMTP id
 p13mr3608369wmb.28.1582631548295; 
 Tue, 25 Feb 2020 03:52:28 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 088/136] Remove unnecessary cast when using the
 cpu_[physical]_memory API
Date: Tue, 25 Feb 2020 12:50:18 +0100
Message-Id: <1582631466-13880-88-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/display/omap_lcdc.c                 | 10 +++++-----
 hw/dma/etraxfs_dma.c                   | 25 ++++++++++---------------
 hw/scsi/vmw_pvscsi.c                   |  8 +++-----
 scripts/coccinelle/exec_rw_const.cocci | 10 ++++++++++
 target/i386/hax-all.c                  |  6 +++---
 5 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index 6ad13f2..fa4a381 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -91,9 +91,9 @@ static void omap_update_display(void *opaque)
 
     frame_offset = 0;
     if (omap_lcd->plm != 2) {
-        cpu_physical_memory_read(omap_lcd->dma->phys_framebuffer[
-                                  omap_lcd->dma->current_frame],
-                                 (void *)omap_lcd->palette, 0x200);
+        cpu_physical_memory_read(
+                omap_lcd->dma->phys_framebuffer[omap_lcd->dma->current_frame],
+                omap_lcd->palette, 0x200);
         switch (omap_lcd->palette[0] >> 12 & 7) {
         case 3 ... 7:
             frame_offset += 0x200;
@@ -244,8 +244,8 @@ static void omap_lcd_update(struct omap_lcd_panel_s *s) {
 
     if (s->plm != 2 && !s->palette_done) {
         cpu_physical_memory_read(
-            s->dma->phys_framebuffer[s->dma->current_frame],
-            (void *)s->palette, 0x200);
+                            s->dma->phys_framebuffer[s->dma->current_frame],
+                            s->palette, 0x200);
         s->palette_done = 1;
         omap_lcd_interrupts(s);
     }
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index 47e1c6d..c4334e8 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -225,9 +225,8 @@ static void channel_load_g(struct fs_dma_ctrl *ctrl, int c)
 	hwaddr addr = channel_reg(ctrl, c, RW_GROUP);
 
 	/* Load and decode. FIXME: handle endianness.  */
-	cpu_physical_memory_read (addr, 
-				  (void *) &ctrl->channels[c].current_g, 
-				  sizeof ctrl->channels[c].current_g);
+    cpu_physical_memory_read(addr, &ctrl->channels[c].current_g,
+                             sizeof(ctrl->channels[c].current_g));
 }
 
 static void dump_c(int ch, struct dma_descr_context *c)
@@ -257,9 +256,8 @@ static void channel_load_c(struct fs_dma_ctrl *ctrl, int c)
 	hwaddr addr = channel_reg(ctrl, c, RW_GROUP_DOWN);
 
 	/* Load and decode. FIXME: handle endianness.  */
-	cpu_physical_memory_read (addr, 
-				  (void *) &ctrl->channels[c].current_c, 
-				  sizeof ctrl->channels[c].current_c);
+    cpu_physical_memory_read(addr, &ctrl->channels[c].current_c,
+                             sizeof(ctrl->channels[c].current_c));
 
 	D(dump_c(c, &ctrl->channels[c].current_c));
 	/* I guess this should update the current pos.  */
@@ -275,9 +273,8 @@ static void channel_load_d(struct fs_dma_ctrl *ctrl, int c)
 
 	/* Load and decode. FIXME: handle endianness.  */
 	D(printf("%s ch=%d addr=" TARGET_FMT_plx "\n", __func__, c, addr));
-	cpu_physical_memory_read (addr,
-				  (void *) &ctrl->channels[c].current_d, 
-				  sizeof ctrl->channels[c].current_d);
+    cpu_physical_memory_read(addr, &ctrl->channels[c].current_d,
+                             sizeof(ctrl->channels[c].current_d));
 
 	D(dump_d(c, &ctrl->channels[c].current_d));
 	ctrl->channels[c].regs[RW_DATA] = addr;
@@ -290,9 +287,8 @@ static void channel_store_c(struct fs_dma_ctrl *ctrl, int c)
 	/* Encode and store. FIXME: handle endianness.  */
 	D(printf("%s ch=%d addr=" TARGET_FMT_plx "\n", __func__, c, addr));
 	D(dump_d(c, &ctrl->channels[c].current_d));
-	cpu_physical_memory_write (addr,
-				  (void *) &ctrl->channels[c].current_c,
-				  sizeof ctrl->channels[c].current_c);
+    cpu_physical_memory_write(addr, &ctrl->channels[c].current_c,
+                              sizeof(ctrl->channels[c].current_c));
 }
 
 static void channel_store_d(struct fs_dma_ctrl *ctrl, int c)
@@ -301,9 +297,8 @@ static void channel_store_d(struct fs_dma_ctrl *ctrl, int c)
 
 	/* Encode and store. FIXME: handle endianness.  */
 	D(printf("%s ch=%d addr=" TARGET_FMT_plx "\n", __func__, c, addr));
-	cpu_physical_memory_write (addr,
-				  (void *) &ctrl->channels[c].current_d, 
-				  sizeof ctrl->channels[c].current_d);
+    cpu_physical_memory_write(addr, &ctrl->channels[c].current_d,
+                              sizeof(ctrl->channels[c].current_d));
 }
 
 static inline void channel_stop(struct fs_dma_ctrl *ctrl, int c)
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index e4ee2e6..c91352c 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -404,8 +404,7 @@ pvscsi_cmp_ring_put(PVSCSIState *s, struct PVSCSIRingCmpDesc *cmp_desc)
 
     cmp_descr_pa = pvscsi_ring_pop_cmp_descr(&s->rings);
     trace_pvscsi_cmp_ring_put(cmp_descr_pa);
-    cpu_physical_memory_write(cmp_descr_pa, (void *)cmp_desc,
-                              sizeof(*cmp_desc));
+    cpu_physical_memory_write(cmp_descr_pa, cmp_desc, sizeof(*cmp_desc));
 }
 
 static void
@@ -415,8 +414,7 @@ pvscsi_msg_ring_put(PVSCSIState *s, struct PVSCSIRingMsgDesc *msg_desc)
 
     msg_descr_pa = pvscsi_ring_pop_msg_descr(&s->rings);
     trace_pvscsi_msg_ring_put(msg_descr_pa);
-    cpu_physical_memory_write(msg_descr_pa, (void *)msg_desc,
-                              sizeof(*msg_desc));
+    cpu_physical_memory_write(msg_descr_pa, msg_desc, sizeof(*msg_desc));
 }
 
 static void
@@ -491,7 +489,7 @@ pvscsi_get_next_sg_elem(PVSCSISGState *sg)
 {
     struct PVSCSISGElement elem;
 
-    cpu_physical_memory_read(sg->elemAddr, (void *)&elem, sizeof(elem));
+    cpu_physical_memory_read(sg->elemAddr, &elem, sizeof(elem));
     if ((elem.flags & ~PVSCSI_KNOWN_FLAGS) != 0) {
         /*
             * There is PVSCSI_SGE_FLAG_CHAIN_ELEMENT flag described in
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index fe2cf91..9c14165 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -42,6 +42,16 @@ type T;
 + address_space_write_rom(E1, E2, E3, E4, E5)
 |
 
+- cpu_physical_memory_rw(E1, (T *)(E2), E3, E4)
++ cpu_physical_memory_rw(E1, E2, E3, E4)
+|
+- cpu_physical_memory_read(E1, (T *)(E2), E3)
++ cpu_physical_memory_read(E1, E2, E3)
+|
+- cpu_physical_memory_write(E1, (T *)(E2), E3)
++ cpu_physical_memory_write(E1, E2, E3)
+|
+
 - dma_memory_read(E1, E2, (T *)(E3), E4)
 + dma_memory_read(E1, E2, E3, E4)
 |
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index a8b6e5a..a9cc51e 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -367,7 +367,7 @@ static int hax_accel_init(MachineState *ms)
 static int hax_handle_fastmmio(CPUArchState *env, struct hax_fastmmio *hft)
 {
     if (hft->direction < 2) {
-        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &hft->value, hft->size,
+        cpu_physical_memory_rw(hft->gpa, &hft->value, hft->size,
                                hft->direction);
     } else {
         /*
@@ -376,8 +376,8 @@ static int hax_handle_fastmmio(CPUArchState *env, struct hax_fastmmio *hft)
          *  hft->direction == 2: gpa ==> gpa2
          */
         uint64_t value;
-        cpu_physical_memory_rw(hft->gpa, (uint8_t *) &value, hft->size, 0);
-        cpu_physical_memory_rw(hft->gpa2, (uint8_t *) &value, hft->size, 1);
+        cpu_physical_memory_rw(hft->gpa, &value, hft->size, 0);
+        cpu_physical_memory_rw(hft->gpa2, &value, hft->size, 1);
     }
 
     return 0;
-- 
1.8.3.1




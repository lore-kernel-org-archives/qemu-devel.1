Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6239BC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270062070A
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCMHRiA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270062070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcZe5-00026k-Dg
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 15:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcZcC-0006nW-TM
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:15:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcZcC-0000aV-42
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:15:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id x14so8170275wrp.2
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 12:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MuUd/xx1QteafhtU3bgpxtQqiUIGOCgMcYmDgBe3utQ=;
 b=WCMHRiA3oSImtgwSJmErKS/nRdIiBxoxP7waiHk4/8enyv/RTqhhg4QZXXhpwrJJWT
 I8KOGfk3GY+fjN+8mm2ikn2lqNAgGA3WXhRGADfyANUWK9NVKnS49yuJFIGuWk59phe6
 +skDt9/dHkeLXssCOXu7OV1Qi0RFqNvbWBibJsteo+aRJVG/Cyv2vdxKK1oSBuA052oP
 1wZJWvgd9HYTSEJGcU7X0E6oE2L6W0/J4Qwv13XEF3fMgfH+Vp1wb9LPGfNxPNqOo3c8
 8kqD1ynPZ5GLn+7jR5vgdVEznw7dTC+P8RYmfqzfHOlEH7y2Gps5tJQiBGyGkupeLdIW
 YvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MuUd/xx1QteafhtU3bgpxtQqiUIGOCgMcYmDgBe3utQ=;
 b=ouZYVDvDcrbz6HE/2WxQIy9xUQ7hxOiJZ+uJJfNlBtTWhLiKT9wEEkSFScxiZqu5Nr
 5n77CnT+C3ygWQ6tNWHGGZqXNbDld1+PtdqDZi0xp9o/3CRkfm5rO5WUs/U82W9lbc25
 GBmDS7LZd7Re3I5pAzBF751Hd51RYbb8aZBsJee1alrh1KjFa8MtAOQ767rIhgEtjx8q
 NP2FR+ADYIwU9LEz6d+MKg7gDz1psjew74YzI99HQbeFVNxllepEls4AE6YhgXAgfXjq
 pRRI+gYpAnd9UPV/2WctMXquKWaS555aa/N0QNZYHzM7wFPp8izRfqrx61+3cdK7Wlhf
 8PBg==
X-Gm-Message-State: AOAM533ch5n6iI0g6dBX/6j4sE2m7a7Dka9wuHPWxj1y9T2uQOHidLbB
 YEi2mZU+FR2QFG4f0VmmiSA=
X-Google-Smtp-Source: ABdhPJxsp0qrr0R9QwaYleVmXEpo7+FU2DsVA389XcX9RSH4Sy1ut00UtoplSAQmIBFYCgBnIzCblQ==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr8155313wrt.298.1590261322897; 
 Sat, 23 May 2020 12:15:22 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y185sm13370681wmy.11.2020.05.23.12.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 12:15:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 2/3] hw/display/artist: Refactor artist_rop8() to avoid buffer
 over-run
Date: Sat, 23 May 2020 21:15:16 +0200
Message-Id: <20200523191517.23684-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200523191517.23684-1-f4bug@amsat.org>
References: <20200523191517.23684-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Invalid I/O writes can craft an offset out of the vram_buffer
range.
Instead of passing an unsafe pointer to artist_rop8(), pass the
vram_buffer and the offset. We can now check if the offset is
in range before accessing it.

We avoid:

  Program terminated with signal SIGSEGV, Segmentation fault.
  284             *dst &= ~plane_mask;
  (gdb) bt
  #0  0x000056367b2085c0 in artist_rop8 (s=0x56367d38b510, dst=0x7f9f972fffff <error: Cannot access memory at address 0x7f9f972fffff>, val=0 '\000') at hw/display/artist.c:284
  #1  0x000056367b209325 in draw_line (s=0x56367d38b510, x1=-20480, y1=-1, x2=0, y2=17920, update_start=true, skip_pix=-1, max_pix=-1) at hw/display/artist.c:646

Reported-by: LLVM libFuzzer
Buglink: https://bugs.launchpad.net/qemu/+bug/1880326
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/artist.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 3c2550f6db..6f61b85a24 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -273,11 +273,20 @@ static artist_rop_t artist_get_op(ARTISTState *s)
     return (s->image_bitmap_op >> 8) & 0xf;
 }
 
-static void artist_rop8(ARTISTState *s, uint8_t *dst, uint8_t val)
+static void artist_rop8(ARTISTState *s, struct vram_buffer *buf,
+                        int offset, uint8_t val)
 {
-
     const artist_rop_t op = artist_get_op(s);
-    uint8_t plane_mask = s->plane_mask & 0xff;
+    uint8_t plane_mask;
+    uint8_t *dst;
+
+    if (offset < 0 || offset >= buf->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "rop8 offset:%d bufsize:%u\n", offset, buf->size);
+        return;
+    }
+    dst = buf->data + offset;
+    plane_mask = s->plane_mask & 0xff;
 
     switch (op) {
     case ARTIST_ROP_CLEAR:
@@ -381,7 +390,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
         }
 
         for (i = 0; i < pix_count; i++) {
-            artist_rop8(s, p + offset + pix_count - 1 - i,
+            artist_rop8(s, buf, offset + pix_count - 1 - i,
                         (data & 1) ? (s->plane_mask >> 24) : 0);
             data >>= 1;
         }
@@ -398,7 +407,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
         for (i = 3; i >= 0; i--) {
             if (!(s->image_bitmap_op & 0x20000000) ||
                 s->vram_bitmask & (1 << (28 + i))) {
-                artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
+                artist_rop8(s, buf, offset + 3 - i, data8[ROP8OFF(i)]);
             }
         }
         memory_region_set_dirty(&buf->mr, offset, 3);
@@ -426,10 +435,10 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
             if (!(s->image_bitmap_op & 0x20000000) ||
                 (vram_bitmask & mask)) {
                 if (data & mask) {
-                    artist_rop8(s, p + offset + i, s->fg_color);
+                    artist_rop8(s, buf, offset + i, s->fg_color);
                 } else {
                     if (!(s->image_bitmap_op & 0x10000002)) {
-                        artist_rop8(s, p + offset + i, s->bg_color);
+                        artist_rop8(s, buf, offset + i, s->bg_color);
                     }
                 }
             }
@@ -507,7 +516,7 @@ static void block_move(ARTISTState *s, int source_x, int source_y, int dest_x,
             if (dst + column > buf->size || src + column > buf->size) {
                 continue;
             }
-            artist_rop8(s, buf->data + dst + column, buf->data[src + column]);
+            artist_rop8(s, buf, dst + column, buf->data[src + column]);
         }
     }
 
@@ -548,7 +557,7 @@ static void fill_window(ARTISTState *s, int startx, int starty,
         offset = y * s->width;
 
         for (x = startx; x < startx + width; x++) {
-            artist_rop8(s, buf->data + offset + x, color);
+            artist_rop8(s, buf, offset + x, color);
         }
     }
     artist_invalidate_lines(buf, starty, height);
@@ -561,7 +570,6 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
     uint8_t color;
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
-    uint8_t *p;
 
     trace_artist_draw_line(x1, y1, x2, y2);
 
@@ -630,16 +638,18 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
     color = artist_get_color(s);
 
     do {
+        int ofs;
+
         if (c1) {
-            p = buf->data + x * s->width + y;
+            ofs = x * s->width + y;
         } else {
-            p = buf->data + y * s->width + x;
+            ofs = y * s->width + x;
         }
 
         if (skip_pix > 0) {
             skip_pix--;
         } else {
-            artist_rop8(s, p, color);
+            artist_rop8(s, buf, ofs, color);
         }
 
         if (e > 0) {
@@ -773,10 +783,10 @@ static void font_write16(ARTISTState *s, uint16_t val)
     for (i = 0; i < 16; i++) {
         mask = 1 << (15 - i);
         if (val & mask) {
-            artist_rop8(s, buf->data + offset + i, color);
+            artist_rop8(s, buf, offset + i, color);
         } else {
             if (!(s->image_bitmap_op & 0x20000000)) {
-                artist_rop8(s, buf->data + offset + i, s->bg_color);
+                artist_rop8(s, buf, offset + i, s->bg_color);
             }
         }
     }
-- 
2.21.3



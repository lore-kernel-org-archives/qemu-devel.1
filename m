Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D6AC352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150FB20873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpm8ei4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150FB20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2OcP-0005s3-9G
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObV-0004Wi-Oh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObU-0006wn-Ig
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:09 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2ObU-0006vZ-C2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:13:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id a5so8214327wmb.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 16:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zf3PhdUFbvcfneYdRj7vR71aYgxGRLP50x8FK7k3NmM=;
 b=Gpm8ei4PXPy4sTI7Lr2b+e5Zdo6EzbMQzEVDq3Cpowhhllw2VPMnBFUYCUZin8eXmk
 cCS1p5eCLkyWNCA3UDG5Z9LTx+Nn49fg+ozUTOUKcx+dvlMziBBMF3nDwVHAMvt1jDYU
 zgoJ7oovMT9rNVmT07WId0eX8wdTQba6/Dqvt5/ejx0IPQ8Uk+AyKTCM6dEsO4S9XKW9
 zzYEwE2CDC5eEbLyV1KznuHfJbOikZxNhpTtzH5qvj2miZFwX4HJ9dpkVinRIfVCPw4m
 lyMY2atncTdwt5f79E1XUnJIPP5cvxEYcXVrZSHJOCpg13KqSBT/eBCczugaUZd+k7ge
 jPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zf3PhdUFbvcfneYdRj7vR71aYgxGRLP50x8FK7k3NmM=;
 b=GQWoAoABSZo9lVyTZ99grEQ7MxghM/Xs+0mdI43oH2+KYR5z1LOXD81ySKuIHbSxaW
 BHESv8d0Y6XWDjFIzzpelwxmI4B4IRRXoE93gJwLk2XMompcS0c5tsoSfqGpkEM9omGL
 /0FxkW2hy7ETZSRHRe81H5kPsThmWvC6dDeMjVWKfqtuTk2r+BZUIP7DKqiXijz+uNYn
 Pqnzn5X/ztM7c/HPAikbejSZtPJsVHtsTZdkh6VOdhyrzy798VNw1P7OOTGV64k+xy0j
 bJMRPVFVP4vTZGvrHcHHYdF/cWo+GMPRu/S+VjuZwTuI5NYVO7ZdzkU2O75EgyDjECrB
 5anA==
X-Gm-Message-State: APjAAAW2j/CWrybrejUfxKCfRFPIrRBlYBu6MzgVO8GsuDYzFI5suBsZ
 bArDswtKXgTZUdoSC985ERc=
X-Google-Smtp-Source: APXvYqxTsS3EfD97FXZK79cm0JlFMR7dwrBk8jPthBh5PyLMpnB9jaMeL4tlWg3Q+b8Sj7F3TiIOqw==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr667551wml.83.1581639187339;
 Thu, 13 Feb 2020 16:13:07 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a16sm4679230wrx.87.2020.02.13.16.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 16:13:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 1/5] hw/display/artist: Move trace event to draw_line()
Date: Fri, 14 Feb 2020 01:12:58 +0100
Message-Id: <20200214001303.12873-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214001303.12873-1-f4bug@amsat.org>
References: <20200214001303.12873-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of emitting the trace event before each call to
draw_line(), call it once at draw_line() entrance.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/artist.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 65be9e3554..abacb0e27d 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -557,90 +557,91 @@ static void fill_window(ARTISTState *s, int startx, int starty,
 static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
                       bool update_start, int skip_pix, int max_pix)
 {
     struct vram_buffer *buf;
     uint8_t color = artist_get_color(s);
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
     uint8_t *p;
 
+    trace_artist_draw_line(x1, y1, x2, y2);
 
     if (update_start) {
         s->vram_start = (x2 << 16) | y2;
     }
 
     buf = &s->vram_buffer[ARTIST_BUFFER_AP];
 
     c1 = false;
     incy = 1;
 
     if (x2 > x1) {
         dx = x2 - x1;
     } else {
         dx = x1 - x2;
     }
     if (y2 > y1) {
         dy = y2 - y1;
     } else {
         dy = y1 - y2;
     }
     if (dy > dx) {
         t = y2;
         y2 = x2;
         x2 = t;
 
         t = y1;
         y1 = x1;
         x1 = t;
 
         t = dx;
         dx = dy;
         dy = t;
 
         c1 = true;
     }
 
     if (x1 > x2) {
         t = y2;
         y2 = y1;
         y1 = t;
 
         t = x1;
         x1 = x2;
         x2 = t;
     }
 
     horiz = dy << 1;
     diago = (dy - dx) << 1;
     e = (dy << 1) - dx;
 
     if (y1 <= y2) {
         incy = 1;
     } else {
         incy = -1;
     }
     x = x1;
     y = y1;
 
     do {
         if (c1) {
             p = buf->data + x * s->width + y;
         } else {
             p = buf->data + y * s->width + x;
         }
 
         if (skip_pix > 0) {
             skip_pix--;
         } else {
             artist_rop8(s, p, color);
         }
 
         if (e > 0) {
             artist_invalidate_lines(buf, y, 1);
             y  += incy;
             e  += diago;
         } else {
             e += horiz;
         }
         x++;
     } while (x <= x2 && (max_pix == -1 || --max_pix > 0));
 }
@@ -648,13 +649,12 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
 static void draw_line_pattern_start(ARTISTState *s)
 {
 
     int startx = artist_get_x(s->vram_start);
     int starty = artist_get_y(s->vram_start);
     int endx = artist_get_x(s->blockmove_size);
     int endy = artist_get_y(s->blockmove_size);
     int pstart = s->line_pattern_start >> 16;
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, false, -1, pstart);
     s->line_pattern_skip = pstart;
 }
@@ -662,15 +662,14 @@ static void draw_line_pattern_start(ARTISTState *s)
 static void draw_line_pattern_next(ARTISTState *s)
 {
 
     int startx = artist_get_x(s->vram_start);
     int starty = artist_get_y(s->vram_start);
     int endx = artist_get_x(s->blockmove_size);
     int endy = artist_get_y(s->blockmove_size);
     int line_xy = s->line_xy >> 16;
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, false, s->line_pattern_skip,
               s->line_pattern_skip + line_xy);
     s->line_pattern_skip += line_xy;
     s->image_bitmap_op ^= 2;
 }
@@ -678,84 +677,81 @@ static void draw_line_pattern_next(ARTISTState *s)
 static void draw_line_size(ARTISTState *s, bool update_start)
 {
 
     int startx = artist_get_x(s->vram_start);
     int starty = artist_get_y(s->vram_start);
     int endx = artist_get_x(s->line_size);
     int endy = artist_get_y(s->line_size);
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, update_start, -1, -1);
 }
 
 static void draw_line_xy(ARTISTState *s, bool update_start)
 {
 
     int startx = artist_get_x(s->vram_start);
     int starty = artist_get_y(s->vram_start);
     int sizex = artist_get_x(s->blockmove_size);
     int sizey = artist_get_y(s->blockmove_size);
     int linexy = s->line_xy >> 16;
     int endx, endy;
 
     endx = startx;
     endy = starty;
 
     if (sizex > 0) {
         endx = startx + linexy;
     }
 
     if (sizex < 0) {
         endx = startx;
         startx -= linexy;
     }
 
     if (sizey > 0) {
         endy = starty + linexy;
     }
 
     if (sizey < 0) {
         endy = starty;
         starty -= linexy;
     }
 
     if (startx < 0) {
         startx = 0;
     }
 
     if (endx < 0) {
         endx = 0;
     }
 
     if (starty < 0) {
         starty = 0;
     }
 
     if (endy < 0) {
         endy = 0;
     }
 
 
     if (endx < 0) {
         return;
     }
 
     if (endy < 0) {
         return;
     }
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, false, -1, -1);
 }
 
 static void draw_line_end(ARTISTState *s, bool update_start)
 {
 
     int startx = artist_get_x(s->vram_start);
     int starty = artist_get_y(s->vram_start);
     int endx = artist_get_x(s->line_end);
     int endy = artist_get_y(s->line_end);
 
-    trace_artist_draw_line(startx, starty, endx, endy);
     draw_line(s, startx, starty, endx, endy, update_start, -1, -1);
 }
 
-- 
2.21.1



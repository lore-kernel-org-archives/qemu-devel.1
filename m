Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F05C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:16:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698AA2070A
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 19:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbKNzZ+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698AA2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcZcy-00084W-JA
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 15:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcZcB-0006mK-JF
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:15:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcZcA-0000aM-UD
 for qemu-devel@nongnu.org; Sat, 23 May 2020 15:15:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id s8so13519020wrt.9
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AdMpyqTCFlk39vXTmF2j6XEmuS3qX56Iy8h4IChD2rE=;
 b=gbKNzZ+YyBvYcTEK48o3NQh141E3nP6RlZfweMi3pVm5hn9ZUr5+dIQdp4OZBfikll
 4agcifFJlMVtxMnIfLJE/6BdFwXWuSnyPWZRcDRPDb0Lg1sf9pCxrxdtxF12gZLNMxmb
 kCBnKaP72RJkB7tOhKVe7/kODlb3hEVT+qknve45oN5895fNQXORlCQ6UikE9Mai+tDN
 TuVC9CFE8uGSvXPwJk1tJA5o47dbRvktFoQDOCtYfrsf59b3+YRTbmR+2SpSMSVQgJkf
 wcvRM9LdWqxWRT20vYTd6PJ3gTa0LIgb33/qQZh5BNFQkRyVZ5lv25Cd3weZZEG8bR4W
 22Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=AdMpyqTCFlk39vXTmF2j6XEmuS3qX56Iy8h4IChD2rE=;
 b=T/7co12lTsuINAiI5UrCi51t1guZjWUWOUz+uVwOetrUM+BKxHO9DOlI3fx1QJYu7e
 qy4+wPa+2F81ELdVqvbTTavEJlqM+Qr+Sxxr/n/4Vmpqph0kULudMvx3TQRV0gvv4M5J
 0v/X5VO6hn4YbUmhFOS1euNJuu9RQ4MA0rpb0+rFlgkPY+tS0n7igN1VpnyPRq4qkr5s
 Vc1KrWueQ+EqRrBQR/62uuXJdE7tcsZi1vaI0gA2KGcGV9TEEtV5gk9KqV1E3PZ8jhr3
 yponC+H6TFCnfcP1seWpA5LhLnXJBTF5G/r9YXG+zuTI5Cqd0nrN3UGbqSq42GOBszUN
 giMA==
X-Gm-Message-State: AOAM531uJ6N672q/uaEV1tGdSc1EzKYigxt+FCjWkAAV8ySHCFhxnoOQ
 /C3SpKdIJG1l7R/TpA4BqJI=
X-Google-Smtp-Source: ABdhPJyMpW3LrrN+PrjNd1oKVioCjlnbdpHrQ7cz4jbLOIvuB+BlupyCaf+QggOnwjyld/XjJFerxw==
X-Received: by 2002:adf:f990:: with SMTP id f16mr2840152wrr.311.1590261321821; 
 Sat, 23 May 2020 12:15:21 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id y185sm13370681wmy.11.2020.05.23.12.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 12:15:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 1/3] hw/display/artist: Check offset in draw_line to avoid
 buffer over-run
Date: Sat, 23 May 2020 21:15:15 +0200
Message-Id: <20200523191517.23684-2-f4bug@amsat.org>
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

We avoid:

  Program terminated with signal SIGSEGV, Segmentation fault.
  284             *dst &= ~plane_mask;
  (gdb) bt
  #0  0x000055d5dccdc5c0 in artist_rop8 (s=0x55d5defee510, dst=0x7f8e84ed8216 <error: Cannot access memory at address 0x7f8e84ed8216>, val=0 '\000') at hw/display/artist.c:284
  #1  0x000055d5dccdcf83 in fill_window (s=0x55d5defee510, startx=22, starty=5674, width=65, height=5697) at hw/display/artist.c:551
  #2  0x000055d5dccddfb9 in artist_reg_write (opaque=0x55d5defee510, addr=1051140, val=4265537, size=4) at hw/display/artist.c:902
  #3  0x000055d5dcb42a7c in memory_region_write_accessor (mr=0x55d5defeea10, addr=1051140, value=0x7ffe57db08c8, size=4, shift=0, mask=4294967295, attrs=...) at memory.c:483

Reported-by: LLVM libFuzzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/artist.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 6261bfe65b..3c2550f6db 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -557,7 +557,7 @@ static void fill_window(ARTISTState *s, int startx, int starty,
 static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
                       bool update_start, int skip_pix, int max_pix)
 {
-    struct vram_buffer *buf;
+    struct vram_buffer *buf = &s->vram_buffer[ARTIST_BUFFER_AP];
     uint8_t color;
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
@@ -565,6 +565,12 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
 
     trace_artist_draw_line(x1, y1, x2, y2);
 
+    if (x1 * y1 >= buf->size || x2 * y2 >= buf->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "draw_line (%d,%d) (%d,%d)\n", x1, y1, x2, y2);
+        return;
+    }
+
     if (update_start) {
         s->vram_start = (x2 << 16) | y2;
     }
@@ -622,7 +628,6 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
     x = x1;
     y = y1;
     color = artist_get_color(s);
-    buf = &s->vram_buffer[ARTIST_BUFFER_AP];
 
     do {
         if (c1) {
-- 
2.21.3



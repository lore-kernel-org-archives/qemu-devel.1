Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4103C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732CC207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iveI+Cis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732CC207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcoYh-0004Dw-Lv
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 07:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoXl-0003QE-Rd; Sun, 24 May 2020 07:11:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoXh-0001A5-PA; Sun, 24 May 2020 07:11:46 -0400
Received: by mail-wr1-x444.google.com with SMTP id i15so14549492wrx.10;
 Sun, 24 May 2020 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C1eszk0Q8nnnhJsx17RLrSJtA9SbbE0OV6yQiljuJ0I=;
 b=iveI+CismgTPerhEU7qbOOxEFnl8EU3He6R+1d2wWFrxTM6WdB9PF0oycUGvZzPGk8
 s6Ui/Lg9ZOFFE9yiuWT5F43BkDSp0swMlJ7RV6VPVdAHsit1HQJbX0mhtecMoGUlYEGS
 vqxii9tqgyk5wb1s4mbT42VrkCXGaRogJp8r1cmDW8SgjTwZB41/nm1btGZiWtQhV8Rb
 Oh6h5j2IGnYkmTDM2Fg4GuOZs60MtQDi3fWssbEbF+kWjQ33yhR6/uUO4W+pQxPDS1ZX
 NySMO8ciC70zqSBce0bq0C1rUDJNN2NSk/v+OpFfuaIg/Q3sP4HN2HiG2QZqhYQHTmh0
 cdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=C1eszk0Q8nnnhJsx17RLrSJtA9SbbE0OV6yQiljuJ0I=;
 b=gGRs8l51ea9xtYSrbwt4+vXxQGXwRux555qCWqQCIuz/wjBafNxY9KmDC3iSKsE5Br
 kDc3t4Rb5SSO7D5kGcVeY1bt6mZOsl8jtlsl58SmVfFc/o1eukwMm44mlMXMonyv1yw3
 lMHOlegKXImy73aoudMffygkYooD+YIvrkodZloPU9i3lPb+j6rEncziwoErwkQP0sLj
 0fESG6rwaYTH+TjGFJnoXiK9t1jDL7/Mt5uHyvfRqqrYddb5b6M2JTUg8yFKKCCKseFR
 61QvUbfwVRS3UaHPdMImI77g5jCwkAQRiVIp8EsIIDqHKnG7lquqKZkQU7I7BlvSL9O6
 nX8Q==
X-Gm-Message-State: AOAM530Rl4kUXmY3F8/Uvrzlwp+N+dcVbJhj2nzVvF0SIFIU9u0/U3h3
 qBpfb/tlLz7oOxjFuiDxiG70EBzFjvc=
X-Google-Smtp-Source: ABdhPJzMvcspME0+nQdavVFZYQ4XEOgABUrwV/cNPCUfKbNnYefevQWuDFkD7jKxevQmkadqbhTPPQ==
X-Received: by 2002:adf:ef01:: with SMTP id e1mr10160998wro.28.1590318703168; 
 Sun, 24 May 2020 04:11:43 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a12sm9109661wrs.70.2020.05.24.04.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 04:11:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/display/exynos4210_fimd: Use qemu_log_mask(GUEST_ERROR)
Date: Sun, 24 May 2020 13:11:40 +0200
Message-Id: <20200524111140.16365-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace DPRINT_ERROR() by qemu_log_mask(GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/exynos4210_fimd.c | 46 +++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index 1c0266ce9f..4b7286b7c9 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -31,6 +31,7 @@
 #include "ui/pixel_ops.h"
 #include "qemu/bswap.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 
 /* Debug messages configuration */
 #define EXYNOS4210_FIMD_DEBUG              0
@@ -39,20 +40,15 @@
 #if EXYNOS4210_FIMD_DEBUG == 0
     #define DPRINT_L1(fmt, args...)       do { } while (0)
     #define DPRINT_L2(fmt, args...)       do { } while (0)
-    #define DPRINT_ERROR(fmt, args...)    do { } while (0)
 #elif EXYNOS4210_FIMD_DEBUG == 1
     #define DPRINT_L1(fmt, args...) \
         do {fprintf(stderr, "QEMU FIMD: "fmt, ## args); } while (0)
     #define DPRINT_L2(fmt, args...)       do { } while (0)
-    #define DPRINT_ERROR(fmt, args...)  \
-        do {fprintf(stderr, "QEMU FIMD ERROR: "fmt, ## args); } while (0)
 #else
     #define DPRINT_L1(fmt, args...) \
         do {fprintf(stderr, "QEMU FIMD: "fmt, ## args); } while (0)
     #define DPRINT_L2(fmt, args...) \
         do {fprintf(stderr, "QEMU FIMD: "fmt, ## args); } while (0)
-    #define DPRINT_ERROR(fmt, args...)  \
-        do {fprintf(stderr, "QEMU FIMD ERROR: "fmt, ## args); } while (0)
 #endif
 
 #if EXYNOS4210_FIMD_MODE_TRACE == 0
@@ -1108,7 +1104,7 @@ static inline int fimd_get_buffer_id(Exynos4210fimdWindow *w)
     case FIMD_WINCON_BUF2_STAT:
         return 2;
     default:
-        DPRINT_ERROR("Non-existent buffer index\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "FIMD: Non-existent buffer index\n");
         return 0;
     }
 }
@@ -1160,20 +1156,24 @@ static void fimd_update_memory_section(Exynos4210fimdState *s, unsigned win)
 
     if (int128_get64(w->mem_section.size) != w->fb_len ||
             !memory_region_is_ram(w->mem_section.mr)) {
-        DPRINT_ERROR("Failed to find window %u framebuffer region\n", win);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: Failed to find window %u framebuffer region\n",
+                      win);
         goto error_return;
     }
 
     w->host_fb_addr = cpu_physical_memory_map(fb_start_addr, &fb_mapped_len,
                                               false);
     if (!w->host_fb_addr) {
-        DPRINT_ERROR("Failed to map window %u framebuffer\n", win);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: Failed to map window %u framebuffer\n", win);
         goto error_return;
     }
 
     if (fb_mapped_len != w->fb_len) {
-        DPRINT_ERROR("Window %u mapped framebuffer length is less then "
-                "expected\n", win);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: Window %u mapped framebuffer length is less than "
+                      "expected\n", win);
         cpu_physical_memory_unmap(w->host_fb_addr, fb_mapped_len, 0, 0);
         goto error_return;
     }
@@ -1490,7 +1490,9 @@ static void exynos4210_fimd_write(void *opaque, hwaddr offset,
             break;
         case 3:
             if (w != 1 && w != 2) {
-                DPRINT_ERROR("Bad write offset 0x%08x\n", offset);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "FIMD: Bad write offset 0x%08"HWADDR_PRIx"\n",
+                              offset);
                 return;
             }
             s->window[w].osdsize = val;
@@ -1624,7 +1626,9 @@ static void exynos4210_fimd_write(void *opaque, hwaddr offset,
         break;
     case FIMD_VIDW0ADD0_B2 ... FIMD_VIDW4ADD0_B2:
         if (offset & 0x0004) {
-            DPRINT_ERROR("bad write offset 0x%08x\n", offset);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n",
+                          offset);
             break;
         }
         w = (offset - FIMD_VIDW0ADD0_B2) >> 3;
@@ -1638,14 +1642,18 @@ static void exynos4210_fimd_write(void *opaque, hwaddr offset,
         break;
     case FIMD_SHD_ADD0_START ... FIMD_SHD_ADD0_END:
         if (offset & 0x0004) {
-            DPRINT_ERROR("bad write offset 0x%08x\n", offset);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n",
+                          offset);
             break;
         }
         s->window[(offset - FIMD_SHD_ADD0_START) >> 3].shadow_buf_start = val;
         break;
     case FIMD_SHD_ADD1_START ... FIMD_SHD_ADD1_END:
         if (offset & 0x0004) {
-            DPRINT_ERROR("bad write offset 0x%08x\n", offset);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n",
+                          offset);
             break;
         }
         s->window[(offset - FIMD_SHD_ADD1_START) >> 3].shadow_buf_end = val;
@@ -1665,7 +1673,8 @@ static void exynos4210_fimd_write(void *opaque, hwaddr offset,
         s->window[w].palette[i] = val;
         break;
     default:
-        DPRINT_ERROR("bad write offset 0x%08x\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n", offset);
         break;
     }
 }
@@ -1715,7 +1724,9 @@ static uint64_t exynos4210_fimd_read(void *opaque, hwaddr offset,
             break;
         case 3:
             if (w != 1 && w != 2) {
-                DPRINT_ERROR("bad read offset 0x%08x\n", offset);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "FIMD: bad read offset 0x%08"HWADDR_PRIx"\n",
+                              offset);
                 return 0xBAADBAAD;
             }
             ret = s->window[w].osdsize;
@@ -1809,7 +1820,8 @@ static uint64_t exynos4210_fimd_read(void *opaque, hwaddr offset,
         return s->window[w].palette[i];
     }
 
-    DPRINT_ERROR("bad read offset 0x%08x\n", offset);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "FIMD: bad read offset 0x%08"HWADDR_PRIx"\n", offset);
     return 0xBAADBAAD;
 }
 
-- 
2.21.3



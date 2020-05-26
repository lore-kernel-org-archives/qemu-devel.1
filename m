Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF72C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A6F20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKVOzr0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A6F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdTAf-0005Od-RG
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzb-0007A9-Gj; Tue, 26 May 2020 02:23:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSza-0002VB-IP; Tue, 26 May 2020 02:23:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so19247102wru.0;
 Mon, 25 May 2020 23:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C1eszk0Q8nnnhJsx17RLrSJtA9SbbE0OV6yQiljuJ0I=;
 b=RKVOzr0yT4KO+MxW9cweRT0YlB+Ikjka4cLp7IHYFY42cSsx2OaWb6rfxUSg2m6bQg
 PTY1d/QL5TAhx2DLTOu7j/YBJkjdFQ9Bk6LIv4SX6UoFy7HQb/cCrvTsLNwgJU8TuJZp
 D60/V5Ipy2HjLmmdW8D/tap6DQ5AOcY9DBcH6SD9dAcSjHh/B6yuUFxXw9Ig0O//FIlB
 s/EcdUfOb+h0C0YxI0MsVbok6xY5ahNRSRMEVvgr0pygWL2ZO7NgMrDMc6q1cXDAi+gd
 zi++zwJsz5sJjsCRo5S/CqbVehM24+ZXCUfWjbmrmqOcDGqr7JOT8+D8sYul37nAgXd3
 6Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=C1eszk0Q8nnnhJsx17RLrSJtA9SbbE0OV6yQiljuJ0I=;
 b=rj9YNna+hiVvCWtyW2qqg+Wg7ClMJLNLuSbEvCyhBsLu23GuXBOr9Wy8qK+TNfA0lm
 HtDHf2qvDYJTvaKQpmGPilfBiEkCMvNPLLUqwMdUufVsBkTT/gNZbzsyxwirHyD4/+0X
 WCB50QdZAKtjOOMahr+Ox4ncax1MeqwGDs7wKLjovzoUDYuF5LPfLLyNlYqE8rkk3Otk
 mW/p2+rzym8jhb8skgJjiuEyq0r/avNYT/BVb76hFLxwCSpspw95bbnTCB6UKDtGollE
 ilAFrslAVKpm/8gZSQPkKduvcx//tQGi7klJWoUHsFA7+x79ea4PPoWc18v7qgJ2U0xn
 JU+A==
X-Gm-Message-State: AOAM531eJivK0uOmb575RrsuBhFKavjYOM0E7hmVQCCr3V58z/McMrM6
 am0GVsLp0VKF6+Pkl/Ns+ao=
X-Google-Smtp-Source: ABdhPJwsQHQUWBeOvragwLlSG8OGZYwlW508qbsuOkkJgDqwMWH9a4gXjh+kJr92Nco5L4q5dl4nLQ==
X-Received: by 2002:adf:dc0f:: with SMTP id t15mr18172610wri.165.1590474192596; 
 Mon, 25 May 2020 23:23:12 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:23:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 12/14] hw/display/exynos4210_fimd: Use
 qemu_log_mask(GUEST_ERROR)
Date: Tue, 26 May 2020 08:22:50 +0200
Message-Id: <20200526062252.19852-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
References: <20200526062252.19852-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
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



Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9290C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F2420776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsrZQcLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F2420776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdT0x-00013u-L2
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzM-0006Sc-PY; Tue, 26 May 2020 02:23:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzM-0002Ss-2r; Tue, 26 May 2020 02:23:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so2029673wmj.0;
 Mon, 25 May 2020 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pta0eVDdmzHpJTkJqgde2ZPUU3TI6CLS/Vt1iAvSpkI=;
 b=EsrZQcLFhPCJDCotmUtuc3Wpr3btBBWGNs7Eqv5KQEoks5D4MkYXYmeu/F30nccrGN
 SxlWy9H8vO0qqcTc8qbsxD0as5jQgAyBJ6AvFx1q33IiLh83ugUx5Lbmwq9ND12tIXwo
 kTP50eIHiPq2FZX2IsXYIiyoD7JHuZwbpphjXW/bavwD/2MKpBqfyT3fev7eEuLdKgO5
 Sg3Fc1ulTsuCjzhf8WTprUbNaDn2R9FTCYzvfSDfwvXRjAYioR5CG8T1uk3cBQMx6yWj
 9e/0pcLf2EjKYmaA5pvRs1YPCmiq0ACMi+6aIatkywRKwQD69st7WvSSImmp+kwPJGgv
 rQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pta0eVDdmzHpJTkJqgde2ZPUU3TI6CLS/Vt1iAvSpkI=;
 b=pjeBkDLPtd5gLDhDW4pRDVL96xW2FjdNs7pYeTtPWovb/0oRfJo7Y9PTbdrXuu/osO
 qxwYHIY4/Kp1rioiCzTYxsTnJ9WRjiT0Pm9rrsJnOJZDuKxWc6lBhllblCWoCCqhOfFt
 yHDkHzERSegaQs4A3c5uZg8xfMMg6SgaP8raFOd+OhpHmSBIaVq/fdolehpyA3MAjpsc
 kS0wWhoFntZjQ5fixxG1DZZIQx2gBfq05W8mvRHLkjIPqD3ZeCOG78guoPENhIS300Un
 adTWzKxKAcj+G6Esn5ft2R0U+OCKs3LfMlsikk/oI9Xxr34mPBo/9KYd0KWmRbNAnxDN
 fgiw==
X-Gm-Message-State: AOAM530nhP7nXBbJnuOiReGI/rfMw5NUqFN4mPql3wA2VnybAWihXSoQ
 cfeDscd7uFZ/GvI3HxuNckY=
X-Google-Smtp-Source: ABdhPJyuzq1yThawVWattaZB7+r90MJOq7H+zCMNHr5jWZINtUz+gaNhXR77h6GbyOyzLE8x/4QxgQ==
X-Received: by 2002:a1c:7712:: with SMTP id t18mr26950259wmi.182.1590474178188; 
 Mon, 25 May 2020 23:22:58 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:22:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 02/14] hw/display/cg3: Convert debug printf()s to trace events
Date: Tue, 26 May 2020 08:22:40 +0200
Message-Id: <20200526062252.19852-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
References: <20200526062252.19852-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

Convert DPRINTF() to trace events and remove ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/cg3.c        | 14 ++++----------
 hw/display/trace-events |  4 ++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index f7f1c199ce..7cbe6e56ff 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -35,6 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 /* Change to 1 to enable debugging */
 #define DEBUG_CG3 0
@@ -63,12 +64,6 @@
 #define CG3_VRAM_SIZE 0x100000
 #define CG3_VRAM_OFFSET 0x800000
 
-#define DPRINTF(fmt, ...) do { \
-    if (DEBUG_CG3) { \
-        printf("CG3: " fmt , ## __VA_ARGS__); \
-    } \
-} while (0)
-
 #define TYPE_CG3 "cgthree"
 #define CG3(obj) OBJECT_CHECK(CG3State, (obj), TYPE_CG3)
 
@@ -195,7 +190,8 @@ static uint64_t cg3_reg_read(void *opaque, hwaddr addr, unsigned size)
         val = 0;
         break;
     }
-    DPRINTF("read %02x from reg %" HWADDR_PRIx "\n", val, addr);
+    trace_cg3_read(addr, val, size);
+
     return val;
 }
 
@@ -206,9 +202,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr, uint64_t val,
     uint8_t regval;
     int i;
 
-    DPRINTF("write %" PRIx64 " to reg %" HWADDR_PRIx " size %d\n",
-            val, addr, size);
-
+    trace_cg3_write(addr, val, size);
     switch (addr) {
     case CG3_REG_BT458_ADDR:
         s->dac_index = val;
diff --git a/hw/display/trace-events b/hw/display/trace-events
index e6e22bef88..47b2b168ae 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -151,3 +151,7 @@ artist_vram_write(unsigned int size, uint64_t addr, uint64_t val) "%u 0x%"PRIx64
 artist_fill_window(unsigned int start_x, unsigned int start_y, unsigned int width, unsigned int height, uint32_t op, uint32_t ctlpln) "start=%ux%u length=%ux%u op=0x%08x ctlpln=0x%08x"
 artist_block_move(unsigned int start_x, unsigned int start_y, unsigned int dest_x, unsigned int dest_y, unsigned int width, unsigned int height) "source %ux%u -> dest %ux%u size %ux%u"
 artist_draw_line(unsigned int start_x, unsigned int start_y, unsigned int end_x, unsigned int end_y) "%ux%u %ux%u"
+
+# cg3.c
+cg3_read(uint32_t addr, uint32_t val, unsigned size) "read addr:0x%06"PRIx32" val:0x%08"PRIx32" size:%u"
+cg3_write(uint32_t addr, uint32_t val, unsigned size) "write addr:0x%06"PRIx32" val:0x%08"PRIx32" size:%u"
-- 
2.21.3



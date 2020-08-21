Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50E3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FC620738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8OYIYYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FC620738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9B4g-0000ZO-UO
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArU-0001pl-1y; Fri, 21 Aug 2020 13:29:57 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArR-0001GS-VA; Fri, 21 Aug 2020 13:29:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id 83so2627896wme.4;
 Fri, 21 Aug 2020 10:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6RaWSIQ7O/kyP/fOVD7Nn9+SCTDuG1HapMmgzJ7Bipo=;
 b=i8OYIYYC7csM7gn/RNMoizJuGOYwwf20rOa6BZk9AOfR99ekwncKC0BNxfMW5vhPSp
 J0zoHRZq7o7ysSblI4lg7uwvbpuw2/TQ8kkkHK+pJxsF1bdxRzQxBVYKE13gEt5fBTla
 2cJ7ahIN6lQ7wIyiv5px3uonXfFcclKTN7vdKaHGAxz1npBuP2RFrlHTcxTsJOJ1y7jX
 K+KXt06UrYR7hDrTPznKwoGCB4nuC53z7BBd79PJ2HO6n432/7Zgw/rAgxrzVY0TZC+q
 5M2euS7G42cY5DvO3nHAFX04Ud47yH7+QQ9AtGZ+bYcKh/Mp4ugSm4SuLFzz5AjS13ug
 hJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6RaWSIQ7O/kyP/fOVD7Nn9+SCTDuG1HapMmgzJ7Bipo=;
 b=S6aU3/3wzftnpSAKvZB1Kkrs6H7cTZTRtR8dJ5h/toP6a+doRHjbpCsWJM/+IvlLrW
 L6wsT3Felmixo0iJdIacHt2IPi22tnojFvhn0+XlVjZ3AarW0m+cgtlE0Zzp59MDqfLE
 9MHg9eWuYaeNeLrv/rXWQHOuBK8l3bze0NdQQpb6+qTAWv+sPxGt1HdXkI0ieNzy25/n
 aUDURrT7Zqg0/TNGPDrohh3O4xbg5Ex6NSQEDJU9qYaZNN7piT0ANdPnHsATXSDO01BT
 06qW4Vu3lWN2A7RITd0q4+gx21VQAKrzkq7boyAgS7y/3Ym+qooHvw7FVPCSNLmBaiUR
 Z+mQ==
X-Gm-Message-State: AOAM532DcSiYfmpHGjHNTwsiAQUrOI0fOD+9wsYlkDCl1dFWOoGrg/ZE
 Rq3l8Q8rqfVh3Z7p4X94Y9VTh8g1FoU=
X-Google-Smtp-Source: ABdhPJx3jHbDSkrQ0GIo/BZ2/qIs2Bu11RRA7xBt01e2zx3nGsmkK+CYPHRAvBeFngDWEwVh494iTA==
X-Received: by 2002:a1c:41c5:: with SMTP id o188mr4303845wma.187.1598030991628; 
 Fri, 21 Aug 2020 10:29:51 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/23] hw/sd: Use sdbus_read_data() instead of
 sdbus_read_byte() when possible
Date: Fri, 21 Aug 2020 19:29:14 +0200
Message-Id: <20200821172916.1260954-22-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the recently added sdbus_read_data() to read multiple
bytes at once, instead of looping calling sdbus_read_byte().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200814092346.21825-8-f4bug@amsat.org>
---
 hw/sd/allwinner-sdhost.c  | 10 +++-------
 hw/sd/milkymist-memcard.c |  7 ++-----
 hw/sd/sdhci.c             | 28 ++++++++--------------------
 3 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index eea5659c5f1..f9eb92c09ed 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -337,9 +337,7 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
 
         /* Read from SD bus */
         } else {
-            for (uint32_t i = 0; i < buf_bytes; i++) {
-                buf[i] = sdbus_read_byte(&s->sdbus);
-            }
+            sdbus_read_data(&s->sdbus, buf, buf_bytes);
             cpu_physical_memory_write((desc->addr & DESC_SIZE_MASK) + num_done,
                                        buf, buf_bytes);
         }
@@ -518,10 +516,8 @@ static uint64_t allwinner_sdhost_read(void *opaque, hwaddr offset,
         break;
     case REG_SD_FIFO:      /* Read/Write FIFO */
         if (sdbus_data_ready(&s->sdbus)) {
-            res = sdbus_read_byte(&s->sdbus);
-            res |= sdbus_read_byte(&s->sdbus) << 8;
-            res |= sdbus_read_byte(&s->sdbus) << 16;
-            res |= sdbus_read_byte(&s->sdbus) << 24;
+            sdbus_read_data(&s->sdbus, &res, sizeof(uint32_t));
+            le32_to_cpus(&res);
             allwinner_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
             allwinner_sdhost_auto_stop(s);
             allwinner_sdhost_update_irq(s);
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 12e091a46e7..be89a938763 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -151,11 +151,8 @@ static uint64_t memcard_read(void *opaque, hwaddr addr,
         if (!s->enabled) {
             r = 0xffffffff;
         } else {
-            r = 0;
-            r |= sdbus_read_byte(&s->sdbus) << 24;
-            r |= sdbus_read_byte(&s->sdbus) << 16;
-            r |= sdbus_read_byte(&s->sdbus) << 8;
-            r |= sdbus_read_byte(&s->sdbus);
+            sdbus_read_data(&s->sdbus, &r, sizeof(r));
+            be32_to_cpus(&r);
         }
         break;
     case R_CLK2XDIV:
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ddf36915619..1785d7e1f79 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -399,8 +399,6 @@ static void sdhci_end_transfer(SDHCIState *s)
 /* Fill host controller's read buffer with BLKSIZE bytes of data from card */
 static void sdhci_read_block_from_card(SDHCIState *s)
 {
-    int index = 0;
-    uint8_t data;
     const uint16_t blk_size = s->blksize & BLOCK_SIZE_MASK;
 
     if ((s->trnmod & SDHC_TRNS_MULTI) &&
@@ -408,12 +406,9 @@ static void sdhci_read_block_from_card(SDHCIState *s)
         return;
     }
 
-    for (index = 0; index < blk_size; index++) {
-        data = sdbus_read_byte(&s->sdbus);
-        if (!FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
-            /* Device is not in tuning */
-            s->fifo_buffer[index] = data;
-        }
+    if (!FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
+        /* Device is not in tuning */
+        sdbus_read_data(&s->sdbus, s->fifo_buffer, blk_size);
     }
 
     if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
@@ -574,7 +569,7 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
 static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 {
     bool page_aligned = false;
-    unsigned int n, begin;
+    unsigned int begin;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     uint32_t boundary_chk = 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
     uint32_t boundary_count = boundary_chk - (s->sdmasysad % boundary_chk);
@@ -596,9 +591,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 SDHC_DAT_LINE_ACTIVE;
         while (s->blkcnt) {
             if (s->data_count == 0) {
-                for (n = 0; n < block_size; n++) {
-                    s->fifo_buffer[n] = sdbus_read_byte(&s->sdbus);
-                }
+                sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
             }
             begin = s->data_count;
             if (((boundary_count + begin) < block_size) && page_aligned) {
@@ -662,13 +655,10 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 /* single block SDMA transfer */
 static void sdhci_sdma_transfer_single_block(SDHCIState *s)
 {
-    int n;
     uint32_t datacnt = s->blksize & BLOCK_SIZE_MASK;
 
     if (s->trnmod & SDHC_TRNS_READ) {
-        for (n = 0; n < datacnt; n++) {
-            s->fifo_buffer[n] = sdbus_read_byte(&s->sdbus);
-        }
+        sdbus_read_data(&s->sdbus, s->fifo_buffer, datacnt);
         dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
     } else {
         dma_memory_read(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
@@ -731,7 +721,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 
 static void sdhci_do_adma(SDHCIState *s)
 {
-    unsigned int n, begin, length;
+    unsigned int begin, length;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     ADMADescr dscr = {};
     int i;
@@ -765,9 +755,7 @@ static void sdhci_do_adma(SDHCIState *s)
             if (s->trnmod & SDHC_TRNS_READ) {
                 while (length) {
                     if (s->data_count == 0) {
-                        for (n = 0; n < block_size; n++) {
-                            s->fifo_buffer[n] = sdbus_read_byte(&s->sdbus);
-                        }
+                        sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
                     }
                     begin = s->data_count;
                     if ((length + begin) < block_size) {
-- 
2.26.2



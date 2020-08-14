Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7288C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07632074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCAV0i9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07632074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WjE-0003n8-TO
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwN-0005dO-Df; Fri, 14 Aug 2020 05:23:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwL-0004LE-KG; Fri, 14 Aug 2020 05:23:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id a5so7731015wrm.6;
 Fri, 14 Aug 2020 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aLPTEwW8IgyfTmT0h1xzh2aMoPhT9+v6krhNFnB9JEQ=;
 b=QCAV0i9qsFINmIhKsoAX/iB8/CeY2K3JOfrLM1OKkDnM44nXnW7OFUPOxm1lX1/3Rw
 e4mdfnW5R4yGSQwGIJoxiVeTCl8JiZHENfKZ/qj36kY+r3sik1sOKjPJZ/VD+3okCXgi
 R+N4iA2QvS6tfZVpIr6eG4JgbRrQ7uQqjLi9DdFJwRH1RRiL3L+tagRx7cUl1UBgvO/V
 TKQ8yqPtF9IFk+Ab9p7qtIv2lBZUSo/zyH/nXTeUyWXnKnffkrOma3TeLRbxbCgflU8t
 L5Thmtd/AFLEuk7HCnIFaHI1EjkZ/vsiJwgrZnfCBIPVe9rOAaOy3UHG6W/3QP7VUiHK
 8PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=aLPTEwW8IgyfTmT0h1xzh2aMoPhT9+v6krhNFnB9JEQ=;
 b=eq5HwMmb5eHMju+DjwzfeKr2p64lOtnknzpdzQCvqMQjy92yrLNcakpFrFgZ6Rx3Qt
 YnTEjgFU/VM6dh1xOBujylT51+1tm8RiuGBoa0RaBqxmXy7oQe40NaKa8ITJBHOuJVay
 Cv1yBLzxBzwZySKPkL/YC3lm6grjTyWqcbSDPdEyG7iLMqMcYI+ECUficsL3odBCYbBF
 +1LUdifu4fhOFWd0lZA+W2n211hKXbHY5nbopzWNd9ci4aBW+r5cy/PIeZq903m3UYKO
 Z0tOPW3O4hKCExgAM8Gqi3AISYdMOEfbqQpFlXLNcATamv5rbxZl7T63NPgyzw7n7EjB
 kctg==
X-Gm-Message-State: AOAM532nUpGcImjZ8KMzR6H3gxydF90+PZT3AiUpNLSKc8QEwpeEXot7
 058jvUa5RnJrorvZgDKjfQZjecOC/Ps=
X-Google-Smtp-Source: ABdhPJx1WiV97w8YG2HFyop4igZGjblk6Taew3kw1v527htk2VOINl+X+yAbEXGQIB9eP/v0sA5ZrQ==
X-Received: by 2002:adf:c552:: with SMTP id s18mr1799513wrf.209.1597397035016; 
 Fri, 14 Aug 2020 02:23:55 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b11sm12889395wrq.32.2020.08.14.02.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 02:23:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/sd: Use sdbus_write_data() instead of sdbus_write_byte
 when possible
Date: Fri, 14 Aug 2020 11:23:44 +0200
Message-Id: <20200814092346.21825-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814092346.21825-1-f4bug@amsat.org>
References: <20200814092346.21825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the recently added sdbus_write_data() to write multiple
bytes at once, instead of looping calling sdbus_write_byte().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/allwinner-sdhost.c  | 14 +++++---------
 hw/sd/milkymist-memcard.c |  7 +++----
 hw/sd/sdhci.c             | 18 ++++--------------
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index c004aa39da..eea5659c5f 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -333,10 +333,7 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
         if (is_write) {
             cpu_physical_memory_read((desc->addr & DESC_SIZE_MASK) + num_done,
                                       buf, buf_bytes);
-
-            for (uint32_t i = 0; i < buf_bytes; i++) {
-                sdbus_write_byte(&s->sdbus, buf[i]);
-            }
+            sdbus_write_data(&s->sdbus, buf, buf_bytes);
 
         /* Read from SD bus */
         } else {
@@ -548,6 +545,7 @@ static void allwinner_sdhost_write(void *opaque, hwaddr offset,
                                    uint64_t value, unsigned size)
 {
     AwSdHostState *s = AW_SDHOST(opaque);
+    uint32_t u32;
 
     trace_allwinner_sdhost_write(offset, value, size);
 
@@ -654,11 +652,9 @@ static void allwinner_sdhost_write(void *opaque, hwaddr offset,
         s->startbit_detect = value;
         break;
     case REG_SD_FIFO:      /* Read/Write FIFO */
-        sdbus_write_byte(&s->sdbus, value & 0xff);
-        sdbus_write_byte(&s->sdbus, (value >> 8) & 0xff);
-        sdbus_write_byte(&s->sdbus, (value >> 16) & 0xff);
-        sdbus_write_byte(&s->sdbus, (value >> 24) & 0xff);
-        allwinner_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
+        u32 = cpu_to_le32(value);
+        sdbus_write_data(&s->sdbus, &u32, sizeof(u32));
+        allwinner_sdhost_update_transfer_cnt(s, sizeof(u32));
         allwinner_sdhost_auto_stop(s);
         allwinner_sdhost_update_irq(s);
         break;
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index e8d055bb89..12e091a46e 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -181,6 +181,7 @@ static void memcard_write(void *opaque, hwaddr addr, uint64_t value,
                           unsigned size)
 {
     MilkymistMemcardState *s = opaque;
+    uint32_t val32;
 
     trace_milkymist_memcard_memory_write(addr, value);
 
@@ -209,10 +210,8 @@ static void memcard_write(void *opaque, hwaddr addr, uint64_t value,
         if (!s->enabled) {
             break;
         }
-        sdbus_write_byte(&s->sdbus, (value >> 24) & 0xff);
-        sdbus_write_byte(&s->sdbus, (value >> 16) & 0xff);
-        sdbus_write_byte(&s->sdbus, (value >> 8) & 0xff);
-        sdbus_write_byte(&s->sdbus, value & 0xff);
+        val32 = cpu_to_be32(value);
+        sdbus_write_data(&s->sdbus, &val32, sizeof(val32));
         break;
     case R_ENABLE:
         s->regs[addr] = value;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index b897b1121b..ddf3691561 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -496,8 +496,6 @@ static uint32_t sdhci_read_dataport(SDHCIState *s, unsigned size)
 /* Write data from host controller FIFO to card */
 static void sdhci_write_block_to_card(SDHCIState *s)
 {
-    int index = 0;
-
     if (s->prnsts & SDHC_SPACE_AVAILABLE) {
         if (s->norintstsen & SDHC_NISEN_WBUFRDY) {
             s->norintsts |= SDHC_NIS_WBUFRDY;
@@ -514,9 +512,7 @@ static void sdhci_write_block_to_card(SDHCIState *s)
         }
     }
 
-    for (index = 0; index < (s->blksize & BLOCK_SIZE_MASK); index++) {
-        sdbus_write_byte(&s->sdbus, s->fifo_buffer[index]);
-    }
+    sdbus_write_data(&s->sdbus, s->fifo_buffer, s->blksize & BLOCK_SIZE_MASK);
 
     /* Next data can be written through BUFFER DATORT register */
     s->prnsts |= SDHC_SPACE_AVAILABLE;
@@ -641,9 +637,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                             &s->fifo_buffer[begin], s->data_count - begin);
             s->sdmasysad += s->data_count - begin;
             if (s->data_count == block_size) {
-                for (n = 0; n < block_size; n++) {
-                    sdbus_write_byte(&s->sdbus, s->fifo_buffer[n]);
-                }
+                sdbus_write_data(&s->sdbus, s->fifo_buffer, block_size);
                 s->data_count = 0;
                 if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
                     s->blkcnt--;
@@ -678,9 +672,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
         dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
     } else {
         dma_memory_read(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
-        for (n = 0; n < datacnt; n++) {
-            sdbus_write_byte(&s->sdbus, s->fifo_buffer[n]);
-        }
+        sdbus_write_data(&s->sdbus, s->fifo_buffer, datacnt);
     }
     s->blkcnt--;
 
@@ -814,9 +806,7 @@ static void sdhci_do_adma(SDHCIState *s)
                                     s->data_count - begin);
                     dscr.addr += s->data_count - begin;
                     if (s->data_count == block_size) {
-                        for (n = 0; n < block_size; n++) {
-                            sdbus_write_byte(&s->sdbus, s->fifo_buffer[n]);
-                        }
+                        sdbus_write_data(&s->sdbus, s->fifo_buffer, block_size);
                         s->data_count = 0;
                         if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
                             s->blkcnt--;
-- 
2.21.3



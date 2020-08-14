Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26FFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1B820781
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djomzGOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1B820781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6XGB-00076B-OI
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwL-0005YJ-5S; Fri, 14 Aug 2020 05:23:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwJ-0004Kk-B1; Fri, 14 Aug 2020 05:23:56 -0400
Received: by mail-wm1-x343.google.com with SMTP id 9so6904209wmj.5;
 Fri, 14 Aug 2020 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QAYdy+M4KLzrq8A3jXi6N+nqKx4PGoeP0poZ5UugJaY=;
 b=djomzGOtmPN9ZGwy5IA+vzcREuwN5ab8IMkoF0SwiGxDb+RVvmL+tReZLMSqXzVL+U
 UBKJZOXR8UqGsclFHlZ7/HsjAP2/evNcOZrTYvbOTyToWiuHFiSkqqEbuixdWPG5VIZ8
 FrcK7t6aybelyvSWmkIM6N36lnTDP06Lyz7BbPV7YduppRFqQpxyFE/Ph1o8XZmUSiVv
 LqMpydPqOeGeFzOhOnBRDCaHQABEb2q7pThzN506o4KiQRfsanoFfQL1Tj3sRW6LO4uA
 hWv46DUuBC+V9NYTAjGlAI834oYvo1nhzgQDv8zf4dJNVVFyTazwk2gfbLZ2G3RJ9lRm
 U7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QAYdy+M4KLzrq8A3jXi6N+nqKx4PGoeP0poZ5UugJaY=;
 b=QXTY10A/URsnrUvwbBQcrNoyYiqSXE/nwtbOzP39AmoEAwa+Sz1Wt5lC4g7+NbfN65
 FNMQ/qmi5eEhR9LkClBOokGWQODMrKndwNN3rm0XsSAL8E1AYGPFJSy1zSBrTR4EKFpK
 pkCee9zI2sACMtL125erdxPUzCLc1/bLAp3lBp1YmeDf5M16WVuWJFA4wsr2fflt1Djz
 TTYVbd0TCU/s3MGlN5IZVvX4Ue/8QXfbdR3A73fAN3ZG6uskqaXclh7bQvnoRxa/s9c4
 eLErU/F7KYD549+Ng5gVqz1NOO4241U0WvsTcbOQANxPwpe3BWBIB/vI+joXl+TIg6Ev
 D83Q==
X-Gm-Message-State: AOAM533DPrzW7ZLUUEOe/ewObyzFZjg1cGG9zQrQ06MnANjhiIPgfbxZ
 anCO9w6/ETwZ7lhd/G3TA1uL58uwOV4=
X-Google-Smtp-Source: ABdhPJy4SH2z7IMz6a62jRzF2ZMnIN2lXHucUcadEPE0iCroY+km7+UMdlMwFYtvG3wH31LS3igA7g==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr1826177wmb.151.1597397032414;
 Fri, 14 Aug 2020 02:23:52 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b11sm12889395wrq.32.2020.08.14.02.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 02:23:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hw/sd: Rename sdbus_read_data() as sdbus_read_byte()
Date: Fri, 14 Aug 2020 11:23:42 +0200
Message-Id: <20200814092346.21825-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814092346.21825-1-f4bug@amsat.org>
References: <20200814092346.21825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

The sdbus_read_data() method do a single byte access on the data
line of a SD bus. Rename it as sdbus_read_byte() and document it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h        | 10 +++++++++-
 hw/sd/allwinner-sdhost.c  | 10 +++++-----
 hw/sd/bcm2835_sdhost.c    |  2 +-
 hw/sd/core.c              |  2 +-
 hw/sd/milkymist-memcard.c |  8 ++++----
 hw/sd/pl181.c             |  2 +-
 hw/sd/pxa2xx_mmci.c       |  2 +-
 hw/sd/sdhci.c             |  8 ++++----
 hw/sd/ssi-sd.c            |  2 +-
 9 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 1e5ac955d0..14ffc7f475 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -166,7 +166,15 @@ int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
  * Write a byte on the data lines of a SD bus.
  */
 void sdbus_write_byte(SDBus *sd, uint8_t value);
-uint8_t sdbus_read_data(SDBus *sd);
+/**
+ * Read a byte from a SD bus.
+ * @sd: bus
+ *
+ * Read a byte from the data lines of a SD bus.
+ *
+ * Return: byte value read
+ */
+uint8_t sdbus_read_byte(SDBus *sd);
 bool sdbus_data_ready(SDBus *sd);
 bool sdbus_get_inserted(SDBus *sd);
 bool sdbus_get_readonly(SDBus *sd);
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index e05e8a3864..c004aa39da 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -341,7 +341,7 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
         /* Read from SD bus */
         } else {
             for (uint32_t i = 0; i < buf_bytes; i++) {
-                buf[i] = sdbus_read_data(&s->sdbus);
+                buf[i] = sdbus_read_byte(&s->sdbus);
             }
             cpu_physical_memory_write((desc->addr & DESC_SIZE_MASK) + num_done,
                                        buf, buf_bytes);
@@ -521,10 +521,10 @@ static uint64_t allwinner_sdhost_read(void *opaque, hwaddr offset,
         break;
     case REG_SD_FIFO:      /* Read/Write FIFO */
         if (sdbus_data_ready(&s->sdbus)) {
-            res = sdbus_read_data(&s->sdbus);
-            res |= sdbus_read_data(&s->sdbus) << 8;
-            res |= sdbus_read_data(&s->sdbus) << 16;
-            res |= sdbus_read_data(&s->sdbus) << 24;
+            res = sdbus_read_byte(&s->sdbus);
+            res |= sdbus_read_byte(&s->sdbus) << 8;
+            res |= sdbus_read_byte(&s->sdbus) << 16;
+            res |= sdbus_read_byte(&s->sdbus) << 24;
             allwinner_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
             allwinner_sdhost_auto_stop(s);
             allwinner_sdhost_update_irq(s);
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 16aba7cc92..2c7a675a2d 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -190,7 +190,7 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
         if (is_read) {
             n = 0;
             while (s->datacnt && s->fifo_len < BCM2835_SDHOST_FIFO_LEN) {
-                value |= (uint32_t)sdbus_read_data(&s->sdbus) << (n * 8);
+                value |= (uint32_t)sdbus_read_byte(&s->sdbus) << (n * 8);
                 s->datacnt--;
                 n++;
                 if (n == 4) {
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 13b5ca0316..a3b620b802 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -114,7 +114,7 @@ void sdbus_write_byte(SDBus *sdbus, uint8_t value)
     }
 }
 
-uint8_t sdbus_read_data(SDBus *sdbus)
+uint8_t sdbus_read_byte(SDBus *sdbus)
 {
     SDState *card = get_card(sdbus);
     uint8_t value = 0;
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 4128109c04..e8d055bb89 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -152,10 +152,10 @@ static uint64_t memcard_read(void *opaque, hwaddr addr,
             r = 0xffffffff;
         } else {
             r = 0;
-            r |= sdbus_read_data(&s->sdbus) << 24;
-            r |= sdbus_read_data(&s->sdbus) << 16;
-            r |= sdbus_read_data(&s->sdbus) << 8;
-            r |= sdbus_read_data(&s->sdbus);
+            r |= sdbus_read_byte(&s->sdbus) << 24;
+            r |= sdbus_read_byte(&s->sdbus) << 16;
+            r |= sdbus_read_byte(&s->sdbus) << 8;
+            r |= sdbus_read_byte(&s->sdbus);
         }
         break;
     case R_CLK2XDIV:
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 771bae193f..579d68ad83 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -223,7 +223,7 @@ static void pl181_fifo_run(PL181State *s)
         if (is_read) {
             n = 0;
             while (s->datacnt && s->fifo_len < PL181_FIFO_LEN) {
-                value |= (uint32_t)sdbus_read_data(&s->sdbus) << (n * 8);
+                value |= (uint32_t)sdbus_read_byte(&s->sdbus) << (n * 8);
                 s->datacnt--;
                 n++;
                 if (n == 4) {
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 07ddc2eba3..04f0a98f81 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -194,7 +194,7 @@ static void pxa2xx_mmci_fifo_update(PXA2xxMMCIState *s)
     } else
         while (s->bytesleft && s->rx_len < 32) {
             s->rx_fifo[(s->rx_start + (s->rx_len ++)) & 0x1f] =
-                sdbus_read_data(&s->sdbus);
+                sdbus_read_byte(&s->sdbus);
             s->bytesleft --;
             s->intreq |= INT_RXFIFO_REQ;
         }
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 4bf1ee88b2..b897b1121b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -409,7 +409,7 @@ static void sdhci_read_block_from_card(SDHCIState *s)
     }
 
     for (index = 0; index < blk_size; index++) {
-        data = sdbus_read_data(&s->sdbus);
+        data = sdbus_read_byte(&s->sdbus);
         if (!FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, EXECUTE_TUNING)) {
             /* Device is not in tuning */
             s->fifo_buffer[index] = data;
@@ -601,7 +601,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
         while (s->blkcnt) {
             if (s->data_count == 0) {
                 for (n = 0; n < block_size; n++) {
-                    s->fifo_buffer[n] = sdbus_read_data(&s->sdbus);
+                    s->fifo_buffer[n] = sdbus_read_byte(&s->sdbus);
                 }
             }
             begin = s->data_count;
@@ -673,7 +673,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
 
     if (s->trnmod & SDHC_TRNS_READ) {
         for (n = 0; n < datacnt; n++) {
-            s->fifo_buffer[n] = sdbus_read_data(&s->sdbus);
+            s->fifo_buffer[n] = sdbus_read_byte(&s->sdbus);
         }
         dma_memory_write(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
     } else {
@@ -774,7 +774,7 @@ static void sdhci_do_adma(SDHCIState *s)
                 while (length) {
                     if (s->data_count == 0) {
                         for (n = 0; n < block_size; n++) {
-                            s->fifo_buffer[n] = sdbus_read_data(&s->sdbus);
+                            s->fifo_buffer[n] = sdbus_read_byte(&s->sdbus);
                         }
                     }
                     begin = s->data_count;
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 9210ef567f..a7ef9cb922 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -190,7 +190,7 @@ static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
         s->mode = SSI_SD_DATA_READ;
         return 0xfe;
     case SSI_SD_DATA_READ:
-        val = sdbus_read_data(&s->sdbus);
+        val = sdbus_read_byte(&s->sdbus);
         if (!sdbus_data_ready(&s->sdbus)) {
             DPRINTF("Data read end\n");
             s->mode = SSI_SD_CMD;
-- 
2.21.3



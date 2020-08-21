Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C52EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D38620738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcTQNH9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D38620738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9B43-00086v-Hd
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArN-0001ij-EO; Fri, 21 Aug 2020 13:29:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:39451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArL-0001EQ-8s; Fri, 21 Aug 2020 13:29:49 -0400
Received: by mail-wr1-x430.google.com with SMTP id a5so2656454wrm.6;
 Fri, 21 Aug 2020 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HEwX79oo8D7n/oZUencYO6rP85LqJ2NQ5PmlyfVwwIE=;
 b=OcTQNH9S1Lompx5HoQZj6DQH1bKC6QNN30kM2SLDoF3vL0MLI9KrjvBmla1PIv/gqu
 gYPM4hL78cUXKtqea0i69sLFg252dmfu1TDbvRrJmUU5CcurUPYGV4VYH0Zd5/L1T8MS
 d0/jpTQiZ/0dLZkao3O0LzEmBpMLQKEVNh2eaH0HCxXOz83onV+zpEibgrU6fVof6edk
 mCsf29RjRHFpQggm/ssxva9P92yKiOYpu+rwDg/syqo7rYZ4OMApl7sYfJhQ/tpBKQZp
 RU1MrNZ0BFEFORLXT5nZ3lR+p3I9w/3XU1iGPkQwr4DFDSn23VIATPQGaR55Ll55tcA8
 bwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HEwX79oo8D7n/oZUencYO6rP85LqJ2NQ5PmlyfVwwIE=;
 b=LQDLcErY1z/ODYyZqFlY0hpm81W/Jrkf1JdZvc3ORviFpVq880njI3JyQIDQqr/fBp
 vDXiIAgvL35BvenwVy7BrbN8iHaneSrb6KnF1pJlZKsnqD5lWHyVTXQeEvkZdVyclnN0
 HBCyRrHns22mhtZYl1C371ROX0qhlo/suWmUIy3rSanFx2/otwEbkWWpbZ6nVYCE+1EH
 RgKnw3qn+CsfKKvzyC9CxyYZpeUlEshlxFJT8gL1uY8hdKRZP4xqZlwSpovNn8wrMgrI
 L2HI2KcHRjKKncSiQba3c/1sB+wOCDbJwqa9W1WSyJaDcjewvxpEhJZEye77p9WHqO67
 Scvw==
X-Gm-Message-State: AOAM530cAG3pq6q0lIYFBvwxc5RZa7oZPw9z7Dp674rQLC6CSTGcY9uf
 IprvDQymuEDBiAiBSlusfLsFDNo0jMs=
X-Google-Smtp-Source: ABdhPJxkJL+KUn1JgAXaH10ibQ8TDhJ1vAVUUlQGnWsEQ+TviIwXo6Usfsr4zY/sWAmXbAigCBatxA==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr3604205wro.408.1598030983806; 
 Fri, 21 Aug 2020 10:29:43 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/23] hw/sd: Rename sdbus_write_data() as sdbus_write_byte()
Date: Fri, 21 Aug 2020 19:29:09 +0200
Message-Id: <20200821172916.1260954-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
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

The sdbus_write_data() method do a single byte access on the data
line of a SD bus. Rename it as sdbus_write_byte() and document it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200814092346.21825-3-f4bug@amsat.org>
---
 include/hw/sd/sd.h        |  9 ++++++++-
 hw/sd/allwinner-sdhost.c  | 10 +++++-----
 hw/sd/bcm2835_sdhost.c    |  2 +-
 hw/sd/core.c              |  2 +-
 hw/sd/milkymist-memcard.c |  8 ++++----
 hw/sd/pl181.c             |  2 +-
 hw/sd/pxa2xx_mmci.c       |  2 +-
 hw/sd/sdhci.c             |  8 ++++----
 8 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index b58b5a19afe..1e5ac955d05 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -158,7 +158,14 @@ void sdbus_set_voltage(SDBus *sdbus, uint16_t millivolts);
 uint8_t sdbus_get_dat_lines(SDBus *sdbus);
 bool sdbus_get_cmd_line(SDBus *sdbus);
 int sdbus_do_command(SDBus *sd, SDRequest *req, uint8_t *response);
-void sdbus_write_data(SDBus *sd, uint8_t value);
+/**
+ * Write a byte to a SD bus.
+ * @sd: bus
+ * @value: byte to write
+ *
+ * Write a byte on the data lines of a SD bus.
+ */
+void sdbus_write_byte(SDBus *sd, uint8_t value);
 uint8_t sdbus_read_data(SDBus *sd);
 bool sdbus_data_ready(SDBus *sd);
 bool sdbus_get_inserted(SDBus *sd);
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index f404e1fdb45..e05e8a3864c 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -335,7 +335,7 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
                                       buf, buf_bytes);
 
             for (uint32_t i = 0; i < buf_bytes; i++) {
-                sdbus_write_data(&s->sdbus, buf[i]);
+                sdbus_write_byte(&s->sdbus, buf[i]);
             }
 
         /* Read from SD bus */
@@ -654,10 +654,10 @@ static void allwinner_sdhost_write(void *opaque, hwaddr offset,
         s->startbit_detect = value;
         break;
     case REG_SD_FIFO:      /* Read/Write FIFO */
-        sdbus_write_data(&s->sdbus, value & 0xff);
-        sdbus_write_data(&s->sdbus, (value >> 8) & 0xff);
-        sdbus_write_data(&s->sdbus, (value >> 16) & 0xff);
-        sdbus_write_data(&s->sdbus, (value >> 24) & 0xff);
+        sdbus_write_byte(&s->sdbus, value & 0xff);
+        sdbus_write_byte(&s->sdbus, (value >> 8) & 0xff);
+        sdbus_write_byte(&s->sdbus, (value >> 16) & 0xff);
+        sdbus_write_byte(&s->sdbus, (value >> 24) & 0xff);
         allwinner_sdhost_update_transfer_cnt(s, sizeof(uint32_t));
         allwinner_sdhost_auto_stop(s);
         allwinner_sdhost_update_irq(s);
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index 4a80fbcc861..16aba7cc92b 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -223,7 +223,7 @@ static void bcm2835_sdhost_fifo_run(BCM2835SDHostState *s)
                 }
                 n--;
                 s->datacnt--;
-                sdbus_write_data(&s->sdbus, value & 0xff);
+                sdbus_write_byte(&s->sdbus, value & 0xff);
                 value >>= 8;
             }
         }
diff --git a/hw/sd/core.c b/hw/sd/core.c
index 79d96576ead..13b5ca03169 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -102,7 +102,7 @@ int sdbus_do_command(SDBus *sdbus, SDRequest *req, uint8_t *response)
     return 0;
 }
 
-void sdbus_write_data(SDBus *sdbus, uint8_t value)
+void sdbus_write_byte(SDBus *sdbus, uint8_t value)
 {
     SDState *card = get_card(sdbus);
 
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index e9f5db5e22d..4128109c047 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -209,10 +209,10 @@ static void memcard_write(void *opaque, hwaddr addr, uint64_t value,
         if (!s->enabled) {
             break;
         }
-        sdbus_write_data(&s->sdbus, (value >> 24) & 0xff);
-        sdbus_write_data(&s->sdbus, (value >> 16) & 0xff);
-        sdbus_write_data(&s->sdbus, (value >> 8) & 0xff);
-        sdbus_write_data(&s->sdbus, value & 0xff);
+        sdbus_write_byte(&s->sdbus, (value >> 24) & 0xff);
+        sdbus_write_byte(&s->sdbus, (value >> 16) & 0xff);
+        sdbus_write_byte(&s->sdbus, (value >> 8) & 0xff);
+        sdbus_write_byte(&s->sdbus, value & 0xff);
         break;
     case R_ENABLE:
         s->regs[addr] = value;
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 574500ce600..771bae193f5 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -244,7 +244,7 @@ static void pl181_fifo_run(PL181State *s)
                 }
                 n--;
                 s->datacnt--;
-                sdbus_write_data(&s->sdbus, value & 0xff);
+                sdbus_write_byte(&s->sdbus, value & 0xff);
                 value >>= 8;
             }
         }
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 2996a2ef177..07ddc2eba3e 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -184,7 +184,7 @@ static void pxa2xx_mmci_fifo_update(PXA2xxMMCIState *s)
 
     if (s->cmdat & CMDAT_WR_RD) {
         while (s->bytesleft && s->tx_len) {
-            sdbus_write_data(&s->sdbus, s->tx_fifo[s->tx_start++]);
+            sdbus_write_byte(&s->sdbus, s->tx_fifo[s->tx_start++]);
             s->tx_start &= 0x1f;
             s->tx_len --;
             s->bytesleft --;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index deac1818650..4bf1ee88b2a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -515,7 +515,7 @@ static void sdhci_write_block_to_card(SDHCIState *s)
     }
 
     for (index = 0; index < (s->blksize & BLOCK_SIZE_MASK); index++) {
-        sdbus_write_data(&s->sdbus, s->fifo_buffer[index]);
+        sdbus_write_byte(&s->sdbus, s->fifo_buffer[index]);
     }
 
     /* Next data can be written through BUFFER DATORT register */
@@ -642,7 +642,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
             s->sdmasysad += s->data_count - begin;
             if (s->data_count == block_size) {
                 for (n = 0; n < block_size; n++) {
-                    sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
+                    sdbus_write_byte(&s->sdbus, s->fifo_buffer[n]);
                 }
                 s->data_count = 0;
                 if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
@@ -679,7 +679,7 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
     } else {
         dma_memory_read(s->dma_as, s->sdmasysad, s->fifo_buffer, datacnt);
         for (n = 0; n < datacnt; n++) {
-            sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
+            sdbus_write_byte(&s->sdbus, s->fifo_buffer[n]);
         }
     }
     s->blkcnt--;
@@ -815,7 +815,7 @@ static void sdhci_do_adma(SDHCIState *s)
                     dscr.addr += s->data_count - begin;
                     if (s->data_count == block_size) {
                         for (n = 0; n < block_size; n++) {
-                            sdbus_write_data(&s->sdbus, s->fifo_buffer[n]);
+                            sdbus_write_byte(&s->sdbus, s->fifo_buffer[n]);
                         }
                         s->data_count = 0;
                         if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
-- 
2.26.2



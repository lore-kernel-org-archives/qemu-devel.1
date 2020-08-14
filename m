Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02FBC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AACA2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX12473c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AACA2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WhQ-0008UT-TJ
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwI-0005QR-4O; Fri, 14 Aug 2020 05:23:54 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwG-0004KG-9t; Fri, 14 Aug 2020 05:23:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id p20so7751501wrf.0;
 Fri, 14 Aug 2020 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+/2SLK598ki9weuwoeMpo5eHHltzo6y+gY/RQh6VyAk=;
 b=PX12473c23LrbCmGbqsqd0i8e3/cdApRFg7qEOgnBPptG/gkERKztbM59bK3qHH6y7
 q80yfgzBYfGlgElyAq5VYZvPyq+KJMJbDnSjrzn8vTckyLSupraujbpoeKqNDN4hJMEy
 eFFGfySCVfVHgIPucQ/8A0mB1Nkm6+y4Uf2rQxpg7qBaG5ozC0Hh4wH5A0DMsESvteuU
 YhtCVF1EbCK6g7Q+pcGN+2C+Z5h3SYTMSXQOnRAMPRuOlM1Jgq5vSj2wqoMiUkyylPmR
 ff07PZbEGGHQVqPjmA4Ik55FV1zpKm8d3xcSaGiXUl4QbkP+aBhDXZ7DFFQ9je7LRrc2
 pubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+/2SLK598ki9weuwoeMpo5eHHltzo6y+gY/RQh6VyAk=;
 b=lR2/eyFHFvERebIhz70YtHiwps2mF2fn/HLXj2FWE15zRZZ4yqLzmzuMAUPSfIUcXn
 MBWB6B1x9LfJ2HAZ8N0FY2E2eKaxOqJTRL3BKqKvp725fR/uM1ZZq0TUpMK+fyhVnnPt
 9mIWGjOLA1TZEB4Pc7kyFj+6XWXQXi0siE/krtnP7ZI7AXdrTbizsTgPBxi9pDmMzJ73
 tP7jbt3Ka5kE+6MBB6IZ7qD6fu/7zJ0TM8jOJoXrbb3nPTFNKyL5W2AcuBxfwdsgFDhF
 UbgrJGIPZmlM95ROQ/0FOgaucfQiCaJGxkTz6DsZ+RzjYxQs7qbZ0Db9xq+Y5cwaCSku
 dnUg==
X-Gm-Message-State: AOAM532EziSmx4+zy2Ij4Cgmh+ajv9w0G03hs3oXXCGt3IweytGbYHSp
 ZeZyUdbIOXMrkEHkYJ1qsNyBX+hhkWM=
X-Google-Smtp-Source: ABdhPJwZA41u3GgvezYq4b8hIR0u1WEW5lshX5MCe0UC4Tyc522pC0Qabo37eAPQ0Mev/tKsjvhdEg==
X-Received: by 2002:a5d:6047:: with SMTP id j7mr1828972wrt.315.1597397029912; 
 Fri, 14 Aug 2020 02:23:49 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b11sm12889395wrq.32.2020.08.14.02.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 02:23:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] hw/sd: Rename read/write_data() as read/write_byte()
Date: Fri, 14 Aug 2020 11:23:40 +0200
Message-Id: <20200814092346.21825-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814092346.21825-1-f4bug@amsat.org>
References: <20200814092346.21825-1-f4bug@amsat.org>
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The read/write_data() methods write do a single byte access
on the data line of a SD card. Rename them as read/write_byte().
Add some documentation (not in "hw/sd/sdcard_legacy.h" which we
are going to remove soon).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h            | 19 +++++++++++++++++--
 include/hw/sd/sdcard_legacy.h |  4 ++--
 hw/sd/core.c                  |  4 ++--
 hw/sd/omap_mmc.c              |  8 ++++----
 hw/sd/sd.c                    | 16 ++++++++--------
 5 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 8767ab817c..b58b5a19af 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -104,8 +104,23 @@ typedef struct {
     /*< public >*/
 
     int (*do_command)(SDState *sd, SDRequest *req, uint8_t *response);
-    void (*write_data)(SDState *sd, uint8_t value);
-    uint8_t (*read_data)(SDState *sd);
+    /**
+     * Write a byte to a SD card.
+     * @sd: card
+     * @value: byte to write
+     *
+     * Write a byte on the data lines of a SD card.
+     */
+    void (*write_byte)(SDState *sd, uint8_t value);
+    /**
+     * Read a byte from a SD card.
+     * @sd: card
+     *
+     * Read a byte from the data lines of a SD card.
+     *
+     * Return: byte value read
+     */
+    uint8_t (*read_byte)(SDState *sd);
     bool (*data_ready)(SDState *sd);
     void (*set_voltage)(SDState *sd, uint16_t millivolts);
     uint8_t (*get_dat_lines)(SDState *sd);
diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.h
index 8681f8089b..0dc3889555 100644
--- a/include/hw/sd/sdcard_legacy.h
+++ b/include/hw/sd/sdcard_legacy.h
@@ -34,8 +34,8 @@
 /* Legacy functions to be used only by non-qdevified callers */
 SDState *sd_init(BlockBackend *blk, bool is_spi);
 int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
-void sd_write_data(SDState *card, uint8_t value);
-uint8_t sd_read_data(SDState *card);
+void sd_write_byte(SDState *card, uint8_t value);
+uint8_t sd_read_byte(SDState *card);
 void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
 
 /* sd_enable should not be used -- it is only used on the nseries boards,
diff --git a/hw/sd/core.c b/hw/sd/core.c
index abec48bccb..79d96576ea 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -110,7 +110,7 @@ void sdbus_write_data(SDBus *sdbus, uint8_t value)
     if (card) {
         SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
-        sc->write_data(card, value);
+        sc->write_byte(card, value);
     }
 }
 
@@ -122,7 +122,7 @@ uint8_t sdbus_read_data(SDBus *sdbus)
     if (card) {
         SDCardClass *sc = SD_CARD_GET_CLASS(card);
 
-        value = sc->read_data(card);
+        value = sc->read_byte(card);
     }
     trace_sdbus_read(sdbus_name(sdbus), value);
 
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 7d33c59226..1f946908fe 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -232,10 +232,10 @@ static void omap_mmc_transfer(struct omap_mmc_s *host)
             if (host->fifo_len > host->af_level)
                 break;
 
-            value = sd_read_data(host->card);
+            value = sd_read_byte(host->card);
             host->fifo[(host->fifo_start + host->fifo_len) & 31] = value;
             if (-- host->blen_counter) {
-                value = sd_read_data(host->card);
+                value = sd_read_byte(host->card);
                 host->fifo[(host->fifo_start + host->fifo_len) & 31] |=
                         value << 8;
                 host->blen_counter --;
@@ -247,10 +247,10 @@ static void omap_mmc_transfer(struct omap_mmc_s *host)
                 break;
 
             value = host->fifo[host->fifo_start] & 0xff;
-            sd_write_data(host->card, value);
+            sd_write_byte(host->card, value);
             if (-- host->blen_counter) {
                 value = host->fifo[host->fifo_start] >> 8;
-                sd_write_data(host->card, value);
+                sd_write_byte(host->card, value);
                 host->blen_counter --;
             }
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5c6f5c94f3..7c9d956f11 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1809,7 +1809,7 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
 #define APP_READ_BLOCK(a, len)	memset(sd->data, 0xec, len)
 #define APP_WRITE_BLOCK(a, len)
 
-void sd_write_data(SDState *sd, uint8_t value)
+void sd_write_byte(SDState *sd, uint8_t value)
 {
     int i;
 
@@ -1818,7 +1818,7 @@ void sd_write_data(SDState *sd, uint8_t value)
 
     if (sd->state != sd_receivingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "sd_write_data: not in Receiving-Data state\n");
+                      "%s: not in Receiving-Data state\n", __func__);
         return;
     }
 
@@ -1940,7 +1940,7 @@ void sd_write_data(SDState *sd, uint8_t value)
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "sd_write_data: unknown command\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
         break;
     }
 }
@@ -1959,7 +1959,7 @@ static const uint8_t sd_tuning_block_pattern[SD_TUNING_BLOCK_SIZE] = {
     0xbb, 0xff, 0xf7, 0xff,         0xf7, 0x7f, 0x7b, 0xde,
 };
 
-uint8_t sd_read_data(SDState *sd)
+uint8_t sd_read_byte(SDState *sd)
 {
     /* TODO: Append CRCs */
     uint8_t ret;
@@ -1970,7 +1970,7 @@ uint8_t sd_read_data(SDState *sd)
 
     if (sd->state != sd_sendingdata_state) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "sd_read_data: not in Sending-Data state\n");
+                      "%s: not in Sending-Data state\n", __func__);
         return 0x00;
     }
 
@@ -2076,7 +2076,7 @@ uint8_t sd_read_data(SDState *sd)
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "sd_read_data: unknown command\n");
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
         return 0x00;
     }
 
@@ -2192,8 +2192,8 @@ static void sd_class_init(ObjectClass *klass, void *data)
     sc->get_dat_lines = sd_get_dat_lines;
     sc->get_cmd_line = sd_get_cmd_line;
     sc->do_command = sd_do_command;
-    sc->write_data = sd_write_data;
-    sc->read_data = sd_read_data;
+    sc->write_byte = sd_write_byte;
+    sc->read_byte = sd_read_byte;
     sc->data_ready = sd_data_ready;
     sc->enable = sd_enable;
     sc->get_inserted = sd_get_inserted;
-- 
2.21.3



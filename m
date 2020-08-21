Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8452075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdhJIdyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8452075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9B68-0002ea-Pj
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArL-0001h1-GD; Fri, 21 Aug 2020 13:29:47 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ArI-0001E4-Py; Fri, 21 Aug 2020 13:29:47 -0400
Received: by mail-wr1-x42a.google.com with SMTP id c15so2627108wrs.11;
 Fri, 21 Aug 2020 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=slnS/GfxccZ/mD5eYQpI17Cum8OBadJc/KQdBJcV6Z4=;
 b=SdhJIdyZbJfQAuEFNAWAe5NO/u6ToD7rXzZJsmCfiNKZ8/+kki6Gz2GVLGcUh7CwPz
 vByRGycfCJTK6t6u96KgnZ+89fqcgzR/i/HvF7EHWzpboNvwh+zMF0E2Eb9BXL6b6kce
 gTbe9NtaCSj3yPzXPOwh5SH72VVUAvqD+Vgd7LGXeDh9j/u+6l3/3D9JnviQK9zXHJpq
 ywNOgdiHECIhIPyJna1P5zMID3M+qsPFk3O9nQqLM3c7bAVfBljsm3Ljiiguplk7Z09q
 NpXr2VDPJHcAOHmCkBeQFGPIWQyteuVvErahIbaAtThyjM4jWgR6Zo8b01ABtrmxFHVT
 9Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=slnS/GfxccZ/mD5eYQpI17Cum8OBadJc/KQdBJcV6Z4=;
 b=FwBtgwWTjQ5tqjD1kO85xpTsXi0l8U5NxQLzaqAKT+MqpLyxnZwCqVyi73WYZMmCLU
 oD1etMOJD7K2p6Lj1/Wr2fI05cToN24i1D+BZ2oV7H9G9djm3AxalBBs/y8DjYMaVYT6
 EGsnhS3YUfXDaquu1ijf4JsXY9KW0xjPkOrcdscclN3iEST/Vjob5EEMd8X0+1ah5fET
 NIWhl4xPPnkSE7vqKn4HqZCq2pDvS2H1EMCmGN7w9nbMZ2K8JHPujjKs2M5+2PsJcIy2
 aj5xyhjWeaoD1ZibnJF+pXRInGnkgMn/gCOLPyvzCY5IzNGKxg6a338p0B6aiPqakvtS
 ZaCA==
X-Gm-Message-State: AOAM530mO2a+LYXSXppMP2D8amRec5GKIIvoRv7kydx9lSAN3pt4xMjy
 DEfCQUbR9UEWhIUOr4UrS99Z+M8j9bM=
X-Google-Smtp-Source: ABdhPJwky+N09B5oo+mbFer6eatQ6NZCW51d0NhgPjQEE65pvr9P1d0NsSqptDO6+mXKj5emPsg09w==
X-Received: by 2002:a5d:4e02:: with SMTP id p2mr3687252wrt.399.1598030982364; 
 Fri, 21 Aug 2020 10:29:42 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/23] hw/sd: Rename read/write_data() as read/write_byte()
Date: Fri, 21 Aug 2020 19:29:08 +0200
Message-Id: <20200821172916.1260954-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
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

The read/write_data() methods write do a single byte access
on the data line of a SD card. Rename them as read/write_byte().
Add some documentation (not in "hw/sd/sdcard_legacy.h" which we
are going to remove soon).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200814092346.21825-2-f4bug@amsat.org>
---
 include/hw/sd/sd.h            | 19 +++++++++++++++++--
 include/hw/sd/sdcard_legacy.h |  4 ++--
 hw/sd/core.c                  |  4 ++--
 hw/sd/omap_mmc.c              |  8 ++++----
 hw/sd/sd.c                    | 16 ++++++++--------
 5 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 8767ab817c1..b58b5a19afe 100644
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
index 8681f8089ba..0dc38895551 100644
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
index abec48bccb8..79d96576ead 100644
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
index 7d33c59226a..1f946908fe1 100644
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
index 5c6f5c94f3d..7c9d956f113 100644
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
2.26.2



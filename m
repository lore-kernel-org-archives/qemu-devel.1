Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BBAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405B3207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+wmNB8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405B3207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorHE-0002vL-EG
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDJ-0005P4-QU; Fri, 26 Jun 2020 12:28:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDI-0003Ka-1B; Fri, 26 Jun 2020 12:28:29 -0400
Received: by mail-wm1-x342.google.com with SMTP id f18so9932623wml.3;
 Fri, 26 Jun 2020 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0q3fvINBMewfm4ouk0ChZ+kON+bgL7uzrdyA1Uly1X8=;
 b=f+wmNB8G8JOaWUmH2S4Zhmj6TCiVETj8LbbARXDF9waok9EXdu6hwlgvqbPiDMVZBT
 L4qSyiXsIPnKzx2zDQzSq3ahd8BdLgYvuDJgYDmBQVc9TurTr0CHtn2HPALKyKknU9SW
 3UkeVgsjUKweRrQ66bkqX3IYjhiRY+Rod8BwhybKGtmGlwmQPiYa6GBRK39M1E9RGzEq
 OXXFdooswOUGrNy02Pbh+pWqrPPL4NjjRBoXcGgfs04DbQnMmD3zzWMgzI3Q9cW3UsN4
 Hm0JRXfvR7nvoWVOb2vTRD/981U683IsyjSy4mJVE8I6hAGxat4RirJe022Y1JKtWO6A
 57AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0q3fvINBMewfm4ouk0ChZ+kON+bgL7uzrdyA1Uly1X8=;
 b=oM3GFHYg17gEY7zGHpoCWpJ0NcudMFFvybC7Xiiew3McuXT5Y6NqlqKG01hx/u2b0t
 /fe9SDIi1gFkoORMw6jIKcKmhLIGYpdmQPf1FD7H8g36JrKKFJV1KKr8FqorK23VGdZQ
 1AbPbKV6TtHA4qpuA7VfBAPNyz7QJNgQAEcOofPENBvsRJszGkmCVN+2R3xCftQ120lU
 3aL2jymWeq+QI4+z+OTs9bi2PYfjlc4R3P3a+t5CpX1Dzc/Rq0Ze+2BpkYvMYSvc8E1m
 /vUYQaLCM+DN0gehliqxBOS6K08oHtEa7XiJNHc+RcIFTZ9p1M44eEkBjpnsVhKPiZRg
 hXjw==
X-Gm-Message-State: AOAM531IMFYmGBzmxWBaM1gTWpja334B8lWUtTBg98WxAiSHKutAjRcR
 oaXexKbahaO/iryTdCcr+MMjfmHZ
X-Google-Smtp-Source: ABdhPJz6MeSZdgxW5+n7i1glaudEfIu7yuZgpUxHuc9bhMFaIwD00nfjqdAb+HHNPj2Lyv/FTxqMEw==
X-Received: by 2002:a1c:a7ca:: with SMTP id q193mr4323211wme.69.1593188906134; 
 Fri, 26 Jun 2020 09:28:26 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 05/14] hw/sd/sdcard: Do not switch to ReceivingData if
 address is invalid
Date: Fri, 26 Jun 2020 18:28:09 +0200
Message-Id: <20200626162818.25840-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
References: <20200626162818.25840-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only move the state machine to ReceivingData if there is no
pending error. This avoids later OOB access while processing
commands queued.

  "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"

  4.3.3 Data Read

  Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
  occurred and no data transfer is performed.

  4.3.4 Data Write

  Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
  occurred and no data transfer is performed.

WP_VIOLATION errors are not modified: the error bit is set, we
stay in receive-data state, wait for a stop command. All further
data transfer is ignored. See the check on sd->card_status at the
beginning of sd_read_data() and sd_write_data().

Fixes: CVE-2020-13253
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v4: Only modify ADDRESS_ERROR, not WP_VIOLATION (pm215)
---
 hw/sd/sd.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 04451fdad2..7e0d684aca 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1167,13 +1167,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 17:	/* CMD17:  READ_SINGLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
 
             if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
             }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
             return sd_r1;
 
         default:
@@ -1184,13 +1186,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
 
             if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
             }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
             return sd_r1;
 
         default:
@@ -1230,14 +1234,17 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
+
+            if (sd->data_start + sd->blk_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
+            }
+
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-            }
             if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
             }
@@ -1257,14 +1264,17 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
+
+            if (sd->data_start + sd->blk_len > sd->size) {
+                sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
+            }
+
             sd->state = sd_receivingdata_state;
             sd->data_start = addr;
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size) {
-                sd->card_status |= ADDRESS_ERROR;
-            }
             if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
             }
-- 
2.21.3



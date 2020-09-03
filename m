Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B45C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C8F206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbCA72sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C8F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwrc-0000zx-Hs
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLr-0004lE-1V; Thu, 03 Sep 2020 17:00:59 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLp-0007oK-2p; Thu, 03 Sep 2020 17:00:58 -0400
Received: by mail-ot1-x341.google.com with SMTP id y5so4017464otg.5;
 Thu, 03 Sep 2020 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c/XJ4cq89jTidCJNmUTRkTTxQKsiT4FwBhQY5tAah/0=;
 b=LbCA72sb0bW2BOnLqpeCgCYTIX0V7dPXWccAVW1OylGFmSc64t0d+brN8UkODmKVFk
 KuGEyMaXy498WdQB1g9OI/+3mQ7nNFe4+QhAubD2O1PzKZeaNqLyuVvCdLJbGidjICSw
 /wg+KvXrm6zG9tqux+mgsVFttt0TxZSD3xsevW2gNjpMnnKULAv1g9ngz56Ht/0UojIv
 09ZWH8T2WCsxtW9W9C6vwgSe2p53v3XeEIhOr4BHn8qwaFue5o3CG48Ij4uSbPmIfsLL
 GJNEPx/ohRD8U5scxHB42b0Qkl2A6iAj8t6poRtXN/Vie099ciiszlfNQsr7yW2hfpD1
 GyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=c/XJ4cq89jTidCJNmUTRkTTxQKsiT4FwBhQY5tAah/0=;
 b=KG8kUILphz3Z5/hg7UNZ8HsVaTvrMttD3uOi4vvTuLf7QH1t2epr3Km4xtnwZ2fLgk
 zRlC5LskJzeGrpFPeulpizZ9/skn4ksot9wEN0yz2OZrneE+tHGZQ0fQkdXvghOLa2wa
 6kyRLkMqL2mqlz027cAmAXqJmJoYDVkTMb5IpAUvXHf7pBZnz6Vy7ZGSpA1NnjF/EKYw
 v58hHuoigwogqaadS30NMuw13bmsnureK15fDPRcHTntJjT7P4KWjo+0iall1IwtDxqz
 joYU5RRv+M2fFVlQ/90DtkdUlEULt/ZV/MFYnZN0UtLykOe96e8FeXQvyGhE160DS1Fl
 sstg==
X-Gm-Message-State: AOAM531wUUwv29sNaOuIx3ETUuHkogmrsC3y5dMPvOQFb+ewXQABkcmC
 p1Q8+jeohwj+ZnPEt3br2LJMGHFNDuQ=
X-Google-Smtp-Source: ABdhPJz6LNJZd6F8S0FPtauEwH+iTHJPRz5DFMyEmgcUOKWYgpc2KiegdJl3AM+2Kq12xxkVLCzHaQ==
X-Received: by 2002:a05:6830:1d8a:: with SMTP id
 y10mr3186967oti.92.1599166855226; 
 Thu, 03 Sep 2020 14:00:55 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g62sm761424otg.56.2020.09.03.14.00.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:54 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 55/77] hw/sd/sdcard: Do not switch to ReceivingData if address
 is invalid
Date: Thu,  3 Sep 2020 15:59:13 -0500
Message-Id: <20200903205935.27832-56-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Cc: qemu-stable@nongnu.org
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200630133912.9428-6-f4bug@amsat.org>
(cherry picked from commit 790762e5487114341cccc5bffcec4cb3c022c3cd)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/sd/sd.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b927f7966d..837fe9053d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1156,13 +1156,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 17:	/* CMD17:  READ_SINGLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size) {
+            if (addr + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
             }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
             return sd_r1;
 
         default:
@@ -1173,13 +1175,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
     case 18:	/* CMD18:  READ_MULTIPLE_BLOCK */
         switch (sd->state) {
         case sd_transfer_state:
-            sd->state = sd_sendingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size) {
+            if (addr + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+                return sd_r1;
             }
+
+            sd->state = sd_sendingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
             return sd_r1;
 
         default:
@@ -1219,14 +1223,17 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
+
+            if (addr + sd->blk_len > sd->size) {
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
@@ -1246,14 +1253,17 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             /* Writing in SPI mode not implemented.  */
             if (sd->spi)
                 break;
+
+            if (addr + sd->blk_len > sd->size) {
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
2.17.1



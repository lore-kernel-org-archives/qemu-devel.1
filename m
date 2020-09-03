Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF2CC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DCA20639
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0JRqocK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DCA20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx4k-00013T-BP
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLp-0004ie-Q7; Thu, 03 Sep 2020 17:00:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLn-0007o6-UX; Thu, 03 Sep 2020 17:00:57 -0400
Received: by mail-ot1-x342.google.com with SMTP id 109so4028785otv.3;
 Thu, 03 Sep 2020 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HoXMwJ6jL8idPvXw+qvTHpg54S9w/O8tNTCV84dfgYM=;
 b=b0JRqocK7EDtDSG09dqWAJm6fybhUrz8wMy3oOQXWBJW70aXXiBeg4VJJtpFDaDqOm
 BhyJblnWclBDnenefmAm18UFt9TGKkqnYAFI1X3SNwaHgkoYZrEEZAcBAxqqNZZtvrmg
 ZauK2qR0CCK5G2wOhVEf58VOdNWj38hbDwh/NZKRSi1OzZalU0YX941XweOcA4+vPQ0F
 OLZC/sNzRKxKE1taNK4k8DAgFMAVxxozXp1+6rY9alhbxnPlYnkw7U2Gq9jYAAOmgzZh
 GRt56E9mxsQyLWME4udye6+wqPfLRVzrmm/CKh/u2KLaApvV1sZuIWmYhp5MYuQZVQew
 tGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HoXMwJ6jL8idPvXw+qvTHpg54S9w/O8tNTCV84dfgYM=;
 b=Ris8jzcOd+3hS8iJhPZ82joKC6WgaIF8SKMHps8u14ogdSc7vosaey07TmxktGgsZZ
 R6IDVs8DU/8BJeRlJaOdnghXFtMFbjuoUuly9cWrJDnaEhxL1gZY74YyDJPTmkAdO1YD
 bJcRe+zQsWpCgMAQ9LH/4UJor5Fwrq0I+uaFLdpMJO9UsemjiGKrpQF7qHIAHDcBZ02H
 Gx3Ywc2HaORcudnhPdoMOs3apnabguw2WT8CM9snlC1+MomNeEyRXVGrjv42oiE1IXYF
 /EqZE+0u2a2FnA5idOitiqsfKpALp/cFGNbgZ67M2tJ8Ma5elltbEUAkbn65bkES/i4l
 z4lQ==
X-Gm-Message-State: AOAM5300CGhszzf68D5adcz4p+0DT0FqBI5GUA/ZqnF2Gwo9o+hALlxN
 ZxaqOiQAdkrI8VKNXz6meoH9SVdZgHs=
X-Google-Smtp-Source: ABdhPJxkB/6NybeUL8fCrkagp8muImqa+wg8bUBdvjcfapkmjFV5xZsyGRgxSO9lVZAx6NE/WURgYw==
X-Received: by 2002:a9d:3bb7:: with SMTP id k52mr3031468otc.242.1599166854163; 
 Thu, 03 Sep 2020 14:00:54 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g23sm869321ooh.45.2020.09.03.14.00.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:53 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/77] hw/sd/sdcard: Update coding style to make checkpatch.pl
 happy
Date: Thu,  3 Sep 2020 15:59:12 -0500
Message-Id: <20200903205935.27832-55-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
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

To make the next commit easier to review, clean this code first.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200630133912.9428-3-f4bug@amsat.org>
(cherry picked from commit 794d68de2f021a6d3874df41d6bbe8590ec05207)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/sd/sd.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c34435ede4..b927f7966d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1160,8 +1160,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_start = addr;
             sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+            }
             return sd_r1;
 
         default:
@@ -1176,8 +1177,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_start = addr;
             sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+            }
             return sd_r1;
 
         default:
@@ -1222,12 +1224,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
-            if (sd_wp_addr(sd, sd->data_start))
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
-            if (sd->csd[14] & 0x30)
+            }
+            if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
+            }
             return sd_r1;
 
         default:
@@ -1246,12 +1251,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
-            if (sd_wp_addr(sd, sd->data_start))
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
-            if (sd->csd[14] & 0x30)
+            }
+            if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
+            }
             return sd_r1;
 
         default:
-- 
2.17.1



Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D764C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6C321D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oX+uREvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6C321D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSwzS-0001Qr-9v
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuJ-00056L-22; Thu, 15 Oct 2020 02:38:35 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuH-0006r6-H1; Thu, 15 Oct 2020 02:38:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id s9so1908694wro.8;
 Wed, 14 Oct 2020 23:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mHMBZwFybrG3Wb5VMsP3egLDE4ZsHJicDRun+ytDKB4=;
 b=oX+uREvNOCcK1z0CsHc0geb9reSMcKogmylLUVsL7upxNVLy+7RBJIHd5RI1bDrA0c
 bN446L/3HRHiEEIIr3N+hbY7hdhhrRWvYuIS7384YIsjNhhkkrN3OqMv25LpS792yR0Z
 fR82oRe354j6dV4EGXFLJv7kMXQRikBkLHM/z8wv3MNug5+HujNqMR6PSAHmzkpu/8oX
 hkR1f06NiDeHJIecH6pA+5tS4dyv0nlUdO5MkN6uzZDyQlJAt9kY6F/D/R920Bq17ZKu
 sRG3/+7uk4o09rKRj8geLrRZwCt0qlu4ILTETkfihtKDBloojvVl++VPUKKShzMUTXPh
 zo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mHMBZwFybrG3Wb5VMsP3egLDE4ZsHJicDRun+ytDKB4=;
 b=EhOE4Qb9Y5TVAzUDim+R5a1Tycn6S8UvVT4tX6BWDjo3xBpISvqpecnLQZGuOfiE+U
 pAB1+FiK1u7jtwi+GjVNI0h/lCtmWBYTDhwzmpo3w4Ok7DPkKjuRJA0cMEOGIYiAyaVI
 DWfDnt3b15afUWE7Zmi1xky2W/wTHkqlt8RVFroxpmLXQp5k2T7ZNKHudWX12Lm42BbR
 WcCtGRah/NG0Aq49lNb8mDS9MpBearBRM6Zn0r3pfLFexWOqb9zq/2tQnuMqwiM5igOq
 4FhutwyO7iHaWmX/b4Pct2otYzQC2iOpCbachougTCNYD24BU2B+Qq8ZdfdqQ+moiKNN
 4DXQ==
X-Gm-Message-State: AOAM531iNuBtIdWyH2UlvY0cdO3WhLA5bppW8rsU95fDIbSURZWwHZKy
 XFWr7o/Vqfbby14Xk/DIm2h00GO9cO4=
X-Google-Smtp-Source: ABdhPJzgi9yyNKmxqk0JPSexWeRyf4g7g8ZtzbND1J7AZ9fDdYUF6cEiaW1qj3ow2govJzQKCuOTBw==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr2347037wrs.232.1602743911454; 
 Wed, 14 Oct 2020 23:38:31 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c18sm2796897wmk.36.2020.10.14.23.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 23:38:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] hw/sd/sdcard: Add trace event for ERASE command (CMD38)
Date: Thu, 15 Oct 2020 08:38:19 +0200
Message-Id: <20201015063824.212980-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015063824.212980-1-f4bug@amsat.org>
References: <20201015063824.212980-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trace addresses provided to the ERASE command.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c         | 2 +-
 hw/sd/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 00128822224..2606b969e34 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -749,7 +749,7 @@ static void sd_erase(SDState *sd)
     uint64_t erase_start = sd->erase_start;
     uint64_t erase_end = sd->erase_end;
 
-    trace_sdcard_erase();
+    trace_sdcard_erase(sd->erase_start, sd->erase_end);
     if (!sd->erase_start || !sd->erase_end) {
         sd->card_status |= ERASE_SEQ_ERROR;
         return;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index a87d7355fb8..96c7ea5e52f 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -46,7 +46,7 @@ sdcard_reset(void) ""
 sdcard_set_blocklen(uint16_t length) "0x%03x"
 sdcard_inserted(bool readonly) "read_only: %u"
 sdcard_ejected(void) ""
-sdcard_erase(void) ""
+sdcard_erase(uint32_t first, uint32_t last) "addr first 0x%" PRIx32" last 0x%" PRIx32
 sdcard_lock(void) ""
 sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
-- 
2.26.2



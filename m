Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA5C55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCB62224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNEXywAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCB62224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVI3V-0005V9-2f
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1R-0003jY-86
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:55914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kVI1P-0006Gn-Ho
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:35:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id a72so2992019wme.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fzUN3m5jQNygQt0awS2eaBT0Cdsnit89rpHTEPVkwn0=;
 b=oNEXywAiA1XRgqBTjH8uT0rQFi1YQhY+FOxcCAMDWa5wYVZk6ZxPr/f6wd5eulNCII
 74fg99kDITdU3+Jt+nMBKL88dyz6jl0nrVYH1x5CGjktBYX1phb1kwG5pa1hV6EPvYBi
 ZScXuRyHcp8zPk2vWaKpT2WpcL/1xDZ/l5Nh7cB6OpZETUwJ2VWSnztSM4kgr7KnU9Im
 2vgfsI+OFzBQJdTQ/OF08iR/ZsegiOnGMfcC4wFbJmi6Av2BgU4XP5b8hn73Sd1lIAJn
 602MJJ4S1l/xPDEjpBtjvve+ioJcx60r6rXM2wYKIa9IdR2420YSYGoeVxowiA0Vgafo
 +80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fzUN3m5jQNygQt0awS2eaBT0Cdsnit89rpHTEPVkwn0=;
 b=sHyA6k79s5X1sjC3Gzi+lkbzStNpKmfbYso1rTeo/4xVVHrOSC4poWCwOECVOaN/nT
 TWKP69GyQmbZPjbc4Jov3LMkcSNPxqLucUSbSAlXmglqnHuyOO1n/s9OqSbKAe6GKbuo
 US07by51d+jRN23aN2vAyyOhMR3WDH36jZhacgVXH/kTjAOlK6+JSzMwWO2DzIW71IVT
 2gJ1XalgXk5N+Bh707Uh1BWtCKAzX0JvnK5sC21EZMb7/D51IjMTsN8Tdt1sY/9LiuS1
 i0dMRKOU0F2Snx0ihfPbrO33PNgc34E0XThlBXZ1H29oMbyHpt90z3X1W+9H+wbdRNjI
 6IjQ==
X-Gm-Message-State: AOAM532Iq2sBG414qeUgttqGVsbHozHRa9RxosASKIDBA3wVgdBwM0PL
 WcM1MWcyy+ZTNZ9BDP8Zs/vTtBBfNLA=
X-Google-Smtp-Source: ABdhPJwXBoRsdDb44X9EuqWeZflAOBRTVuTjdzWUu+OVIA3Rkl7nxfTTlIJV7lDIa7IO9G5VvrDJOw==
X-Received: by 2002:a1c:4445:: with SMTP id r66mr3286682wma.140.1603301734029; 
 Wed, 21 Oct 2020 10:35:34 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b25sm4412857wmj.21.2020.10.21.10.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:35:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/13] hw/sd/sdcard: Introduce the INVALID_ADDRESS definition
Date: Wed, 21 Oct 2020 19:34:46 +0200
Message-Id: <20201021173450.2616910-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021173450.2616910-1-f4bug@amsat.org>
References: <20201021173450.2616910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'0' is used as a value to indicate an invalid (or unset)
address. Use a definition instead of a magic value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201015063824.212980-3-f4bug@amsat.org>
---
 hw/sd/sd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2606b969e34..30ae435d669 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -53,6 +53,8 @@
 
 #define SDSC_MAX_CAPACITY   (2 * GiB)
 
+#define INVALID_ADDRESS     0
+
 typedef enum {
     sd_r0 = 0,    /* no response */
     sd_r1,        /* normal response command */
@@ -575,8 +577,8 @@ static void sd_reset(DeviceState *dev)
     sd->wpgrps_size = sect;
     sd->wp_groups = bitmap_new(sd->wpgrps_size);
     memset(sd->function_group, 0, sizeof(sd->function_group));
-    sd->erase_start = 0;
-    sd->erase_end = 0;
+    sd->erase_start = INVALID_ADDRESS;
+    sd->erase_end = INVALID_ADDRESS;
     sd->size = size;
     sd->blk_len = 0x200;
     sd->pwd_len = 0;
@@ -750,7 +752,8 @@ static void sd_erase(SDState *sd)
     uint64_t erase_end = sd->erase_end;
 
     trace_sdcard_erase(sd->erase_start, sd->erase_end);
-    if (!sd->erase_start || !sd->erase_end) {
+    if (sd->erase_start == INVALID_ADDRESS
+            || sd->erase_end == INVALID_ADDRESS) {
         sd->card_status |= ERASE_SEQ_ERROR;
         return;
     }
@@ -763,8 +766,8 @@ static void sd_erase(SDState *sd)
 
     erase_start = sd_addr_to_wpnum(erase_start);
     erase_end = sd_addr_to_wpnum(erase_end);
-    sd->erase_start = 0;
-    sd->erase_end = 0;
+    sd->erase_start = INVALID_ADDRESS;
+    sd->erase_end = INVALID_ADDRESS;
     sd->csd[14] |= 0x40;
 
     for (i = erase_start; i <= erase_end; i++) {
-- 
2.26.2



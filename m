Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB220206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXvW9gSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB220206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joraH-0004zt-UK
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorPF-0000Nu-IQ; Fri, 26 Jun 2020 12:40:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorPE-0006Ch-5L; Fri, 26 Jun 2020 12:40:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id z13so10125102wrw.5;
 Fri, 26 Jun 2020 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=074iMePnrQX+lQLKspStcL4/Sdxmmp5D48oE2Br3C4s=;
 b=LXvW9gSYa0SXpnKOq+5gPIPRM27/qard9nfNtEgjqVFqXXxOjt0BujRrp48k/qxncI
 hoUvufxqu0iVZCDVc9PGaA20csjXXFOEQctIamsfK95Melp3+gVbhnX/yJNocCJl18h+
 2ePe7fPhfxnlIsyDymkF1qzzRWj0VHkiWP8g8ZwJCUW8YGBsCV2LBU083CUQkSQZO6c9
 +kiP3eu4ChiyZQT5tcfNsqspZpBGC7U9zOubPP9G/6iTKHJRMmKULHuaJQ713KFWL4cS
 doXKJ2U5/GjhReLqn6gsMppwVaJ8dAuPk5Jziot3OIPyxdFnRHYSLvDzRFQULpOBtLwW
 EBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=074iMePnrQX+lQLKspStcL4/Sdxmmp5D48oE2Br3C4s=;
 b=mL21zghCb/cSoznny5anyVDmuJsk8A90/0xoA2hstPp/lfSEQVh+mU/jsKJ8/7PyMh
 jbR3LaDtsuR0D0R6rUI2HqB4oCkCkhAZ2zHsdVAJPfeBN2tFdczrezU+/rzn+wJ+294w
 TukXyJN9QPKxi5MTEFVorfV3h/behBx+v6lITfjGDGN0m0K6em0uPqPK3dC9zLaHKbJu
 DQ3ESfiXDmZaxV4iMmAP6aYzYOOh6BJaZf6qw3QIRN0zCVhqzW+pUr3Qu+wzfKgAOhww
 xLvdRv1V5yaZ9xDu5GHVQk8g+69wNUWeP4ROCP4Q1ngwDCwkPSzLeS1YvcXsYQ7GLMNx
 LThA==
X-Gm-Message-State: AOAM531jdfPXD18zCGSS0dZgWCtyJ4UlFCX8t4Tx7l1B/y5w9Dxa75GD
 inEtFJIcfpOX+hrcxXFLoTU2hrLf
X-Google-Smtp-Source: ABdhPJx3WyHMW1H3lktkBrGgzXb7DO9o79d+l3PLYrGf+y6TiFXz2tsXmyKS0Cp6+snHZjEkxqRmmQ==
X-Received: by 2002:a5d:6786:: with SMTP id v6mr4614577wru.258.1593189646269; 
 Fri, 26 Jun 2020 09:40:46 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/15] hw/sd/sdcard: Simplify realize() a bit
Date: Fri, 26 Jun 2020 18:40:26 +0200
Message-Id: <20200626164026.766-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to check if sd->blk is set twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f0b5527eaf..27a7862c98 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2140,12 +2140,12 @@ static void sd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (sd->blk && blk_is_read_only(sd->blk)) {
-        error_setg(errp, "Cannot use read-only drive as SD card");
-        return;
-    }
-
     if (sd->blk) {
+        if (blk_is_read_only(sd->blk)) {
+            error_setg(errp, "Cannot use read-only drive as SD card");
+            return;
+        }
+
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {
-- 
2.21.3



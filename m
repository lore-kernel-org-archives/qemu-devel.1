Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8160AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5248720675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZwld1Lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5248720675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGbt-000740-J4
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGU4-0001Qf-D1; Tue, 30 Jun 2020 09:39:36 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:33339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGU2-0006MC-Qs; Tue, 30 Jun 2020 09:39:36 -0400
Received: by mail-ej1-x641.google.com with SMTP id n26so6701580ejx.0;
 Tue, 30 Jun 2020 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tv3cmbEAPQXfnR101UMsB/BGFDSkA4UlLHtuhpdSRTY=;
 b=RZwld1LpTlMivvRFtSgkkewYWAozjm9c+mZhg+8hyFNdCAYhhViSqsMRKMh3IR+LBy
 0+3/b6lnT070B980UAtoCmriTlp/UywBCkcKUyjBxnBa55iYV4MlXbKHy21MdHhwWrTF
 1Byys60KyVshW292Ee9bCCg8KE+EqSNPWpvK19EH7CdGV4DnGmLck9M57nKTi3bPTwaF
 bNHb9g4LJZacdU6kEY4yJfJgRkViTRqEjyvDs5Teg5Y59kxM/uT8coMrcx/Q7bzmkDAq
 XJHs0uyyAnAnGKO8Ppx5K/ORHho/mVk9IxLlTpkrNoQFe5cF3OCfbiTnLJtEjrFT50v/
 pCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tv3cmbEAPQXfnR101UMsB/BGFDSkA4UlLHtuhpdSRTY=;
 b=WW9a7yVnzML1V0UppFJTjEt+U5dWbt3Ha9ox0vUwRRpZsOT4tmpkAAjixd29g8dZ0E
 zm+JEr79DRIj0oAqjZC89Fb42mldk/bks5VAQsTWtFLf43YYrEPiQv8v/iOClfexxPOn
 p2kAjbv7Hl4/+hlDKYWkrGniitFYNWSKwZMa7UpeaIVJWMVu8gRS21r4LFVy9JC1twMR
 rf22WX3coLslN5+V8Bl3LFqVlIatB4tPtgZ09YEO31VtPxbviQY9l3zdgSsHMeOFBL3L
 LcVZ1G4LvIagfcFCOHTBhV4Rv2JxVxu9o7RJEqozEBVv3CdPjvMxaTnqgjnQrLrzBkDT
 iKCw==
X-Gm-Message-State: AOAM533Qy4HFBSqczw4UfRg9aqbguFcBpVuytmRD64kzcPnaUg0FfP2q
 sE2bqBQtxHTTJ1VprS6SvvUGFzzDIQo=
X-Google-Smtp-Source: ABdhPJxprMXSEY422d+55cynJZbdJ2JJRydkzFCARpZUc4WY2Z2+H9HW8zezDTdqbSzrgBRGSsIChQ==
X-Received: by 2002:a17:906:1f4f:: with SMTP id
 d15mr18121720ejk.206.1593524372900; 
 Tue, 30 Jun 2020 06:39:32 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 17/17] hw/sd/sdcard: Simplify realize() a bit
Date: Tue, 30 Jun 2020 15:39:11 +0200
Message-Id: <20200630133912.9428-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
index 304fa4143a..8ef6715665 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2154,12 +2154,12 @@ static void sd_realize(DeviceState *dev, Error **errp)
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



Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9ABC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7D9205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ab1N51qT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7D9205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzRB-0001L8-PP
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzBD-0005kO-F2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB9-0006hB-Ia
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id z15so16715214wrl.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wkQrJoXM425PWoucOv5GqHn+31dKoPwmmNyiyLTRjMk=;
 b=ab1N51qT6aWxcN+Ljw+HD5GaAfNJhRblBK3SF8vj8rNlyrfQhw357v4NmjpBSlor23
 sWs5dIzM+jNXa7ZVw0YRZXYNRw6eEQebi5AvnCLUUIwjX2vWQTsI/m9RUmS3MFd3uRIs
 mUvGKaBRBJObN4oHEGeEhRMP0ZEFrz9PwHTPbu9zoOvfwx1LhrOv2JWxwPwECCFNN9CD
 1Y4d3Yk57cF9fgqBkJdos31VYIajBgwFZgGD/khdp9sq5gD73yWvi3T4R/sMVBtAWWFr
 +MfUYYnAcLWCLRcqQcz4tEBeTwfpkdN3ZpzPMyyjEuWs7tYmNa+xP2agDqFcvQ3gDP7D
 /cWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wkQrJoXM425PWoucOv5GqHn+31dKoPwmmNyiyLTRjMk=;
 b=ZY62jPsY467LE/qhT/fc4P4UmDs1tet1CKUM1/c9dF/hPuEhRLK0z894bZ0vbdq/vq
 V/JdIblUIXFjoNOHwU+y9TyykWksOLK3ON1JhXGLT26RNMmoZaD6DfJlPO9yonGn4STQ
 Pjy9/eGYGHl0YjazCF0Za0x8nDOMxOiS/KmDhUUGL0i44vMeD5HZ9s1I7qnRbJE0VR94
 Bzm8Tc158+FOenMY9uUpVA12tdjfZV7LQ+XtkcLffQTzH+/uZioxKO84NJ7NdXwExoFS
 25ldUB2yFxjCyl8fn9i6exSQxE/MkeYVrH93eLKXs9VPxCCRrWwzGbuA/5XYPwGlo4Js
 XXvw==
X-Gm-Message-State: AOAM532WLhIxKdqx5nEF61aLMCm9tn8JPeoCLe2j+FRcXkNpHShErpWQ
 a37UwatahxzaldGz8BBE05PP3k7HjIdirg==
X-Google-Smtp-Source: ABdhPJw+0VHI65LvFGwTJnJo/snoGigZRm07x44aEMZiYpinRl2HuQbrurWhVRwOdttDWVT2mE1XPg==
X-Received: by 2002:adf:ff8d:: with SMTP id j13mr77733455wrr.11.1594649493921; 
 Mon, 13 Jul 2020 07:11:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/25] hw/arm/aspeed: Do not create and attach empty SD cards
 by default
Date: Mon, 13 Jul 2020 15:11:04 +0100
Message-Id: <20200713141104.5139-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Since added in commit 2bea128c3d, each SDHCI is wired with a SD
card, using empty card when no block drive provided. This is not
the desired behavior. The SDHCI exposes a SD bus to plug cards
on, if no card available, it is fine to have an unplugged bus.

Avoid creating unnecessary SD card device when no block drive
provided.

Fixes: 2bea128c3d ("hw/sd/aspeed_sdhci: New device")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200705173402.15620-1-f4bug@amsat.org
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 660dcb54144..6a3a345a6f6 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -246,11 +246,12 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
 {
         DeviceState *card;
 
-        card = qdev_new(TYPE_SD_CARD);
-        if (dinfo) {
-            qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
-                                    &error_fatal);
+        if (!dinfo) {
+            return;
         }
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
         qdev_realize_and_unref(card,
                                qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
                                &error_fatal);
-- 
2.20.1



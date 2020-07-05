Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF31C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:35:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7B220674
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 17:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0/1sdk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7B220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js8Xs-00025z-Jv
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 13:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1js8Wm-0000l9-Nc; Sun, 05 Jul 2020 13:34:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1js8Wk-0003M0-Jb; Sun, 05 Jul 2020 13:34:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id o2so39208057wmh.2;
 Sun, 05 Jul 2020 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PuV1/W4zTy0w1hBZeJNwhkU/sfRpJmdSN3gziOQhnYw=;
 b=T0/1sdk7SX+8+dLtkRsdSXmNpNVNstCXr/dW31W3Ma051IhpNje62Db8076i07n4++
 ibyuZHKLnh06V/ba2cqxaP6EfcIHAwVdlEOKCvkRncE1TGxerjXB+8gmZC2w9XGIVaJY
 FCwZxHZNxgHsS/8qngus1CIm96Hgr8DqBAA6dXaVXvkA70fgsPvhiNCk8bplffh3Xj3a
 eN7mNMDY9e9IqILH8pgM4bGqF6HRY0Gm24sCbO15skB2iG+9OhGzDTs9rjTZhZThEgJa
 DrpEbP1ry0rpG0hcNWS7u1cJ2tJJv/a+WFnqvkxp6APAddGzyY2SqTErWDEzWktHJ5VO
 BQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PuV1/W4zTy0w1hBZeJNwhkU/sfRpJmdSN3gziOQhnYw=;
 b=WTadNBUDYGRIYmf+Dkhh0uaX+fIMj2EaC3KNF+8reXDiPGO7rLZGZdEAdr4ZvAWtvl
 60uySyuUMCNI4SeJeRjduggLxWSRO9kVocqJ+R1HBuRJD3vXRx6I6tXy2H0viXy7oIYd
 i5EYZFne1XSvRrYSerQLNuvGd3InlRzeUXP0/lP+5OJFZSDhICIHLYQwtMhy6lnYZ35E
 dZqSzYTkJ35sp2ws8BlFkAwulFAwPxTLOutnH9GggZXxtQ8aMLTQ5XRJskx6+XmMURB5
 kk0WwmbrixuEJV4ePeGLWxcWnxF5IoW4pKLK+yp3x1wlVBePxX4ADTL1TnG1Jma5tGGP
 vBiA==
X-Gm-Message-State: AOAM533OK9VD4ePs1zoHIIG643+1cKs5F8nEcPvcKyBAzRPgiRvYcHzu
 G88gBi3bBR/NIRIanL5zvTsy87MnKdM=
X-Google-Smtp-Source: ABdhPJyT1cES9EQZNQG/P1df5Ypw8csm2z085zokKzkPSW51NEgMc3bqDEYX6nFBNILdUoNVfxpXPA==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr3701643wmb.185.1593970444887; 
 Sun, 05 Jul 2020 10:34:04 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j14sm20625357wrs.75.2020.07.05.10.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 10:34:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/aspeed: Do not create and attach empty SD cards by
 default
Date: Sun,  5 Jul 2020 19:34:02 +0200
Message-Id: <20200705173402.15620-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Eddie James <eajames@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since added in commit 2bea128c3d, each SDHCI is wired with a SD
card, using empty card when no block drive provided. This is not
the desired behavior. The SDHCI exposes a SD bus to plug cards
on, if no card available, it is fine to have an unplugged bus.

Avoid creating unnecessary SD card device when no block drive
provided.

Fixes: 2bea128c3d ("hw/sd/aspeed_sdhci: New device")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Eddie James <eajames@linux.ibm.com>
Cc: Cédric Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
---
 hw/arm/aspeed.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 379f9672a5..11521c4be1 100644
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
2.21.3



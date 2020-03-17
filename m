Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5BFC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4502051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCb853Z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4502051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAbe-0002d2-Mo
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaW-0000NJ-Di
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaV-0002MX-DT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAaV-0002Db-6j
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id a25so25212093wrd.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gGt7/ycHlk/paOjuicsg+s6eHvlL+QhBi/5GXoTKKrA=;
 b=jCb853Z24I+auyAJtr2pNHZaN8W7teP3+bramSLeBQfME8nI/peMv2Ye1e2WeBCMSN
 OhziJaUornz7vbbeWH9a506mD6YZTrvVo/f7wLTSK1AnscKn/QFp3X5+GH5OtRxzzI4r
 z8lExrguuvwUXnjYukDUTinXJoJRA6RMoj3yeAB/+8079nQ4HRhPA4ttH7WP2CMLlS9K
 ASCjeMjryixvJ462lUVGh+ITFFNIgNOVR/ek4BaRTvN0QcuUv0Kp4Ks8c7ALnWfIpPUE
 baJnrH51vWiYfEt8e3H3zOPt+7/ivE2FSy3ID2i1tSp8sq7GOz2Zz1YPxcTVV15D5wGj
 Vsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gGt7/ycHlk/paOjuicsg+s6eHvlL+QhBi/5GXoTKKrA=;
 b=K+Dbpu88qivi5tHegANqHYQOgzBL4fS4585zyGDHuJ5LbW40Fbn1ipiWvHtcxu0yDr
 0R0ex34J/13CnaRxO76ey8jkeCZTfxVUhUVyfHqbD5W7lKYOPz18uUwgUOfkx9xnwCSm
 5OuAzbf9Vm+QscNqFAp5phdS1mMBA2G6rOyeLunRo5KB5IPcLIepedHCgCc8Wbyk1OX1
 SUHVIYeTTfbcbwsS+WJ+iBy5ly1U/clXyq03zUhGriqapG1OX5rx1I8Rh2DmawdDhfNC
 f1yVG7lg9KahhyhALD6oLZWaaFBbYF8EZFCHcNE+5VSaXne59/u1VUTqtwaP73p30neR
 ULag==
X-Gm-Message-State: ANhLgQ0iYKR3U25iKjwQ6RsHXy8lj+5AYi+RdtMEQx70kl4cibG8UV+z
 KUBNJK0/D7lBcFtiIeNiJUdbKA1EZTm3Iw==
X-Google-Smtp-Source: ADFU+vuqq1kHs/gSy1ZIgsAO5i92QnlB0HmaKGMg1k6aHODUVZln5lWutdExd6KIAXCb6mE0AWhzEg==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr5554501wrn.283.1584445245549; 
 Tue, 17 Mar 2020 04:40:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] hw/arm/fsl-imx6ul: Instantiate unimplemented pwm and can
 devices
Date: Tue, 17 Mar 2020 11:40:31 +0000
Message-Id: <20200317114039.26914-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
References: <20200317114039.26914-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

From: Guenter Roeck <linux@roeck-us.net>

Recent Linux kernels (post v4.20) crash due to accesses to flexcan
and pwm controllers. Instantiate as unimplemented devices to work
around the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200313014551.12554-4-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx6ul.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index c405b68d1dd..a0bcc6f8957 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -516,6 +516,20 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
      */
     create_unimplemented_device("sdma", FSL_IMX6UL_SDMA_ADDR, 0x4000);
 
+    /*
+     * PWM
+     */
+    create_unimplemented_device("pwm1", FSL_IMX6UL_PWM1_ADDR, 0x4000);
+    create_unimplemented_device("pwm2", FSL_IMX6UL_PWM2_ADDR, 0x4000);
+    create_unimplemented_device("pwm3", FSL_IMX6UL_PWM3_ADDR, 0x4000);
+    create_unimplemented_device("pwm4", FSL_IMX6UL_PWM4_ADDR, 0x4000);
+
+    /*
+     * CAN
+     */
+    create_unimplemented_device("can1", FSL_IMX6UL_CAN1_ADDR, 0x4000);
+    create_unimplemented_device("can2", FSL_IMX6UL_CAN2_ADDR, 0x4000);
+
     /*
      * APHB_DMA
      */
-- 
2.20.1



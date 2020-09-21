Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A513C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020F620874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTPbg0Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020F620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGoh-0003bF-4u
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgk-0004Vb-IQ; Mon, 21 Sep 2020 03:56:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKGgj-0005uK-0S; Mon, 21 Sep 2020 03:56:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id l9so11520510wme.3;
 Mon, 21 Sep 2020 00:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ic/xY7slvI0DSSOiTKsUuGtbaH5pAUlsTrPjkrl/0T0=;
 b=CTPbg0CaIHhrO745w+utHk53avcjYQmUHmWhcAYTCveL4v47a6pNMxrDyOXJY2mMxF
 w8HlBKT1cOqCeMWlICEdyvZeBf7A+YELf9QG2MnM0cd3KpENKrdm6pZ6+kLnQFEFjy22
 rYLazSdTmKXMqeTH9158BaOy9V8fi5pqbAOTQdfrbeHeaiKe5k7jVdphKeZb76Q3wD1t
 bFO7KyyyetbJiUzlKHnayS3vQ53yvJ45ZwnQa32XetvxSHfiTw2UpQl6uKh4bTW057qj
 hKOe1e+Tak+NRsc8FpUFE2qvyhDxFxyg/oMC7us7CpI83EZfhrL5NS4JQ2mw7neI8MeD
 DNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ic/xY7slvI0DSSOiTKsUuGtbaH5pAUlsTrPjkrl/0T0=;
 b=at6UCi0ljVHrLWWaedbbDYLO6tkjA0b/hkN8Ma/yWQeZ0Af0aETgmIsn8tA2x2x3xg
 DRjmfok4gKN7Hu9zSqyaX8Oi1TWqrPHwkwdjySR0xTaKWC9Rlyb8GO84mpj6r8Y+WOJt
 dff5UhoajPWaBLsmse82l6OV+7HxCmMFw+pZMwqgb3xZxvbQ72NZ2HP+JZYU5hJ9c8Yg
 RR8YFhaEuvlQoaVeEre85KK8vjrd0Mm0spGhTXUDviq3VWO7rnz4j+L1fFZrZ1YrXIbw
 bZ3XJLqFd9zgLI4FmbtdJMR4YtStNVaYguzLtjOp6SNzz2W4FJ0CaJDolN7nE6h4rxOu
 sEKw==
X-Gm-Message-State: AOAM53048IpHTiLHIqmpekHZAZYXPiBUGJPvn/MSFeA9P0cKJ7mNPRLQ
 oBQZEfJf3qb2DphcpsEwILu/JwgX8Sk=
X-Google-Smtp-Source: ABdhPJzRPSS51oC0+x3IGazpoPxGXl10TNsptbPoANOVjRBMThNJ9tiPtWrjMuB8nGq3BNhh+ogk3g==
X-Received: by 2002:a05:600c:414e:: with SMTP id
 h14mr28130346wmm.2.1600674996053; 
 Mon, 21 Sep 2020 00:56:36 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o15sm17807538wmh.29.2020.09.21.00.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 00:56:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] hw/arm/raspi: Use more specific machine names
Date: Mon, 21 Sep 2020 09:56:25 +0200
Message-Id: <20200921075628.466506-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921075628.466506-1-f4bug@amsat.org>
References: <20200921075628.466506-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we can instantiate different machines based on their
board_rev register value, we can have various raspi2 and raspi3.

In commit fc78a990ec103 we corrected the machine description.
Correct the machine names too. For backward compatibility, add
an alias to the previous generic name.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3000e6d57e6..3426521379e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -327,6 +327,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
 
+    mc->alias = "raspi2";
     rmc->board_rev = 0xa21041;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
@@ -337,6 +338,7 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
 
+    mc->alias = "raspi3";
     rmc->board_rev = 0xa02082;
     raspi_machine_class_common_init(mc, rmc->board_rev);
 };
@@ -344,12 +346,12 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi_machine_types[] = {
     {
-        .name           = MACHINE_TYPE_NAME("raspi2"),
+        .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
 #ifdef TARGET_AARCH64
     }, {
-        .name           = MACHINE_TYPE_NAME("raspi3"),
+        .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
 #endif
-- 
2.26.2



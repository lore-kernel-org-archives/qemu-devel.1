Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF014C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0324208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyheaOu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0324208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPHx-0006bt-Se
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxN-0005C4-K3
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxL-0005hs-P2
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id q15so32632012wmj.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iwlYqQU7+O2GzS7GEPMQGSoYyptCVeRYnaJi/QEQwvA=;
 b=UyheaOu2VW5fWM1ujPiYm3BL9/aNbs9/aGy5CsSdzkxnKPRe7VAcm01jY9/L7fV9B5
 5+8cAqp5ntoakgpGz50MNPz8d4zpTGgR2SsfiDIQ1pibE+pFzhJtIOQqJ7adkfY3KTX1
 RgQNnXojK7Q5qIAQH5pHw+Rk2vE5WXImfE90hLwlRw47mJMFtkMNamTTUUm9jvO0Dovn
 h3KgdoDqJrxWYOWDT7426vtlXYLujTFQMeRlutVTbMuh30bSbVd+lDDowh2RYD2SLylK
 OIf5OZRLHJKj0M2aKdai6CeDyrPfAdQo6HPhFZjgHcbqjdsWVrfp7rLLBkNdAEOv49Um
 ZLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iwlYqQU7+O2GzS7GEPMQGSoYyptCVeRYnaJi/QEQwvA=;
 b=XN/W2E7KfnS+izNo7w/NFtdAvlSOd4NdI3mFrgnVilo743jMycinqlUn/fskTamiuu
 FrFBn6ANVSAhveEh63Cural94/ydswblQIhaUlUqx38kbJyTqQf7EempBi9RhmjNOT29
 t+bV+hSjguD5KE3GBHfSwOnWhqEZSF1SdQwvaRwgjnrDgHnmn4n6ELITJs7kk11UveLH
 RcA/wh4v0dPKYC/1rl2Rairm4p2EwHJE+HYMCpj7+yyvHnyC3RgKzde0rdx1jUX6rlXI
 +dgAW9O/p9njd7MBjGZi4WHh2kiB6MRVoQU9bfAm2w9cKgSdbiI07RQ+YyXfZFT5fZ4A
 XQFQ==
X-Gm-Message-State: AOAM531CYGeaB3n+X9muKXURX2sQg6J8davEfNAPexUPCeh0YQ4jRQ4X
 JkYDS2oOVBJ1kNjwnWJAxLLcmUa+TYw2RQ==
X-Google-Smtp-Source: ABdhPJysB1+4wULg3zmtJafZcjkAE4Iu3U6JCeEn75lRKg+P07Xkf+i2WMnXALHJgN3oNXpku8kW8g==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr6375072wmj.152.1593795270034; 
 Fri, 03 Jul 2020 09:54:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/34] hw/arm/spitz: Keep pointers to scp0,
 scp1 in SpitzMachineState
Date: Fri,  3 Jul 2020 17:53:51 +0100
Message-Id: <20200703165405.17672-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Keep pointers to scp0, scp1 in SpitzMachineState, and just pass
that to spitz_scoop_gpio_setup().

(We'll want to use some of the other fields in SpitzMachineState
in that function in the next commit.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-5-peter.maydell@linaro.org
---
 hw/arm/spitz.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index f48e966c047..69bc2b3fa10 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -48,6 +48,8 @@ typedef struct {
     DeviceState *lcdtg;
     DeviceState *ads7846;
     DeviceState *max1111;
+    DeviceState *scp0;
+    DeviceState *scp1;
 } SpitzMachineState;
 
 #define TYPE_SPITZ_MACHINE "spitz-common"
@@ -845,22 +847,23 @@ static void spitz_out_switch(void *opaque, int line, int level)
 #define SPITZ_SCP2_BACKLIGHT_ON                 8
 #define SPITZ_SCP2_MIC_BIAS             9
 
-static void spitz_scoop_gpio_setup(PXA2xxState *cpu,
-                DeviceState *scp0, DeviceState *scp1)
+static void spitz_scoop_gpio_setup(SpitzMachineState *sms)
 {
-    qemu_irq *outsignals = qemu_allocate_irqs(spitz_out_switch, cpu, 8);
+    qemu_irq *outsignals = qemu_allocate_irqs(spitz_out_switch, sms->mpu, 8);
 
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_CHRG_ON, outsignals[0]);
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_JK_B, outsignals[1]);
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_LED_GREEN, outsignals[2]);
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_LED_ORANGE, outsignals[3]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_CHRG_ON, outsignals[0]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_JK_B, outsignals[1]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_GREEN, outsignals[2]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_LED_ORANGE, outsignals[3]);
 
-    if (scp1) {
-        qdev_connect_gpio_out(scp1, SPITZ_SCP2_BACKLIGHT_CONT, outsignals[4]);
-        qdev_connect_gpio_out(scp1, SPITZ_SCP2_BACKLIGHT_ON, outsignals[5]);
+    if (sms->scp1) {
+        qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_CONT,
+                              outsignals[4]);
+        qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_ON,
+                              outsignals[5]);
     }
 
-    qdev_connect_gpio_out(scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
+    qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
 }
 
 #define SPITZ_GPIO_HSYNC                22
@@ -943,7 +946,6 @@ static void spitz_common_init(MachineState *machine)
     SpitzMachineState *sms = SPITZ_MACHINE(machine);
     enum spitz_model_e model = smc->model;
     PXA2xxState *mpu;
-    DeviceState *scp0, *scp1 = NULL;
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *rom = g_new(MemoryRegion, 1);
 
@@ -962,12 +964,14 @@ static void spitz_common_init(MachineState *machine)
 
     spitz_ssp_attach(sms);
 
-    scp0 = sysbus_create_simple("scoop", 0x10800000, NULL);
+    sms->scp0 = sysbus_create_simple("scoop", 0x10800000, NULL);
     if (model != akita) {
-        scp1 = sysbus_create_simple("scoop", 0x08800040, NULL);
+        sms->scp1 = sysbus_create_simple("scoop", 0x08800040, NULL);
+    } else {
+        sms->scp1 = NULL;
     }
 
-    spitz_scoop_gpio_setup(mpu, scp0, scp1);
+    spitz_scoop_gpio_setup(sms);
 
     spitz_gpio_setup(mpu, (model == akita) ? 1 : 2);
 
-- 
2.20.1



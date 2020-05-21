Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5781C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7F6207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2rX4itS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7F6207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqpP-0005aM-Gw
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgH-0002do-DH
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:45472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgG-0000SC-9n
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:37 -0400
Received: by mail-wr1-x431.google.com with SMTP id c3so3527754wru.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2Mka/5Sz7nZUUrfy7Vlrx4tkhq1CXZaUSp5RTGkdVVc=;
 b=v2rX4itSwOvP7xr52jl0n0Z6/9me89mqWHmKmhhjgolAywV/5D1wHBJz5IBmULUzio
 YNqN3DoBMYjSdAL/bF3vBeXam5lzVGIY7UVz5h9dgF9EaMwatgx99nYgABxGQglGd0a5
 ci4MDdu0ol+q0LLG7QUGO+cDQ+l/sSH5avW82HLTJ0o7LidSSn6mrq7WHPEpkw+V7Ys5
 E2TQBNapWxMVvopF5HWy5LUfjH9RUAp6iCCcBXY5/HpDZ3MxPmaQ9noVHAeFcD4XR9eG
 GfQowiEnPxbMIf6X0hljk4SJ83V3dQfuzwpY3Zsuy1+hwysvjVVbuWTM6q6nDB4PYaea
 UMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2Mka/5Sz7nZUUrfy7Vlrx4tkhq1CXZaUSp5RTGkdVVc=;
 b=lVHfGnrdB7KDQR5xBZ4uSE4HzoPRGgwOOanxUeszlNYttLncyr1Sed4ldOXEnqpr52
 6+tCRXpTCrEOloRsKGKNBIqOfrPQ70syPO+Jhw4EpHgiXRhhxLgnZtEyFoqtz311yNex
 pUBvCmmDxBzyPIAGprOADeJ01jpYH8Dw2+YRmooovZLHI8GXX4Ynmsx1maY9tineNdeC
 AM9ACvyrWNkCvKszunaPtSRYpAR5worPSWzOa+3eHK2SB5J5ZQtjyZqtCxvC/kJD1gNY
 9SGQKqTcsFw7HJJ8OE6c4uezoTsJ90Gveh7wQH9AHsombYANGRgmPROO9bJIseAVQGuj
 AmUA==
X-Gm-Message-State: AOAM532nI3fx0eYyTiCDkc71+I0XuoKz2xxwTVJ8iawDw6L4Wh7vCll7
 MebHVVxekjRbtCr5lyS14qgTOePn1xypjg==
X-Google-Smtp-Source: ABdhPJylkyyiGmqQgaS9mAYsz7c4CfCrE3EbCRBuPQLAiGogv2SISXQD3O2MmlmdGHZ6E/SXE01O5w==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr104163wrd.394.1590088594568; 
 Thu, 21 May 2020 12:16:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/29] hw/arm/fsl-imx7: Instantiate various unimplemented
 devices
Date: Thu, 21 May 2020 20:15:59 +0100
Message-Id: <20200521191610.10941-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Guenter Roeck <linux@roeck-us.net>

Instantiating PWM, CAN, CAAM, and OCOTP devices is necessary to avoid
crashes when booting mainline Linux.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200517162135.110364-8-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx7.h | 16 ++++++++++++++++
 hw/arm/fsl-imx7.c         | 24 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 3a0041c4c26..47826da2b7e 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -113,6 +113,9 @@ enum FslIMX7MemoryMap {
     FSL_IMX7_IOMUXC_GPR_ADDR      = 0x30340000,
     FSL_IMX7_IOMUXCn_SIZE         = 0x1000,
 
+    FSL_IMX7_OCOTP_ADDR           = 0x30350000,
+    FSL_IMX7_OCOTP_SIZE           = 0x10000,
+
     FSL_IMX7_ANALOG_ADDR          = 0x30360000,
     FSL_IMX7_SNVS_ADDR            = 0x30370000,
     FSL_IMX7_CCM_ADDR             = 0x30380000,
@@ -124,11 +127,24 @@ enum FslIMX7MemoryMap {
     FSL_IMX7_ADC2_ADDR            = 0x30620000,
     FSL_IMX7_ADCn_SIZE            = 0x1000,
 
+    FSL_IMX7_PWM1_ADDR            = 0x30660000,
+    FSL_IMX7_PWM2_ADDR            = 0x30670000,
+    FSL_IMX7_PWM3_ADDR            = 0x30680000,
+    FSL_IMX7_PWM4_ADDR            = 0x30690000,
+    FSL_IMX7_PWMn_SIZE            = 0x10000,
+
     FSL_IMX7_PCIE_PHY_ADDR        = 0x306D0000,
     FSL_IMX7_PCIE_PHY_SIZE        = 0x10000,
 
     FSL_IMX7_GPC_ADDR             = 0x303A0000,
 
+    FSL_IMX7_CAAM_ADDR            = 0x30900000,
+    FSL_IMX7_CAAM_SIZE            = 0x40000,
+
+    FSL_IMX7_CAN1_ADDR            = 0x30A00000,
+    FSL_IMX7_CAN2_ADDR            = 0x30A10000,
+    FSL_IMX7_CANn_SIZE            = 0x10000,
+
     FSL_IMX7_I2C1_ADDR            = 0x30A20000,
     FSL_IMX7_I2C2_ADDR            = 0x30A30000,
     FSL_IMX7_I2C3_ADDR            = 0x30A40000,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 119b281a500..d6cf7c48ce8 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -459,6 +459,30 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      */
     create_unimplemented_device("sdma", FSL_IMX7_SDMA_ADDR, FSL_IMX7_SDMA_SIZE);
 
+    /*
+     * CAAM
+     */
+    create_unimplemented_device("caam", FSL_IMX7_CAAM_ADDR, FSL_IMX7_CAAM_SIZE);
+
+    /*
+     * PWM
+     */
+    create_unimplemented_device("pwm1", FSL_IMX7_PWM1_ADDR, FSL_IMX7_PWMn_SIZE);
+    create_unimplemented_device("pwm2", FSL_IMX7_PWM2_ADDR, FSL_IMX7_PWMn_SIZE);
+    create_unimplemented_device("pwm3", FSL_IMX7_PWM3_ADDR, FSL_IMX7_PWMn_SIZE);
+    create_unimplemented_device("pwm4", FSL_IMX7_PWM4_ADDR, FSL_IMX7_PWMn_SIZE);
+
+    /*
+     * CAN
+     */
+    create_unimplemented_device("can1", FSL_IMX7_CAN1_ADDR, FSL_IMX7_CANn_SIZE);
+    create_unimplemented_device("can2", FSL_IMX7_CAN2_ADDR, FSL_IMX7_CANn_SIZE);
+
+    /*
+     * OCOTP
+     */
+    create_unimplemented_device("ocotp", FSL_IMX7_OCOTP_ADDR,
+                                FSL_IMX7_OCOTP_SIZE);
 
     object_property_set_bool(OBJECT(&s->gpr), true, "realized",
                              &error_abort);
-- 
2.20.1



Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4851C1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554EA206F9
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 21:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrZilAhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554EA206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG86v-0002Yv-9D
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 17:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jG80S-0002v6-6q
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jG80Q-0002mk-BY
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 17:19:39 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jG80Q-0002m2-63; Sun, 22 Mar 2020 17:19:38 -0400
Received: by mail-pg1-x543.google.com with SMTP id u12so6092618pgb.10;
 Sun, 22 Mar 2020 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8hrUyZuUOd4fuzydcZbAphAtvryaQ5y5r6qpUUi+dwg=;
 b=SrZilAhJXD8X7npbDGQ1EiuoT7zM7wT05/FhTM02+MwlmnnHhFlnk52IXR4DsjuaOC
 YG55A1HbUq6Z2eTXG0lFUWM+lxQnqwiui1DaIafQIPq6eIM9+06KtSgGVbA2r24GBGf2
 Y+8oRFeiaERtmxI4Ybomkct51hKg5jciV/JLx0jEwRJHkBep2OUxkAgdt8TdfJDGyCs1
 E41sn4FW63U94yKlUg8xeXW6vUxFbmkuPhwRhI8HAXdXOHZhP/u4AS22qPoLdQXvFXfB
 OirzIxcYA3u0VL3RGInxK+lK501+9VziODkZrCvx+udbSsYTaADCGNhf+u66yyUqQgrW
 3E4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=8hrUyZuUOd4fuzydcZbAphAtvryaQ5y5r6qpUUi+dwg=;
 b=Lb0mFP3KaZ5bHLhxG3l1PstAeN6vp1ZeFxBcH/I3ZPfTIjnKQSVaUes7Mbcpp9lPeE
 Kp2zBnNDFFClkJHP3PIpqVRg2h6Q2zqj0UGHU63DPt0v6JjIYM0Y4vtkq6L2ie7Tlqwl
 jqJYGBoAfgbxQlwAoQRU87Lo8MNqcBTbGAUBndv/e/c65TXyfEFs0UFNkf4FCyMVfVIi
 /tSM91b720Movohw1IKF1Kau8FvU33k5FZLhv+DuhTKTKMhGSXcn6Y3c+Swc8v+Gn9g+
 fytnX3cu2vedv4RwiSPf4hC5M6USFWY9MxPflZf6RNFqxeJB7tZhtY/FHYy+Ltp/mSJ8
 +ukg==
X-Gm-Message-State: ANhLgQ0eXDlZehTA1JSIRZ132kB7pXpY2FHvrooWCvp+VgsI9HIWSuUy
 LY9PMtHNSIms6nHdLeIev6o=
X-Google-Smtp-Source: ADFU+vtlmVaDBjd0xd2Q98nD37VgjUZJyuukWL2tSHReHUHT6j+rMSN2qM700hKmir9bS+AqpBZ0Ig==
X-Received: by 2002:a62:7d11:: with SMTP id y17mr20723291pfc.127.1584911976552; 
 Sun, 22 Mar 2020 14:19:36 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 64sm11493454pfd.48.2020.03.22.14.19.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 22 Mar 2020 14:19:36 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 7/8] hw/arm/fsl-imx7: Instantiate various unimplemented
 devices
Date: Sun, 22 Mar 2020 14:19:18 -0700
Message-Id: <20200322211919.11335-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322211919.11335-1-linux@roeck-us.net>
References: <20200322211919.11335-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instantiating PWM, CAN, CAAM, and OCOTP devices is necessary to avoid
crashes when booting mainline Linux.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: "octop" -> "ocotp"

 hw/arm/fsl-imx7.c         | 24 ++++++++++++++++++++++++
 include/hw/arm/fsl-imx7.h | 16 ++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 119b281a50..d6cf7c48ce 100644
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
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 3a0041c4c2..47826da2b7 100644
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
-- 
2.17.1



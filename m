Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D4C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2D220809
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1iI/dXh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2D220809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaM3s-0007qz-Uf
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2z-0006Aj-3F
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:53 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2y-0006lA-Bd
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:52 -0400
Received: by mail-pg1-x541.google.com with SMTP id j21so3574793pgb.7
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pQedwNUBknL/+lF1H+EDj57MsYWnhoTYuAbD05sgY70=;
 b=t1iI/dXhi2FXCmXj0FwnBlks3h67LzF13FUfzdbZG0qrzZhmkydhUxOd4IkjFfTfKZ
 Ct4CzKOXKfou5jh8NwDYH9/SIs3VH+vTr0ThOZppNj312P2Cf4C3eAb8MqaQU4ynSuVj
 Wfqsr6yqzzEWsJRH3eX7m70kGOIvMSA4GGtFp5a5k3D6lU8hRqvRJA68Y2Si5tNGoA6Y
 qlFT/mjtohyxzWGY5hDAGBOCEmqlDEekEfWH/SZY7AjtAOJxtXqGXFC+nxggyy4S9Uyn
 MI0sufbSHZtJNpc08VEo4FRFNug7xdtQzTgmbi7D65uE8OUmW3jQwOTIe3QljdmQhkrY
 Z8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=pQedwNUBknL/+lF1H+EDj57MsYWnhoTYuAbD05sgY70=;
 b=D2PVCYuqDmvLcnTvgpXefFKzUUuW+Lea3DsrbkeRZOPGrhc+j9t+OhCP81qOgJ5VqA
 XkW7sOoVSR9YeI/oDfxMgKyiYrgaGtH6dXfoenQCxfnfP+TGFRAKvEErfILfcSh3aKVJ
 TCz2Dnd3hoSgka4JrZKlTFgiRZ0pPuXEVle3WclXStTX0an4LrywElrOUQQFdZOiTEqJ
 ch3AZFPNKF+3OFq33p76DZYDBCJSQfM5Vry6/R2tvies9q8Gh6bBAdiE80DvvxOKTwk4
 C/J2KCSHDk5KzxBwXQmu1aMiV1n5T1BbZ0XXzi4nFKSWLQBijvFV7bPCEBZ2eLu2/RpE
 AtvA==
X-Gm-Message-State: AOAM533MxREA2xLpQpDP6NE0zQOyetEI+w3+1xKmbKLb8tdYGlELBO5y
 IaLdJP5gf9ZSmXK3092T7q8=
X-Google-Smtp-Source: ABdhPJzDlv/pgAaWVE/kzuTaT3BcMXCCPA2dOhEDgnjQQG1MQbfYqnd6/nb3Hc+CFhwfYGpSJ7J1nw==
X-Received: by 2002:aa7:92cc:: with SMTP id k12mr12467974pfa.184.1589732511143; 
 Sun, 17 May 2020 09:21:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id k13sm3980827pfd.14.2020.05.17.09.21.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 May 2020 09:21:50 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 7/8] hw/arm/fsl-imx7: Instantiate various unimplemented
 devices
Date: Sun, 17 May 2020 09:21:34 -0700
Message-Id: <20200517162135.110364-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517162135.110364-1-linux@roeck-us.net>
References: <20200517162135.110364-1-linux@roeck-us.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instantiating PWM, CAN, CAAM, and OCOTP devices is necessary to avoid
crashes when booting mainline Linux.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Added Peter's Reviewed-by: tag
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



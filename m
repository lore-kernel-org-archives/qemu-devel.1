Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A47C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890DE207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pXFjLFj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890DE207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqq9-0008Co-MX
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgE-0002WI-6V
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:34 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37999)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgD-0000Rl-1L
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:33 -0400
Received: by mail-wm1-x342.google.com with SMTP id u12so2757945wmd.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=g6opxpyblY3BJiC2qRIQdxGctvh0Y/Yc1moA3MhazYA=;
 b=pXFjLFj+QRe9uCKoLKExzRLAghoVCGMjOt+VM8zeOuRblvfr4YNweihnj3K1DNqQ4o
 /7NWSh7K7Jo7PNXc8CLIlepWmFCElAcS7djDZc0ArhCMSjVD4A1CAKm3Pudle6Iqw+V6
 nyddkDZaT2pu262LV1ACI6JlGUSKvXcbAv8nomf+T0zHx+172FXAjXc6CQDW6z1GyDDC
 seR6wO6BpU8KdNLoQahsUGYdLdhGDCI6wmhNiCqnS4V96MTS04f4/idHmuju3zoYsZMf
 X9FVoF0uEyFIaSwnA7ms531SZNXiYxNbCEPIGIZtO68IlfIggYzRcrytTbdnMMvHAzzf
 4Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g6opxpyblY3BJiC2qRIQdxGctvh0Y/Yc1moA3MhazYA=;
 b=SRSWnDDe6lb/UOjAtpHEa/6bn5sf7ku6IRFB5PRWN7MClua1s3l6ebKqi34VELPg35
 pAAUn6+IHqB3BotWoKynaqtU7QzrxRTyRiaNwj4B2SKl/iwa9BzUrpx0A2z9KmbPqTlR
 fj3xZkuXlm1MNeTE6dCsz8F8kaiJYHAOZu1qg95wogh4VlkEoaTRvA5vzsM1YnzAU5t9
 8ARHf2UXOJhyDIheZTUcJcPGshaLnBiwCIsscXtdJEUpyUVcPkO9CfmIXWE92CMIKeGr
 WHQoZih9GeMeQq/VpyGZFDo59HnpLLjgnp1/91m+iIUEWvC1qB+ZrhoLAIyIo5PV07FD
 tLHw==
X-Gm-Message-State: AOAM533znRQhW1YIS5fmpnNApGucM/9yJ7re33Tp2+B2ZVRXSqHGOenx
 Qk/HrMmLKCA+exfOXVd4VmDJLmyY0T/BTQ==
X-Google-Smtp-Source: ABdhPJxJLJ0PMiddTLUJHYpY6U/695lNDbgKseCBAIoxTu4xQWy26FjzOILP7T4MCGMeCY0kp/H7Mw==
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr9825172wma.157.1590088591206; 
 Thu, 21 May 2020 12:16:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/29] hw/arm/fsl-imx31: Wire up watchdog
Date: Thu, 21 May 2020 20:15:56 +0100
Message-Id: <20200521191610.10941-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

With this patch, the watchdog on i.MX31 emulations is fully operational.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200517162135.110364-5-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx31.h | 4 ++++
 hw/arm/fsl-imx31.c         | 6 ++++++
 hw/arm/Kconfig             | 1 +
 3 files changed, 11 insertions(+)

diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index ac5ca9826a4..dd8561b3098 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -25,6 +25,7 @@
 #include "hw/timer/imx_epit.h"
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "exec/memory.h"
 #include "target/arm/cpu.h"
 
@@ -49,6 +50,7 @@ typedef struct FslIMX31State {
     IMXEPITState   epit[FSL_IMX31_NUM_EPITS];
     IMXI2CState    i2c[FSL_IMX31_NUM_I2CS];
     IMXGPIOState   gpio[FSL_IMX31_NUM_GPIOS];
+    IMX2WdtState   wdt;
     MemoryRegion   secure_rom;
     MemoryRegion   rom;
     MemoryRegion   iram;
@@ -87,6 +89,8 @@ typedef struct FslIMX31State {
 #define FSL_IMX31_GPIO1_SIZE            0x4000
 #define FSL_IMX31_GPIO2_ADDR            0x53FD0000
 #define FSL_IMX31_GPIO2_SIZE            0x4000
+#define FSL_IMX31_WDT_ADDR              0x53FDC000
+#define FSL_IMX31_WDT_SIZE              0x4000
 #define FSL_IMX31_AVIC_ADDR             0x68000000
 #define FSL_IMX31_AVIC_SIZE             0x100
 #define FSL_IMX31_SDRAM0_ADDR           0x80000000
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 8472d2e9111..1e7959863dd 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -63,6 +63,8 @@ static void fsl_imx31_init(Object *obj)
         sysbus_init_child_obj(obj, "gpio[*]", &s->gpio[i], sizeof(s->gpio[i]),
                               TYPE_IMX_GPIO);
     }
+
+    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt), TYPE_IMX2_WDT);
 }
 
 static void fsl_imx31_realize(DeviceState *dev, Error **errp)
@@ -205,6 +207,10 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                             gpio_table[i].irq));
     }
 
+    /* Watchdog */
+    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX31_WDT_ADDR);
+
     /* On a real system, the first 16k is a `secure boot rom' */
     memory_region_init_rom(&s->secure_rom, OBJECT(dev), "imx31.secure_rom",
                            FSL_IMX31_SECURE_ROM_SIZE, &err);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8a5eb140f59..9afa6eee799 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -367,6 +367,7 @@ config FSL_IMX31
     select SERIAL
     select IMX
     select IMX_I2C
+    select WDT_IMX2
     select LAN9118
 
 config FSL_IMX6
-- 
2.20.1



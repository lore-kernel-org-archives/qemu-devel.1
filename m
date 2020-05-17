Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BDEC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9372E2070A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oA/Vd15f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9372E2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaM3p-0007hB-FY
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2u-00064D-1E
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:48 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2t-0006kc-3f
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:47 -0400
Received: by mail-pf1-x443.google.com with SMTP id y198so2105179pfb.4
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JRQ52zM2NnpaXcf+LK51XyGqjmB9A212C485J5vFewc=;
 b=oA/Vd15fbDbj0vCe8mvgAa61jmml2MYP0dy9sR7mm/amEIOk82hQgz5yXaSN8d2V29
 TutQuv12qS8YH1AncEEc2Lid9MNspQBPP6+EboRGaZJkvdYG6bTdrSA3/qRMG7kRUVoy
 jRcAbbl4SArcFbibAGngDJiIhyCITJ3a2eUsSb7ONJ9Zav89I/iCPbZ2qxYc13FyOA/D
 so6j+qag3oxZ2tu4Y4VTqcjenwPB/qbHOmn2UmmpsePhDzD32bNin1/pw0u9qP3jGLZP
 /6YXiOKwOOlF1u+oQED209MjeJ2ZaS6n3E3w1q2Rg+ZfW+iYC3Vwy+K2CaNYlxTJzknO
 VM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JRQ52zM2NnpaXcf+LK51XyGqjmB9A212C485J5vFewc=;
 b=fpibV+n8ccyuLelGrUHAfEva1XnoUyJm0/IvGpm9pknOfuSORDqjisAeVamQWO8sq2
 mQ+ceVz96DP8cdYu0XPVIsQoher7q/O6DHpjodRv+aZr5VBnHJ78C+FnCbHGobqmpqBa
 /hGNkKYh8Htgmk00xtLfj85kovrf7qG0sSriLUipFuPW6vTqfFZkguVs6WWLTOsVKv0S
 wRNJ6VXW8kxgZI5rX60Xfy0n5jSdFFVDxCpkB6S8gWidOh+FFT2/dSF3iV5AKOE2J6Ff
 IxuEETpk2VvS96HOLkFkdIhIjCUf4uI80U47XR28i2wlcGlhfByuBxsS4ZRCJPM7c6ZL
 8g3Q==
X-Gm-Message-State: AOAM531SWEwNEmFlkKjlSJJId9i9FYN3xGqQL8yDdoiYMleDsG8eutmv
 NI5fEyuexTOqOYZvBsTOpAk=
X-Google-Smtp-Source: ABdhPJwn8Uf+O78M9ie/qrVv+EGmiCeKzTwm6i0LW/8shaMplRs6jBPbXo/DNLRNwv0scOpnTG7qVA==
X-Received: by 2002:aa7:8dc1:: with SMTP id j1mr13209200pfr.285.1589732505951; 
 Sun, 17 May 2020 09:21:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id q25sm6553653pfh.94.2020.05.17.09.21.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 May 2020 09:21:45 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 3/8] hw/arm/fsl-imx25: Wire up watchdog
Date: Sun, 17 May 2020 09:21:30 -0700
Message-Id: <20200517162135.110364-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517162135.110364-1-linux@roeck-us.net>
References: <20200517162135.110364-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x443.google.com
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

With this commit, the watchdog on imx25-pdk is fully operational,
including pretimeout support.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: No change
v2: Select WDT_IMX2 explicitly
    Added Philippe's Reviewed-by: tag

 hw/arm/Kconfig             |  1 +
 hw/arm/fsl-imx25.c         | 10 ++++++++++
 include/hw/arm/fsl-imx25.h |  5 +++++
 3 files changed, 16 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index adf401e827..54a49aeabd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -358,6 +358,7 @@ config FSL_IMX25
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select WDT_IMX2
     select DS1338
 
 config FSL_IMX31
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 6f1a82ce3d..cdaa79c26b 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -87,6 +87,7 @@ static void fsl_imx25_init(Object *obj)
                               TYPE_CHIPIDEA);
     }
 
+    sysbus_init_child_obj(obj, "wdt", &s->wdt, sizeof(s->wdt), TYPE_IMX2_WDT);
 }
 
 static void fsl_imx25_realize(DeviceState *dev, Error **errp)
@@ -302,6 +303,15 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                             usb_table[i].irq));
     }
 
+    /* Watchdog */
+    object_property_set_bool(OBJECT(&s->wdt), true, "pretimeout-support",
+                             &error_abort);
+    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX25_WDT_ADDR);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt), 0,
+                                      qdev_get_gpio_in(DEVICE(&s->avic),
+                                                       FSL_IMX25_WDT_IRQ));
+
     /* initialize 2 x 16 KB ROM */
     memory_region_init_rom(&s->rom[0], OBJECT(dev), "imx25.rom0",
                            FSL_IMX25_ROM0_SIZE, &err);
diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 5e196bbf05..9e228dacea 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -29,6 +29,7 @@
 #include "hw/gpio/imx_gpio.h"
 #include "hw/sd/sdhci.h"
 #include "hw/usb/chipidea.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "exec/memory.h"
 #include "target/arm/cpu.h"
 
@@ -60,6 +61,7 @@ typedef struct FslIMX25State {
     IMXGPIOState   gpio[FSL_IMX25_NUM_GPIOS];
     SDHCIState     esdhc[FSL_IMX25_NUM_ESDHCS];
     ChipideaState  usb[FSL_IMX25_NUM_USBS];
+    IMX2WdtState   wdt;
     MemoryRegion   rom[2];
     MemoryRegion   iram;
     MemoryRegion   iram_alias;
@@ -229,6 +231,8 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_GPIO1_SIZE    0x4000
 #define FSL_IMX25_GPIO2_ADDR    0x53FD0000
 #define FSL_IMX25_GPIO2_SIZE    0x4000
+#define FSL_IMX25_WDT_ADDR      0x53FDC000
+#define FSL_IMX25_WDT_SIZE      0x4000
 #define FSL_IMX25_USB1_ADDR     0x53FF4000
 #define FSL_IMX25_USB1_SIZE     0x0200
 #define FSL_IMX25_USB2_ADDR     0x53FF4400
@@ -268,5 +272,6 @@ typedef struct FslIMX25State {
 #define FSL_IMX25_ESDHC2_IRQ    8
 #define FSL_IMX25_USB1_IRQ      37
 #define FSL_IMX25_USB2_IRQ      35
+#define FSL_IMX25_WDT_IRQ       55
 
 #endif /* FSL_IMX25_H */
-- 
2.17.1



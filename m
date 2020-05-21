Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32112C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065F120826
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xg8AZVIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065F120826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbql9-0003iC-7d
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgD-0002TU-44
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgB-0000Rc-VG
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id l11so7810533wru.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+hbGBZsc8AF+X3waDnF16DXho47LwjO3DYv4rpJ8Ce8=;
 b=xg8AZVIs+o4OLrkktftOCo313ZSmdaO9FCHixpqR+jSPkIgh3ckslVAyJyNXrNGHJR
 8aRKof89O55LGXV2ew7tAoPbZ9z+OvfsMrqS/ZYWoORFsXpVLWZdgCS0hm+JOhVLS2/R
 xI6nDK0yH3v6QLG4CuqDkQbQ4Rem1ffZyE0snyZWcbWa68PxvoA3Iarw7a/JNyTzpKgb
 TS6uoLtjy/DiEkZjw4LRSqEefq76U7zuL+qey7sOh/v2lTViaaTy9Dujwygf0lvDpmRz
 tBHNNyfL0EPhI++m/Da5f+IlUV/PHhu7QpMvws0gceKbA5Jruc5h2+wjfv4O1SR7+5Et
 hJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+hbGBZsc8AF+X3waDnF16DXho47LwjO3DYv4rpJ8Ce8=;
 b=l7DKcMllhUIpz6zl6mersHvyFUGnh4cRxX9pnniyBMRrnvBxtJi7Zh5nOeQ9tT3Opz
 vrY67GBYke0vL8D7RuAmBojkua7XO7bf3IGSf+AbbFmpDgJTt6j8SaFt84uucDcTRYIV
 icsgKoBi7RNrWlgzM0Au7KXSiZEI0mp6M1LoiEJyBfcVEzCTIOtFGv7sN30n2lZg6giB
 5TQG07qUDAmy4PBLw0ussFiFxsQU7Ce4J7zwCyq7dnyvDQud2qpig3QeLloXZJxRGd8+
 AUa+gUOMN0iEA1U7fvESHMm1WvCZyPJDo0HO/lgheGB/RgNjE71D5xbZde8uYNyBiee5
 zpcA==
X-Gm-Message-State: AOAM533pFVAYy/iTMTxrEdGzoejep5cO5DJDZv24rcNXw3RmPLPU8/a7
 A+o0hwISqYqf1TtDTv9m0QjHDJWZKs4G7g==
X-Google-Smtp-Source: ABdhPJy1+1SY8wRwUo5QnexxzzB34QT1pYIjhbJVRncnpkYoOy750pMFNE0pm83mOJIMPr3i33KWHw==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr88187wrq.121.1590088590028;
 Thu, 21 May 2020 12:16:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/29] hw/arm/fsl-imx25: Wire up watchdog
Date: Thu, 21 May 2020 20:15:55 +0100
Message-Id: <20200521191610.10941-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

With this commit, the watchdog on imx25-pdk is fully operational,
including pretimeout support.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200517162135.110364-4-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx25.h |  5 +++++
 hw/arm/fsl-imx25.c         | 10 ++++++++++
 hw/arm/Kconfig             |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index 5e196bbf059..9e228daceae 100644
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
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 6f1a82ce3db..cdaa79c26bd 100644
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
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d05dc8538c..8a5eb140f59 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -359,6 +359,7 @@ config FSL_IMX25
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select WDT_IMX2
     select DS1338
 
 config FSL_IMX31
-- 
2.20.1



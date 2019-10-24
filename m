Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B98CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1083520659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gh2UpAr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1083520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgkg-0001ZC-IX
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyN-0008Ne-58
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyK-00015C-SC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyK-00014x-M6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id z11so3426695wro.11
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rFFq99KjNRPKwCumrUa38nTH8zpDsdg+udhpyP1ndZA=;
 b=gh2UpAr1dKcujn0ivGmq8cOE6z5VChPo4Q0f121SMOuchWjp1XxF13nJpA1ml4LEMz
 MY4kCmiUUaL8wlX6RUH3Y3gJEPTlDM7mQ9hGYM2eO5Rt2vn+ATX0asQogy5wZKFB7Poi
 1I5VxTMg+MqEPEmU3UHGSehGWBH7k2ZAD5i5SEwEMIYUOA8MQk0nyVhb9Y4Ax7BhP1Vx
 mTKehyfkTC/7rGoJGgEhL1ZUMCMQ2BxPISzDi+pp+ATg0Srzytc9p6kXe3r3I3mY+7F1
 ieb9iZKlJrQl4V1TsKkpKr1mZ6KGF5Kof/791g9L86Spo48k3ZyfxWWQF7xpB6+Ajg2X
 vr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rFFq99KjNRPKwCumrUa38nTH8zpDsdg+udhpyP1ndZA=;
 b=XW+natUmbPzYoizH3E9cGmsdNF8dpjhtFe2ju0HGR+ErIzMdaAFxmcyVaJZhSQQ3k/
 3s5LMbXr/jkMyXFG31JeSRqWyF72jUPLiwrr1qHIF28j72LuF9kRMpwzPDWsIZ/Qo4Xg
 OxlhIW/5tFoWgecy4B4OnAXxpRL0v2YY+FfrycGLojYeWK/Cz6AS3pRcBTFHuwTDx8bj
 EJl+JdUO3Zo6ufGTIER/tJmWhX4OKAgzD31dN7hMUOIKL/xWBlBfACtR5dRAfBk1dCT/
 HZ3fh5wQJUs3lAykBtHRN6tYoCvm5PR/ucmuqTpXAYfTHiGDIPDmgYUCRhCe/TlfN9+1
 u1bg==
X-Gm-Message-State: APjAAAWr9ra35A/6af9LQuh4eT8y73iwbCjQzMerqeNjUCPDkQFj578m
 ZEmsGj2hMG6sLBPf46PgPQYrNVYFL8M=
X-Google-Smtp-Source: APXvYqz3fjWED6wXjAzRNtRQnQpyeYa62gT4qVkvaBezR59gGgPrulRiriIpjVql5k31As1LiDfcVw==
X-Received: by 2002:a5d:6a03:: with SMTP id m3mr4390417wru.90.1571934503453;
 Thu, 24 Oct 2019 09:28:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/51] hw/arm/bcm2835_peripherals: Use the thermal sensor block
Date: Thu, 24 Oct 2019 17:27:18 +0100
Message-Id: <20191024162724.31675-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Map the thermal sensor in the BCM2835 block.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20191019234715.25750-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h |  2 ++
 include/hw/arm/raspi_platform.h      |  1 +
 hw/arm/bcm2835_peripherals.c         | 13 +++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 62a4c7b559d..be7ad9b4991 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -20,6 +20,7 @@
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_rng.h"
 #include "hw/misc/bcm2835_mbox.h"
+#include "hw/misc/bcm2835_thermal.h"
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
@@ -53,6 +54,7 @@ typedef struct BCM2835PeripheralState {
     SDHCIState sdhci;
     BCM2835SDHostState sdhost;
     BCM2835GpioState gpio;
+    Bcm2835ThermalState thermal;
     UnimplementedDeviceState i2s;
     UnimplementedDeviceState spi[1];
     UnimplementedDeviceState i2c[3];
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index cdcbca943fb..61b04a1bd4a 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -48,6 +48,7 @@
 #define SPI0_OFFSET             0x204000
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
 #define OTP_OFFSET              0x20f000
+#define THERMAL_OFFSET          0x212000
 #define BSC_SL_OFFSET           0x214000 /* SPI slave */
 #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
 #define EMMC1_OFFSET            0x300000
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index fdcf616c56a..70bf927a025 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -111,6 +111,10 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
 
+    /* Thermal */
+    sysbus_init_child_obj(obj, "thermal", &s->thermal, sizeof(s->thermal),
+                          TYPE_BCM2835_THERMAL);
+
     /* GPIO */
     sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
                           TYPE_BCM2835_GPIO);
@@ -321,6 +325,15 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                                   INTERRUPT_DMA0 + n));
     }
 
+    /* THERMAL */
+    object_property_set_bool(OBJECT(&s->thermal), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(&s->peri_mr, THERMAL_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
+
     /* GPIO */
     object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
     if (err) {
-- 
2.20.1



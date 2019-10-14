Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064AFECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C665A21835
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7fAjvDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C665A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3s7-0004nK-NM
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2r4-0005j5-7z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2r1-0008Ln-4H
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:53 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:43769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2r0-0008KZ-Qp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:51 -0400
Received: by mail-wr1-x429.google.com with SMTP id j18so20372995wrq.10
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UraMZutU1VvKULhAxA6XaJqHAyKCSSxGQ8DBYDAxU98=;
 b=W7fAjvDw5a59pjKmCUZajLiwM+sEP+VROJbIH5cO20crzM6FG7DXmVAg9j/DH0hO4D
 7XasxdqHRYMQN3t4vwWnupSS3B+8j30bilA9ShFx8JjnMsq9fqSfRGg6auJaq/J0FuVC
 /IK5LzjNU3u6gxZ4MhYup0PPhohWdRKMJTrH94nOicSwFGEF/sewCIgjP1LpQ+JHGMYp
 C4OBEtfka26bvuAMgAIEwg8t3U38r4m3pLY3grrCmiBQAqnPYMzBTWtupTg5hVPnuypY
 2afyU81ARlTuHLtfGmFhmkyANS7BJGP9X4ybVjzb7D3oAj+V0o200X5tI87HdjoQACGS
 tG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UraMZutU1VvKULhAxA6XaJqHAyKCSSxGQ8DBYDAxU98=;
 b=o89i43ZZGx/rc3/2nNUWekMDuuAJPJb/fK7uoGZ9v+jbH4MZ3jvg7eoVy7Ervt83P9
 IAxVDN0jB0pzdN3YxbikHt9AQGUFOeNFBJT8l8FRVfcQ5eZ1FtpKchF5epVJSfsAbnsK
 TyyJQLFQmDfq0V1AhdadB6FIy5gcwSx0O4rPWzZdKNnS4f6OhPC/RnMqGqYJ6FcTI8ma
 ZXeU5wuFOR85I3pxaUuYRVDQbsD0b8Q4WGbqMGSOydAUEIN8b/B41siLrDDTxw5dwtq+
 Haw8PpUx9dVzQwt6J4D7u5g+TyWmRfDmL0n60eXDrtyF5v5RAPC59PUcxxPWNcTlMWhC
 YveQ==
X-Gm-Message-State: APjAAAXkEx1USwC4X2xc9FCTWvXK3PSQ4WJIz1MDEoK/Kme2A4brQRe5
 GkYvY0E+FFmEwNgncgDxmt4dE+jELQM7fA==
X-Google-Smtp-Source: APXvYqwW2dMN1WAKDEEJ5yDKUjXgOq/zsrJ7L8KQriFmeK6UmMKQ4PaAr0qJ7vYEio02HyB7WskRwg==
X-Received: by 2002:adf:de85:: with SMTP id w5mr25899176wrl.278.1571069149430; 
 Mon, 14 Oct 2019 09:05:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/68] hw/arm/bcm2835: Add various unimplemented peripherals
Date: Mon, 14 Oct 2019 17:04:03 +0100
Message-Id: <20191014160404.19553-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

Base addresses and sizes taken from the "BCM2835 ARM Peripherals"
datasheet from February 06 2012:
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190926173428.10713-6-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h | 15 ++++++++++++++
 include/hw/arm/raspi_platform.h      |  8 +++++++
 hw/arm/bcm2835_peripherals.c         | 31 ++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 6b17f6a3827..62a4c7b559d 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -23,6 +23,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
+#include "hw/misc/unimp.h"
 
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
 #define BCM2835_PERIPHERALS(obj) \
@@ -37,6 +38,10 @@ typedef struct BCM2835PeripheralState {
     MemoryRegion ram_alias[4];
     qemu_irq irq, fiq;
 
+    UnimplementedDeviceState systmr;
+    UnimplementedDeviceState armtmr;
+    UnimplementedDeviceState cprman;
+    UnimplementedDeviceState a2w;
     PL011State uart0;
     BCM2835AuxState aux;
     BCM2835FBState fb;
@@ -48,6 +53,16 @@ typedef struct BCM2835PeripheralState {
     SDHCIState sdhci;
     BCM2835SDHostState sdhost;
     BCM2835GpioState gpio;
+    UnimplementedDeviceState i2s;
+    UnimplementedDeviceState spi[1];
+    UnimplementedDeviceState i2c[3];
+    UnimplementedDeviceState otp;
+    UnimplementedDeviceState dbus;
+    UnimplementedDeviceState ave0;
+    UnimplementedDeviceState bscsl;
+    UnimplementedDeviceState smi;
+    UnimplementedDeviceState dwc2;
+    UnimplementedDeviceState sdramc;
 } BCM2835PeripheralState;
 
 #endif /* BCM2835_PERIPHERALS_H */
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 66969fac5d2..cdcbca943fb 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -38,6 +38,8 @@
                                                       * Doorbells & Mailboxes */
 #define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
 #define CM_OFFSET               0x101000 /* Clock Management */
+#define A2W_OFFSET              0x102000 /* Reset controller */
+#define AVS_OFFSET              0x103000 /* Audio Video Standard */
 #define RNG_OFFSET              0x104000
 #define GPIO_OFFSET             0x200000
 #define UART0_OFFSET            0x201000
@@ -45,11 +47,17 @@
 #define I2S_OFFSET              0x203000
 #define SPI0_OFFSET             0x204000
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
+#define OTP_OFFSET              0x20f000
+#define BSC_SL_OFFSET           0x214000 /* SPI slave */
 #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
 #define EMMC1_OFFSET            0x300000
 #define SMI_OFFSET              0x600000
 #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
+#define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
+#define DBUS_OFFSET             0x900000
+#define AVE0_OFFSET             0x910000
 #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
+#define SDRAMC_OFFSET           0xe00000
 #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
 
 /* GPU interrupts */
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 1bd2ff41d52..fdcf616c56a 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -22,6 +22,20 @@
 /* Capabilities for SD controller: no DMA, high-speed, default clocks etc. */
 #define BCM2835_SDHC_CAPAREG 0x52134b4
 
+static void create_unimp(BCM2835PeripheralState *ps,
+                         UnimplementedDeviceState *uds,
+                         const char *name, hwaddr ofs, hwaddr size)
+{
+    sysbus_init_child_obj(OBJECT(ps), name, uds,
+                          sizeof(UnimplementedDeviceState),
+                          TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(DEVICE(uds), "name", name);
+    qdev_prop_set_uint64(DEVICE(uds), "size", size);
+    object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
+    memory_region_add_subregion_overlap(&ps->peri_mr, ofs,
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0), -1000);
+}
+
 static void bcm2835_peripherals_init(Object *obj)
 {
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(obj);
@@ -323,6 +337,23 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+
+    create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
+    create_unimp(s, &s->systmr, "bcm2835-systimer", ST_OFFSET, 0x20);
+    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
+    create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
+    create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
+    create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
+    create_unimp(s, &s->spi[0], "bcm2835-spi0", SPI0_OFFSET, 0x20);
+    create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
+    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
+    create_unimp(s, &s->otp, "bcm2835-otp", OTP_OFFSET, 0x80);
+    create_unimp(s, &s->dbus, "bcm2835-dbus", DBUS_OFFSET, 0x8000);
+    create_unimp(s, &s->ave0, "bcm2835-ave0", AVE0_OFFSET, 0x8000);
+    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OTG_OFFSET, 0x1000);
+    create_unimp(s, &s->sdramc, "bcm2835-sdramc", SDRAMC_OFFSET, 0x100);
 }
 
 static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
-- 
2.20.1



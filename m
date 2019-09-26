Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE4C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:47:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF0F21D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwNnoiFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF0F21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXro-0007Qo-Ag
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgB-0004M8-AV
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg9-0002qH-OQ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg9-0002p0-Fi; Thu, 26 Sep 2019 13:35:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so3030319wro.5;
 Thu, 26 Sep 2019 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/8xcNneZ2/qvbDmM1OKk4z67N/LkpAUXIQ5kG5a96Wc=;
 b=TwNnoiFM7EJNzS+NQNIFxuyhk4QbIaOBCgsNgCY6waK+qwWJlJraWMcsPvYzeW4IqD
 1yKNf9NU/5tX/ObAztYMZmC7Tvz+/Rl+Pf3fcIEO+px0//XWxod1vKlJOcy9VeFin6v2
 9t5pL2izNG7VKmrT4eTh5mc/ryQoFzwImMYxGkEKmB79ZpN6mckyBeXNr/qWgwO8csyj
 RDV3Le1Xf0UlEYk0S2nBdGJVB0PkSRC6wPM7nHQaj8DXtMXtFKfiGD7yUTdmAXgXcrHL
 HC2hpb4T7RS1x/nHomNmtHoBTVMA/PyTNHS1AcO0jmKI7tImXBAEdtE5TAYwDqy2iS1S
 sClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/8xcNneZ2/qvbDmM1OKk4z67N/LkpAUXIQ5kG5a96Wc=;
 b=X+yxSt0O3Sr2nW5eV62merqIaJqh/xmItm6fyDorxRZ3EH1Mz8BzXhwUg5bRvCkxSh
 NYjZvDBayT96OjHm2aOpl+nLD/4rMWWSFfgpOMsvrs6ZwpSe5wcuhkUZlRmrOwMR9VYy
 VBkWKoXjOmgRnJeTuz2KPvgt65Zob1JRm3SZBV+14JrJkXvwAzmqSJEKQik4mMiGQdpT
 rt0n6SuIz4nOQE+iPNPGA/vnKyw99RHRbiYHTnFr63qBTtSpI68eCJsG/D9pkBmY1lbW
 y5ece+TtpuAuAVxEjbw0qH0soXbhi6EbbDi29ve4Gfh0ckYqKQIZ3i2i4qna2P4nLlNw
 QEyg==
X-Gm-Message-State: APjAAAV3epPCqnY2GarO+x3zxSo1CbS+oVEL2sv8UQ2wlfFeMFHyaBqp
 gOO9cPApFrPzEJdbW87iDI0Y6pDBQ6c=
X-Google-Smtp-Source: APXvYqwRla+cPsLh/Qgqpz/qU/JFJJLJe2vqqDTqnFwTn5ku946P2NzbzWXSpZ6TM0QuYc6tJwM9HQ==
X-Received: by 2002:adf:ce05:: with SMTP id p5mr2398368wrn.48.1569519284264;
 Thu, 26 Sep 2019 10:34:44 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/19] hw/arm/bcm2835: Add various unimplemented peripherals
Date: Thu, 26 Sep 2019 19:34:13 +0200
Message-Id: <20190926173428.10713-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Base addresses and sizes taken from the "BCM2835 ARM Peripherals"
datasheet from February 06 2012:
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c         | 31 ++++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h | 15 ++++++++++++++
 include/hw/arm/raspi_platform.h      |  8 +++++++
 3 files changed, 54 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 1bd2ff41d5..fdcf616c56 100644
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
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 6b17f6a382..62a4c7b559 100644
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
index 66969fac5d..cdcbca943f 100644
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
-- 
2.20.1



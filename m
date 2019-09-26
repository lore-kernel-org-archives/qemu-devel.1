Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02921C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48F6222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jmzr0cep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48F6222C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXoi-0003bK-CZ
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgH-0004Th-D6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgG-0002uJ-0N
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgF-0002tD-PG; Thu, 26 Sep 2019 13:35:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so3740735wrs.0;
 Thu, 26 Sep 2019 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dMBRiTpLuqyI3tuVBy2ZLm7Wzg1GaNHi9g5XPWVyXlc=;
 b=Jmzr0cepOGPkBtav/ifREcbjSkztyj4oaLOjlFggGH84IjFxe/y9BRADm2t992Zbtp
 +NeizxJcxR49MK4ex7iSxdoaOpm7vkRbbSh2zm1IjeBmBW/lNZZCQrpNX+aeEsey2mBP
 XiTea//MnVQCeKZQz58jllVa2TyyFfnfNHAdvtlFYHzzY094lob4KdWRmuNEFIRc/dAp
 IEbSsXmy9RjE7ZEUDcEUgSNkNyR+O5S6jJcl5JyQOpWVzROXv01o+E4LQFvvgt+kTUHm
 +gZXiraEGRl1D/ykjZv+Up+ePPJPnHUpbCdUeE5JHW5mC/FrUnrvr0Hmw2l2D2Ib1VDM
 CxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dMBRiTpLuqyI3tuVBy2ZLm7Wzg1GaNHi9g5XPWVyXlc=;
 b=WojbChAH54DryaO3EwaJPmFTOHxcWa5mq7WSM6rgZji30R+D1EmdjtHPNgYn7JNc2y
 4mXbCGzAB53P5yB3PaX1US9MuzlWQrvzlNQ15CKCzg+FnaA7GiWAGlpVvLKmd7mU/dyj
 1GsfdpXjbq0nxhxoYHzMDExixjUgpRBz6iRlJEQEKgfsC7zlGqTqqskSzfBEmnN9qZ2l
 AT60SmrqEmhZp716h7UYk8G3p3pMPTNS8dXjLWLLzeo/KcJuzOQkg9P6qc3nLZ/rLmrZ
 T4Me/TD5Dvu5S9R+kFgSEMbf/Ze4skcILfGcYvDNycwu0X1waGHYQ/DlPx0G+0gq6/S5
 3/YQ==
X-Gm-Message-State: APjAAAU4y8IKzf+ks3gGB1jVL3pAKyGvhUwMWhBLwAHvhXjDgbqi8rf6
 PuXNITtxkzLDi2Abr9WcCepahkzsPNk=
X-Google-Smtp-Source: APXvYqxeuWYYg9hX3pE803WJPHi40gPn283dlsa22r7adI30TKyVLYiJIztv6j7iQzBAvCQ2vhtBwg==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr4217967wrj.269.1569519290674; 
 Thu, 26 Sep 2019 10:34:50 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/19] hw/arm/bcm2835_peripherals: Use the thermal sensor block
Date: Thu, 26 Sep 2019 19:34:17 +0200
Message-Id: <20190926173428.10713-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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

Map the thermal sensor in the BCM2835 block.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c         | 13 +++++++++++++
 include/hw/arm/bcm2835_peripherals.h |  2 ++
 include/hw/arm/raspi_platform.h      |  1 +
 3 files changed, 16 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index fdcf616c56..70bf927a02 100644
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
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 62a4c7b559..be7ad9b499 100644
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
index cdcbca943f..61b04a1bd4 100644
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
-- 
2.20.1



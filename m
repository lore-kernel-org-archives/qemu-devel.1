Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A203C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18908222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmupJf/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18908222C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXn1-0001mg-W6
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg9-0004JH-Df
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg7-0002oI-Uo
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg7-0002na-GD; Thu, 26 Sep 2019 13:35:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so3744359wrx.1;
 Thu, 26 Sep 2019 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GlaMMIfLZjSDDtTHA/uHOissc0A853GaqoDlAhxsiJM=;
 b=QmupJf/2U6S3tX/1kh4MFs5BaT311mz8YFy6GDfe48td7bhn2osy22KsyarRVS923C
 8X3/iIygr3eeECtn+stZAmoPSUm8V67qnRi8JsomTI9FPiRnVQDjnsRV4FHlvyGSx9o2
 M+pTAkfrdtx+ihkxpo5eFEVff+KzWz46t9NdFQJsRo+W2adA38IxhisCAvG6FV0Q1L9Z
 WEuR909D8JpwJaGWIGd+zAYcYpg4FbnhAyLNy8M69cMZf3Z1sRWDW5yPY541PycNqnma
 U2LjSk+eslIW5vBuroQIVTBKO9AVooov6G7BfVwqUMbwqDLHjW849bJkFtCtlfzsl5oy
 1Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GlaMMIfLZjSDDtTHA/uHOissc0A853GaqoDlAhxsiJM=;
 b=aQVQmNT7cGw4eHuGAhtfaWuSpRxkaUKXjcBhq4THGyhDXdS46b+JFcCqjfTMc6F6DA
 LXX6npwXfnqeVpm18qbdm6DEolFAL9MXS8lIfxmYyBj0Jf9cbvnbu7nEM6if0tn/bjOi
 6fTYHfJFlpDXyjGmfJYeItgFBzp6os6fND/LxL1I4z7SETLA+kcrIOGC2VF2SFgyvcyg
 bByGaub/at3TqHAyUdwsMtgKAk3apP/W64T3Ry9u4aG+whQYzCMFOWndyXqYYZSzXolw
 HnbMcL2h+Gj1yeSioHn3kfGtTNvoXt9iXI67p7lJRlva6pLMcFy7hwID9pkMspG8UBEf
 QnAw==
X-Gm-Message-State: APjAAAXfkPelNXCdsoapHbt6l4KYi1bAju2T8vTOmTTUsrwajbRPDlCU
 TK/4B8lGLJ3xmlEWs2Si98J3SagBFhk=
X-Google-Smtp-Source: APXvYqw+fkY52vMHrG//JdryzcdZScvMMu4GxtjhI4Rnv3uQ6n1RZUgwXDegCA/wvOTM46oIhEVFQw==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr1834075wru.205.1569519282325; 
 Thu, 26 Sep 2019 10:34:42 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/19] hw/arm/bcm2835: Rename some definitions
Date: Thu, 26 Sep 2019 19:34:12 +0200
Message-Id: <20190926173428.10713-5-f4bug@amsat.org>
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

The UART1 is part of the AUX peripheral,
the PCM_CLOCK (yet unimplemented) is part of the CPRMAN.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
I dunno if this is OK to do that since the header has:

 * These definitions are derived from those in Raspbian Linux at
 * arch/arm/mach-{bcm2708,bcm2709}/include/mach/platform.h
 * where they carry the following notice:
 *
 * Copyright (C) 2010 Broadcom
---
 hw/arm/bcm2835_peripherals.c    |  7 ++++---
 hw/arm/bcm2836.c                |  2 +-
 include/hw/arm/raspi_platform.h | 16 +++++++---------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 8984e2e91f..1bd2ff41d5 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -165,7 +165,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart0), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart0), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
-                               INTERRUPT_UART));
+                               INTERRUPT_UART0));
+
     /* AUX / UART1 */
     qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hd(1));
 
@@ -175,7 +176,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_add_subregion(&s->peri_mr, UART1_OFFSET,
+    memory_region_add_subregion(&s->peri_mr, AUX_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->aux), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->aux), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
@@ -268,7 +269,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    memory_region_add_subregion(&s->peri_mr, EMMC_OFFSET,
+    memory_region_add_subregion(&s->peri_mr, EMMC1_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhci), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 493a913f89..723aef6bf5 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -126,7 +126,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
         /* set periphbase/CBAR value for CPU-local registers */
         object_property_set_int(OBJECT(&s->cpus[n]),
-                                BCM2836_PERI_BASE + MCORE_OFFSET,
+                                BCM2836_PERI_BASE + MSYNC_OFFSET,
                                 "reset-cbar", &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 10083d33df..66969fac5d 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -25,8 +25,7 @@
 #ifndef HW_ARM_RASPI_PLATFORM_H
 #define HW_ARM_RASPI_PLATFORM_H
 
-#define MCORE_OFFSET            0x0000   /* Fake frame buffer device
-                                          * (the multicore sync block) */
+#define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define IC0_OFFSET              0x2000
 #define ST_OFFSET               0x3000   /* System Timer */
 #define MPHI_OFFSET             0x6000   /* Message-based Parallel Host Intf. */
@@ -37,9 +36,8 @@
 #define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 */
 #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0 (ARM) Semaphores
                                                       * Doorbells & Mailboxes */
-#define PM_OFFSET               0x100000 /* Power Management, Reset controller
-                                          * and Watchdog registers */
-#define PCM_CLOCK_OFFSET        0x101098
+#define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
+#define CM_OFFSET               0x101000 /* Clock Management */
 #define RNG_OFFSET              0x104000
 #define GPIO_OFFSET             0x200000
 #define UART0_OFFSET            0x201000
@@ -47,11 +45,11 @@
 #define I2S_OFFSET              0x203000
 #define SPI0_OFFSET             0x204000
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
-#define UART1_OFFSET            0x215000
-#define EMMC_OFFSET             0x300000
+#define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
+#define EMMC1_OFFSET            0x300000
 #define SMI_OFFSET              0x600000
 #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
-#define USB_OFFSET              0x980000 /* DTC_OTG USB controller */
+#define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
 #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
 
 /* GPU interrupts */
@@ -112,7 +110,7 @@
 #define INTERRUPT_SPI                  54
 #define INTERRUPT_I2SPCM               55
 #define INTERRUPT_SDIO                 56
-#define INTERRUPT_UART                 57
+#define INTERRUPT_UART0                57
 #define INTERRUPT_SLIMBUS              58
 #define INTERRUPT_VEC                  59
 #define INTERRUPT_CPG                  60
-- 
2.20.1



Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B686FCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8014B2082F
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRS7Sge6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8014B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyVo-00061u-4H
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRU-00006U-6H
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRT-0005Wp-0H
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRS-0005WY-QW; Sat, 19 Oct 2019 19:47:26 -0400
Received: by mail-wm1-x343.google.com with SMTP id i16so9566246wmd.3;
 Sat, 19 Oct 2019 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n7quA1dGafaHo0DTqTtlgCaafQtBK1c/6u1kSk551IY=;
 b=lRS7Sge6aBIDnhtlGzKpDMR/n81AmTFwtiuiAlXA00tfcZ9Z4w7LODUm44a3/eaefK
 tyWu9KgI8fxxW1YY+v4EeQfDtq8QlIalOAwzs8iyvE9giu4jMlPALfJEzv/Fwx9n7Fd2
 X2tgT5uhNZXyw5ND6T8GTmca4/FhBV63/Ut15ehNi1hvALcZUXlr1gkesy3tc0kFcljo
 ge58BheF6tUsbgvt1lAcQC5/nSTQw3n7IBbyOTly09AXh7PbFQ10E7dwmH4kvuys2UC5
 1016g8+dwVQPYkpBnjkeW15DKH3I2OO/nqpSMLsYFBiATaS1eOwMfv2VNwPH3iV8h71H
 Qqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=n7quA1dGafaHo0DTqTtlgCaafQtBK1c/6u1kSk551IY=;
 b=sewGzipfYZ44mbo4xmeOVu5SHz6E6KYNqbcJShsGlruxr/LCGhxha7UA8MhGNo3h9j
 7Nl5tmnNWSGuyXg3nvaOl8T9LAvWU4AwbAmOoP6v5VS0eJ8d5bYqgwE46CoTYWPPbk8G
 VezJ2Rdg4Odn/OdYinitDvy7zq7knFE3xz0SGPWGUqaLd3OhUpQmJYWOCqn4foMbBepp
 Ae8XfRQqVQJP+TndvG/aAkmBaHTZi2O+3ySb8voHnQLMRpIuwDRDBFUN0hctP0SkJtOv
 Qn57aN5pJS7T04dhufDDGrzzFQlxx0iKScXukYI3N3GNCjxBaxRFOkpgkDia28DhxlkQ
 Nbwg==
X-Gm-Message-State: APjAAAUIC8em3XGssxbphLQH1K0+HMJ2FNvQvBJxv3MZoJHZsScLLjvr
 G4ILeEymNvA9bTx8MOh/2SZ/jMsY
X-Google-Smtp-Source: APXvYqwMyepWQjnONpEna7iYh7IwvYJAbZziDGa9VhyF1JG8Tfiicvg+J1xLanLOIJukiMq59Sge0w==
X-Received: by 2002:a05:600c:2319:: with SMTP id
 25mr9047217wmo.141.1571528845606; 
 Sat, 19 Oct 2019 16:47:25 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/16] hw/arm/bcm2835_peripherals: Use the SYS_timer
Date: Sun, 20 Oct 2019 01:47:03 +0200
Message-Id: <20191019234715.25750-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 Alistair Francis <alistair.francis@wdc.com>,
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Connect the recently added SYS_timer.
Now U-Boot does not hang anymore polling a free running counter
stuck at 0.
This timer is also used by the Linux kernel thermal subsystem.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Remove spurious error check (Alex)
---
 hw/arm/bcm2835_peripherals.c         | 17 ++++++++++++++++-
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 70bf927a02..17207ae07e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -58,6 +58,10 @@ static void bcm2835_peripherals_init(Object *obj)
     /* Interrupt Controller */
     sysbus_init_child_obj(obj, "ic", &s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
 
+    /* SYS Timer */
+    sysbus_init_child_obj(obj, "systimer", &s->systmr, sizeof(s->systmr),
+                          TYPE_BCM2835_SYSTIMER);
+
     /* UART0 */
     sysbus_init_child_obj(obj, "uart0", &s->uart0, sizeof(s->uart0),
                           TYPE_PL011);
@@ -171,6 +175,18 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ic), 0));
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
 
+    /* Sys Timer */
+    object_property_set_bool(OBJECT(&s->systmr), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systmr), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
+                               INTERRUPT_ARM_TIMER));
+
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
     object_property_set_bool(OBJECT(&s->uart0), true, "realized", &err);
@@ -352,7 +368,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
-    create_unimp(s, &s->systmr, "bcm2835-systimer", ST_OFFSET, 0x20);
     create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
     create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
     create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index be7ad9b499..7859281e11 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -24,6 +24,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
+#include "hw/timer/bcm2835_systmr.h"
 #include "hw/misc/unimp.h"
 
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
@@ -39,7 +40,7 @@ typedef struct BCM2835PeripheralState {
     MemoryRegion ram_alias[4];
     qemu_irq irq, fiq;
 
-    UnimplementedDeviceState systmr;
+    BCM2835SystemTimerState systmr;
     UnimplementedDeviceState armtmr;
     UnimplementedDeviceState cprman;
     UnimplementedDeviceState a2w;
-- 
2.21.0



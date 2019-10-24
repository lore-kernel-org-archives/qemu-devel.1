Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B49CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7086A205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iObXXY1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7086A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgos-0004e9-8b
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyP-0008UX-HA
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyO-00016q-9a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:29 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyO-00016V-2t
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:28 -0400
Received: by mail-wm1-x341.google.com with SMTP id g7so3537789wmk.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=c6aABKpXMCHWTjg1I/aM1uM5Hh9/GIS1D4WV2556Mg4=;
 b=iObXXY1Qjasb8l9kgr5weofW45cXjcwtCFMDzcVvAU3uU7j9sT5YtD6JwCU81t++Ad
 wwULvHdfkdTUbPzBYolGqB8t6ESOuI2mq9JfjAWrXKEn7/T4C/oDl7F7heEWzdnT4s9V
 nVSCGdLHnjoaym7YYKyUHK0lACk/R9JavA3MOjA6Ve0E4aZJELoi4W77SKpmw7wuyV9a
 C1QPwpPZs2LfwYcAQ6ry+2cGBk0pxKmS3lqalO0bBWdgNdJhVbPmR76DSru1XSVO6Wmc
 Z33Nb7hP4o+i7ArakcGuaujvaKwb9LP4texfGD+XILuyguttRHbfjnwXz4f5C7j+7xHc
 T36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c6aABKpXMCHWTjg1I/aM1uM5Hh9/GIS1D4WV2556Mg4=;
 b=oddx0vnm7hwCaC/rXM6BBUe76hexiNzAFHziVcj1G580xbZlYyfYLXP6STx+/fPVy5
 sDKYAPAHAJT1XL9DwEFpiGPT8RVaeYUJSDKZupLKE6q5ju+q2Xft3FTKYAR49kJqGY7w
 QAOkf5l2Aumxcd+P0t2wuzfZ2vwt9VinL3AympS1k79lRuij3fh6vlKXZTqCSASR7o9e
 8leXD+BX4n2PYQ+lqljv2/+TWm6o6Qrl2uPYEWRpFsJMLRwaaGQ6Z2JrFyJvjbRs63k9
 R4vmC02mDYQGoshp4RDz0ue2s+gUb3Rh2Qla4iabyFcML8VszrQj+yzc6wdxi9lucs/u
 G6zg==
X-Gm-Message-State: APjAAAVw/H1wvt9MmzEXk95JyCMq2jdPhGuOoYtQAKfPb0xIxdo1YH7J
 puaTWIQZTrCeTI4H3m/fYBkw/6MsSJ8=
X-Google-Smtp-Source: APXvYqwp6Mliq7OTsooiSgNJ+7lX+B8x/qXvzRAkI/UQ4psqBISTCzzBe258vhsNctHz2jZqiXAb4w==
X-Received: by 2002:a1c:2407:: with SMTP id k7mr5324814wmk.99.1571934506809;
 Thu, 24 Oct 2019 09:28:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/51] hw/arm/bcm2835_peripherals: Use the SYS_timer
Date: Thu, 24 Oct 2019 17:27:20 +0100
Message-Id: <20191024162724.31675-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Connect the recently added SYS_timer.
Now U-Boot does not hang anymore polling a free running counter
stuck at 0.
This timer is also used by the Linux kernel thermal subsystem.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20191019234715.25750-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h |  3 ++-
 hw/arm/bcm2835_peripherals.c         | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index be7ad9b4991..7859281e11b 100644
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
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 70bf927a025..17207ae07e3 100644
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
-- 
2.20.1



Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A81C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B02F206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 13:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9yL5isR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B02F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY8iH-0003AO-OA
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 09:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZT-0001kd-SS
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY8ZS-00070I-V6
 for qemu-devel@nongnu.org; Mon, 11 May 2020 09:34:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id m12so13162949wmc.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wIUXoa1qdi1AIuD+cK38yBBIEnIcG+EzyRhkeedc+fE=;
 b=W9yL5isRdDsx4hAyn8gDmlY7pbq+F0a/Hl2FXfTGs4ZvPtgsvaYtl7YbSU+uvlWEhw
 e9u1531rUD+U1SbpxcoX1VynDMyAazUeo55vjCngMluvsjR3Kz93n3MB1tYuHa0XxE2f
 vrE2c1iLkI84V60CBgUeetbb8Ybzk/Gwhv7K46KioQPCXHNZBlhdlnpQv3WMW5eNj7K2
 4oJyyepvexBLypICPVPQaIryNVr1JPU7E1B0nCQzrJSdDM4WgkeUEVwLpIFVfGbp2b5y
 4sx2PK1dWx0KhbhE+7GPphRJVGmszYq/XRPFQFg4DAt0W4QrUmGvi10UIxpdVMo1uf43
 jQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wIUXoa1qdi1AIuD+cK38yBBIEnIcG+EzyRhkeedc+fE=;
 b=qLVM8BLcTDmsnDKFSsLswYjWVqIrSdpVb9D3WGf+Oplrz8zw94kWETr6rAZgbLe1MG
 PVgha+oMrKQ6MFLnQP6RVWneZ4te/GVBCX7olWlncHSx/inG5y3gK2ZIVhc3CGzvbhV0
 B6Gun+OYdW5XwU2nXsYv7Ukuf4OB69LjILPo4CHjIh5C+kSfeQiWkdxJydxAf/qD5GlY
 vlVVS35VZ09inISjZbDuzAocJIk7WeRsQo+vQSLRF/GogWJoxctwtnjT+q5o0Y81v0yT
 lxQH8AGhke8PboY3RH2uEChAKbGzgy6F86CpPI4iBcJf4MnU+CQ1EYJgtO5GwFygGjG0
 254Q==
X-Gm-Message-State: AGi0Pua59A4xb+8Of9yMqTiMy6NVAYzob4Q02oCMQHLEZxWNrL5cGwuk
 8PjprdgSPuWCg85yJxUneWSwllvVAt0dHw==
X-Google-Smtp-Source: APiQypJwNma/q8RCPSA++cMwXR3MNIcUot6bt9pcrwJfOhFxx4Cws+x69OvqIMQx1gIm89e5dXiLiw==
X-Received: by 2002:a7b:cf25:: with SMTP id m5mr33820213wmg.65.1589204053320; 
 Mon, 11 May 2020 06:34:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m3sm2154818wrn.96.2020.05.11.06.34.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 06:34:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/34] hw/arm/nrf51: Add NRF51_PERIPHERAL_SIZE definition
Date: Mon, 11 May 2020 14:33:36 +0100
Message-Id: <20200511133405.5275-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
References: <20200511133405.5275-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

On the NRF51 series, all peripherals have a fixed I/O size
of 4KiB. Define NRF51_PERIPHERAL_SIZE and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200504072822.18799-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/nrf51.h        | 3 +--
 include/hw/i2c/microbit_i2c.h | 2 +-
 hw/arm/nrf51_soc.c            | 4 ++--
 hw/i2c/microbit_i2c.c         | 2 +-
 hw/timer/nrf51_timer.c        | 2 +-
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/nrf51.h b/include/hw/arm/nrf51.h
index 1008fee6c93..de836beaa4c 100644
--- a/include/hw/arm/nrf51.h
+++ b/include/hw/arm/nrf51.h
@@ -24,11 +24,10 @@
 #define NRF51_IOMEM_BASE      0x40000000
 #define NRF51_IOMEM_SIZE      0x20000000
 
+#define NRF51_PERIPHERAL_SIZE 0x00001000
 #define NRF51_UART_BASE       0x40002000
 #define NRF51_TWI_BASE        0x40003000
-#define NRF51_TWI_SIZE        0x00001000
 #define NRF51_TIMER_BASE      0x40008000
-#define NRF51_TIMER_SIZE      0x00001000
 #define NRF51_RNG_BASE        0x4000D000
 #define NRF51_NVMC_BASE       0x4001E000
 #define NRF51_GPIO_BASE       0x50000000
diff --git a/include/hw/i2c/microbit_i2c.h b/include/hw/i2c/microbit_i2c.h
index aad636127ea..2bff36680cc 100644
--- a/include/hw/i2c/microbit_i2c.h
+++ b/include/hw/i2c/microbit_i2c.h
@@ -29,7 +29,7 @@
 #define MICROBIT_I2C(obj) \
     OBJECT_CHECK(MicrobitI2CState, (obj), TYPE_MICROBIT_I2C)
 
-#define MICROBIT_I2C_NREGS (NRF51_TWI_SIZE / sizeof(uint32_t))
+#define MICROBIT_I2C_NREGS (NRF51_PERIPHERAL_SIZE / sizeof(uint32_t))
 
 typedef struct {
     SysBusDevice parent_obj;
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 57eff63f0df..e50473fd199 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -156,7 +156,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
             return;
         }
 
-        base_addr = NRF51_TIMER_BASE + i * NRF51_TIMER_SIZE;
+        base_addr = NRF51_TIMER_BASE + i * NRF51_PERIPHERAL_SIZE;
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer[i]), 0, base_addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer[i]), 0,
@@ -166,7 +166,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* STUB Peripherals */
     memory_region_init_io(&s->clock, OBJECT(dev_soc), &clock_ops, NULL,
-                          "nrf51_soc.clock", 0x1000);
+                          "nrf51_soc.clock", NRF51_PERIPHERAL_SIZE);
     memory_region_add_subregion_overlap(&s->container,
                                         NRF51_IOMEM_BASE, &s->clock, -1);
 
diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index 4661f052532..80247398208 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -100,7 +100,7 @@ static void microbit_i2c_realize(DeviceState *dev, Error **errp)
     MicrobitI2CState *s = MICROBIT_I2C(dev);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &microbit_i2c_ops, s,
-                          "microbit.twi", NRF51_TWI_SIZE);
+                          "microbit.twi", NRF51_PERIPHERAL_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
index e04046eb15e..bc82c85a6f2 100644
--- a/hw/timer/nrf51_timer.c
+++ b/hw/timer/nrf51_timer.c
@@ -313,7 +313,7 @@ static void nrf51_timer_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
     memory_region_init_io(&s->iomem, obj, &rng_ops, s,
-            TYPE_NRF51_TIMER, NRF51_TIMER_SIZE);
+                          TYPE_NRF51_TIMER, NRF51_PERIPHERAL_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
     sysbus_init_irq(sbd, &s->irq);
 
-- 
2.20.1



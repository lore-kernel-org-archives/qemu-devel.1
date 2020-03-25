Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB547C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73944206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 19:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK8Z5CR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73944206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHBce-0006rP-Ky
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 15:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBYA-0008OG-0M
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBY8-0008Mh-0m
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 15:18:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jHBY7-0008M2-PV; Wed, 25 Mar 2020 15:18:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id a81so4171790wmf.5;
 Wed, 25 Mar 2020 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GhVX8f98O0Xa/LOVRL95qx+viSjodj+CYTsM4Px49fY=;
 b=JK8Z5CR/vAs+6GNWR0Pc0Cq4xV4rhs44H+vI9mGz+3lT8gmhVFY1NllA7uofymoktC
 OOclKhzERBoU/GzD1dJES4G/UJgvl1RUJJ9kNghnhttGDn0bdwkHRf/Ey1VR0XFH3TzU
 wOWSW/pQABNh/pmWRlzEMb/uVMCGtnwmGdAEzsnIp+3iSJfmy8TBGnXws3x4QwZfrEPI
 a4XhOPv35/drV2M+Y8km8jAe9wb2fFCZoc0H/rR5waIKkt3oSsR5WnH7dkuTOkjjUnQw
 XRRO1F66lML2S3dfYwFA9yy8OFGtXGj0SjPtglj8dq2oQ2rylSGUuLclC8ky934kREEg
 5tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GhVX8f98O0Xa/LOVRL95qx+viSjodj+CYTsM4Px49fY=;
 b=m6pgHU5lSG/HBgJLrYFb/d11O5UMaTciJVMnHa4LDinmiACMS04/Gtd4K6fYUsRLdb
 XeZBo4UsRaDoS6Kxb+X2DGddccmxTmfEeU7Q0fWxk0QS33vQn6aRva93w2RhWBWqyiiG
 x0ZmV270bix6vYU/YHWgzpFk50pPLyeiE2PEBuSwExhL9K4G+hATq820HzUr1Ilt13T9
 DrfFZH/TynDpmjt5o983S4T6haZB2X9ABrxJRRvYUpUr+psOkWEItCLDHW8r/dm/Z53n
 5tpB5k4vMrhBXpkQHargJouwEnMsEZWP2GaAklGNlPqRPOYgKJe3YKrIWKBUBgdXDmco
 ylBw==
X-Gm-Message-State: ANhLgQ13tiHB97llkQ4bGrzsEaqw2zaptKW8NkAQ3nN155vHoDzKEmKX
 MgfKVJpwEKXCwjZKOv3Hrdx4j4juh30=
X-Google-Smtp-Source: ADFU+vvTWcMqq/E0mn8RtOqbGbhhftd/mq/2WBj+7QJppdLptSgZJXwgm/gtKBHwIBbeIRUW73G1pQ==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr4615449wmg.99.1585163926248; 
 Wed, 25 Mar 2020 12:18:46 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id r17sm6345672wrx.46.2020.03.25.12.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 12:18:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 04/12] hw/arm/stm32fx05_soc: Add missing
 error-propagation code
Date: Wed, 25 Mar 2020 20:18:22 +0100
Message-Id: <20200325191830.16553-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325191830.16553-1-f4bug@amsat.org>
References: <20200325191830.16553-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/stm32f205_soc.c | 4 ++++
 hw/arm/stm32f405_soc.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 118c342559..1d80f91dd7 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -83,113 +83,117 @@ static void stm32f205_soc_initfn(Object *obj)
 static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     STM32F205State *s = STM32F205_SOC(dev_soc);
     DeviceState *dev, *armv7m;
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
 
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *sram = g_new(MemoryRegion, 1);
     MemoryRegion *flash = g_new(MemoryRegion, 1);
     MemoryRegion *flash_alias = g_new(MemoryRegion, 1);
 
     memory_region_init_rom(flash, OBJECT(dev_soc), "STM32F205.flash",
                            FLASH_SIZE, &error_fatal);
     memory_region_init_alias(flash_alias, OBJECT(dev_soc),
                              "STM32F205.flash.alias", flash, 0, FLASH_SIZE);
 
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
     memory_region_add_subregion(system_memory, 0, flash_alias);
 
     memory_region_init_ram(sram, NULL, "STM32F205.sram", SRAM_SIZE,
                            &error_fatal);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
     object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0x40013800);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, 71));
 
     /* Attach UART (uses USART registers) and USART controllers */
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
         object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, usart_addr[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq[i]));
     }
 
     /* Timer 2 to 5 */
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
         object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, timer_addr[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, timer_irq[i]));
     }
 
     /* ADC 1 to 3 */
     object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(s->adc_irqs), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
     qdev_connect_gpio_out(DEVICE(s->adc_irqs), 0,
                           qdev_get_gpio_in(armv7m, ADC_IRQ));
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
         object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, adc_addr[i]);
         sysbus_connect_irq(busdev, 0,
                            qdev_get_gpio_in(DEVICE(s->adc_irqs), i));
     }
 
     /* SPI 1 and 2 */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
         object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, spi_addr[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_irq[i]));
     }
 }
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 4f10ce6176..398a3b5b4f 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -89,183 +89,187 @@ static void stm32f405_soc_initfn(Object *obj)
 static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     STM32F405State *s = STM32F405_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *dev, *armv7m;
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
 
     memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32F405.flash",
                            FLASH_SIZE, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
     memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
                              "STM32F405.flash.alias", &s->flash, 0,
                              FLASH_SIZE);
 
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
 
     memory_region_init_ram(&s->sram, NULL, "STM32F405.sram", SRAM_SIZE,
                            &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
     armv7m = DEVICE(&s->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(system_memory),
                                      "memory", &error_abort);
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
     object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, SYSCFG_ADD);
     sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, SYSCFG_IRQ));
 
     /* Attach UART (uses USART registers) and USART controllers */
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
         object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, usart_addr[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq[i]));
     }
 
     /* Timer 2 to 5 */
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
         object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, timer_addr[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, timer_irq[i]));
     }
 
     /* ADC device, the IRQs are ORed together */
     object_initialize_child(OBJECT(s), "adc-orirq", &s->adc_irqs,
                             sizeof(s->adc_irqs), TYPE_OR_IRQ,
                             &err, NULL);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
     object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->adc_irqs), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
                           qdev_get_gpio_in(armv7m, ADC_IRQ));
 
     dev = DEVICE(&(s->adc[i]));
     object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, ADC_ADDR);
     sysbus_connect_irq(busdev, 0,
                        qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
 
     /* SPI devices */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
         object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, spi_addr[i]);
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_irq[i]));
     }
 
     /* EXTI device */
     dev = DEVICE(&s->exti);
     object_property_set_bool(OBJECT(&s->exti), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, EXTI_ADDR);
     for (i = 0; i < 16; i++) {
         sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
     }
     for (i = 0; i < 16; i++) {
         qdev_connect_gpio_out(DEVICE(&s->syscfg), i, qdev_get_gpio_in(dev, i));
     }
 
     create_unimplemented_device("timer[7]",    0x40001400, 0x400);
     create_unimplemented_device("timer[12]",   0x40001800, 0x400);
     create_unimplemented_device("timer[6]",    0x40001000, 0x400);
     create_unimplemented_device("timer[13]",   0x40001C00, 0x400);
     create_unimplemented_device("timer[14]",   0x40002000, 0x400);
     create_unimplemented_device("RTC and BKP", 0x40002800, 0x400);
     create_unimplemented_device("WWDG",        0x40002C00, 0x400);
     create_unimplemented_device("IWDG",        0x40003000, 0x400);
     create_unimplemented_device("I2S2ext",     0x40003000, 0x400);
     create_unimplemented_device("I2S3ext",     0x40004000, 0x400);
     create_unimplemented_device("I2C1",        0x40005400, 0x400);
     create_unimplemented_device("I2C2",        0x40005800, 0x400);
     create_unimplemented_device("I2C3",        0x40005C00, 0x400);
     create_unimplemented_device("CAN1",        0x40006400, 0x400);
     create_unimplemented_device("CAN2",        0x40006800, 0x400);
     create_unimplemented_device("PWR",         0x40007000, 0x400);
     create_unimplemented_device("DAC",         0x40007400, 0x400);
     create_unimplemented_device("timer[1]",    0x40010000, 0x400);
     create_unimplemented_device("timer[8]",    0x40010400, 0x400);
     create_unimplemented_device("SDIO",        0x40012C00, 0x400);
     create_unimplemented_device("timer[9]",    0x40014000, 0x400);
     create_unimplemented_device("timer[10]",   0x40014400, 0x400);
     create_unimplemented_device("timer[11]",   0x40014800, 0x400);
     create_unimplemented_device("GPIOA",       0x40020000, 0x400);
     create_unimplemented_device("GPIOB",       0x40020400, 0x400);
     create_unimplemented_device("GPIOC",       0x40020800, 0x400);
     create_unimplemented_device("GPIOD",       0x40020C00, 0x400);
     create_unimplemented_device("GPIOE",       0x40021000, 0x400);
     create_unimplemented_device("GPIOF",       0x40021400, 0x400);
     create_unimplemented_device("GPIOG",       0x40021800, 0x400);
     create_unimplemented_device("GPIOH",       0x40021C00, 0x400);
     create_unimplemented_device("GPIOI",       0x40022000, 0x400);
     create_unimplemented_device("CRC",         0x40023000, 0x400);
     create_unimplemented_device("RCC",         0x40023800, 0x400);
     create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
     create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
     create_unimplemented_device("DMA1",        0x40026000, 0x400);
     create_unimplemented_device("DMA2",        0x40026400, 0x400);
     create_unimplemented_device("Ethernet",    0x40028000, 0x1400);
     create_unimplemented_device("USB OTG HS",  0x40040000, 0x30000);
     create_unimplemented_device("USB OTG FS",  0x50000000, 0x31000);
     create_unimplemented_device("DCMI",        0x50050000, 0x400);
     create_unimplemented_device("RNG",         0x50060800, 0x400);
 }
-- 
2.21.1



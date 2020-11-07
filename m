Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAEFC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25292087E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrqPGW9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25292087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbU3m-0004J9-VQ
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 14:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTz1-00081L-1m; Sat, 07 Nov 2020 14:34:43 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyy-0008NA-Jw; Sat, 07 Nov 2020 14:34:42 -0500
Received: by mail-wm1-x343.google.com with SMTP id v5so4559640wmh.1;
 Sat, 07 Nov 2020 11:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fgdYdhDY03zoPgadIiKhWW6DCP4typfikMNrmEkn0p8=;
 b=jrqPGW9tsCt+SXiyZQcQkihiqvMadba2ZzCBGwKS+j/drhGHyHFTrNp1nc5+s/sHsR
 mGrSsGjkGTYnaQ5N9SzxpO7Eqql1sCxTEri14zP9f5IFYHeP+oIscRmLhcIyH4fKJWJz
 2PWgZbrHz9+FC8ePucHjrKHmBaCTNGsxulqNO7qpEhKqK4U9jbFyFoXxiRTuNIQMPr5a
 29d2eaaOWW0kE38BhNAnBlU5I7t/x4T5X3cibScm0CSpPSG7edLZ+hRlO18H1z+3fx4Q
 rdiW+R8WuAG35tcM7qGjsXN5QXUWrI0ApTPR7r/TrKo87n3CfVlRsBxjKG3CO/p5PFeN
 U9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fgdYdhDY03zoPgadIiKhWW6DCP4typfikMNrmEkn0p8=;
 b=R6QAWObpmaHgBQnr/VEJ95Oj3uNpTrRHdiZX3Gr6q0rHKmEHi1d4uDKUAVstLZrRzp
 8VKWcwtYOpJ9neB1uuCzyl2Q6hBpfFMVwMjzBtd7lpqjBJ8+shtl/F5fDgqW/khZ8KdO
 d3/y95FAzVrFA/b6gifgk4uGuHiigpq/Dned4N3Ca7Wa41nPJJ2dZBg5CsH3UQlCjyer
 u8nFwK108ZO3ltiCosfQRGxSpLosIMoPeHxBly0+kz+gPUSAhB7dUJOlJFSeOGv945+J
 qsx7++CLA4LekJp6ZDIxBszjNjerUWOgcFxQ4nh2Sfu2Esf82akZhXX/cmFMZLguIj8o
 jmdw==
X-Gm-Message-State: AOAM53322x5+pb/w/SU+0kB3rc3tDFpQvg6/7poqs6YUlD/lk9HvgTP5
 as4ixlysm6rR+8GSJ3o3fVNj5824Vuc=
X-Google-Smtp-Source: ABdhPJzch91pop+RyceriIHWKgC4IQBp5vZmhnL2xbV1Xqtwzcflj42NHJ5xYpDbBGsez41J0pTSxA==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr6095102wmi.70.1604777671085; 
 Sat, 07 Nov 2020 11:34:31 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id q2sm7363998wrw.40.2020.11.07.11.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 11:34:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 5/5] hw/arm/musicpal: Only use qdev_get_gpio_in() when
 necessary
Date: Sat,  7 Nov 2020 20:34:03 +0100
Message-Id: <20201107193403.436146-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107193403.436146-1-f4bug@amsat.org>
References: <20201107193403.436146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need to fill the full pic[] array if we only use
few of the interrupt lines. Directly call qdev_get_gpio_in()
when necessary.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/musicpal.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index ebc3ec24ef7..458b1cbeb76 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1587,8 +1587,8 @@ static struct arm_boot_info musicpal_binfo = {
 static void musicpal_init(MachineState *machine)
 {
     ARMCPU *cpu;
-    qemu_irq pic[32];
     DeviceState *dev;
+    DeviceState *pic;
     DeviceState *uart_orgate;
     DeviceState *i2c_dev;
     DeviceState *lcd_dev;
@@ -1619,20 +1619,20 @@ static void musicpal_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, MP_SRAM_BASE, sram);
 
-    dev = sysbus_create_simple(TYPE_MV88W8618_PIC, MP_PIC_BASE,
+    pic = sysbus_create_simple(TYPE_MV88W8618_PIC, MP_PIC_BASE,
                                qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ));
-    for (i = 0; i < 32; i++) {
-        pic[i] = qdev_get_gpio_in(dev, i);
-    }
-    sysbus_create_varargs(TYPE_MV88W8618_PIT, MP_PIT_BASE, pic[MP_TIMER1_IRQ],
-                          pic[MP_TIMER2_IRQ], pic[MP_TIMER3_IRQ],
-                          pic[MP_TIMER4_IRQ], NULL);
+    sysbus_create_varargs(TYPE_MV88W8618_PIT, MP_PIT_BASE,
+                          qdev_get_gpio_in(pic, MP_TIMER1_IRQ),
+                          qdev_get_gpio_in(pic, MP_TIMER2_IRQ),
+                          qdev_get_gpio_in(pic, MP_TIMER3_IRQ),
+                          qdev_get_gpio_in(pic, MP_TIMER4_IRQ), NULL);
 
     /* Logically OR both UART IRQs together */
     uart_orgate = DEVICE(object_new(TYPE_OR_IRQ));
     object_property_set_int(OBJECT(uart_orgate), "num-lines", 2, &error_fatal);
     qdev_realize_and_unref(uart_orgate, NULL, &error_fatal);
-    qdev_connect_gpio_out(DEVICE(uart_orgate), 0, pic[MP_UART_SHARED_IRQ]);
+    qdev_connect_gpio_out(DEVICE(uart_orgate), 0,
+                          qdev_get_gpio_in(pic, MP_UART_SHARED_IRQ));
 
     serial_mm_init(address_space_mem, MP_UART1_BASE, 2,
                    qdev_get_gpio_in(uart_orgate, 0),
@@ -1674,14 +1674,15 @@ static void musicpal_init(MachineState *machine)
                              OBJECT(get_system_memory()), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MP_ETH_BASE);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[MP_ETH_IRQ]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(pic, MP_ETH_IRQ));
 
     sysbus_create_simple("mv88w8618_wlan", MP_WLAN_BASE, NULL);
 
     sysbus_create_simple(TYPE_MUSICPAL_MISC, MP_MISC_BASE, NULL);
 
     dev = sysbus_create_simple(TYPE_MUSICPAL_GPIO, MP_GPIO_BASE,
-                               pic[MP_GPIO_IRQ]);
+                               qdev_get_gpio_in(pic, MP_GPIO_IRQ));
     i2c_dev = sysbus_create_simple("gpio_i2c", -1, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(i2c_dev, "i2c");
 
@@ -1713,7 +1714,7 @@ static void musicpal_init(MachineState *machine)
                              NULL);
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
-    sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(pic, MP_AUDIO_IRQ));
 
     musicpal_binfo.ram_size = MP_RAM_DEFAULT_SIZE;
     arm_load_kernel(cpu, machine, &musicpal_binfo);
-- 
2.26.2



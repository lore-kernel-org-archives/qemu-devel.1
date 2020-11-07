Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E97CC388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EB402087E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usdV4vQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB402087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbU1M-0001KP-DB
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 14:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyn-0007tZ-RW; Sat, 07 Nov 2020 14:34:29 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTym-0008MC-AR; Sat, 07 Nov 2020 14:34:29 -0500
Received: by mail-wm1-x334.google.com with SMTP id d142so4549190wmd.4;
 Sat, 07 Nov 2020 11:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IWHQ4zGNPskYzL/akHXO5stc1InHlH57u2pVf49lbSo=;
 b=usdV4vQZ1IclT8J7iUAbyQ7oGZe+DBjrkIvsyG/6y/WGIr7QrLNtVs8fdC1YNOzIm/
 T5E9HwWtrYvYkRFYi/d8HnVP2RhxGYIOucLVl3AW1G9YYxxegty+xtofGNFbFlnlxRQp
 Cq7q43ewAyqZ5mUr20//056ytxru/MP3OvY7OcJqaxxU133ium/lMbfnbGYPjJopV+3A
 BaqV8/7amoP+D879Fun9tMuDsNM4aPTBI+DZ1jEAKdEcnuxvTQ5Fz5I5+NuAmDPakTRv
 VymbX7SuL7QLYC4DGysGoOy0MTKDhiLndlao0RYyneg9ENUQ07RoVmj8F/ag8tUaOIgd
 blXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IWHQ4zGNPskYzL/akHXO5stc1InHlH57u2pVf49lbSo=;
 b=rjIh9KoMECMW3EaJGXDy6c29dR7a7LePHMP13GJp4kei9xzMahe+anVJMW/leSKO+F
 j3R0pJ+BgiwEf83j3AV5d3I4kOhQKtuKhEmVk2r0yUwrfjp09NkrqC+8vFovu3o2GNd9
 YZ8Y2SPK6IQqkIsIpUGEmu9P+GQV0CJyDx9XSCUnVgPNQ/Dwizxo3X4ou1qXcTCwPoUc
 5ciDCjgi050aXl86zOb/gX6IpIJMKSjTu0OihwHMdOh/Hep2Hvwd9juzLApBq/OWG/mU
 d7/XkszkJlQUwu5M/yu3f2XUgd09aMB7XZV9EaJKzLBIvQEEr5NNLxgY5OjOrxSe5XjQ
 IrXw==
X-Gm-Message-State: AOAM531G0HlAFdLN61RRIbRYqZpMbgPiVfiMiD1bkygnJ/HAJrPF49Y5
 bMcM7lw8Om8ErazyBPYD43spkLjSgDk=
X-Google-Smtp-Source: ABdhPJwxI6y3vKynt/gYrD08m/TxE/J+PPvvYqOF5LVBMzUGPmvonJwRmvAIVwiN+gzoWXCT07Xekw==
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr6113072wmd.73.1604777666245; 
 Sat, 07 Nov 2020 11:34:26 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s4sm194076wro.10.2020.11.07.11.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 11:34:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2? 4/5] hw/arm/musicpal: Don't connect two qemu_irqs
 directly to the same input
Date: Sat,  7 Nov 2020 20:34:02 +0100
Message-Id: <20201107193403.436146-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107193403.436146-1-f4bug@amsat.org>
References: <20201107193403.436146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
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

The MusicPal board code connects both of the IRQ outputs of the UART
to the same INTC qemu_irq. Connecting two qemu_irqs outputs directly
to the same input is not valid as it produces subtly wrong behaviour
(for instance if both the IRQ lines are high, and then one goes
low, the INTC input will see this as a high-to-low transition
even though the second IRQ line should still be holding it high).

This kind of wiring needs an explicitly created OR gate; add one.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/musicpal.c | 17 +++++++++++++----
 hw/arm/Kconfig    |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 5eb3f969fb4..ebc3ec24ef7 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -27,6 +27,7 @@
 #include "ui/console.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
+#include "hw/or-irq.h"
 #include "hw/audio/wm8750.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/runstate.h"
@@ -77,8 +78,7 @@
 #define MP_TIMER4_IRQ           7
 #define MP_EHCI_IRQ             8
 #define MP_ETH_IRQ              9
-#define MP_UART1_IRQ            11
-#define MP_UART2_IRQ            11
+#define MP_UART_SHARED_IRQ      11
 #define MP_GPIO_IRQ             12
 #define MP_RTC_IRQ              28
 #define MP_AUDIO_IRQ            30
@@ -1589,6 +1589,7 @@ static void musicpal_init(MachineState *machine)
     ARMCPU *cpu;
     qemu_irq pic[32];
     DeviceState *dev;
+    DeviceState *uart_orgate;
     DeviceState *i2c_dev;
     DeviceState *lcd_dev;
     DeviceState *key_dev;
@@ -1627,9 +1628,17 @@ static void musicpal_init(MachineState *machine)
                           pic[MP_TIMER2_IRQ], pic[MP_TIMER3_IRQ],
                           pic[MP_TIMER4_IRQ], NULL);
 
-    serial_mm_init(address_space_mem, MP_UART1_BASE, 2, pic[MP_UART1_IRQ],
+    /* Logically OR both UART IRQs together */
+    uart_orgate = DEVICE(object_new(TYPE_OR_IRQ));
+    object_property_set_int(OBJECT(uart_orgate), "num-lines", 2, &error_fatal);
+    qdev_realize_and_unref(uart_orgate, NULL, &error_fatal);
+    qdev_connect_gpio_out(DEVICE(uart_orgate), 0, pic[MP_UART_SHARED_IRQ]);
+
+    serial_mm_init(address_space_mem, MP_UART1_BASE, 2,
+                   qdev_get_gpio_in(uart_orgate, 0),
                    1825000, serial_hd(0), DEVICE_NATIVE_ENDIAN);
-    serial_mm_init(address_space_mem, MP_UART2_BASE, 2, pic[MP_UART2_IRQ],
+    serial_mm_init(address_space_mem, MP_UART2_BASE, 2,
+                   qdev_get_gpio_in(uart_orgate, 1),
                    1825000, serial_hd(1), DEVICE_NATIVE_ENDIAN);
 
     /* Register flash */
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fdf4464b948..319916c310e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -94,6 +94,7 @@ config MUSCA
 
 config MUSICPAL
     bool
+    select OR_IRQ
     select BITBANG_I2C
     select MARVELL_88W8618
     select PTIMER
-- 
2.26.2



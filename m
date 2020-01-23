Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207ADC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE0B21835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdPVjOxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE0B21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuV7S-00053o-P1
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iuV0I-0004wY-G8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iuV0G-0001rl-ST
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:26:06 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iuV0B-0001pK-MX; Thu, 23 Jan 2020 00:25:59 -0500
Received: by mail-pg1-x541.google.com with SMTP id 4so771213pgd.6;
 Wed, 22 Jan 2020 21:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KeM+UcLJ0eZCHHeipWPmwwPiaN02ZhSI49JMqf9Y4mU=;
 b=QdPVjOxMhYXoon6u89PhZsZHpR/3WcQt09Zpc622s6LKjlcfYF4f8wOyY/ORFw4XdH
 cPjfeEtwD4msjL0lJGc2SDWESk65+UqKvK6j95RIO2KCQbWS7M6UoV622lVPKteDoG0m
 lSSff/8issKkvZcP4W49YLPytK7zrKiBKPB3M8q3AUCfaIyaqtvZ1frEzYhD0DlkmxsE
 dYiDy7u+lDyg4Nc0+5M4AjFVrT/FxxJkiZk8pPE3YvQoxBK/lySnaogcR5/Hp/tv7zqi
 FXTObFRH3T2J6jP0IqdqKDlbh7Fh3JD21oLbpGdQQbh5tlGvt8S2hrV/Zu1twWGDH7QW
 p5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=KeM+UcLJ0eZCHHeipWPmwwPiaN02ZhSI49JMqf9Y4mU=;
 b=gNDoFNmTDNJ53We4yUNu3k3L4zzpOs5e4PApPDyqvcpBkRo7IAUv9SEO3iTSfYCCNV
 BlTE00VXUHmPetLmNVWPpaavm2GbbQvXu/8LbsDkLy5JoB5ottLfIRhh6cEVIxZ97S0I
 2jjoTelo8+pzvWkpSxo/z/R1EiyTqfc8htNSplEw8lm/j96sNPu+I5Yyy43yEZeLvhKe
 Iyyq1TNmZ/PSGHj0FGnhkRuX3C2ngZBrZS9u/tzZEEUpZFH8XscwBDbsM/upEeDBXAic
 CxuGIa0g/OpKwJaTRAZjJHR9HQoZHuB0oVn/0m+cM8o9lT4Y/t6IU2kZjAXc8MccmoFB
 7pJA==
X-Gm-Message-State: APjAAAXRHrDPI1PgiitQ+amvsB3FJlEtNoeakeiMrUHhvoltG8pavo+D
 S8uYfAptP4G88qtRcSQziHU=
X-Google-Smtp-Source: APXvYqzoIdeEopZGCNkFFwLebtJ4ETGdRWYwX2xufS5RIjnhRAbP7q4Q9sJp4wwQJcifKb5UBvYdrg==
X-Received: by 2002:a62:83c5:: with SMTP id h188mr5963479pfe.0.1579757157542; 
 Wed, 22 Jan 2020 21:25:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 17sm730160pfv.142.2020.01.22.21.25.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 22 Jan 2020 21:25:57 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 7/8] hw/char/exynos4210_uart: Add receive DMA support
Date: Wed, 22 Jan 2020 21:25:39 -0800
Message-Id: <20200123052540.6132-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123052540.6132-1-linux@roeck-us.net>
References: <20200123052540.6132-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To support receive DMA, we need to inform the DMA controller if receive data
is available. Otherwise the DMA controller keeps requesting data, causing
receive errors.

Implement this using an interrupt line. The instantiating code then needs
to connect the interrupt with the matching DMA controller GPIO pin.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: No change

v2: Added Reviewed-by: tag

 hw/char/exynos4210_uart.c | 24 ++++++++++++++++++++++++
 hw/char/trace-events      |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 8d6b4a071e..bf9e586e79 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -154,6 +154,7 @@ typedef struct Exynos4210UartState {
 
     CharBackend       chr;
     qemu_irq          irq;
+    qemu_irq          dmairq;
 
     uint32_t channel;
 
@@ -261,6 +262,24 @@ exynos4210_uart_Rx_FIFO_trigger_level(const Exynos4210UartState *s)
     return exynos4210_uart_FIFO_trigger_level(s->channel, reg);
 }
 
+/*
+ * Update Rx DMA busy signal if Rx DMA is enabled. For simplicity,
+ * mark DMA as busy if DMA is enabled and the receive buffer is empty.
+ */
+static void exynos4210_uart_update_dmabusy(Exynos4210UartState *s)
+{
+    bool rx_dma_enabled = (s->reg[I_(UCON)] & 0x03) == 0x02;
+    uint32_t count = fifo_elements_number(&s->rx);
+
+    if (rx_dma_enabled && !count) {
+        qemu_irq_raise(s->dmairq);
+        trace_exynos_uart_dmabusy(s->channel);
+    } else {
+        qemu_irq_lower(s->dmairq);
+        trace_exynos_uart_dmaready(s->channel);
+    }
+}
+
 static void exynos4210_uart_update_irq(Exynos4210UartState *s)
 {
     /*
@@ -282,10 +301,12 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
         count = fifo_elements_number(&s->rx);
         if ((count && !(s->reg[I_(UCON)] & 0x80)) ||
             count >= exynos4210_uart_Rx_FIFO_trigger_level(s)) {
+            exynos4210_uart_update_dmabusy(s);
             s->reg[I_(UINTSP)] |= UINTSP_RXD;
             timer_del(s->fifo_timeout_timer);
         }
     } else if (s->reg[I_(UTRSTAT)] & UTRSTAT_Rx_BUFFER_DATA_READY) {
+        exynos4210_uart_update_dmabusy(s);
         s->reg[I_(UINTSP)] |= UINTSP_RXD;
     }
 
@@ -311,6 +332,7 @@ static void exynos4210_uart_timeout_int(void *opaque)
         (s->reg[I_(UCON)] & (1 << 11))) {
         s->reg[I_(UINTSP)] |= UINTSP_RXD;
         s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_TIMEOUT;
+        exynos4210_uart_update_dmabusy(s);
         exynos4210_uart_update_irq(s);
     }
 }
@@ -495,6 +517,7 @@ static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
             s->reg[I_(UTRSTAT)] &= ~UTRSTAT_Rx_BUFFER_DATA_READY;
             res = s->reg[I_(URXH)];
         }
+        exynos4210_uart_update_dmabusy(s);
         trace_exynos_uart_read(s->channel, offset,
                                exynos4210_uart_regname(offset), res);
         return res;
@@ -661,6 +684,7 @@ static void exynos4210_uart_init(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 
     sysbus_init_irq(dev, &s->irq);
+    sysbus_init_irq(dev, &s->dmairq);
 }
 
 static void exynos4210_uart_realize(DeviceState *dev, Error **errp)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index cb73fee6a9..6f938301d9 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -79,6 +79,8 @@ nrf51_uart_read(uint64_t addr, uint64_t r, unsigned int size) "addr 0x%" PRIx64
 nrf51_uart_write(uint64_t addr, uint64_t value, unsigned int size) "addr 0x%" PRIx64 " value 0x%" PRIx64 " size %u"
 
 # exynos4210_uart.c
+exynos_uart_dmabusy(uint32_t channel) "UART%d: DMA busy (Rx buffer empty)"
+exynos_uart_dmaready(uint32_t channel) "UART%d: DMA ready"
 exynos_uart_irq_raised(uint32_t channel, uint32_t reg) "UART%d: IRQ raised: 0x%08"PRIx32
 exynos_uart_irq_lowered(uint32_t channel) "UART%d: IRQ lowered"
 exynos_uart_update_params(uint32_t channel, int speed, uint8_t parity, int data, int stop, uint64_t wordtime) "UART%d: speed: %d, parity: %c, data bits: %d, stop bits: %d wordtime: %"PRId64"ns"
-- 
2.17.1



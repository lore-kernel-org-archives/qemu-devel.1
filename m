Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D6EC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A1121835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSCZowX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A1121835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuV6f-0004Mf-Tw
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iuV0H-0004vA-FP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iuV0F-0001rL-KN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:26:05 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iuV0A-0001ol-0y; Thu, 23 Jan 2020 00:25:58 -0500
Received: by mail-pj1-x1042.google.com with SMTP id s7so710915pjc.0;
 Wed, 22 Jan 2020 21:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rQNYGv9KlroXur59rvYeczF8ZGHTU/mUuy+9ut/zKbk=;
 b=uSCZowX5WeHuHl7OmFbvRgJyAP6vz95DZL9Cj3OH5WU0dcKs8YMJdL3tnh//PLDrGz
 T6AlI9nrFLLbsSEJARrlrS1p7z0JDOcS5slZK+OoEDUgIwSM1zjV7BpRhzy4Zw9O5p9O
 //K2drpP4lYoqsLJLHnbfUBLHBsMvePfwixi9QfqvTB3BOz76fK1Xl4VwrkAE3HzKzD2
 UsUpcw91/o8kjKrm9/VxEp36BWr2PMDkypC2jsWPaKpw5IERQ+LXPExyAHnBrv47ZbWE
 G4DYkzdDHW5Fy7vYYOqRNf52V41Kulufsv1t0juOEOdWy1MH9uNbmuBVPMMm2dBASPx8
 dVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=rQNYGv9KlroXur59rvYeczF8ZGHTU/mUuy+9ut/zKbk=;
 b=GKQrOMrLqG/WGMeYsmjIVdspJHNeUVD5zSug+PuBRbzCSAYrL0+hBrmjaSseAS8nRX
 7Jgk1Wx439oj5q0dKz/NpkRi+rKoiUv6+GzRQHiA+OpLevLMzraDyBhxP6zazNt3er3e
 9i1JN+I/zfeLAkiXLN6o7C71U8NAcSIQVf3FRGqu8ReKDh3OPXIQFGgBify2xl0A844e
 nYOlpW/ydkCByRKgCzod5Ak6vuzjzuclQD2UfhHLB/qZdugFvwS4JnP+T/Vr60WX59qY
 Qpso9x3ofxvvV9lN44AG49nn0+UngX1UKlLQrYeM4vChk1yr6ATf9rFBcZg1QEOW2Yof
 bv+w==
X-Gm-Message-State: APjAAAVLvdb20syEqA2HkVyg6z1DSO0ODJMQQdFPy1R8vyUxyH7oNd40
 r8PQ4tjDkkf0703gzczC6K8=
X-Google-Smtp-Source: APXvYqxNsA0texJAdGQbzetGuwjslvvgEFm5QITJyzyaVtmuvtGqg3OEie4JpKbTH+VNWPso8gUE+w==
X-Received: by 2002:a17:90a:7345:: with SMTP id
 j5mr2392120pjs.69.1579757156191; 
 Wed, 22 Jan 2020 21:25:56 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id d3sm697675pfn.113.2020.01.22.21.25.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 22 Jan 2020 21:25:55 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 6/8] hw/char/exynos4210_uart: Implement Rx FIFO level
 triggers and timeouts
Date: Wed, 22 Jan 2020 21:25:38 -0800
Message-Id: <20200123052540.6132-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123052540.6132-1-linux@roeck-us.net>
References: <20200123052540.6132-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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

The driver already implements a receive FIFO, but it does not
handle receive FIFO trigger levels and timeout. Implement the
missing functionality.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Dropped VMSTATE_TIMER_PTR
    Don't call exynos4210_uart_rx_timeout_set() and
    exynos4210_uart_update_irq() after writes into the UCON register.
    Chip behavior in this situation is not specified and any handling
    may be inaccurate, so do nothing.

v2: Call exynos4210_uart_rx_timeout_set() from new post_load function
    to set the receive timeout timer.
    Add timer to vmstate_exynos4210_uart.

 hw/char/exynos4210_uart.c | 117 ++++++++++++++++++++++++++++++--------
 hw/char/trace-events      |   3 +-
 2 files changed, 94 insertions(+), 26 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 5d48701b6d..8d6b4a071e 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -24,6 +24,7 @@
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "qemu/timer.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
 
@@ -118,6 +119,7 @@ static const Exynos4210UartReg exynos4210_uart_regs[] = {
 #define ULCON_STOP_BIT_SHIFT  1
 
 /* UART Tx/Rx Status */
+#define UTRSTAT_Rx_TIMEOUT              0x8
 #define UTRSTAT_TRANSMITTER_EMPTY       0x4
 #define UTRSTAT_Tx_BUFFER_EMPTY         0x2
 #define UTRSTAT_Rx_BUFFER_DATA_READY    0x1
@@ -147,6 +149,9 @@ typedef struct Exynos4210UartState {
     Exynos4210UartFIFO   rx;
     Exynos4210UartFIFO   tx;
 
+    QEMUTimer *fifo_timeout_timer;
+    uint64_t wordtime;        /* word time in ns */
+
     CharBackend       chr;
     qemu_irq          irq;
 
@@ -209,15 +214,12 @@ static void fifo_reset(Exynos4210UartFIFO *q)
     q->rp = 0;
 }
 
-static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState *s)
+static uint32_t exynos4210_uart_FIFO_trigger_level(uint32_t channel,
+                                                   uint32_t reg)
 {
-    uint32_t level = 0;
-    uint32_t reg;
+    uint32_t level;
 
-    reg = (s->reg[I_(UFCON)] & UFCON_Tx_FIFO_TRIGGER_LEVEL) >>
-            UFCON_Tx_FIFO_TRIGGER_LEVEL_SHIFT;
-
-    switch (s->channel) {
+    switch (channel) {
     case 0:
         level = reg * 32;
         break;
@@ -231,12 +233,34 @@ static uint32_t exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState
         break;
     default:
         level = 0;
-        trace_exynos_uart_channel_error(s->channel);
+        trace_exynos_uart_channel_error(channel);
+        break;
     }
-
     return level;
 }
 
+static uint32_t
+exynos4210_uart_Tx_FIFO_trigger_level(const Exynos4210UartState *s)
+{
+    uint32_t reg;
+
+    reg = (s->reg[I_(UFCON)] & UFCON_Tx_FIFO_TRIGGER_LEVEL) >>
+            UFCON_Tx_FIFO_TRIGGER_LEVEL_SHIFT;
+
+    return exynos4210_uart_FIFO_trigger_level(s->channel, reg);
+}
+
+static uint32_t
+exynos4210_uart_Rx_FIFO_trigger_level(const Exynos4210UartState *s)
+{
+    uint32_t reg;
+
+    reg = ((s->reg[I_(UFCON)] & UFCON_Rx_FIFO_TRIGGER_LEVEL) >>
+            UFCON_Rx_FIFO_TRIGGER_LEVEL_SHIFT) + 1;
+
+    return exynos4210_uart_FIFO_trigger_level(s->channel, reg);
+}
+
 static void exynos4210_uart_update_irq(Exynos4210UartState *s)
 {
     /*
@@ -244,13 +268,25 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
      * transmit FIFO is smaller than the trigger level.
      */
     if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
-
         uint32_t count = (s->reg[I_(UFSTAT)] & UFSTAT_Tx_FIFO_COUNT) >>
                 UFSTAT_Tx_FIFO_COUNT_SHIFT;
 
         if (count <= exynos4210_uart_Tx_FIFO_trigger_level(s)) {
             s->reg[I_(UINTSP)] |= UINTSP_TXD;
         }
+
+        /*
+         * Rx interrupt if trigger level is reached or if rx timeout
+         * interrupt is disabled and there is data in the receive buffer
+         */
+        count = fifo_elements_number(&s->rx);
+        if ((count && !(s->reg[I_(UCON)] & 0x80)) ||
+            count >= exynos4210_uart_Rx_FIFO_trigger_level(s)) {
+            s->reg[I_(UINTSP)] |= UINTSP_RXD;
+            timer_del(s->fifo_timeout_timer);
+        }
+    } else if (s->reg[I_(UTRSTAT)] & UTRSTAT_Rx_BUFFER_DATA_READY) {
+        s->reg[I_(UINTSP)] |= UINTSP_RXD;
     }
 
     s->reg[I_(UINTP)] = s->reg[I_(UINTSP)] & ~s->reg[I_(UINTM)];
@@ -264,6 +300,21 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
     }
 }
 
+static void exynos4210_uart_timeout_int(void *opaque)
+{
+    Exynos4210UartState *s = opaque;
+
+    trace_exynos_uart_rx_timeout(s->channel, s->reg[I_(UTRSTAT)],
+                                 s->reg[I_(UINTSP)]);
+
+    if ((s->reg[I_(UTRSTAT)] & UTRSTAT_Rx_BUFFER_DATA_READY) ||
+        (s->reg[I_(UCON)] & (1 << 11))) {
+        s->reg[I_(UINTSP)] |= UINTSP_RXD;
+        s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_TIMEOUT;
+        exynos4210_uart_update_irq(s);
+    }
+}
+
 static void exynos4210_uart_update_parameters(Exynos4210UartState *s)
 {
     int speed, parity, data_bits, stop_bits;
@@ -302,10 +353,24 @@ static void exynos4210_uart_update_parameters(Exynos4210UartState *s)
     ssp.data_bits = data_bits;
     ssp.stop_bits = stop_bits;
 
+    s->wordtime = NANOSECONDS_PER_SECOND * (data_bits + stop_bits + 1) / speed;
+
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 
     trace_exynos_uart_update_params(
-                s->channel, speed, parity, data_bits, stop_bits);
+                s->channel, speed, parity, data_bits, stop_bits, s->wordtime);
+}
+
+static void exynos4210_uart_rx_timeout_set(Exynos4210UartState *s)
+{
+    if (s->reg[I_(UCON)] & 0x80) {
+        uint32_t timeout = ((s->reg[I_(UCON)] >> 12) & 0x0f) * s->wordtime;
+
+        timer_mod(s->fifo_timeout_timer,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + timeout);
+    } else {
+        timer_del(s->fifo_timeout_timer);
+    }
 }
 
 static void exynos4210_uart_write(void *opaque, hwaddr offset,
@@ -361,6 +426,10 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
         exynos4210_uart_update_irq(s);
         break;
     case UTRSTAT:
+        if (val & UTRSTAT_Rx_TIMEOUT) {
+            s->reg[I_(UTRSTAT)] &= ~UTRSTAT_Rx_TIMEOUT;
+        }
+        break;
     case UERSTAT:
     case UFSTAT:
     case UMSTAT:
@@ -382,6 +451,7 @@ static void exynos4210_uart_write(void *opaque, hwaddr offset,
         break;
     }
 }
+
 static uint64_t exynos4210_uart_read(void *opaque, hwaddr offset,
                                   unsigned size)
 {
@@ -461,7 +531,6 @@ static int exynos4210_uart_can_receive(void *opaque)
     return fifo_empty_elements_number(&s->rx);
 }
 
-
 static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, int size)
 {
     Exynos4210UartState *s = (Exynos4210UartState *)opaque;
@@ -469,24 +538,17 @@ static void exynos4210_uart_receive(void *opaque, const uint8_t *buf, int size)
 
     if (s->reg[I_(UFCON)] & UFCON_FIFO_ENABLE) {
         if (fifo_empty_elements_number(&s->rx) < size) {
-            for (i = 0; i < fifo_empty_elements_number(&s->rx); i++) {
-                fifo_store(&s->rx, buf[i]);
-            }
+            size = fifo_empty_elements_number(&s->rx);
             s->reg[I_(UINTSP)] |= UINTSP_ERROR;
-            s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
-        } else {
-            for (i = 0; i < size; i++) {
-                fifo_store(&s->rx, buf[i]);
-            }
-            s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
         }
-        /* XXX: Around here we maybe should check Rx trigger level */
-        s->reg[I_(UINTSP)] |= UINTSP_RXD;
+        for (i = 0; i < size; i++) {
+            fifo_store(&s->rx, buf[i]);
+        }
+        exynos4210_uart_rx_timeout_set(s);
     } else {
         s->reg[I_(URXH)] = buf[0];
-        s->reg[I_(UINTSP)] |= UINTSP_RXD;
-        s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
     }
+    s->reg[I_(UTRSTAT)] |= UTRSTAT_Rx_BUFFER_DATA_READY;
 
     exynos4210_uart_update_irq(s);
 }
@@ -527,6 +589,7 @@ static int exynos4210_uart_post_load(void *opaque, int version_id)
     Exynos4210UartState *s = (Exynos4210UartState *)opaque;
 
     exynos4210_uart_update_parameters(s);
+    exynos4210_uart_rx_timeout_set(s);
 
     return 0;
 }
@@ -588,6 +651,10 @@ static void exynos4210_uart_init(Object *obj)
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     Exynos4210UartState *s = EXYNOS4210_UART(dev);
 
+    s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                         exynos4210_uart_timeout_int, s);
+    s->wordtime = NANOSECONDS_PER_SECOND * 10 / 9600;
+
     /* memory mapping */
     memory_region_init_io(&s->iomem, obj, &exynos4210_uart_ops, s,
                           "exynos4210.uart", EXYNOS4210_UART_REGS_MEM_SIZE);
diff --git a/hw/char/trace-events b/hw/char/trace-events
index ba28b45b53..cb73fee6a9 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -81,7 +81,7 @@ nrf51_uart_write(uint64_t addr, uint64_t value, unsigned int size) "addr 0x%" PR
 # exynos4210_uart.c
 exynos_uart_irq_raised(uint32_t channel, uint32_t reg) "UART%d: IRQ raised: 0x%08"PRIx32
 exynos_uart_irq_lowered(uint32_t channel) "UART%d: IRQ lowered"
-exynos_uart_update_params(uint32_t channel, int speed, uint8_t parity, int data, int stop) "UART%d: speed: %d, parity: %c, data bits: %d, stop bits: %d"
+exynos_uart_update_params(uint32_t channel, int speed, uint8_t parity, int data, int stop, uint64_t wordtime) "UART%d: speed: %d, parity: %c, data bits: %d, stop bits: %d wordtime: %"PRId64"ns"
 exynos_uart_write(uint32_t channel, uint32_t offset, const char *name, uint64_t val) "UART%d: <0x%04x> %s <- 0x%" PRIx64
 exynos_uart_read(uint32_t channel, uint32_t offset, const char *name, uint64_t val) "UART%d: <0x%04x> %s -> 0x%" PRIx64
 exynos_uart_rx_fifo_reset(uint32_t channel) "UART%d: Rx FIFO Reset"
@@ -94,3 +94,4 @@ exynos_uart_rx_error(uint32_t channel) "UART%d: Rx error"
 exynos_uart_wo_read(uint32_t channel, const char *name, uint32_t reg) "UART%d: Trying to read from WO register: %s [0x%04"PRIx32"]"
 exynos_uart_rxsize(uint32_t channel, uint32_t size) "UART%d: Rx FIFO size: %d"
 exynos_uart_channel_error(uint32_t channel) "Wrong UART channel number: %d"
+exynos_uart_rx_timeout(uint32_t channel, uint32_t stat, uint32_t intsp) "UART%d: Rx timeout stat=0x%x intsp=0x%x"
-- 
2.17.1



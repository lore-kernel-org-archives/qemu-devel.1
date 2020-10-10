Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2617EC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04DA20795
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0fmYaTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04DA20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLeO-0004O9-R4
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLcF-0001zO-Im; Sat, 10 Oct 2020 16:37:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLcD-0006dE-In; Sat, 10 Oct 2020 16:37:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id e17so14129393wru.12;
 Sat, 10 Oct 2020 13:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2dF62r5NGZYv16IvnRIG9HnMALb65UHicnzi+SydcjI=;
 b=e0fmYaTisHLP6PC/i6eCzL8J7CfeTvC0kJpYM33AyznUGFfEDNUmuRHsyxU8nYJa4U
 W2KaKXjgz/6aJFaBFcFK0k4al+qLvXn8PDwjCPQnkWoh4Dyb7oesdPk91QdjfPoP0mCr
 ViGO/ZvTR29KxfZc+VzBZ1wEaiY3uAybXKNXtE1sFrNHg67NR1xAaJgxIPZBLxPXTVIu
 Pr+VT/8NtXCBud79jas1LzokmQhNftgtIj9V5j9MLo7xh48KH5GfK6vKASKCeLuFh+0F
 t0s+aD6Ud6pEewVl9wT2dF5rPwQN8t5ADrM2f6/BMS29oggq/5o118tQMqoI7hjJ61WT
 h2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2dF62r5NGZYv16IvnRIG9HnMALb65UHicnzi+SydcjI=;
 b=pKbbJySVmfTEqbQrfcl9d1siA5pk+bBbzLfX3siK13rUOv9wBDUME3qFQc0tLj2iph
 p2pAMW9DfBk6mzhSshoOvM5Ld87lUGfwFzKSU4nnN6WN90WSJ/SK8ZsW1NLUOYl2fudX
 qUOGgFfjE5jO+9YGQOKSOOaBVn+xdvubYErqmgu2uG6xiFtbKM8L/lw/yC2eTG6NNAXb
 WP+La9BauaaG1lDjCbZ+f9wE+Y3r1h3QiKA5/oBEPfxWe1JCTWjLHTq+fmypK5Lypxsn
 OHtg/TND5ONF4wNn3jc1qBVCOavx3dZGwbQG1wrx3pFl8vtEt7962bbJ7Y7VuFaWX2vP
 BJrQ==
X-Gm-Message-State: AOAM531uZF7jJVyYnxGEhwrDCn9UphPLDHubH3q4tPyo+4GDFEWniZ/b
 yqtft1amxHpc8OzUPmCd1ORXfs7RsGc=
X-Google-Smtp-Source: ABdhPJwI63yq1KEdkRiKFUbDWugdns1owB7uFsDYxTH4TokX+6TUUfl2KV0S+Rn6F52z/53mIGGVAQ==
X-Received: by 2002:a5d:4451:: with SMTP id x17mr4734033wrr.176.1602362235666; 
 Sat, 10 Oct 2020 13:37:15 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v17sm5661341wru.44.2020.10.10.13.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:37:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/4] hw/timer/bcm2835: Support the timer COMPARE registers
Date: Sat, 10 Oct 2020 22:37:08 +0200
Message-Id: <20201010203709.3116542-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010203709.3116542-1-f4bug@amsat.org>
References: <20201010203709.3116542-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This peripheral has 1 free-running timer and 4 compare registers.

Only the free-running timer is implemented. Add support the
COMPARE registers (each register is wired to an IRQ).

Reference: "BCM2835 ARM Peripherals" datasheet [*]
            chapter 12 "System Timer":

  The System Timer peripheral provides four 32-bit timer channels
  and a single 64-bit free running counter. Each channel has an
  output compare register, which is compared against the 32 least
  significant bits of the free running counter values. When the
  two values match, the system timer peripheral generates a signal
  to indicate a match for the appropriate channel. The match signal
  is then fed into the interrupt controller.

This peripheral is used since Linux 3.7, commit ee4af5696720
("ARM: bcm2835: add system timer").

[*] https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v4:
- Fix arithmetic to correctly get value in future (Richard)
- Use 32-bit argument value (Richard)
v3:
- Only compare 32 least significant bits of the free running
  counter values (Luc)
---
 include/hw/timer/bcm2835_systmr.h | 11 +++++--
 hw/timer/bcm2835_systmr.c         | 48 ++++++++++++++++++++-----------
 hw/timer/trace-events             |  6 ++--
 3 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index f15788a78d8..bd3097d746b 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -11,6 +11,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/irq.h"
+#include "qemu/timer.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
@@ -18,18 +19,24 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2835SystemTimerState, BCM2835_SYSTIMER)
 
 #define BCM2835_SYSTIMER_COUNT 4
 
+typedef struct {
+    unsigned id;
+    QEMUTimer timer;
+    qemu_irq irq;
+    BCM2835SystemTimerState *state;
+} BCM2835SystemTimerCompare;
+
 struct BCM2835SystemTimerState {
     /*< private >*/
     SysBusDevice parent_obj;
 
     /*< public >*/
     MemoryRegion iomem;
-    qemu_irq irq;
-
     struct {
         uint32_t ctrl_status;
         uint32_t compare[BCM2835_SYSTIMER_COUNT];
     } reg;
+    BCM2835SystemTimerCompare tmr[BCM2835_SYSTIMER_COUNT];
 };
 
 #endif
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index b234e83824f..67669a57ff3 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -28,20 +28,13 @@ REG32(COMPARE1,     0x10)
 REG32(COMPARE2,     0x14)
 REG32(COMPARE3,     0x18)
 
-static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
+static void bcm2835_systmr_timer_expire(void *opaque)
 {
-    bool enable = !!s->reg.ctrl_status;
+    BCM2835SystemTimerCompare *tmr = opaque;
 
-    trace_bcm2835_systmr_irq(enable);
-    qemu_set_irq(s->irq, enable);
-}
-
-static void bcm2835_systmr_update_compare(BCM2835SystemTimerState *s,
-                                          unsigned timer_index)
-{
-    /* TODO fow now, since neither Linux nor U-boot use these timers. */
-    qemu_log_mask(LOG_UNIMP, "COMPARE register %u not implemented\n",
-                  timer_index);
+    trace_bcm2835_systmr_timer_expired(tmr->id);
+    tmr->state->reg.ctrl_status |= 1 << tmr->id;
+    qemu_set_irq(tmr->irq, 1);
 }
 
 static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
@@ -75,19 +68,33 @@ static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
 }
 
 static void bcm2835_systmr_write(void *opaque, hwaddr offset,
-                                 uint64_t value, unsigned size)
+                                 uint64_t value64, unsigned size)
 {
     BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
+    int index;
+    uint32_t value = value64;
+    uint32_t triggers_delay_us;
+    uint64_t now;
 
     trace_bcm2835_systmr_write(offset, value);
     switch (offset) {
     case A_CTRL_STATUS:
         s->reg.ctrl_status &= ~value; /* Ack */
-        bcm2835_systmr_update_irq(s);
+        for (index = 0; index < ARRAY_SIZE(s->tmr); index++) {
+            if (extract32(value, index, 1)) {
+                trace_bcm2835_systmr_irq_ack(index);
+                qemu_set_irq(s->tmr[index].irq, 0);
+            }
+        }
         break;
     case A_COMPARE0 ... A_COMPARE3:
-        s->reg.compare[(offset - A_COMPARE0) >> 2] = value;
-        bcm2835_systmr_update_compare(s, (offset - A_COMPARE0) >> 2);
+        index = (offset - A_COMPARE0) >> 2;
+        s->reg.compare[index] = value;
+        now = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+        /* Compare lower 32-bits of the free-running counter. */
+        triggers_delay_us = value - now;
+        trace_bcm2835_systmr_run(index, triggers_delay_us);
+        timer_mod(&s->tmr[index].timer, now + triggers_delay_us);
         break;
     case A_COUNTER_LOW:
     case A_COUNTER_HIGH:
@@ -125,7 +132,14 @@ static void bcm2835_systmr_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_systmr_ops,
                           s, "bcm2835-sys-timer", 0x20);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+
+    for (size_t i = 0; i < ARRAY_SIZE(s->tmr); i++) {
+        s->tmr[i].id = i;
+        s->tmr[i].state = s;
+        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->tmr[i].irq);
+        timer_init_us(&s->tmr[i].timer, QEMU_CLOCK_VIRTUAL,
+                      bcm2835_systmr_timer_expire, &s->tmr[i]);
+    }
 }
 
 static const VMStateDescription bcm2835_systmr_vmstate = {
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index b996d992000..7a4326d9566 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -77,9 +77,11 @@ nrf51_timer_write(uint8_t timer_id, uint64_t addr, uint32_t value, unsigned size
 nrf51_timer_set_count(uint8_t timer_id, uint8_t counter_id, uint32_t value) "timer %u counter %u count 0x%" PRIx32
 
 # bcm2835_systmr.c
-bcm2835_systmr_irq(bool enable) "timer irq state %u"
+bcm2835_systmr_timer_expired(unsigned id) "timer #%u expired"
+bcm2835_systmr_irq_ack(unsigned id) "timer #%u acked"
 bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset 0x%" PRIx64 " data 0x%" PRIx64
-bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offset 0x%" PRIx64 " data 0x%" PRIx64
+bcm2835_systmr_write(uint64_t offset, uint32_t data) "timer write: offset 0x%" PRIx64 " data 0x%" PRIx32
+bcm2835_systmr_run(unsigned id, uint64_t delay_us) "timer #%u expiring in %"PRIu64" us"
 
 # avr_timer16.c
 avr_timer16_read(uint8_t addr, uint8_t value) "timer16 read addr:%u value:%u"
-- 
2.26.2



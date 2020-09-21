Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A677BC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4236D207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbkhTWmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4236D207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKCum-0006Dl-CH
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCt3-0004V8-0L; Sun, 20 Sep 2020 23:53:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCt1-00031p-3W; Sun, 20 Sep 2020 23:53:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id s13so10684328wmh.4;
 Sun, 20 Sep 2020 20:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZsGklvGCCEfAG2C9pvK94uYRWIB54oFE2Bd5BK/jcb8=;
 b=FbkhTWmtCJg8yfGQc4petf4ZKQBnoVsqmNvO9ZB5vRJYAQv0Tr+K+WmS4B5z1qXtgs
 9pq0DSZlksXJuTFkLid9kiCyjcfP1V2EbxAPTnYgie2XpR561+kQMTZuy2xsSuUjWvcc
 zpW6VfT5wwSK0RrlwaVG2rmKAyHw8xdRIdFrnC8sk/9HFkA0EqH/AIcG5P7/PQdqITE1
 M3w5biIumFAHd4GxbOegbooJRsF2TyO7UBI9JIiFD7l1XyZq4TYT9OxdUEKYbwoqBe4V
 hFN2T9/z0Nzc/SgJTFeHNDRRx3+t6F2piJVgXDC/fK4mAaps0Ec7FU4MDfCybXHDUrs9
 5guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZsGklvGCCEfAG2C9pvK94uYRWIB54oFE2Bd5BK/jcb8=;
 b=ssmiS6lLZO9TvAliqjRDcIUuvz4W2yyUZJRtO0DEYglDHOHEOtitLIqfjXNasFyl+g
 Qqt++RRW7f1i7RMeDMebs1yOvbrvbPFm6KAdEq1nu57SlrwCbtWNGITmJsOYiccb62xI
 veVlrnAglkUU3Tauvi1/kHI+pOMjCrYl7mhptk3PzMedQSQ/kqb1ozTQJb2ddYiSwqwk
 zK7eoSsQLwho4RNy/uX58xaVOpVYEptO+ebcA3xiPTrbWAPrWJaCDNrbwMKYKJJCYGdT
 gmEDsgPWa0jZ6+9zuW4F8LuJgBldgYD6vr/9q95mV9t7J65GDcbTli5TpNykCTxoI94W
 ZnKw==
X-Gm-Message-State: AOAM533fZHs5UwOBUxyIcrPjuym3iRyEk3vOYt8j8sMS1VEs4eJYnm6x
 T1pZqWXPYp0bh6oxkbOLJuEOStDlkiI=
X-Google-Smtp-Source: ABdhPJynD9YGr28bXrQV6LHe8RPXPRetUqQ69s0fyyJ5Us2LFlObveqgtuzM3c2HWxoL/snWbsBDEw==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr19905535wmp.187.1600660385027; 
 Sun, 20 Sep 2020 20:53:05 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a17sm19633754wra.24.2020.09.20.20.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 20:53:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] hw/timer/bcm2835: Support the timer COMPARE registers
Date: Mon, 21 Sep 2020 05:52:56 +0200
Message-Id: <20200921035257.434532-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921035257.434532-1-f4bug@amsat.org>
References: <20200921035257.434532-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
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
 include/hw/timer/bcm2835_systmr.h | 11 +++++++--
 hw/timer/bcm2835_systmr.c         | 41 +++++++++++++++++++------------
 hw/timer/trace-events             |  4 ++-
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index e0db9e9e12b..17fdd9d67b2 100644
--- a/include/hw/timer/bcm2835_systmr.h
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -11,6 +11,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/irq.h"
+#include "qemu/timer.h"
 #include "qom/object.h"
 
 #define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
@@ -20,18 +21,24 @@ DECLARE_INSTANCE_CHECKER(BCM2835SystemTimerState, BCM2835_SYSTIMER,
 
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
index b234e83824f..43e644f5e45 100644
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
@@ -78,16 +71,25 @@ static void bcm2835_systmr_write(void *opaque, hwaddr offset,
                                  uint64_t value, unsigned size)
 {
     BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
+    int index;
 
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
+        timer_mod(&s->tmr[index].timer, value);
+        trace_bcm2835_systmr_run(index,
+                                 value - qemu_clock_get_us(QEMU_CLOCK_VIRTUAL));
         break;
     case A_COUNTER_LOW:
     case A_COUNTER_HIGH:
@@ -125,7 +127,14 @@ static void bcm2835_systmr_realize(DeviceState *dev, Error **errp)
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
index b996d992000..f4ca31d4951 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -77,9 +77,11 @@ nrf51_timer_write(uint8_t timer_id, uint64_t addr, uint32_t value, unsigned size
 nrf51_timer_set_count(uint8_t timer_id, uint8_t counter_id, uint32_t value) "timer %u counter %u count 0x%" PRIx32
 
 # bcm2835_systmr.c
-bcm2835_systmr_irq(bool enable) "timer irq state %u"
+bcm2835_systmr_timer_expired(unsigned id) "timer #%u expired"
+bcm2835_systmr_irq_ack(unsigned id) "timer #%u acked"
 bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset 0x%" PRIx64 " data 0x%" PRIx64
 bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offset 0x%" PRIx64 " data 0x%" PRIx64
+bcm2835_systmr_run(unsigned id, uint64_t delay_us) "timer #%u expiring in %"PRIu64" us"
 
 # avr_timer16.c
 avr_timer16_read(uint8_t addr, uint8_t value) "timer16 read addr:%u value:%u"
-- 
2.26.2



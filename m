Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC96C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C4420719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsMIULxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C4420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOCx-0001Ho-Qj
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOO8Y-0004F5-8F; Fri, 02 Oct 2020 12:42:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kOO8W-0005d2-84; Fri, 02 Oct 2020 12:42:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id g4so2516654wrs.5;
 Fri, 02 Oct 2020 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lo+NLeYd13T3W4hIWAIUPXQaMQ+IojORhmIinFsRoSc=;
 b=TsMIULxzGGPcU4okfRIFLxzgrQHifjQEWoMpRpcgj4qOEJ78d4CpNdD0BcBfmH+0Bz
 Xry7qMNAH/jOvNnh3aXA6LlT9Qf+iVTt/NnhaZEZddJ7+jkQR/DY2J3h3rwgnwjceyxS
 KXSZd8bUv3f9NURpDAsqo5kQrxd111ILJOPWY8iDLieuusYxVxy3D99EzJ6jpyzUfvMK
 xhweUAmnpgf75gimCIQXB2mf1G00e3krAgWX+JUH7lXPDEhauTtunOzPkgX9OEZ6Gdfc
 LIPG5uv9d/A4Uv+fBdrQGxoopNXWKykDMKn+PbBCZ+iEe321HRvvBdjTvsdm3hGv6SUk
 iUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Lo+NLeYd13T3W4hIWAIUPXQaMQ+IojORhmIinFsRoSc=;
 b=GpkmFqIrUBG+whw0h8GpyuOaJfRk8aDPnR/oeU8dvsKEs4uy7yfBooFpdFd+EFn/5B
 OS3Og6TgOKW7ifTv5UUjkaab/S0g6BoVkYHSRln6bN5D2DNcTPRP21+QT/AoUPXAzngH
 R+SrRCu0NAbwV/QObvf799BYIFg4wOPbkEpreNcHqeL0+ioN0jnrQB5SGFyE6vy6ajhw
 FH2MhkdZp95I/wwceNQ1zwq+IHQMbACD9o5gMBbotbP92Uoi686VoLJUEQzTIhOFIgH5
 T9hb/0WA9uqBs1rDGfd225NBcW57N9Vla1TIkwihTywGMdYZz7rwiwX9d8b/YYX+uOhu
 g3GA==
X-Gm-Message-State: AOAM532s87k7m+XWdfNk9/GsCn+vnSUQ/Csdn9yMWTQE/cE+A3Qz2Nm2
 Rbp7IjOMHDr+hrJpJaGvd2TTX/7hnKk=
X-Google-Smtp-Source: ABdhPJzpndBOLDlDQ0y61K4+51BjzCGnXVqU2F0jJfYL2kOIeJjJ+w3VFobVpzYPN0Vj7E1bYnC0zA==
X-Received: by 2002:adf:e852:: with SMTP id d18mr4288673wrn.40.1601656942235; 
 Fri, 02 Oct 2020 09:42:22 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t17sm2378673wrx.82.2020.10.02.09.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 09:42:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] hw/timer/bcm2835: Support the timer COMPARE registers
Date: Fri,  2 Oct 2020 18:42:15 +0200
Message-Id: <20201002164216.1741110-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002164216.1741110-1-f4bug@amsat.org>
References: <20201002164216.1741110-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
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
v3:
- Only compare 32 least significant bits of the free running
  counter values (Luc)
---
 include/hw/timer/bcm2835_systmr.h | 11 ++++++--
 hw/timer/bcm2835_systmr.c         | 45 ++++++++++++++++++++-----------
 hw/timer/trace-events             |  4 ++-
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
index f15788a78d..bd3097d746 100644
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
index b234e83824..66a1d4d6b8 100644
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
@@ -78,16 +71,29 @@ static void bcm2835_systmr_write(void *opaque, hwaddr offset,
                                  uint64_t value, unsigned size)
 {
     BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
+    int index;
+    uint64_t now;
+    uint64_t triggers_delay_us;
 
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
+        triggers_delay_us = value - (now & UINT32_MAX);
+        trace_bcm2835_systmr_run(index, triggers_delay_us);
+        timer_mod(&s->tmr[index].timer, now + triggers_delay_us);
         break;
     case A_COUNTER_LOW:
     case A_COUNTER_HIGH:
@@ -125,7 +131,14 @@ static void bcm2835_systmr_realize(DeviceState *dev, Error **errp)
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
index b996d99200..f4ca31d495 100644
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



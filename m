Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D6C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC5A20663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lt7IfiW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC5A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3R2-00035I-SL
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qa-0004zM-CH
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qZ-00082u-04
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:56007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qY-00082I-Pm
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id a6so17834860wma.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Cv6HZ91yGk0xGYbUoTFw/+DdSIijp5QJpKDphiE70KU=;
 b=Lt7IfiW1JftmiClW5f/IVDVxaZCGPpBT+TjimKispERn50D9DGW8HS9oMaJg6EFP/p
 W/w+x3BVs7TNcrgS4PFQcDSfS2Nl3DoWRncRox9oE4zSV665M+4s7+IbCAax6yujG47K
 t0A9EQcN1AsM5n6Jp71ND43gdbRdbVovNnAhKRbT80NYuAiZEztH0uROggnmiFu2/C7V
 FmHeIeLI/oRU5g7wZL2T1QDK2n5BcoGK1bOZfFSsZATNWv4jslhND6cDg3KCjVwZ3DS2
 uldEJeWGthtApdxnsNtL+XzOC+IUcZX/JkZ93zG8UlSJzLz8Zq4LOQx5lgEXnfHuKrL/
 gGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cv6HZ91yGk0xGYbUoTFw/+DdSIijp5QJpKDphiE70KU=;
 b=m6CcoNgriEaQHoXaZfX7Bfumd9yUiUIGEw9LwBnELYeTGhL1LObo7ctjH1SUlTXxrB
 8BXox+FIs72g1U15M1aICXNziMb2XBY6XmPuRvVHpuf8zuwMLdM26Ph8YgSON7tAqOED
 1q0PdHidmjLVqvJAABrZRZ5M8NqYQBes+QK4swdvFNLxCBou/Duo/DV7oFKkKerx49nI
 elh9Qr3NOySmN/1xKVWFICpyRFYXde2PXZaySIcz2Diw2X0LxsobzJMJUTml9ZG8K2/a
 7dedqF9iILpdUbhKzYjNX3th6NuWTPvruYuhFF6tYYpBm5ijsBMSIASIHT69WJRwTH6p
 QO5Q==
X-Gm-Message-State: APjAAAWyMQ6Sz0vXGGkqx5bPu6jx7JvbpLkdaGBOOIpmLwxpPCl32Tfw
 65m0ZlzxyxRB90Vx6telY5X7sfHGqVsyag==
X-Google-Smtp-Source: APXvYqxJ+XwYzDMsFn6f2lVGb4+0y2wJfScFy752LgQ84DBlDnN3pn8CdrpEXCs7r+LNxhbrfQ2HYw==
X-Received: by 2002:a7b:c011:: with SMTP id c17mr16026485wmb.95.1571069121590; 
 Mon, 14 Oct 2019 09:05:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/68] aspeed/timer: Add support for IRQ status register on the
 AST2600
Date: Mon, 14 Oct 2019 17:03:42 +0100
Message-Id: <20191014160404.19553-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

From: Cédric Le Goater <clg@kaod.org>

The AST2600 timer replaces control register 2 with a interrupt status
register. It is set by hardware when an IRQ occurs and cleared by
software.

Modify the vmstate version to take into account the new fields.

Based on previous work from Joel Stanley.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-8-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/aspeed_timer.h |  1 +
 hw/timer/aspeed_timer.c         | 36 +++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
index 69b1377af01..948329893c0 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -60,6 +60,7 @@ typedef struct AspeedTimerCtrlState {
     uint32_t ctrl;
     uint32_t ctrl2;
     uint32_t ctrl3;
+    uint32_t irq_sts;
     AspeedTimer timers[ASPEED_TIMER_NR_TIMERS];
 
     AspeedSCUState *scu;
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 7f73d0c7533..bcce2192a92 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -160,7 +160,9 @@ static uint64_t calculate_next(struct AspeedTimer *t)
     timer_del(&t->timer);
 
     if (timer_overflow_interrupt(t)) {
+        AspeedTimerCtrlState *s = timer_to_ctrl(t);
         t->level = !t->level;
+        s->irq_sts |= BIT(t->id);
         qemu_set_irq(t->irq, t->level);
     }
 
@@ -199,7 +201,9 @@ static void aspeed_timer_expire(void *opaque)
     }
 
     if (interrupt) {
+        AspeedTimerCtrlState *s = timer_to_ctrl(t);
         t->level = !t->level;
+        s->irq_sts |= BIT(t->id);
         qemu_set_irq(t->irq, t->level);
     }
 
@@ -244,9 +248,6 @@ static uint64_t aspeed_timer_read(void *opaque, hwaddr offset, unsigned size)
     case 0x30: /* Control Register */
         value = s->ctrl;
         break;
-    case 0x34: /* Control Register 2 */
-        value = s->ctrl2;
-        break;
     case 0x00 ... 0x2c: /* Timers 1 - 4 */
         value = aspeed_timer_get_value(&s->timers[(offset >> 4)], reg);
         break;
@@ -438,9 +439,6 @@ static void aspeed_timer_write(void *opaque, hwaddr offset, uint64_t value,
     case 0x30:
         aspeed_timer_set_ctrl(s, tv);
         break;
-    case 0x34:
-        aspeed_timer_set_ctrl2(s, tv);
-        break;
     /* Timer Registers */
     case 0x00 ... 0x2c:
         aspeed_timer_set_value(s, (offset >> TIMER_NR_REGS), reg, tv);
@@ -468,6 +466,9 @@ static uint64_t aspeed_2400_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
     uint64_t value;
 
     switch (offset) {
+    case 0x34:
+        value = s->ctrl2;
+        break;
     case 0x38:
     case 0x3C:
     default:
@@ -482,7 +483,12 @@ static uint64_t aspeed_2400_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
 static void aspeed_2400_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
                                     uint64_t value)
 {
+    const uint32_t tv = (uint32_t)(value & 0xFFFFFFFF);
+
     switch (offset) {
+    case 0x34:
+        aspeed_timer_set_ctrl2(s, tv);
+        break;
     case 0x38:
     case 0x3C:
     default:
@@ -497,6 +503,9 @@ static uint64_t aspeed_2500_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
     uint64_t value;
 
     switch (offset) {
+    case 0x34:
+        value = s->ctrl2;
+        break;
     case 0x38:
         value = s->ctrl3 & BIT(0);
         break;
@@ -517,6 +526,9 @@ static void aspeed_2500_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
     uint8_t command;
 
     switch (offset) {
+    case 0x34:
+        aspeed_timer_set_ctrl2(s, tv);
+        break;
     case 0x38:
         command = (value >> 1) & 0xFF;
         if (command == 0xAE) {
@@ -543,6 +555,9 @@ static uint64_t aspeed_2600_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
     uint64_t value;
 
     switch (offset) {
+    case 0x34:
+        value = s->irq_sts;
+        break;
     case 0x38:
     case 0x3C:
     default:
@@ -560,6 +575,9 @@ static void aspeed_2600_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
     const uint32_t tv = (uint32_t)(value & 0xFFFFFFFF);
 
     switch (offset) {
+    case 0x34:
+        s->irq_sts &= tv;
+        break;
     case 0x3C:
         aspeed_timer_set_ctrl(s, s->ctrl & ~tv);
         break;
@@ -626,6 +644,7 @@ static void aspeed_timer_reset(DeviceState *dev)
     s->ctrl = 0;
     s->ctrl2 = 0;
     s->ctrl3 = 0;
+    s->irq_sts = 0;
 }
 
 static const VMStateDescription vmstate_aspeed_timer = {
@@ -644,12 +663,13 @@ static const VMStateDescription vmstate_aspeed_timer = {
 
 static const VMStateDescription vmstate_aspeed_timer_state = {
     .name = "aspeed.timerctrl",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
         VMSTATE_UINT32(ctrl3, AspeedTimerCtrlState),
+        VMSTATE_UINT32(irq_sts, AspeedTimerCtrlState),
         VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
                              ASPEED_TIMER_NR_TIMERS, 1, vmstate_aspeed_timer,
                              AspeedTimer),
-- 
2.20.1



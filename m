Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA14AC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4442C222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBG9tg3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4442C222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNnT-0008Rn-3a
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQC-0002D9-Hr
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ8-0004w1-7k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id j7so1511597wrt.9
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EwpCEmpKwtw77BG7CwCJIWmARgA3vhFeuBv+0UYdPi4=;
 b=EBG9tg3mZumk2+wGz9fQ0Tmudc+O15up6R9j/SzYjLMNkYMRknRnvh6HPZX3erjMgQ
 k+2R3R6JMuvo2bRz7QA8xmTTrjpR9lOymqf0B13CvUHLa6Zgvh3qGk/4kRMMCwjKmLr+
 qI9MxdWihC+p/9eMSJqGvNsbOV2BxXlout2YIkYAGArFGbH8hUV7TEomhCKlARGJ3apH
 3NTvTZ1xkYh/stvVtNk6/StbD2KNaVNjoedL4Ge8QceqHLHNSH/wQMFuX4IkuURiRJjA
 VsJjqJ5KRO8oxoImKJkgOzC24r9oQsOagwfO0Q6fyI/u+K5VZZvlZ5LR3LPFi6ViyC2S
 En4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EwpCEmpKwtw77BG7CwCJIWmARgA3vhFeuBv+0UYdPi4=;
 b=TFSre8eKtEXu2kSdik8XJJUdJY4JTiBw2Z6xc50bHqR7vOO4CpSBpkXqAJjFPLzH5X
 UoOYypp92rH9iQedC1oUjAu3c/uJi/EU8VyoMliidTp5lz2EY9eBcpcZSTyx/VkRv8KF
 64LK0ZaXIJp5hcVcH8a4wA4ZCrhaBvKBxZznWlzabjkMHi9y658QUgP5tYiVAdW2CHrd
 FdQRIRtgeCO6fTk6CmUdrfIV957rMH7GK5X+SSlPW16QwlZ6nENuPEqHy6nhZ2KztGPF
 2LZyct63XWUyuLr70chFQrP+H32blbNo4P63VhQFXe6JshTsXXj6D2fPSHe+mh8mHDFI
 ODJQ==
X-Gm-Message-State: AOAM530kzVIRQSntqWbOBtYcByP4HQXlEcTQ+5ykK9L9WvESmKNgcE7n
 KIpB5fEuvsPK+JKZpQa4+qH+lDqyRgopRA==
X-Google-Smtp-Source: ABdhPJwRL+By0Lwr9sOU1NohfT1cTn+wIAuuCICfEbVqLuGyKI507aFH1Lj4hXO0wi2LUU8yt812BA==
X-Received: by 2002:adf:9f4c:: with SMTP id f12mr2416159wrg.108.1603799141793; 
 Tue, 27 Oct 2020 04:45:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/48] hw/timer/armv7m_systick: Rewrite to use ptimers
Date: Tue, 27 Oct 2020 11:44:38 +0000
Message-Id: <20201027114438.17662-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The armv7m systick timer is a 24-bit decrementing, wrap-on-zero,
clear-on-write counter. Our current implementation has various
bugs and dubious workarounds in it (for instance see
https://bugs.launchpad.net/qemu/+bug/1872237).

We have an implementation of a simple decrementing counter
and we put a lot of effort into making sure it handles the
interesting corner cases (like "spend a cycle at 0 before
reloading") -- ptimer.

Rewrite the systick timer to use a ptimer rather than
a raw QEMU timer.

Unfortunately this is a migration compatibility break,
which will affect all M-profile boards.

Among other bugs, this fixes
https://bugs.launchpad.net/qemu/+bug/1872237 :
now writes to SYST_CVR when the timer is enabled correctly
do nothing; when the timer is enabled via SYST_CSR.ENABLE,
the ptimer code will (because of POLICY_NO_IMMEDIATE_RELOAD)
arrange that after one timer tick the counter is reloaded
from SYST_RVR and then counts down from there, as the
architecture requires.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201015151829.14656-3-peter.maydell@linaro.org
---
 include/hw/timer/armv7m_systick.h |   3 +-
 hw/timer/armv7m_systick.c         | 124 +++++++++++++-----------------
 2 files changed, 54 insertions(+), 73 deletions(-)

diff --git a/include/hw/timer/armv7m_systick.h b/include/hw/timer/armv7m_systick.h
index 97cb345ddb4..84496faaf96 100644
--- a/include/hw/timer/armv7m_systick.h
+++ b/include/hw/timer/armv7m_systick.h
@@ -14,6 +14,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "hw/ptimer.h"
 
 #define TYPE_SYSTICK "armv7m_systick"
 
@@ -27,7 +28,7 @@ struct SysTickState {
     uint32_t control;
     uint32_t reload;
     int64_t tick;
-    QEMUTimer *timer;
+    ptimer_state *ptimer;
     MemoryRegion iomem;
     qemu_irq irq;
 };
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index a8cec7eb56b..2f192011eb0 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -39,26 +39,6 @@ static inline int64_t systick_scale(SysTickState *s)
     }
 }
 
-static void systick_reload(SysTickState *s, int reset)
-{
-    /* The Cortex-M3 Devices Generic User Guide says that "When the
-     * ENABLE bit is set to 1, the counter loads the RELOAD value from the
-     * SYST RVR register and then counts down". So, we need to check the
-     * ENABLE bit before reloading the value.
-     */
-    trace_systick_reload();
-
-    if ((s->control & SYSTICK_ENABLE) == 0) {
-        return;
-    }
-
-    if (reset) {
-        s->tick = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-    s->tick += (s->reload + 1) * systick_scale(s);
-    timer_mod(s->timer, s->tick);
-}
-
 static void systick_timer_tick(void *opaque)
 {
     SysTickState *s = (SysTickState *)opaque;
@@ -70,10 +50,12 @@ static void systick_timer_tick(void *opaque)
         /* Tell the NVIC to pend the SysTick exception */
         qemu_irq_pulse(s->irq);
     }
-    if (s->reload == 0) {
-        s->control &= ~SYSTICK_ENABLE;
-    } else {
-        systick_reload(s, 0);
+    if (ptimer_get_limit(s->ptimer) == 0) {
+        /*
+         * Timer expiry with SYST_RVR zero disables the timer
+         * (but doesn't clear SYST_CSR.ENABLE)
+         */
+        ptimer_stop(s->ptimer);
     }
 }
 
@@ -94,30 +76,11 @@ static MemTxResult systick_read(void *opaque, hwaddr addr, uint64_t *data,
         s->control &= ~SYSTICK_COUNTFLAG;
         break;
     case 0x4: /* SysTick Reload Value.  */
-        val = s->reload;
+        val = ptimer_get_limit(s->ptimer);
         break;
     case 0x8: /* SysTick Current Value.  */
-    {
-        int64_t t;
-
-        if ((s->control & SYSTICK_ENABLE) == 0) {
-            val = 0;
-            break;
-        }
-        t = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        if (t >= s->tick) {
-            val = 0;
-            break;
-        }
-        val = ((s->tick - (t + 1)) / systick_scale(s)) + 1;
-        /* The interrupt in triggered when the timer reaches zero.
-           However the counter is not reloaded until the next clock
-           tick.  This is a hack to return zero during the first tick.  */
-        if (val > s->reload) {
-            val = 0;
-        }
+        val = ptimer_get_count(s->ptimer);
         break;
-    }
     case 0xc: /* SysTick Calibration Value.  */
         val = 10000;
         break;
@@ -149,39 +112,50 @@ static MemTxResult systick_write(void *opaque, hwaddr addr,
     switch (addr) {
     case 0x0: /* SysTick Control and Status.  */
     {
-        uint32_t oldval = s->control;
+        uint32_t oldval;
 
+        ptimer_transaction_begin(s->ptimer);
+        oldval = s->control;
         s->control &= 0xfffffff8;
         s->control |= value & 7;
+
         if ((oldval ^ value) & SYSTICK_ENABLE) {
-            int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
             if (value & SYSTICK_ENABLE) {
-                if (s->tick) {
-                    s->tick += now;
-                    timer_mod(s->timer, s->tick);
-                } else {
-                    systick_reload(s, 1);
-                }
+                /*
+                 * Always reload the period in case board code has
+                 * changed system_clock_scale. If we ever replace that
+                 * global with a more sensible API then we might be able
+                 * to set the period only when it actually changes.
+                 */
+                ptimer_set_period(s->ptimer, systick_scale(s));
+                ptimer_run(s->ptimer, 0);
             } else {
-                timer_del(s->timer);
-                s->tick -= now;
-                if (s->tick < 0) {
-                    s->tick = 0;
-                }
+                ptimer_stop(s->ptimer);
             }
         } else if ((oldval ^ value) & SYSTICK_CLKSOURCE) {
-            /* This is a hack. Force the timer to be reloaded
-               when the reference clock is changed.  */
-            systick_reload(s, 1);
+            ptimer_set_period(s->ptimer, systick_scale(s));
         }
+        ptimer_transaction_commit(s->ptimer);
         break;
     }
     case 0x4: /* SysTick Reload Value.  */
-        s->reload = value;
+        ptimer_transaction_begin(s->ptimer);
+        ptimer_set_limit(s->ptimer, value & 0xffffff, 0);
+        ptimer_transaction_commit(s->ptimer);
         break;
-    case 0x8: /* SysTick Current Value.  Writes reload the timer.  */
-        systick_reload(s, 1);
+    case 0x8: /* SysTick Current Value. */
+        /*
+         * Writing any value clears SYST_CVR to zero and clears
+         * SYST_CSR.COUNTFLAG. The counter will then reload from SYST_RVR
+         * on the next clock edge unless SYST_RVR is zero.
+         */
+        ptimer_transaction_begin(s->ptimer);
+        if (ptimer_get_limit(s->ptimer) == 0) {
+            ptimer_stop(s->ptimer);
+        }
+        ptimer_set_count(s->ptimer, 0);
         s->control &= ~SYSTICK_COUNTFLAG;
+        ptimer_transaction_commit(s->ptimer);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -210,10 +184,13 @@ static void systick_reset(DeviceState *dev)
      */
     assert(system_clock_scale != 0);
 
+    ptimer_transaction_begin(s->ptimer);
     s->control = 0;
-    s->reload = 0;
-    s->tick = 0;
-    timer_del(s->timer);
+    ptimer_stop(s->ptimer);
+    ptimer_set_count(s->ptimer, 0);
+    ptimer_set_limit(s->ptimer, 0, 0);
+    ptimer_set_period(s->ptimer, systick_scale(s));
+    ptimer_transaction_commit(s->ptimer);
 }
 
 static void systick_instance_init(Object *obj)
@@ -229,18 +206,21 @@ static void systick_instance_init(Object *obj)
 static void systick_realize(DeviceState *dev, Error **errp)
 {
     SysTickState *s = SYSTICK(dev);
-    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, systick_timer_tick, s);
+    s->ptimer = ptimer_init(systick_timer_tick, s,
+                            PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
+                            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN |
+                            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                            PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT);
 }
 
 static const VMStateDescription vmstate_systick = {
     .name = "armv7m_systick",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(control, SysTickState),
-        VMSTATE_UINT32(reload, SysTickState),
         VMSTATE_INT64(tick, SysTickState),
-        VMSTATE_TIMER_PTR(timer, SysTickState),
+        VMSTATE_PTIMER(ptimer, SysTickState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.20.1



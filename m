Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FBBC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032CB217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4fO2Swr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032CB217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtDp-0004K7-UD
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7O-0006ZS-PO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7K-0002B5-M2
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7K-0002Aj-CB
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id p14so19392015wro.4
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kdkcGfyiI4qEGDjR65U9kIW9WP0Rp2kjWPo/AtqSxYY=;
 b=N4fO2Swrq3xqtJUhi08rxICcOAEPEkFwSLlTJvYdYq9IPf7PVQNXySwXvBeVHPhKtF
 81YyH3lb+5bPV7AX29GT9mq/7PQ9OQgHc+RPhT3so8P3B+lPCkxesY5em26wCYtctbnO
 a66VtmOC5v9NJnoHJrrEomE+7wC2DLymR9PMwZGrhR3n/c8hd0pEm03xotKS/wjh1214
 JIOU/5Aek5zyuK9k25R42Nm+EzlYyfvCOXlllevRwyLk/IEP1eDbkGUO1IZKT7a0+dKz
 U4gQb8ZLgLV24hy8w0aGaRxjdVmaBQFk2/fR54TVzEjnulPIz44Mm3RICFh/Y8AaRrkJ
 vGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kdkcGfyiI4qEGDjR65U9kIW9WP0Rp2kjWPo/AtqSxYY=;
 b=XJ//GI7ia2bD0QwRLAxn1MS6JYir8sZJe2ypRW96utb4uOsvnro59vTJ9US9drELVH
 VpIFzJOf6nQ57eVmkZmv2d+mVbJ1ynXD9/DZNZi0tC5qraqjARDNZEQ20TJ51IFj4stN
 ceZY3YPbwojHdzqhgJqfPlUEhY5IzJyYrLhgzsutTFXpUX2C0OzKSSwlpiXWCt5s34Pc
 rgYOjlWwb0S26j7hfWKDmcHwF6mRxGz5aB3wFA7SrzeCCkR0o78fb/osZcMkzXA5WS1S
 fTGq+qatTdRxUQH2SO87bHK3v2uTQ6SLVdUkLQCUOq15EqQdrHfX0djFHrUXNxdPEUdB
 pfHQ==
X-Gm-Message-State: APjAAAXCShkt0UrflixRrKRMtER7xV2/fxSWwNPjjrz5/EHWdeRHprFa
 Fbgtpn/PdwlgW8BDagmecL36sw==
X-Google-Smtp-Source: APXvYqxZyOUWujqy8fbLhBPhUPib77/Q0H+j3NMy6GkQG2zkT49U4p54bIUpRhAGaDN6LbyWSeBW3g==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr29699566wru.276.1570555064833; 
 Tue, 08 Oct 2019 10:17:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 01/21] ptimer: Rename ptimer_init() to ptimer_init_with_bh()
Date: Tue,  8 Oct 2019 18:17:20 +0100
Message-Id: <20191008171740.9679-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the ptimer design uses a QEMU bottom-half as its
mechanism for calling back into the device model using the
ptimer when the timer has expired. Unfortunately this design
is fatally flawed, because it means that there is a lag
between the ptimer updating its own state and the device
callback function updating device state, and guest accesses
to device registers between the two can return inconsistent
device state.

We want to replace the bottom-half design with one where
the guest device's callback is called either immediately
(when the ptimer triggers by timeout) or when the device
model code closes a transaction-begin/end section (when the
ptimer triggers because the device model changed the
ptimer's count value or other state). As the first step,
rename ptimer_init() to ptimer_init_with_bh(), to free up
the ptimer_init() name for the new API. We can then convert
all the ptimer users away from ptimer_init_with_bh() before
removing it entirely.

(Commit created with
 git grep -l ptimer_init | xargs sed -i -e 's/ptimer_init/ptimer_init_with_bh/'
and three overlong lines folded by hand.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/ptimer.h              | 11 ++++++-----
 hw/arm/musicpal.c                |  2 +-
 hw/core/ptimer.c                 |  2 +-
 hw/dma/xilinx_axidma.c           |  2 +-
 hw/m68k/mcf5206.c                |  2 +-
 hw/m68k/mcf5208.c                |  2 +-
 hw/net/fsl_etsec/etsec.c         |  2 +-
 hw/net/lan9118.c                 |  2 +-
 hw/timer/allwinner-a10-pit.c     |  2 +-
 hw/timer/altera_timer.c          |  2 +-
 hw/timer/arm_mptimer.c           |  6 +++---
 hw/timer/arm_timer.c             |  2 +-
 hw/timer/cmsdk-apb-dualtimer.c   |  2 +-
 hw/timer/cmsdk-apb-timer.c       |  2 +-
 hw/timer/digic-timer.c           |  2 +-
 hw/timer/etraxfs_timer.c         |  6 +++---
 hw/timer/exynos4210_mct.c        |  7 ++++---
 hw/timer/exynos4210_pwm.c        |  2 +-
 hw/timer/exynos4210_rtc.c        |  4 ++--
 hw/timer/grlib_gptimer.c         |  2 +-
 hw/timer/imx_epit.c              |  4 ++--
 hw/timer/imx_gpt.c               |  2 +-
 hw/timer/lm32_timer.c            |  2 +-
 hw/timer/milkymist-sysctl.c      |  4 ++--
 hw/timer/mss-timer.c             |  2 +-
 hw/timer/puv3_ost.c              |  2 +-
 hw/timer/sh_timer.c              |  2 +-
 hw/timer/slavio_timer.c          |  2 +-
 hw/timer/xilinx_timer.c          |  2 +-
 hw/watchdog/cmsdk-apb-watchdog.c |  2 +-
 tests/ptimer-test.c              | 22 +++++++++++-----------
 31 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/include/hw/ptimer.h b/include/hw/ptimer.h
index 9c770552290..2fb9ba1915e 100644
--- a/include/hw/ptimer.h
+++ b/include/hw/ptimer.h
@@ -72,7 +72,7 @@
  * ptimer_set_count() or ptimer_set_limit() will not trigger the timer
  * (though it will cause a reload). Only a counter decrement to "0"
  * will cause a trigger. Not compatible with NO_IMMEDIATE_TRIGGER;
- * ptimer_init() will assert() that you don't set both.
+ * ptimer_init_with_bh() will assert() that you don't set both.
  */
 #define PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT (1 << 5)
 
@@ -81,7 +81,7 @@ typedef struct ptimer_state ptimer_state;
 typedef void (*ptimer_cb)(void *opaque);
 
 /**
- * ptimer_init - Allocate and return a new ptimer
+ * ptimer_init_with_bh - Allocate and return a new ptimer
  * @bh: QEMU bottom half which is run on timer expiry
  * @policy: PTIMER_POLICY_* bits specifying behaviour
  *
@@ -89,13 +89,13 @@ typedef void (*ptimer_cb)(void *opaque);
  * The ptimer takes ownership of @bh and will delete it
  * when the ptimer is eventually freed.
  */
-ptimer_state *ptimer_init(QEMUBH *bh, uint8_t policy_mask);
+ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask);
 
 /**
  * ptimer_free - Free a ptimer
  * @s: timer to free
  *
- * Free a ptimer created using ptimer_init() (including
+ * Free a ptimer created using ptimer_init_with_bh() (including
  * deleting the bottom half which it is using).
  */
 void ptimer_free(ptimer_state *s);
@@ -178,7 +178,8 @@ void ptimer_set_count(ptimer_state *s, uint64_t count);
  * @oneshot: non-zero if this timer should only count down once
  *
  * Start a ptimer counting down; when it reaches zero the bottom half
- * passed to ptimer_init() will be invoked. If the @oneshot argument is zero,
+ * passed to ptimer_init_with_bh() will be invoked.
+ * If the @oneshot argument is zero,
  * the counter value will then be reloaded from the limit and it will
  * start counting down again. If @oneshot is non-zero, then the counter
  * will disable itself when it reaches zero.
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 246cbb13363..b3624d5e280 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -849,7 +849,7 @@ static void mv88w8618_timer_init(SysBusDevice *dev, mv88w8618_timer_state *s,
     s->freq = freq;
 
     bh = qemu_bh_new(mv88w8618_timer_tick, s);
-    s->ptimer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
 }
 
 static uint64_t mv88w8618_pit_read(void *opaque, hwaddr offset,
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index d58e2dfdb08..f0d3ce11398 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -358,7 +358,7 @@ const VMStateDescription vmstate_ptimer = {
     }
 };
 
-ptimer_state *ptimer_init(QEMUBH *bh, uint8_t policy_mask)
+ptimer_state *ptimer_init_with_bh(QEMUBH *bh, uint8_t policy_mask)
 {
     ptimer_state *s;
 
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index a254275b64e..e035d1f7504 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -552,7 +552,7 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
 
         st->nr = i;
         st->bh = qemu_bh_new(timer_hit, st);
-        st->ptimer = ptimer_init(st->bh, PTIMER_POLICY_DEFAULT);
+        st->ptimer = ptimer_init_with_bh(st->bh, PTIMER_POLICY_DEFAULT);
         ptimer_set_freq(st->ptimer, s->freqhz);
     }
     return;
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a9c2c95b0d1..a49096367cb 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -141,7 +141,7 @@ static m5206_timer_state *m5206_timer_init(qemu_irq irq)
 
     s = g_new0(m5206_timer_state, 1);
     bh = qemu_bh_new(m5206_timer_trigger, s);
-    s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
     s->irq = irq;
     m5206_timer_reset(s);
     return s;
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 012710d057d..45c28b75a17 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -192,7 +192,7 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
     for (i = 0; i < 2; i++) {
         s = g_new0(m5208_timer_state, 1);
         bh = qemu_bh_new(m5208_timer_trigger, s);
-        s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+        s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
         memory_region_init_io(&s->iomem, NULL, &m5208_timer_ops, s,
                               "m5208-timer", 0x00004000);
         memory_region_add_subregion(address_space, 0xfc080000 + 0x4000 * i,
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 8451c17fb8f..d9b3e8c691e 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -393,7 +393,7 @@ static void etsec_realize(DeviceState *dev, Error **errp)
 
 
     etsec->bh     = qemu_bh_new(etsec_timer_hit, etsec);
-    etsec->ptimer = ptimer_init(etsec->bh, PTIMER_POLICY_DEFAULT);
+    etsec->ptimer = ptimer_init_with_bh(etsec->bh, PTIMER_POLICY_DEFAULT);
     ptimer_set_freq(etsec->ptimer, 100);
 }
 
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 8bba2a80568..0ea51433dca 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1350,7 +1350,7 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
     s->txp = &s->tx_packet;
 
     bh = qemu_bh_new(lan9118_tick, s);
-    s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
     ptimer_set_freq(s->timer, 10000);
     ptimer_set_limit(s->timer, 0xffff, 1);
 }
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index ca5a9050591..28d055e42f3 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -271,7 +271,7 @@ static void a10_pit_init(Object *obj)
         tc->container = s;
         tc->index = i;
         bh[i] = qemu_bh_new(a10_pit_timer_cb, tc);
-        s->timer[i] = ptimer_init(bh[i], PTIMER_POLICY_DEFAULT);
+        s->timer[i] = ptimer_init_with_bh(bh[i], PTIMER_POLICY_DEFAULT);
     }
 }
 
diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index 936b31311d2..ee32e0ec1ff 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -184,7 +184,7 @@ static void altera_timer_realize(DeviceState *dev, Error **errp)
     }
 
     t->bh = qemu_bh_new(timer_hit, t);
-    t->ptimer = ptimer_init(t->bh, PTIMER_POLICY_DEFAULT);
+    t->ptimer = ptimer_init_with_bh(t->bh, PTIMER_POLICY_DEFAULT);
     ptimer_set_freq(t->ptimer, t->freq_hz);
 
     memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 9f63abef10e..2a54a011431 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -228,7 +228,7 @@ static void arm_mptimer_reset(DeviceState *dev)
     }
 }
 
-static void arm_mptimer_init(Object *obj)
+static void arm_mptimer_init_with_bh(Object *obj)
 {
     ARMMPTimerState *s = ARM_MPTIMER(obj);
 
@@ -261,7 +261,7 @@ static void arm_mptimer_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < s->num_cpu; i++) {
         TimerBlock *tb = &s->timerblock[i];
         QEMUBH *bh = qemu_bh_new(timerblock_tick, tb);
-        tb->timer = ptimer_init(bh, PTIMER_POLICY);
+        tb->timer = ptimer_init_with_bh(bh, PTIMER_POLICY);
         sysbus_init_irq(sbd, &tb->irq);
         memory_region_init_io(&tb->iomem, OBJECT(s), &timerblock_ops, tb,
                               "arm_mptimer_timerblock", 0x20);
@@ -311,7 +311,7 @@ static const TypeInfo arm_mptimer_info = {
     .name          = TYPE_ARM_MPTIMER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ARMMPTimerState),
-    .instance_init = arm_mptimer_init,
+    .instance_init = arm_mptimer_init_with_bh,
     .class_init    = arm_mptimer_class_init,
 };
 
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 283ae1e74a9..848fbcb0e25 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -177,7 +177,7 @@ static arm_timer_state *arm_timer_init(uint32_t freq)
     s->control = TIMER_CTRL_IE;
 
     bh = qemu_bh_new(arm_timer_tick, s);
-    s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
     vmstate_register(NULL, -1, &vmstate_arm_timer, s);
     return s;
 }
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index 5e2352dd326..44d23c80364 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -453,7 +453,7 @@ static void cmsdk_apb_dualtimer_realize(DeviceState *dev, Error **errp)
         QEMUBH *bh = qemu_bh_new(cmsdk_dualtimermod_tick, m);
 
         m->parent = s;
-        m->timer = ptimer_init(bh,
+        m->timer = ptimer_init_with_bh(bh,
                                PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
                                PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
                                PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index c83e26566a9..c9ce9770cef 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -218,7 +218,7 @@ static void cmsdk_apb_timer_realize(DeviceState *dev, Error **errp)
     }
 
     bh = qemu_bh_new(cmsdk_apb_timer_tick, s);
-    s->timer = ptimer_init(bh,
+    s->timer = ptimer_init_with_bh(bh,
                            PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
                            PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
                            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index 021c4ef714f..b111e1fe643 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -129,7 +129,7 @@ static void digic_timer_init(Object *obj)
 {
     DigicTimerState *s = DIGIC_TIMER(obj);
 
-    s->ptimer = ptimer_init(NULL, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init_with_bh(NULL, PTIMER_POLICY_DEFAULT);
 
     /*
      * FIXME: there is no documentation on Digic timer
diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index d62025b8797..ab27fe1895b 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -328,9 +328,9 @@ static void etraxfs_timer_realize(DeviceState *dev, Error **errp)
     t->bh_t0 = qemu_bh_new(timer0_hit, t);
     t->bh_t1 = qemu_bh_new(timer1_hit, t);
     t->bh_wd = qemu_bh_new(watchdog_hit, t);
-    t->ptimer_t0 = ptimer_init(t->bh_t0, PTIMER_POLICY_DEFAULT);
-    t->ptimer_t1 = ptimer_init(t->bh_t1, PTIMER_POLICY_DEFAULT);
-    t->ptimer_wd = ptimer_init(t->bh_wd, PTIMER_POLICY_DEFAULT);
+    t->ptimer_t0 = ptimer_init_with_bh(t->bh_t0, PTIMER_POLICY_DEFAULT);
+    t->ptimer_t1 = ptimer_init_with_bh(t->bh_t1, PTIMER_POLICY_DEFAULT);
+    t->ptimer_wd = ptimer_init_with_bh(t->bh_wd, PTIMER_POLICY_DEFAULT);
 
     sysbus_init_irq(sbd, &t->irq);
     sysbus_init_irq(sbd, &t->nmi);
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 77b9af05f41..9f2e8dd0a42 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1429,7 +1429,7 @@ static void exynos4210_mct_init(Object *obj)
 
     /* Global timer */
     bh[0] = qemu_bh_new(exynos4210_gfrc_event, s);
-    s->g_timer.ptimer_frc = ptimer_init(bh[0], PTIMER_POLICY_DEFAULT);
+    s->g_timer.ptimer_frc = ptimer_init_with_bh(bh[0], PTIMER_POLICY_DEFAULT);
     memset(&s->g_timer.reg, 0, sizeof(struct gregs));
 
     /* Local timers */
@@ -1437,8 +1437,9 @@ static void exynos4210_mct_init(Object *obj)
         bh[0] = qemu_bh_new(exynos4210_ltick_event, &s->l_timer[i]);
         bh[1] = qemu_bh_new(exynos4210_lfrc_event, &s->l_timer[i]);
         s->l_timer[i].tick_timer.ptimer_tick =
-                                   ptimer_init(bh[0], PTIMER_POLICY_DEFAULT);
-        s->l_timer[i].ptimer_frc = ptimer_init(bh[1], PTIMER_POLICY_DEFAULT);
+            ptimer_init_with_bh(bh[0], PTIMER_POLICY_DEFAULT);
+        s->l_timer[i].ptimer_frc =
+            ptimer_init_with_bh(bh[1], PTIMER_POLICY_DEFAULT);
         s->l_timer[i].id = i;
     }
 
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index b7fad2ad449..aa5dca68ef7 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -393,7 +393,7 @@ static void exynos4210_pwm_init(Object *obj)
     for (i = 0; i < EXYNOS4210_PWM_TIMERS_NUM; i++) {
         bh = qemu_bh_new(exynos4210_pwm_tick, &s->timer[i]);
         sysbus_init_irq(dev, &s->timer[i].irq);
-        s->timer[i].ptimer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+        s->timer[i].ptimer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
         s->timer[i].id = i;
         s->timer[i].parent = s;
     }
diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index ea689042297..d5d7c91fb15 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -558,12 +558,12 @@ static void exynos4210_rtc_init(Object *obj)
     QEMUBH *bh;
 
     bh = qemu_bh_new(exynos4210_rtc_tick, s);
-    s->ptimer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
     ptimer_set_freq(s->ptimer, RTC_BASE_FREQ);
     exynos4210_rtc_update_freq(s, 0);
 
     bh = qemu_bh_new(exynos4210_rtc_1Hz_tick, s);
-    s->ptimer_1Hz = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer_1Hz = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
     ptimer_set_freq(s->ptimer_1Hz, RTC_BASE_FREQ);
 
     sysbus_init_irq(dev, &s->alm_irq);
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 32dbf870d4b..bb09268ea14 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -366,7 +366,7 @@ static void grlib_gptimer_realize(DeviceState *dev, Error **errp)
 
         timer->unit   = unit;
         timer->bh     = qemu_bh_new(grlib_gptimer_hit, timer);
-        timer->ptimer = ptimer_init(timer->bh, PTIMER_POLICY_DEFAULT);
+        timer->ptimer = ptimer_init_with_bh(timer->bh, PTIMER_POLICY_DEFAULT);
         timer->id     = i;
 
         /* One IRQ line for each timer */
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index f54e059910b..39810ac8b03 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -317,10 +317,10 @@ static void imx_epit_realize(DeviceState *dev, Error **errp)
                           0x00001000);
     sysbus_init_mmio(sbd, &s->iomem);
 
-    s->timer_reload = ptimer_init(NULL, PTIMER_POLICY_DEFAULT);
+    s->timer_reload = ptimer_init_with_bh(NULL, PTIMER_POLICY_DEFAULT);
 
     bh = qemu_bh_new(imx_epit_cmp, s);
-    s->timer_cmp = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->timer_cmp = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
 }
 
 static void imx_epit_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 49a441f4517..c535d191292 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -492,7 +492,7 @@ static void imx_gpt_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 
     bh = qemu_bh_new(imx_gpt_timeout, s);
-    s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
 }
 
 static void imx_gpt_class_init(ObjectClass *klass, void *data)
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index ac3edaff4f8..f79f818d22c 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -187,7 +187,7 @@ static void lm32_timer_init(Object *obj)
     sysbus_init_irq(dev, &s->irq);
 
     s->bh = qemu_bh_new(timer_hit, s);
-    s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init_with_bh(s->bh, PTIMER_POLICY_DEFAULT);
 
     memory_region_init_io(&s->iomem, obj, &timer_ops, s,
                           "timer", R_MAX * 4);
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 958350767ae..aeba889bba4 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -285,8 +285,8 @@ static void milkymist_sysctl_init(Object *obj)
 
     s->bh0 = qemu_bh_new(timer0_hit, s);
     s->bh1 = qemu_bh_new(timer1_hit, s);
-    s->ptimer0 = ptimer_init(s->bh0, PTIMER_POLICY_DEFAULT);
-    s->ptimer1 = ptimer_init(s->bh1, PTIMER_POLICY_DEFAULT);
+    s->ptimer0 = ptimer_init_with_bh(s->bh0, PTIMER_POLICY_DEFAULT);
+    s->ptimer1 = ptimer_init_with_bh(s->bh1, PTIMER_POLICY_DEFAULT);
 
     memory_region_init_io(&s->regs_region, obj, &sysctl_mmio_ops, s,
             "milkymist-sysctl", R_MAX * 4);
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 45f1cf42f9e..a34c2402b00 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -229,7 +229,7 @@ static void mss_timer_init(Object *obj)
         struct Msf2Timer *st = &t->timers[i];
 
         st->bh = qemu_bh_new(timer_hit, st);
-        st->ptimer = ptimer_init(st->bh, PTIMER_POLICY_DEFAULT);
+        st->ptimer = ptimer_init_with_bh(st->bh, PTIMER_POLICY_DEFAULT);
         ptimer_set_freq(st->ptimer, t->freq_hz);
         sysbus_init_irq(SYS_BUS_DEVICE(obj), &st->irq);
     }
diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 6fe370049b5..0898da5ce97 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -129,7 +129,7 @@ static void puv3_ost_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq);
 
     s->bh = qemu_bh_new(puv3_ost_tick, s);
-    s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init_with_bh(s->bh, PTIMER_POLICY_DEFAULT);
     ptimer_set_freq(s->ptimer, 50 * 1000 * 1000);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_ost_ops, s, "puv3_ost",
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index adcc0c138e7..48a81b4dc79 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -204,7 +204,7 @@ static void *sh_timer_init(uint32_t freq, int feat, qemu_irq irq)
     s->irq = irq;
 
     bh = qemu_bh_new(sh_timer_tick, s);
-    s->timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
 
     sh_timer_write(s, OFFSET_TCOR >> 2, s->tcor);
     sh_timer_write(s, OFFSET_TCNT >> 2, s->tcnt);
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 38fd32b62a0..692d213897d 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -393,7 +393,7 @@ static void slavio_timer_init(Object *obj)
         tc->timer_index = i;
 
         bh = qemu_bh_new(slavio_timer_irq, tc);
-        s->cputimer[i].timer = ptimer_init(bh, PTIMER_POLICY_DEFAULT);
+        s->cputimer[i].timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
         ptimer_set_period(s->cputimer[i].timer, TIMER_PERIOD);
 
         size = i == 0 ? SYS_TIMER_SIZE : CPU_TIMER_SIZE;
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 355518232cd..92dbff304d9 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -221,7 +221,7 @@ static void xilinx_timer_realize(DeviceState *dev, Error **errp)
         xt->parent = t;
         xt->nr = i;
         xt->bh = qemu_bh_new(timer_hit, xt);
-        xt->ptimer = ptimer_init(xt->bh, PTIMER_POLICY_DEFAULT);
+        xt->ptimer = ptimer_init_with_bh(xt->bh, PTIMER_POLICY_DEFAULT);
         ptimer_set_freq(xt->ptimer, t->freq_hz);
     }
 
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 6bf43f943fb..e42c3ebd29d 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -329,7 +329,7 @@ static void cmsdk_apb_watchdog_realize(DeviceState *dev, Error **errp)
     }
 
     bh = qemu_bh_new(cmsdk_apb_watchdog_tick, s);
-    s->timer = ptimer_init(bh,
+    s->timer = ptimer_init_with_bh(bh,
                            PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
                            PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
                            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
diff --git a/tests/ptimer-test.c b/tests/ptimer-test.c
index 5b20e91599e..a3c82d1d147 100644
--- a/tests/ptimer-test.c
+++ b/tests/ptimer-test.c
@@ -68,7 +68,7 @@ static void check_set_count(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
 
     triggered = false;
 
@@ -82,7 +82,7 @@ static void check_set_limit(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
 
     triggered = false;
 
@@ -102,7 +102,7 @@ static void check_oneshot(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
     triggered = false;
@@ -205,7 +205,7 @@ static void check_periodic(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
     bool wrap_policy = (*policy & PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool no_immediate_reload = (*policy & PTIMER_POLICY_NO_IMMEDIATE_RELOAD);
@@ -373,7 +373,7 @@ static void check_on_the_fly_mode_change(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
     bool wrap_policy = (*policy & PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
@@ -420,7 +420,7 @@ static void check_on_the_fly_period_change(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
     triggered = false;
@@ -453,7 +453,7 @@ static void check_on_the_fly_freq_change(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
     bool no_round_down = (*policy & PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
     triggered = false;
@@ -486,7 +486,7 @@ static void check_run_with_period_0(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
 
     triggered = false;
 
@@ -504,7 +504,7 @@ static void check_run_with_delta_0(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
     bool wrap_policy = (*policy & PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool no_immediate_reload = (*policy & PTIMER_POLICY_NO_IMMEDIATE_RELOAD);
@@ -610,7 +610,7 @@ static void check_periodic_with_load_0(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
     bool continuous_trigger = (*policy & PTIMER_POLICY_CONTINUOUS_TRIGGER);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool trig_only_on_dec = (*policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT);
@@ -670,7 +670,7 @@ static void check_oneshot_with_load_0(gconstpointer arg)
 {
     const uint8_t *policy = arg;
     QEMUBH *bh = qemu_bh_new(ptimer_trigger, NULL);
-    ptimer_state *ptimer = ptimer_init(bh, *policy);
+    ptimer_state *ptimer = ptimer_init_with_bh(bh, *policy);
     bool no_immediate_trigger = (*policy & PTIMER_POLICY_NO_IMMEDIATE_TRIGGER);
     bool trig_only_on_dec = (*policy & PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT);
 
-- 
2.20.1



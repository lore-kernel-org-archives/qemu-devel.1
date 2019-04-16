Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CD0C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498E42077C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ile/P/az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498E42077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNwW-0002al-Hp
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:16:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfY-00055w-Kb
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfW-0001V0-IU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfS-0001Rp-Qx
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id k11so26960934wro.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=UKTNZsCqpyNRif3KKld05j9boEG0kVru0ibsoluL1kE=;
	b=Ile/P/azeG+HQLIwK/vFRZLwwPfQ2J7nr4uSJ0Wpo9J3nLlf5JfyUsWggRhnjJJ7IF
	6l0kDbb0DnDgCBJQIaWxWroAoTohw6g9F8fklLupCGPzKsIY60L3q0lwnexrW4VgHOCq
	KUWZourgwemqAp+4fOHd+EB9mrLkZ8xL1uogVgQRWAAqzXvr+iI0mJ7Rn3BTbu5bT9sS
	63DVGHkRdsvpzktMd6lFIGGC95dylOQMOf3ag572nCE5/6JYTogiSfXT71qjnnNI3Scc
	C1+9SbKTFiYv5MZVllARH0wuXn3Rxrit2r04AnY+7uxK59Mq1nVAn8IV3Rq26bLZ0fAh
	vx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=UKTNZsCqpyNRif3KKld05j9boEG0kVru0ibsoluL1kE=;
	b=O5UXof+t0dfqTVo4lUBuQLpBo0nMA7UUVgegD+riAw2DR8oq5tQQ3nvUwXrrRdSC2x
	EE3bH48RoKln2NNBHXSAr8JMp43btQdjeoaT3nnC96/9RxN9rOrA/VuuNunJiGosWrl7
	pom91kNETIOPbkcU5Jr8QjSFmvpNRrv5EjAN9aNNSx73usYiIC6EfaKafVr11j/AyTNI
	FQm0Vu0qaJOPWaUC1CV5Qq0DIA3jzy+RoNjCFNXbe6n4T1Ymcnmr1oHzEpdmPdigL40t
	dqO0aCnAjyicEYjrxPdCYYFoAitpYoV1e/S3e3kkDUgNb/eRZtKYjYZYuoPG3k/nzOIC
	FNDw==
X-Gm-Message-State: APjAAAXNrQRbwlrrL1XQjNs0+xPtvq5tRGQ0yJVEJB31Iif23iIzRCN9
	/VqneA5eXIVhaCfFBcDuoeP4VA==
X-Google-Smtp-Source: APXvYqxejpR4lUFTbNapmohnz5DIsutX1aXHr+ndc8pMqAY2PUyHhGMhSBj+XK29yCd7UVyLb8037Q==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr39648953wrq.209.1555419508861;
	Tue, 16 Apr 2019 05:58:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:39 +0100
Message-Id: <20190416125744.27770-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PATCH 21/26] target/arm: New function
 armv7m_nvic_set_pending_lazyfp()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125739.O1X_iB3ajwU15S-mxS4vKmfbkI1lx05UxjO12Yy0cmM@z>

In the v7M architecture, if an exception is generated in the process
of doing the lazy stacking of FP registers, the handling of
possible escalation to HardFault is treated differently to the normal
approach: it works based on the saved information about exception
readiness that was stored in the FPCCR when the stack frame was
created. Provide a new function armv7m_nvic_set_pending_lazyfp()
which pends exceptions during lazy stacking, and implements
this logic.

This corresponds to the pseudocode TakePreserveFPException().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 12 ++++++
 hw/intc/armv7m_nvic.c | 96 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0a1b82dc996..42df41b11ab 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2009,6 +2009,18 @@ void armv7m_nvic_set_pending(void *opaque, int irq, bool secure);
  * a different exception).
  */
 void armv7m_nvic_set_pending_derived(void *opaque, int irq, bool secure);
+/**
+ * armv7m_nvic_set_pending_lazyfp: mark this lazy FP exception as pending
+ * @opaque: the NVIC
+ * @irq: the exception number to mark pending
+ * @secure: false for non-banked exceptions or for the nonsecure
+ * version of a banked exception, true for the secure version of a banked
+ * exception.
+ *
+ * Similar to armv7m_nvic_set_pending(), but specifically for exceptions
+ * generated in the course of lazy stacking of FP registers.
+ */
+void armv7m_nvic_set_pending_lazyfp(void *opaque, int irq, bool secure);
 /**
  * armv7m_nvic_get_pending_irq_info: return highest priority pending
  *    exception, and whether it targets Secure state
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 53b4631dace..fff6e694e60 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -655,6 +655,102 @@ void armv7m_nvic_set_pending_derived(void *opaque, int irq, bool secure)
     do_armv7m_nvic_set_pending(opaque, irq, secure, true);
 }
 
+void armv7m_nvic_set_pending_lazyfp(void *opaque, int irq, bool secure)
+{
+    /*
+     * Pend an exception during lazy FP stacking. This differs
+     * from the usual exception pending because the logic for
+     * whether we should escalate depends on the saved context
+     * in the FPCCR register, not on the current state of the CPU/NVIC.
+     */
+    NVICState *s = (NVICState *)opaque;
+    bool banked = exc_is_banked(irq);
+    VecInfo *vec;
+    bool targets_secure;
+    bool escalate = false;
+    /*
+     * We will only look at bits in fpccr if this is a banked exception
+     * (in which case 'secure' tells us whether it is the S or NS version).
+     * All the bits for the non-banked exceptions are in fpccr_s.
+     */
+    uint32_t fpccr_s = s->cpu->env.v7m.fpccr[M_REG_S];
+    uint32_t fpccr = s->cpu->env.v7m.fpccr[secure];
+
+    assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
+    assert(!secure || banked);
+
+    vec = (banked && secure) ? &s->sec_vectors[irq] : &s->vectors[irq];
+
+    targets_secure = banked ? secure : exc_targets_secure(s, irq);
+
+    switch (irq) {
+    case ARMV7M_EXCP_DEBUG:
+        if (!(fpccr_s & R_V7M_FPCCR_MONRDY_MASK)) {
+            /* Ignore DebugMonitor exception */
+            return;
+        }
+        break;
+    case ARMV7M_EXCP_MEM:
+        escalate = !(fpccr & R_V7M_FPCCR_MMRDY_MASK);
+        break;
+    case ARMV7M_EXCP_USAGE:
+        escalate = !(fpccr & R_V7M_FPCCR_UFRDY_MASK);
+        break;
+    case ARMV7M_EXCP_BUS:
+        escalate = !(fpccr_s & R_V7M_FPCCR_BFRDY_MASK);
+        break;
+    case ARMV7M_EXCP_SECURE:
+        escalate = !(fpccr_s & R_V7M_FPCCR_SFRDY_MASK);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (escalate) {
+        /*
+         * Escalate to HardFault: faults that initially targeted Secure
+         * continue to do so, even if HF normally targets NonSecure.
+         */
+        irq = ARMV7M_EXCP_HARD;
+        if (arm_feature(&s->cpu->env, ARM_FEATURE_M_SECURITY) &&
+            (targets_secure ||
+             !(s->cpu->env.v7m.aircr & R_V7M_AIRCR_BFHFNMINS_MASK))) {
+            vec = &s->sec_vectors[irq];
+        } else {
+            vec = &s->vectors[irq];
+        }
+    }
+
+    if (!vec->enabled ||
+        nvic_exec_prio(s) <= exc_group_prio(s, vec->prio, secure)) {
+        if (!(fpccr_s & R_V7M_FPCCR_HFRDY_MASK)) {
+            /*
+             * We want to escalate to HardFault but the context the
+             * FP state belongs to prevents the exception pre-empting.
+             */
+            cpu_abort(&s->cpu->parent_obj,
+                      "Lockup: can't escalate to HardFault during "
+                      "lazy FP register stacking\n");
+        }
+    }
+
+    if (escalate) {
+        s->cpu->env.v7m.hfsr |= R_V7M_HFSR_FORCED_MASK;
+    }
+    if (!vec->pending) {
+        vec->pending = 1;
+        /*
+         * We do not call nvic_irq_update(), because we know our caller
+         * is going to handle causing us to take the exception by
+         * raising EXCP_LAZYFP, so raising the IRQ line would be
+         * pointless extra work. We just need to recompute the
+         * priorities so that armv7m_nvic_can_take_pending_exception()
+         * returns the right answer.
+         */
+        nvic_recompute_state(s);
+    }
+}
+
 /* Make pending IRQ active.  */
 void armv7m_nvic_acknowledge_irq(void *opaque)
 {
-- 
2.20.1



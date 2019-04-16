Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD4C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1429820675
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovd5Dugt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1429820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNn3-0002mv-81
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:06:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfF-0004nE-Rp
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNfE-0001Hj-1K
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNfC-0001FV-3r
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:15 -0400
Received: by mail-wr1-x444.google.com with SMTP id r4so26906579wrq.8
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=4RdrN7GA3r8yy/LIQmPOrXRIGWZZCxjf6XHcNWaC7So=;
	b=ovd5Dugtc5ym8g6PNqfZgcpHhg8AICVBnHu06SPNW74TVUkJqXw7Q4dL2WbUQG8tQZ
	ey30lUhD6FnhOshEJLjR+ADKuMrQy49kitMImXJbkN4U6dsZdhwmUkqYvbwxfwipKGr9
	oQpK9l1yyRGBFNw6+PqqT+qbu/mDqUd8wBOKHvCayvRZwnHvqAmFlf/NYNQ42//3x36a
	pwUwDjv412D4HLSlZWrK3pZacVLYvmMOzHw026Oby6qbAfP0NOwsRIx0lcFoqofJSTkY
	ByjyOLhfTi7QQDLF0f8CZ5dPHZTgUfNXC96EagTi2wUz6ipuCanJWh7+XemBUGWrGsT+
	1Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4RdrN7GA3r8yy/LIQmPOrXRIGWZZCxjf6XHcNWaC7So=;
	b=JgcYV2DHE+R/59fo43cXb5CLuMP3Rl/v+uAJ5+2Ltqs/du6avzQEYJNZLro1lw8zBh
	RZZGYR90jK521K5S9dtB2fpXYUDkNk60M/e4I4DbISI5UrsoefzWQyLkAGhXqa8NAS1v
	iHZ05A+1kDKW7onhCtSrMz5pOqvQatiEjWganaTSVfnj7x3WY79Xuv/3wruiVyiXgVTS
	V/tWvWqw+4JvfBv3qCWe6L+/XRCZkBcmMXeI+GzFeIYLBm+nzUJ7Dl8Fg3eHv32xyxSe
	tkwdKZxkpG4DHRPVlHzJJ9czahlsvaGRVTrMTSLRUpzjz4oE7zbpVbPBmNjAovXgBNmP
	f+kA==
X-Gm-Message-State: APjAAAVuXUHxJqJ/J6QyA9dyZvb3THzZAa2nF0P31ndYF84UEHBa0L4+
	XoDMZn6Oa5yJm0e/KJLd5GeCkA==
X-Google-Smtp-Source: APXvYqxXrryAM+9Mf6N9ZqhYorAGtC0xnGFAQDrlTehf6yI2CVMmAyw8TajpxRB0nkB17yWN1YHB+w==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr18983611wrq.218.1555419491605;
	Tue, 16 Apr 2019 05:58:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.58.07
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:58:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:29 +0100
Message-Id: <20190416125744.27770-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 11/26] target/arm: Implement v7m_update_fpccr()
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
Message-ID: <20190416125729.HHNmmt8UMVfXfAt6x6WafxAziv3N6aF4icquaOhHlgc@z>

Implement the code which updates the FPCCR register on an
exception entry where we are going to use lazy FP stacking.
We have to defer to the NVIC to determine whether the
various exceptions are currently ready or not.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h      | 14 +++++++++
 hw/intc/armv7m_nvic.c | 34 ++++++++++++++++++++++
 target/arm/helper.c   | 67 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c8d78bd5b52..0e0cb6b2271 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2045,6 +2045,20 @@ void armv7m_nvic_acknowledge_irq(void *opaque);
  * (Ignoring -1, this is the same as the RETTOBASE value before completion.)
  */
 int armv7m_nvic_complete_irq(void *opaque, int irq, bool secure);
+/**
+ * armv7m_nvic_get_ready_status(void *opaque, int irq, bool secure)
+ * @opaque: the NVIC
+ * @irq: the exception number to mark pending
+ * @secure: false for non-banked exceptions or for the nonsecure
+ * version of a banked exception, true for the secure version of a banked
+ * exception.
+ *
+ * Return whether an exception is "ready", i.e. whether the exception is
+ * enabled and is configured at a priority which would allow it to
+ * interrupt the current execution priority. This controls whether the
+ * RDY bit for it in the FPCCR is set.
+ */
+bool armv7m_nvic_get_ready_status(void *opaque, int irq, bool secure);
 /**
  * armv7m_nvic_raw_execution_priority: return the raw execution priority
  * @opaque: the NVIC
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5eb438f5409..53b4631dace 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -746,6 +746,40 @@ int armv7m_nvic_complete_irq(void *opaque, int irq, bool secure)
     return ret;
 }
 
+bool armv7m_nvic_get_ready_status(void *opaque, int irq, bool secure)
+{
+    /*
+     * Return whether an exception is "ready", i.e. it is enabled and is
+     * configured at a priority which would allow it to interrupt the
+     * current execution priority.
+     *
+     * irq and secure have the same semantics as for armv7m_nvic_set_pending():
+     * for non-banked exceptions secure is always false; for banked exceptions
+     * it indicates which of the exceptions is required.
+     */
+    NVICState *s = (NVICState *)opaque;
+    bool banked = exc_is_banked(irq);
+    VecInfo *vec;
+    int running = nvic_exec_prio(s);
+
+    assert(irq > ARMV7M_EXCP_RESET && irq < s->num_irq);
+    assert(!secure || banked);
+
+    /*
+     * HardFault is an odd special case: we always check against -1,
+     * even if we're secure and HardFault has priority -3; we never
+     * need to check for enabled state.
+     */
+    if (irq == ARMV7M_EXCP_HARD) {
+        return running > -1;
+    }
+
+    vec = (banked && secure) ? &s->sec_vectors[irq] : &s->vectors[irq];
+
+    return vec->enabled &&
+        exc_group_prio(s, vec->prio, secure) < running;
+}
+
 /* callback when external interrupt line is changed */
 static void set_irq_level(void *opaque, int n, int level)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7b2174a5e61..7298f9de735 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8182,6 +8182,71 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
     env->thumb = addr & 1;
 }
 
+static void v7m_update_fpccr(CPUARMState *env, uint32_t frameptr,
+                             bool apply_splim)
+{
+    /*
+     * Like the pseudocode UpdateFPCCR: save state in FPCAR and FPCCR
+     * that we will need later in order to do lazy FP reg stacking.
+     */
+    bool is_secure = env->v7m.secure;
+    void *nvic = env->nvic;
+    /*
+     * Some bits are unbanked and live always in fpccr[M_REG_S]; some bits
+     * are banked and we want to update the bit in the bank for the
+     * current security state; and in one case we want to specifically
+     * update the NS banked version of a bit even if we are secure.
+     */
+    uint32_t *fpccr_s = &env->v7m.fpccr[M_REG_S];
+    uint32_t *fpccr_ns = &env->v7m.fpccr[M_REG_NS];
+    uint32_t *fpccr = &env->v7m.fpccr[is_secure];
+    bool hfrdy, bfrdy, mmrdy, ns_ufrdy, s_ufrdy, sfrdy, monrdy;
+
+    env->v7m.fpcar[is_secure] = frameptr & ~0x7;
+
+    if (apply_splim && arm_feature(env, ARM_FEATURE_V8)) {
+        bool splimviol;
+        uint32_t splim = v7m_sp_limit(env);
+        bool ign = armv7m_nvic_neg_prio_requested(nvic, is_secure) &&
+            (env->v7m.ccr[is_secure] & R_V7M_CCR_STKOFHFNMIGN_MASK);
+
+        splimviol = !ign && frameptr < splim;
+        *fpccr = FIELD_DP32(*fpccr, V7M_FPCCR, SPLIMVIOL, splimviol);
+    }
+
+    *fpccr = FIELD_DP32(*fpccr, V7M_FPCCR, LSPACT, 1);
+
+    *fpccr_s = FIELD_DP32(*fpccr_s, V7M_FPCCR, S, is_secure);
+
+    *fpccr = FIELD_DP32(*fpccr, V7M_FPCCR, USER, arm_current_el(env) == 0);
+
+    *fpccr = FIELD_DP32(*fpccr, V7M_FPCCR, THREAD,
+                        !arm_v7m_is_handler_mode(env));
+
+    hfrdy = armv7m_nvic_get_ready_status(nvic, ARMV7M_EXCP_HARD, false);
+    *fpccr_s = FIELD_DP32(*fpccr_s, V7M_FPCCR, HFRDY, hfrdy);
+
+    bfrdy = armv7m_nvic_get_ready_status(nvic, ARMV7M_EXCP_BUS, false);
+    *fpccr_s = FIELD_DP32(*fpccr_s, V7M_FPCCR, BFRDY, bfrdy);
+
+    mmrdy = armv7m_nvic_get_ready_status(nvic, ARMV7M_EXCP_MEM, is_secure);
+    *fpccr = FIELD_DP32(*fpccr, V7M_FPCCR, MMRDY, mmrdy);
+
+    ns_ufrdy = armv7m_nvic_get_ready_status(nvic, ARMV7M_EXCP_USAGE, false);
+    *fpccr_ns = FIELD_DP32(*fpccr_ns, V7M_FPCCR, UFRDY, ns_ufrdy);
+
+    monrdy = armv7m_nvic_get_ready_status(nvic, ARMV7M_EXCP_DEBUG, false);
+    *fpccr_s = FIELD_DP32(*fpccr_s, V7M_FPCCR, MONRDY, monrdy);
+
+    if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        s_ufrdy = armv7m_nvic_get_ready_status(nvic, ARMV7M_EXCP_USAGE, true);
+        *fpccr_s = FIELD_DP32(*fpccr_s, V7M_FPCCR, UFRDY, s_ufrdy);
+
+        sfrdy = armv7m_nvic_get_ready_status(nvic, ARMV7M_EXCP_SECURE, false);
+        *fpccr_s = FIELD_DP32(*fpccr_s, V7M_FPCCR, SFRDY, sfrdy);
+    }
+}
+
 static bool v7m_push_stack(ARMCPU *cpu)
 {
     /* Do the "set up stack frame" part of exception entry,
@@ -8329,7 +8394,7 @@ static bool v7m_push_stack(ARMCPU *cpu)
                 }
             } else {
                 /* Lazy stacking enabled, save necessary info to stack later */
-                /* TODO : equivalent of UpdateFPCCR() pseudocode */
+                v7m_update_fpccr(env, frameptr + 0x20, true);
             }
         }
     }
-- 
2.20.1



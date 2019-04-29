Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B52C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB3220652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoXh3v0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB3220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32919 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLAEz-00041C-7i
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:38:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fQ-0005WJ-Af
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fO-00075Y-7T
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9fM-0006PQ-6O
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id p21so186668wmc.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=LmOE0d83u1c72HUQ4AcSpNQ+fi+rYfjt+t1Pykdp+Yo=;
	b=CoXh3v0u54eB+WuoQABFjvZjmpV/EtdHOWWc4XjhWBOL5dBoRC8JUOfZknyMN1QkqN
	dknBKPP8/C+92gk6Ytm44WW3THGOBxy2nHsB42cuNG4LSlQnm63EDLvBTQCQxmLv4z60
	+OIxq18cXPuXFwFdG8+omYEYJybd2dc3F8UbGZzMXcPT5GpAxXfXDFvoM4tBK+GtDw+/
	ZSMd3m2N3nCjlXsF4cSUOHDBLwqzlAvTIxqZOHMVEAg+QyU1lH5gJJJ4XcbpIybaTToT
	HwS1IL0GUcG0meGpxYVq1GKsmwOw+YMLTrH01suKSQ8jfHCWVfsyyhkBYu4dxWmysYoR
	XEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=LmOE0d83u1c72HUQ4AcSpNQ+fi+rYfjt+t1Pykdp+Yo=;
	b=PH8uvSWr5ft+ohRzxD4Peg4m/+WWe4Pbu9rOak68kEfSBgI57NxB3+S+KEKU+ulbM0
	RlB6QiHg8lgDoiervq6/HUNHwbwOFLjleSrT6KLDVaoZl5HUOsVdGZvNHdlcdsLtDlLK
	hHAb74oJ2OmacEGOEvESjWAiicJhWkwaPK/3sjnHy9wXyhnRjM9Hcjjbsz4/c8gzArtW
	JPj+BvVYSwzR+06uDAvVSuOOQCY4nwKCN/tuXivBOcYZlt7H1z2pNMSqAlkWfoFka252
	o19NtKk09adU0Sx1CdbmoNYSBtbO3tc9LT9K0vXpl7lnYB2RcWCG8nQ/ucea7CLi9pHU
	o9pA==
X-Gm-Message-State: APjAAAUsmVjy6ZBez92LEVm21pkD4gKXJ2f1FktjcQt0Xz2Awyzln2al
	p3ox3K78a8skjCyg7YVJ207IMe7juWA=
X-Google-Smtp-Source: APXvYqxsFhZ1Y/mDt/8r955Hx3878KuPsEaxP3HjFh+HBZKxMBrbvHMRXa54CO+fjNqJO5BjgvGVzQ==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr67290wmh.0.1556557250374;
	Mon, 29 Apr 2019 10:00:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.49
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:02 +0100
Message-Id: <20190429170030.11323-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PULL 14/42] target/arm: Implement v7m_update_fpccr()
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
Message-ID: <20190429170002.e4LJ-fcAu8tX2N-bRH7Nx9WaLLCCtO2t2yUX2gJnp6U@z>

Implement the code which updates the FPCCR register on an
exception entry where we are going to use lazy FP stacking.
We have to defer to the NVIC to determine whether the
various exceptions are currently ready or not.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190416125744.27770-12-peter.maydell@linaro.org
---
 target/arm/cpu.h      | 14 +++++++++
 hw/intc/armv7m_nvic.c | 34 ++++++++++++++++++++++
 target/arm/helper.c   | 67 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 67e4e95d440..eb989d773af 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2044,6 +2044,20 @@ void armv7m_nvic_acknowledge_irq(void *opaque);
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
index 6e55da5c482..547898581a2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8177,6 +8177,71 @@ static void v7m_exception_taken(ARMCPU *cpu, uint32_t lr, bool dotailchain,
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
@@ -8324,7 +8389,7 @@ static bool v7m_push_stack(ARMCPU *cpu)
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



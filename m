Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF35C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D462075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nduZnefL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D462075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60985 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA4S-0002Vl-HU
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:28:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9ex-000504-Az
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eu-0006op-35
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9et-0006SV-CU
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id h11so153997wmb.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=4NCuKYdU/5uBNbCdep+D4E0qb4uFtn4WI3o3KSNsLEM=;
	b=nduZnefLRFJp0hARyji3cfZKzuHDb9IzyE7NLUwOWvNQQtpawAwXXzSNIwRQ+/oKKF
	0EYPpHT6A0zzhQu0TKp8cHfDVebMM8zkv/GzahSvUk0ULDCKYeNmtrvWu1s8oloNAns4
	yVC5uLW2D0lxqRQV56mNImioP3aqfmCGlbg0RfkV/RtbipTLZTvA40y067WbHsMC3w22
	cshPPAvWe7f6wkZRU+Hql1XltxHmn/yRQ0bR5r0u5vVjBSa5mcq1//sPfa9DsNovfI+n
	C9rmlUiik8WIZ8ET0JpF9RwR0W9sTpZ6+ARuKHFeLqsXcpFhTDbXL9mdlAorwJeRXFmv
	ut+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4NCuKYdU/5uBNbCdep+D4E0qb4uFtn4WI3o3KSNsLEM=;
	b=nnC7nh88f0EY4JbyV74IyY4kOHtUh2ISqt3Y8K9lzuAcKYfX3x/NAi5viTorPw396f
	49fyYhSur0uypdDbqXHU7z4sWi8Z4Uyg2WEPPpfMAtOS6ccNr3/xOKf63XQq32cw3/Ud
	ao8jwvMRHbGMobgNl03+gKepyPCxGwOZxIHnnmL/XLPY7EbDQCNivBRLSRQ5iiJUj6YI
	OwrPAAqyb9yD7YZhCRPdLLxQHLbCK2ApaqFfOgfSMaUPmYr2QQjpiQkJB20mGoDfGTFb
	V0xMbNFKpNw36gE3dbKSEqjdhhXbA4wmjT+7Tpn3Au6RfJ392aYv7bV2J7tuNRPAvgTq
	b74g==
X-Gm-Message-State: APjAAAUGmEa9Cct7BgZw6v37vQ2sM42RuvC3Onc0zNfzvGaroColb82x
	WZZ6bIiYN4xxdv8ubpv8n7C8dOd4VZI=
X-Google-Smtp-Source: APXvYqyu3vUuKmpgRT4AhKHRbaHRDy9KhQ5+vrqiydpqsVgLeKn2rh1k0oPzp56YTls+zl4YTUraYg==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr52633wmc.62.1556557255429;
	Mon, 29 Apr 2019 10:00:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.54
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:06 +0100
Message-Id: <20190429170030.11323-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 18/42] target/arm: Handle floating point
 registers in exception return
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
Message-ID: <20190429170006.e8XxMcdTYyKYhrChidrIeji7KMnfTvH0qw1QeZLZCGs@z>

Handle floating point registers in exception return.
This corresponds to pseudocode functions ValidateExceptionReturn(),
ExceptionReturn(), PopStack() and ConsumeExcStackFrame().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-16-peter.maydell@linaro.org
---
 target/arm/helper.c | 142 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c7b1a8d231d..14604f49a4c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8447,6 +8447,8 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
     bool rettobase = false;
     bool exc_secure = false;
     bool return_to_secure;
+    bool ftype;
+    bool restore_s16_s31;
 
     /* If we're not in Handler mode then jumps to magic exception-exit
      * addresses don't have magic behaviour. However for the v8M
@@ -8484,6 +8486,16 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
                       excret);
     }
 
+    ftype = excret & R_V7M_EXCRET_FTYPE_MASK;
+
+    if (!arm_feature(env, ARM_FEATURE_VFP) && !ftype) {
+        qemu_log_mask(LOG_GUEST_ERROR, "M profile: zero FTYPE in exception "
+                      "exit PC value 0x%" PRIx32 " is UNPREDICTABLE "
+                      "if FPU not present\n",
+                      excret);
+        ftype = true;
+    }
+
     if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         /* EXC_RETURN.ES validation check (R_SMFL). We must do this before
          * we pick which FAULTMASK to clear.
@@ -8584,6 +8596,30 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
      */
     write_v7m_control_spsel_for_secstate(env, return_to_sp_process, exc_secure);
 
+    /*
+     * Clear scratch FP values left in caller saved registers; this
+     * must happen before any kind of tail chaining.
+     */
+    if ((env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_CLRONRET_MASK) &&
+        (env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK)) {
+        if (env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPACT_MASK) {
+            env->v7m.sfsr |= R_V7M_SFSR_LSERR_MASK;
+            armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+            qemu_log_mask(CPU_LOG_INT, "...taking SecureFault on existing "
+                          "stackframe: error during lazy state deactivation\n");
+            v7m_exception_taken(cpu, excret, true, false);
+            return;
+        } else {
+            /* Clear s0..s15 and FPSCR */
+            int i;
+
+            for (i = 0; i < 16; i += 2) {
+                *aa32_vfp_dreg(env, i / 2) = 0;
+            }
+            vfp_set_fpscr(env, 0);
+        }
+    }
+
     if (sfault) {
         env->v7m.sfsr |= R_V7M_SFSR_INVER_MASK;
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
@@ -8745,8 +8781,105 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
             }
         }
 
+        if (!ftype) {
+            /* FP present and we need to handle it */
+            if (!return_to_secure &&
+                (env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPACT_MASK)) {
+                armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_SECURE, false);
+                env->v7m.sfsr |= R_V7M_SFSR_LSERR_MASK;
+                qemu_log_mask(CPU_LOG_INT,
+                              "...taking SecureFault on existing stackframe: "
+                              "Secure LSPACT set but exception return is "
+                              "not to secure state\n");
+                v7m_exception_taken(cpu, excret, true, false);
+                return;
+            }
+
+            restore_s16_s31 = return_to_secure &&
+                (env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_TS_MASK);
+
+            if (env->v7m.fpccr[return_to_secure] & R_V7M_FPCCR_LSPACT_MASK) {
+                /* State in FPU is still valid, just clear LSPACT */
+                env->v7m.fpccr[return_to_secure] &= ~R_V7M_FPCCR_LSPACT_MASK;
+            } else {
+                int i;
+                uint32_t fpscr;
+                bool cpacr_pass, nsacr_pass;
+
+                cpacr_pass = v7m_cpacr_pass(env, return_to_secure,
+                                            return_to_priv);
+                nsacr_pass = return_to_secure ||
+                    extract32(env->v7m.nsacr, 10, 1);
+
+                if (!cpacr_pass) {
+                    armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE,
+                                            return_to_secure);
+                    env->v7m.cfsr[return_to_secure] |= R_V7M_CFSR_NOCP_MASK;
+                    qemu_log_mask(CPU_LOG_INT,
+                                  "...taking UsageFault on existing "
+                                  "stackframe: CPACR.CP10 prevents unstacking "
+                                  "FP regs\n");
+                    v7m_exception_taken(cpu, excret, true, false);
+                    return;
+                } else if (!nsacr_pass) {
+                    armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_USAGE, true);
+                    env->v7m.cfsr[M_REG_S] |= R_V7M_CFSR_INVPC_MASK;
+                    qemu_log_mask(CPU_LOG_INT,
+                                  "...taking Secure UsageFault on existing "
+                                  "stackframe: NSACR.CP10 prevents unstacking "
+                                  "FP regs\n");
+                    v7m_exception_taken(cpu, excret, true, false);
+                    return;
+                }
+
+                for (i = 0; i < (restore_s16_s31 ? 32 : 16); i += 2) {
+                    uint32_t slo, shi;
+                    uint64_t dn;
+                    uint32_t faddr = frameptr + 0x20 + 4 * i;
+
+                    if (i >= 16) {
+                        faddr += 8; /* Skip the slot for the FPSCR */
+                    }
+
+                    pop_ok = pop_ok &&
+                        v7m_stack_read(cpu, &slo, faddr, mmu_idx) &&
+                        v7m_stack_read(cpu, &shi, faddr + 4, mmu_idx);
+
+                    if (!pop_ok) {
+                        break;
+                    }
+
+                    dn = (uint64_t)shi << 32 | slo;
+                    *aa32_vfp_dreg(env, i / 2) = dn;
+                }
+                pop_ok = pop_ok &&
+                    v7m_stack_read(cpu, &fpscr, frameptr + 0x60, mmu_idx);
+                if (pop_ok) {
+                    vfp_set_fpscr(env, fpscr);
+                }
+                if (!pop_ok) {
+                    /*
+                     * These regs are 0 if security extension present;
+                     * otherwise merely UNKNOWN. We zero always.
+                     */
+                    for (i = 0; i < (restore_s16_s31 ? 32 : 16); i += 2) {
+                        *aa32_vfp_dreg(env, i / 2) = 0;
+                    }
+                    vfp_set_fpscr(env, 0);
+                }
+            }
+        }
+        env->v7m.control[M_REG_S] = FIELD_DP32(env->v7m.control[M_REG_S],
+                                               V7M_CONTROL, FPCA, !ftype);
+
         /* Commit to consuming the stack frame */
         frameptr += 0x20;
+        if (!ftype) {
+            frameptr += 0x48;
+            if (restore_s16_s31) {
+                frameptr += 0x40;
+            }
+        }
         /* Undo stack alignment (the SPREALIGN bit indicates that the original
          * pre-exception SP was not 8-aligned and we added a padding word to
          * align it, so we undo this by ORing in the bit that increases it
@@ -8759,7 +8892,14 @@ static void do_v7m_exception_exit(ARMCPU *cpu)
         *frame_sp_p = frameptr;
     }
     /* This xpsr_write() will invalidate frame_sp_p as it may switch stack */
-    xpsr_write(env, xpsr, ~XPSR_SPREALIGN);
+    xpsr_write(env, xpsr, ~(XPSR_SPREALIGN | XPSR_SFPA));
+
+    if (env->v7m.secure) {
+        bool sfpa = xpsr & XPSR_SFPA;
+
+        env->v7m.control[M_REG_S] = FIELD_DP32(env->v7m.control[M_REG_S],
+                                               V7M_CONTROL, SFPA, sfpa);
+    }
 
     /* The restored xPSR exception field will be zero if we're
      * resuming in Thread mode. If that doesn't match what the
-- 
2.20.1



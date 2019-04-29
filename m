Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A2C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D8E2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLLvNVon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D8E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60962 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA2X-0000Pl-I1
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:26:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0004rg-Hk
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eo-0006kd-Gr
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eo-0006NL-1h
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id p21so186402wmc.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=aRW2k9Bx9SmwGykwzikVBcj0TPSJbJZ0vG2+ZFO8UMs=;
	b=wLLvNVonfMOdE5NK01+FeJefR2LEdhlmaHSblf/41ORtcHH2wIU7LiI19j1r15NOc+
	Vckz6RbsacvtlHEjY0ZtRqktYWSkZOxOHcfjpEYj0i+G4U0XRcGxrt7GKUhB/r2mnWg2
	FsxlzWqwq2C9qWTjq1Ku1vG+IvmIB6ihEZX+RLv/IgGnRmrdTusoxQhz+ezNnCsDCs5q
	C4g2wsghmYNLD+R3K1+NfByhp3yIf65ERfrLwerU44yNv1HYwvdFQDmh6dWMHmrKgQ2/
	bErIEYe7amlyDkBv0DP2jWn1cYyvmDMTvluflcRMp+rFLuSGzDGvlr0X2krVx/9HnJfk
	HL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aRW2k9Bx9SmwGykwzikVBcj0TPSJbJZ0vG2+ZFO8UMs=;
	b=qoOHGtrdMMWOFpvQ8ZErVzeC5rVwyf3SLtCFRPdipT1Rg9QWPXcpI165qMR6oZVZ0D
	HR8Kro1lBiSbvuhZeLBzrwTugLZvbiI4DWD21jliUswutBpipNAw0bLVCOoT3nw1NsxK
	cHEiEB5EIOntRCvkB5hrRkuDtlsg1PNS5gYuMlA1BsImrMfMk0yLpuCCd+sHVN5sTlTS
	EfU4Xe8ld+EaG227zTZMswfweMf+RGoawTrQJ94QxTE2uli/DZRGqpCf+j/Q3uNO2N0F
	WCaEjj0W2qhEjLcykFD5LhquPl7ffLkzzv4lxeoE0j/jXdcMsUBZxP3aOMnb50+6Ezoh
	WGcA==
X-Gm-Message-State: APjAAAXPKpAWaJaMRWGUkiE1iIiEmcamc1ey9DRTzhBEiETaKFQbEh1e
	zSsCf1UZos5Frz9HCveGzvmAxokX8GQ=
X-Google-Smtp-Source: APXvYqyT2bc8/CokJXAb3SzQ8KNXk8rd1XS7VRaLkY7fyfQ3Zbtgq+wBVlDxG09t0TdTxsT+E/NBIQ==
X-Received: by 2002:a1c:dc84:: with SMTP id t126mr15391wmg.143.1556557246599; 
	Mon, 29 Apr 2019 10:00:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.45
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 17:59:59 +0100
Message-Id: <20190429170030.11323-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PULL 11/42] target/arm: Handle SFPA and FPCA bits in
 reads and writes of CONTROL
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
Message-ID: <20190429165959.GYx0D12FgQFPqGKOF79a8jEyGHsQ-kDz4tHC0tUvCKQ@z>

The M-profile CONTROL register has two bits -- SFPA and FPCA --
which relate to floating-point support, and should be RES0 otherwise.
Handle them correctly in the MSR/MRS register access code.
Neither is banked between security states, so they are stored
in v7m.control[M_REG_S] regardless of current security state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-9-peter.maydell@linaro.org
---
 target/arm/helper.c | 57 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 45a9d92e505..e801744673f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12027,7 +12027,14 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         return xpsr_read(env) & mask;
         break;
     case 20: /* CONTROL */
-        return env->v7m.control[env->v7m.secure];
+    {
+        uint32_t value = env->v7m.control[env->v7m.secure];
+        if (!env->v7m.secure) {
+            /* SFPA is RAZ/WI from NS; FPCA is stored in the M_REG_S bank */
+            value |= env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK;
+        }
+        return value;
+    }
     case 0x94: /* CONTROL_NS */
         /* We have to handle this here because unprivileged Secure code
          * can read the NS CONTROL register.
@@ -12035,7 +12042,8 @@ uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
         if (!env->v7m.secure) {
             return 0;
         }
-        return env->v7m.control[M_REG_NS];
+        return env->v7m.control[M_REG_NS] |
+            (env->v7m.control[M_REG_S] & R_V7M_CONTROL_FPCA_MASK);
     }
 
     if (el == 0) {
@@ -12141,9 +12149,13 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
      */
     uint32_t mask = extract32(maskreg, 8, 4);
     uint32_t reg = extract32(maskreg, 0, 8);
+    int cur_el = arm_current_el(env);
 
-    if (arm_current_el(env) == 0 && reg > 7) {
-        /* only xPSR sub-fields may be written by unprivileged */
+    if (cur_el == 0 && reg > 7 && reg != 20) {
+        /*
+         * only xPSR sub-fields and CONTROL.SFPA may be written by
+         * unprivileged code
+         */
         return;
     }
 
@@ -12202,6 +12214,15 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
                 env->v7m.control[M_REG_NS] &= ~R_V7M_CONTROL_NPRIV_MASK;
                 env->v7m.control[M_REG_NS] |= val & R_V7M_CONTROL_NPRIV_MASK;
             }
+            /*
+             * SFPA is RAZ/WI from NS. FPCA is RO if NSACR.CP10 == 0,
+             * RES0 if the FPU is not present, and is stored in the S bank
+             */
+            if (arm_feature(env, ARM_FEATURE_VFP) &&
+                extract32(env->v7m.nsacr, 10, 1)) {
+                env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
+                env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
+            }
             return;
         case 0x98: /* SP_NS */
         {
@@ -12304,21 +12325,41 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
         env->v7m.faultmask[env->v7m.secure] = val & 1;
         break;
     case 20: /* CONTROL */
-        /* Writing to the SPSEL bit only has an effect if we are in
+        /*
+         * Writing to the SPSEL bit only has an effect if we are in
          * thread mode; other bits can be updated by any privileged code.
          * write_v7m_control_spsel() deals with updating the SPSEL bit in
          * env->v7m.control, so we only need update the others.
          * For v7M, we must just ignore explicit writes to SPSEL in handler
          * mode; for v8M the write is permitted but will have no effect.
+         * All these bits are writes-ignored from non-privileged code,
+         * except for SFPA.
          */
-        if (arm_feature(env, ARM_FEATURE_V8) ||
-            !arm_v7m_is_handler_mode(env)) {
+        if (cur_el > 0 && (arm_feature(env, ARM_FEATURE_V8) ||
+                           !arm_v7m_is_handler_mode(env))) {
             write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
-        if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
+        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
             env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
             env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         }
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            /*
+             * SFPA is RAZ/WI from NS or if no FPU.
+             * FPCA is RO if NSACR.CP10 == 0, RES0 if the FPU is not present.
+             * Both are stored in the S bank.
+             */
+            if (env->v7m.secure) {
+                env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_SFPA_MASK;
+                env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_SFPA_MASK;
+            }
+            if (cur_el > 0 &&
+                (env->v7m.secure || !arm_feature(env, ARM_FEATURE_M_SECURITY) ||
+                 extract32(env->v7m.nsacr, 10, 1))) {
+                env->v7m.control[M_REG_S] &= ~R_V7M_CONTROL_FPCA_MASK;
+                env->v7m.control[M_REG_S] |= val & R_V7M_CONTROL_FPCA_MASK;
+            }
+        }
         break;
     default:
     bad_reg:
-- 
2.20.1



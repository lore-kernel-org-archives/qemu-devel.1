Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB8C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909BC2171F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 20:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDbaISIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909BC2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsvYP-0006O4-Sk
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 16:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32955)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvN0-0005IS-8y
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsvMz-0003ew-2s
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:46 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35141)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsvMy-0003dv-Sv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 16:38:45 -0400
Received: by mail-pg1-x543.google.com with SMTP id s1so26341816pgr.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 13:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gkdd1xo9dAf4K2ZLEThkLYxs4H8KbbboSDJfUHi98zc=;
 b=ZDbaISIZ3zgNqxZlEnpBUY3V2zdR9HW9CR1WHtGeWAaHAYFzmG1zEiUvprFlqdWgBF
 OoDezKag3b/3idd6mx+ISvn38e2INhCTTjhgRgA+fb6OzEVxk99vZjc/n6f2Fkrtt4MP
 NdvOAY9UqpPnTLAdnqnZmP01d4tCo5Nr8TW04LgZrHetRTTiu8Xjt6e2i9kNZVlrDjRp
 QaxgMB3oG/u5BZp4G516V1v9Mh3ICvJJQTvv3F4m1EQn/ME1w9Cxsl83+cUjn0UQJEIu
 U0hyfSgyExKgrah2yP6hc33PXurZbRsvoO3umB0UXjfv16/TJZde8QSaqIVi5NEce9Wb
 HZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gkdd1xo9dAf4K2ZLEThkLYxs4H8KbbboSDJfUHi98zc=;
 b=fFFiS1cA+ay5rCVVuyivg9qF+oPFukDNGwcpvy3GfC5TzRXSvWPtROEOv2vGVJAF7K
 0a8KVq0A5jcfVN5cTN8LPXKSU6HIUR6sReuYYWggcLH7OWT3KjM/OBd2BQWHq7Jy3tTQ
 bBY4I4lgikry5ZSNH056J1Pvj+o0gvRYRBKYwlFtxVUeaejA5fId49eEMB4WDVyTDYz3
 TJW2hfvOh493kdUv6ncfDR1v+mC3jlH0LuaAHN9Hjn6twjQGSBaRFVym2Ym4gvx2UW2I
 lfaGe21swmVHzyPIU9GbDbE4ik4IfpK5w3EC892KybVytEQmHdsomm14V2exz5rs+8tk
 KQUA==
X-Gm-Message-State: APjAAAXVPUve9OB2JLk0oxR62ki/wpbilpBONTXcxTIqTp8aMH4q1rfk
 WJxXLslL/x783Kj5Aj/SDn35pw29BIw=
X-Google-Smtp-Source: APXvYqxI9PkBPDFz1O+ZDnSIrP/QU7NtnsaAm7mvEC2zO8tOn+kFG6lKJgv2UTEXdcZ5Uzot5HIbqw==
X-Received: by 2002:a62:198d:: with SMTP id 135mr48906850pfz.169.1564605523502; 
 Wed, 31 Jul 2019 13:38:43 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm84054164pfo.93.2019.07.31.13.38.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 13:38:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:38:04 -0700
Message-Id: <20190731203813.30765-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731203813.30765-1-richard.henderson@linaro.org>
References: <20190731203813.30765-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 23/32] target/arm: Update arm_mmu_idx for VHE
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This covers initial generation in arm_mmu_idx, and reconstruction
in core_to_arm_mmu_idx.  As a conseqeuence, we also need a bit in
TBFLAGS in order to make the latter reliable.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  2 ++
 target/arm/helper.c | 42 +++++++++++++++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b5300f9014..64cda8dbea 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3153,6 +3153,8 @@ FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
 /* Target EL if we take a floating-point-disabled exception */
 FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
 FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
+/* For A profile only, if EL2 is AA64 and HCR_EL2.E2H is set.  */
+FIELD(TBFLAG_ANY, E2H, 22, 1)
 
 /* Bit usage when in AArch32 state: */
 FIELD(TBFLAG_A32, THUMB, 0, 1)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5472424179..578dcfefbf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11257,21 +11257,29 @@ int fp_exception_el(CPUARMState *env, int cur_el)
 
 ARMMMUIdx core_to_arm_mmu_idx(CPUARMState *env, int mmu_idx)
 {
+    bool e2h;
+
     if (arm_feature(env, ARM_FEATURE_M)) {
         return mmu_idx | ARM_MMU_IDX_M;
     }
 
     mmu_idx |= ARM_MMU_IDX_A;
+    if (mmu_idx & ARM_MMU_IDX_S) {
+        return mmu_idx;
+    }
+
+    e2h = (env->cp15.hcr_el2 & HCR_E2H) != 0;
+    if (!arm_el_is_aa64(env, 2)) {
+        e2h = false;
+    }
+
     switch (mmu_idx) {
     case 0 | ARM_MMU_IDX_A:
-        return ARMMMUIdx_EL10_0;
+        return e2h ? ARMMMUIdx_EL20_0 : ARMMMUIdx_EL10_0;
     case 1 | ARM_MMU_IDX_A:
         return ARMMMUIdx_EL10_1;
     case ARMMMUIdx_E2:
-    case ARMMMUIdx_SE0:
-    case ARMMMUIdx_SE1:
-    case ARMMMUIdx_SE3:
-        return mmu_idx;
+        return e2h ? ARMMMUIdx_EL20_2 : ARMMMUIdx_E2;
     default:
         g_assert_not_reached();
     }
@@ -11299,24 +11307,28 @@ ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 
 ARMMMUIdx arm_mmu_idx(CPUARMState *env)
 {
+    bool e2h, sec;
     int el;
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         return arm_v7m_mmu_idx_for_secstate(env, env->v7m.secure);
     }
 
+    sec = arm_is_secure_below_el3(env);
+    e2h = (env->cp15.hcr_el2 & HCR_E2H) != 0;
+    if (!arm_el_is_aa64(env, 2)) {
+        e2h = false;
+    }
+
     el = arm_current_el(env);
     switch (el) {
     case 0:
-        /* TODO: ARMv8.1-VHE */
+        return sec ? ARMMMUIdx_SE0 : e2h ? ARMMMUIdx_EL20_0 : ARMMMUIdx_EL10_0;
     case 1:
-        return (arm_is_secure_below_el3(env)
-                ? ARMMMUIdx_SE0 + el
-                : ARMMMUIdx_EL10_0 + el);
+        return sec ? ARMMMUIdx_SE1 : ARMMMUIdx_EL10_1;
     case 2:
-        /* TODO: ARMv8.1-VHE */
         /* TODO: ARMv8.4-SecEL2 */
-        return ARMMMUIdx_E2;
+        return e2h ? ARMMMUIdx_EL20_2 : ARMMMUIdx_E2;
     case 3:
         return ARMMMUIdx_SE3;
     default:
@@ -11428,6 +11440,14 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
 
     flags = FIELD_DP32(flags, TBFLAG_ANY, MMUIDX, arm_to_core_mmu_idx(mmu_idx));
 
+    /*
+     * Include E2H in TBFLAGS so that core_to_arm_mmu_idx can
+     * reliably determine E1&0 vs E2&0 regimes.
+     */
+    if (arm_el_is_aa64(env, 2) && (env->cp15.hcr_el2 & HCR_E2H)) {
+        flags = FIELD_DP32(flags, TBFLAG_ANY, E2H, 1);
+    }
+
     /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
      * states defined in the ARM ARM for software singlestep:
      *  SS_ACTIVE   PSTATE.SS   State
-- 
2.17.1



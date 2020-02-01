Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EF7C33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BF820661
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 19:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xM+07iXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BF820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixyYs-0007zt-JI
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 14:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySh-0007dS-71
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ixySf-0006so-Rj
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:47 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ixySf-0006ro-M4
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 14:29:45 -0500
Received: by mail-pg1-x543.google.com with SMTP id s64so5454406pgb.9
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 11:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=juHwnM8Na/3KK56bRpT8cVui++cBSP96GHuLJj2xiMg=;
 b=xM+07iXq2u1pCuJQLVjYH2LdM7NScv5mVx7IwCuG9cOYZtcurx/GY65jw5+kKzaRGM
 Go5v69WTfHJi8izaOEBgTLmdiu8cGcvOZUe5m1Sb1KPsfHmUN3sAr4rfMBKiFchVmEtd
 sXBwv5oXxWg++eWj8O+5J2Oo0ktvmsx0V+6W/aZOYmE0GtziyPamyo7UwkWKw+aSlXtx
 oaO9W3i7+dny2yv5Nxj5MGEFjPEGONV6UyLSZn0p4AYzlemm3KJSGLY7cHaajOP1EAfI
 iTeZNP33Hx02yxxd1TinribELY0jVGCxpfi0MpKjaoL1KC5wISQMHhfZCk1X6w/NtwMW
 WJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=juHwnM8Na/3KK56bRpT8cVui++cBSP96GHuLJj2xiMg=;
 b=G67mB2eNjJFbCoMxvQ0lzlFGGQqVQI4/5vfm7gst/HUBENzL3n7dN6ortzyRhOiEpS
 TTVWUdBD25ZmWbeEMJtjVDs7xAFQmiZsgcynRLcD66b9xr4dGOrvOzwVEm7ZgSEXvDO+
 po3vQw/iQf3th6aUqrCoJLPVNM+BZGt9p0WQR36C1S0zCafsbo+BOxH5mlzpuSqy3kFT
 Njb5Naj4Dctc34+hgH51IaSZJrDTZOQ3V9qOQlhX3op1SLHQ0YrbBxfln6TvHNNYvfHb
 /G8ZPTf/+bhZHQkPMH8fMOcg7qaJlU6zPn94m6LxKCTo/rZsfkvINER1/Py4sYvzd1u9
 1JEw==
X-Gm-Message-State: APjAAAXFApS1pBrSlHcx7myAehHHHpIZt9/RDmSdHbVCHSOfV3RzcnDU
 57yUie22+91/eQ7DsAMeI2PT8JMetoI=
X-Google-Smtp-Source: APXvYqzg6UXnFuaoJm9RRMxc+WhIQvZBz6jIcXz3Vfad+Qr4JOIkZILmwaPTLaD5Wi5DTlkEu7zYdw==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr16506404pfi.210.1580585384416; 
 Sat, 01 Feb 2020 11:29:44 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l7sm3668509pga.27.2020.02.01.11.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 11:29:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 22/41] target/arm: Update arm_sctlr for VHE
Date: Sat,  1 Feb 2020 11:28:57 -0800
Message-Id: <20200201192916.31796-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200201192916.31796-1-richard.henderson@linaro.org>
References: <20200201192916.31796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the correct sctlr for EL2&0 regime.  Due to header ordering,
and where arm_mmu_idx_el is declared, we need to move the function
out of line.  Use the function in many more places in order to
select the correct control.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Use arm_mmu_idx() to avoid incorrectly replicating the el2&0
    condition therein.  Drop the change to cpu_get_dump_info, as
    that needs a more significant rethink of hard-coded oddness.
v4: Use arm_mmu_idx_el().
---
 target/arm/cpu.h          | 10 +---------
 target/arm/helper-a64.c   |  2 +-
 target/arm/helper.c       | 20 +++++++++++++++-----
 target/arm/pauth_helper.c |  9 +--------
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3fc0e6e746..68e11f0eda 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3141,15 +3141,7 @@ static inline bool arm_sctlr_b(CPUARMState *env)
         (env->cp15.sctlr_el[1] & SCTLR_B) != 0;
 }
 
-static inline uint64_t arm_sctlr(CPUARMState *env, int el)
-{
-    if (el == 0) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-        return env->cp15.sctlr_el[1];
-    } else {
-        return env->cp15.sctlr_el[el];
-    }
-}
+uint64_t arm_sctlr(CPUARMState *env, int el);
 
 static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
                                                   bool sctlr_b)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 36aa6badfd..bf45f8a785 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -70,7 +70,7 @@ static void daif_check(CPUARMState *env, uint32_t op,
                        uint32_t imm, uintptr_t ra)
 {
     /* DAIF update to PSTATE. This is OK from EL0 only if UMA is set.  */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)) {
         raise_exception_ra(env, EXCP_UDEF,
                            syn_aa64_sysregtrap(0, extract32(op, 0, 3),
                                                extract32(op, 3, 3), 4,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9f8d7ca1f3..e4f368d96b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3913,7 +3913,7 @@ static void aa64_fpsr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static CPAccessResult aa64_daif_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
 {
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UMA)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -3932,7 +3932,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
     /* Cache invalidate/clean: NOP, but EL0 must UNDEF unless
      * SCTLR_EL1.UCI is set.
      */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCI)) {
+    if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UCI)) {
         return CP_ACCESS_TRAP;
     }
     return CP_ACCESS_OK;
@@ -8738,14 +8738,24 @@ static uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
+uint64_t arm_sctlr(CPUARMState *env, int el)
+{
+    /* Only EL0 needs to be adjusted for EL1&0 or EL2&0. */
+    if (el == 0) {
+        ARMMMUIdx mmu_idx = arm_mmu_idx_el(env, 0);
+        el = (mmu_idx == ARMMMUIdx_E20_0 ? 2 : 1);
+    }
+    return env->cp15.sctlr_el[el];
+}
 
 /* Return the SCTLR value which controls this address translation regime */
-static inline uint32_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline uint64_t regime_sctlr(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     return env->cp15.sctlr_el[regime_el(env, mmu_idx)];
 }
 
+#ifndef CONFIG_USER_ONLY
+
 /* Return true if the specified stage of address translation is disabled */
 static inline bool regime_translation_disabled(CPUARMState *env,
                                                ARMMMUIdx mmu_idx)
@@ -11484,7 +11494,7 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         flags = FIELD_DP32(flags, TBFLAG_A64, ZCR_LEN, zcr_len);
     }
 
-    sctlr = arm_sctlr(env, el);
+    sctlr = regime_sctlr(env, stage1);
 
     if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
         flags = FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 0a5f41e10c..e0c401c4a9 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -386,14 +386,7 @@ static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
 
 static bool pauth_key_enabled(CPUARMState *env, int el, uint32_t bit)
 {
-    uint32_t sctlr;
-    if (el == 0) {
-        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
-        sctlr = env->cp15.sctlr_el[1];
-    } else {
-        sctlr = env->cp15.sctlr_el[el];
-    }
-    return (sctlr & bit) != 0;
+    return (arm_sctlr(env, el) & bit) != 0;
 }
 
 uint64_t HELPER(pacia)(CPUARMState *env, uint64_t x, uint64_t y)
-- 
2.20.1



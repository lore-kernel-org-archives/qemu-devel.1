Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66E1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6020520767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mU1fP/xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6020520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofOi-0008PU-KB
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6T-00011r-7C
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:37 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6Q-00023L-14
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:36 -0400
Received: by mail-pf1-x442.google.com with SMTP id x207so4060644pfc.5
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OULdj6XcEdTR1qymq8JQYyzbOQeCar6lhcO2Vrh5aX4=;
 b=mU1fP/xosNHr89QcfnZ9jQqGiNnOLZUcafWPvTxghUJv6xLf+3+oZ6o5MACjJzyR2x
 DpDKHH6WqP/vuKfeWFPmhVSP3p4zwFTa9M5TbVE2Gf9jb7JjFyvmEUD0MhnaG1UixJ32
 vTsU5Si9u/tPlNOFDEVX4Hp/oB5zh46K4lAxQtzTIsh1DgVeVW9qXPvOvK10LqSM3/nJ
 UT5nwkZkt6umYPfGikxlOxFnlOa2IfGQ+lCoe6eBQxKWkivOkW3fDNbYWVhC5Kw4Y95A
 ryUBg4+/H2P1qkbK4dbMsqCpBZT3fhCrd7xhRdOI8m/LnJRI+yUmHMkxBBAraxWql9DH
 5nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OULdj6XcEdTR1qymq8JQYyzbOQeCar6lhcO2Vrh5aX4=;
 b=Rq8dG6WxaqWqrhyNYmA/GgsV2W0YhXRqtaaiVoWZzRAVo+n1e7iLDPFNyD6dj+cTYp
 BqQwqSAuNYU3cDq85tOheuiReF/ap3vTC6FqMyisvKmup7bK8SNnzV1vin+FytfikyN6
 ykvG5yE7JVsDR8xlRHTnLbZ4erJTZ2G3By8xdciHSwASESU2HeDuIuxzNbIWWrHAmA7P
 n4MVdHepAZJ5jpIjj/00aQz54V1VLn9Wz3GAWRe8AtqfknoI8iBGrQKwSReTee+6+n4i
 EELHDuXt8R5AXeF/8fVjkGGtwx8I0RJLg8fdPR0HlbnY76MWylfplDH4K79k6knUW268
 rfwQ==
X-Gm-Message-State: AOAM531/dXEo/IOLw2+DGx0fI1t59SG4I2vvrPaDj7OtQJWNdscB7qoY
 pnnAic4AuwNEbfyZsLg8dHHq0sIhXOQ=
X-Google-Smtp-Source: ABdhPJyvmVseupLsgT5YnpOCDjyS8jwNgiciJDPtvJ6BkCbAAfmadtRKgHeU+cqqs+72+ed0C4klFA==
X-Received: by 2002:aa7:8dc1:: with SMTP id j1mr834412pfr.194.1593142352227;
 Thu, 25 Jun 2020 20:32:32 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 34/46] target/arm: Add mte helpers for sve scalar + int
 stores
Date: Thu, 25 Jun 2020 20:31:32 -0700
Message-Id: <20200626033144.790098-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because the elements are sequential, we can eliminate many tests all
at once when the tag hits TCMA, or if the page(s) are not Tagged.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  47 +++++++++++
 target/arm/sve_helper.c    |  95 ++++++++++++++++------
 target/arm/translate-sve.c | 162 ++++++++++++++++++++++++-------------
 3 files changed, 226 insertions(+), 78 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 1bc1974fc2..1425f33c92 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1363,6 +1363,53 @@ DEF_HELPER_FLAGS_4(sve_st1hd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1sd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_st1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1bh_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bd_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1hs_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hs_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1sd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_6(sve_ldbsu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldhsu_le_zsu, TCG_CALL_NO_WG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 767ecb399f..ded9cedd18 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5022,11 +5022,12 @@ DO_LDFF1_LDNF1_2(dd,  MO_64, MO_64)
  */
 
 static inline QEMU_ALWAYS_INLINE
-void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr, uint32_t desc,
-               const uintptr_t retaddr, const int esz,
-               const int msz, const int N,
+void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
+               uint32_t desc, const uintptr_t retaddr,
+               const int esz, const int msz, const int N, uint32_t mtedesc,
                sve_ldst1_host_fn *host_fn,
-               sve_ldst1_tlb_fn *tlb_fn)
+               sve_ldst1_tlb_fn *tlb_fn,
+               sve_cont_ldst_mte_check_fn *mte_check_fn)
 {
     const unsigned rd = simd_data(desc);
     const intptr_t reg_max = simd_oprsz(desc);
@@ -5048,7 +5049,14 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr, uint32_t desc,
     sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, N << msz,
                               BP_MEM_WRITE, retaddr);
 
-    /* TODO: MTE check. */
+    /*
+     * Handle mte checks for all active elements.
+     * Since TBI must be set for MTE, !mtedesc => !mte_active.
+     */
+    if (mte_check_fn && mtedesc) {
+        mte_check_fn(&info, env, vg, addr, 1 << esz, N << msz,
+                     mtedesc, retaddr);
+    }
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
@@ -5142,26 +5150,67 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr, uint32_t desc,
     }
 }
 
-#define DO_STN_1(N, NAME, ESZ) \
-void HELPER(sve_st##N##NAME##_r)(CPUARMState *env, void *vg,        \
-                                 target_ulong addr, uint32_t desc)  \
-{                                                                   \
-    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, N,           \
-              sve_st1##NAME##_host, sve_st1##NAME##_tlb);           \
+static inline QEMU_ALWAYS_INLINE
+void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
+                   uint32_t desc, const uintptr_t ra,
+                   const int esz, const int msz, const int N,
+                   sve_ldst1_host_fn *host_fn,
+                   sve_ldst1_tlb_fn *tlb_fn)
+{
+    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    int bit55 = extract64(addr, 55, 1);
+
+    /* Remove mtedesc from the normal sve descriptor. */
+    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+
+    /* Perform gross MTE suppression early. */
+    if (!tbi_check(desc, bit55) ||
+        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+        mtedesc = 0;
+    }
+
+    sve_stN_r(env, vg, addr, desc, ra, esz, msz, N, mtedesc, host_fn, tlb_fn,
+              N == 1 ? sve_cont_ldst_mte_check1 : sve_cont_ldst_mte_checkN);
 }
 
-#define DO_STN_2(N, NAME, ESZ, MSZ) \
-void HELPER(sve_st##N##NAME##_le_r)(CPUARMState *env, void *vg,       \
-                                    target_ulong addr, uint32_t desc) \
-{                                                                     \
-    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,              \
-              sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb);       \
-}                                                                     \
-void HELPER(sve_st##N##NAME##_be_r)(CPUARMState *env, void *vg,       \
-                                    target_ulong addr, uint32_t desc) \
-{                                                                     \
-    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,              \
-              sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb);       \
+#define DO_STN_1(N, NAME, ESZ)                                          \
+void HELPER(sve_st##N##NAME##_r)(CPUARMState *env, void *vg,            \
+                                 target_ulong addr, uint32_t desc)      \
+{                                                                       \
+    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, N, 0,            \
+              sve_st1##NAME##_host, sve_st1##NAME##_tlb, NULL);         \
+}                                                                       \
+void HELPER(sve_st##N##NAME##_r_mte)(CPUARMState *env, void *vg,        \
+                                     target_ulong addr, uint32_t desc)  \
+{                                                                       \
+    sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, N,           \
+                  sve_st1##NAME##_host, sve_st1##NAME##_tlb);           \
+}
+
+#define DO_STN_2(N, NAME, ESZ, MSZ)                                     \
+void HELPER(sve_st##N##NAME##_le_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
+{                                                                       \
+    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N, 0,             \
+              sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb, NULL);   \
+}                                                                       \
+void HELPER(sve_st##N##NAME##_be_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
+{                                                                       \
+    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N, 0,             \
+              sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb, NULL);   \
+}                                                                       \
+void HELPER(sve_st##N##NAME##_le_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,            \
+                  sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb);     \
+}                                                                       \
+void HELPER(sve_st##N##NAME##_be_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,            \
+                  sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb);     \
 }
 
 DO_STN_1(1, bb, MO_8)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 2620c965f0..daac8589f3 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5018,73 +5018,125 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                       int msz, int esz, int nreg)
 {
-    static gen_helper_gvec_mem * const fn_single[2][4][4] = {
-        { { gen_helper_sve_st1bb_r,
-            gen_helper_sve_st1bh_r,
-            gen_helper_sve_st1bs_r,
-            gen_helper_sve_st1bd_r },
-          { NULL,
-            gen_helper_sve_st1hh_le_r,
-            gen_helper_sve_st1hs_le_r,
-            gen_helper_sve_st1hd_le_r },
-          { NULL, NULL,
-            gen_helper_sve_st1ss_le_r,
-            gen_helper_sve_st1sd_le_r },
-          { NULL, NULL, NULL,
-            gen_helper_sve_st1dd_le_r } },
-        { { gen_helper_sve_st1bb_r,
-            gen_helper_sve_st1bh_r,
-            gen_helper_sve_st1bs_r,
-            gen_helper_sve_st1bd_r },
-          { NULL,
-            gen_helper_sve_st1hh_be_r,
-            gen_helper_sve_st1hs_be_r,
-            gen_helper_sve_st1hd_be_r },
-          { NULL, NULL,
-            gen_helper_sve_st1ss_be_r,
-            gen_helper_sve_st1sd_be_r },
-          { NULL, NULL, NULL,
-            gen_helper_sve_st1dd_be_r } },
+    static gen_helper_gvec_mem * const fn_single[2][2][4][4] = {
+        { { { gen_helper_sve_st1bb_r,
+              gen_helper_sve_st1bh_r,
+              gen_helper_sve_st1bs_r,
+              gen_helper_sve_st1bd_r },
+            { NULL,
+              gen_helper_sve_st1hh_le_r,
+              gen_helper_sve_st1hs_le_r,
+              gen_helper_sve_st1hd_le_r },
+            { NULL, NULL,
+              gen_helper_sve_st1ss_le_r,
+              gen_helper_sve_st1sd_le_r },
+            { NULL, NULL, NULL,
+              gen_helper_sve_st1dd_le_r } },
+          { { gen_helper_sve_st1bb_r,
+              gen_helper_sve_st1bh_r,
+              gen_helper_sve_st1bs_r,
+              gen_helper_sve_st1bd_r },
+            { NULL,
+              gen_helper_sve_st1hh_be_r,
+              gen_helper_sve_st1hs_be_r,
+              gen_helper_sve_st1hd_be_r },
+            { NULL, NULL,
+              gen_helper_sve_st1ss_be_r,
+              gen_helper_sve_st1sd_be_r },
+            { NULL, NULL, NULL,
+              gen_helper_sve_st1dd_be_r } } },
+
+        { { { gen_helper_sve_st1bb_r_mte,
+              gen_helper_sve_st1bh_r_mte,
+              gen_helper_sve_st1bs_r_mte,
+              gen_helper_sve_st1bd_r_mte },
+            { NULL,
+              gen_helper_sve_st1hh_le_r_mte,
+              gen_helper_sve_st1hs_le_r_mte,
+              gen_helper_sve_st1hd_le_r_mte },
+            { NULL, NULL,
+              gen_helper_sve_st1ss_le_r_mte,
+              gen_helper_sve_st1sd_le_r_mte },
+            { NULL, NULL, NULL,
+              gen_helper_sve_st1dd_le_r_mte } },
+          { { gen_helper_sve_st1bb_r_mte,
+              gen_helper_sve_st1bh_r_mte,
+              gen_helper_sve_st1bs_r_mte,
+              gen_helper_sve_st1bd_r_mte },
+            { NULL,
+              gen_helper_sve_st1hh_be_r_mte,
+              gen_helper_sve_st1hs_be_r_mte,
+              gen_helper_sve_st1hd_be_r_mte },
+            { NULL, NULL,
+              gen_helper_sve_st1ss_be_r_mte,
+              gen_helper_sve_st1sd_be_r_mte },
+            { NULL, NULL, NULL,
+              gen_helper_sve_st1dd_be_r_mte } } },
     };
-    static gen_helper_gvec_mem * const fn_multiple[2][3][4] = {
-        { { gen_helper_sve_st2bb_r,
-            gen_helper_sve_st2hh_le_r,
-            gen_helper_sve_st2ss_le_r,
-            gen_helper_sve_st2dd_le_r },
-          { gen_helper_sve_st3bb_r,
-            gen_helper_sve_st3hh_le_r,
-            gen_helper_sve_st3ss_le_r,
-            gen_helper_sve_st3dd_le_r },
-          { gen_helper_sve_st4bb_r,
-            gen_helper_sve_st4hh_le_r,
-            gen_helper_sve_st4ss_le_r,
-            gen_helper_sve_st4dd_le_r } },
-        { { gen_helper_sve_st2bb_r,
-            gen_helper_sve_st2hh_be_r,
-            gen_helper_sve_st2ss_be_r,
-            gen_helper_sve_st2dd_be_r },
-          { gen_helper_sve_st3bb_r,
-            gen_helper_sve_st3hh_be_r,
-            gen_helper_sve_st3ss_be_r,
-            gen_helper_sve_st3dd_be_r },
-          { gen_helper_sve_st4bb_r,
-            gen_helper_sve_st4hh_be_r,
-            gen_helper_sve_st4ss_be_r,
-            gen_helper_sve_st4dd_be_r } },
+    static gen_helper_gvec_mem * const fn_multiple[2][2][3][4] = {
+        { { { gen_helper_sve_st2bb_r,
+              gen_helper_sve_st2hh_le_r,
+              gen_helper_sve_st2ss_le_r,
+              gen_helper_sve_st2dd_le_r },
+            { gen_helper_sve_st3bb_r,
+              gen_helper_sve_st3hh_le_r,
+              gen_helper_sve_st3ss_le_r,
+              gen_helper_sve_st3dd_le_r },
+            { gen_helper_sve_st4bb_r,
+              gen_helper_sve_st4hh_le_r,
+              gen_helper_sve_st4ss_le_r,
+              gen_helper_sve_st4dd_le_r } },
+          { { gen_helper_sve_st2bb_r,
+              gen_helper_sve_st2hh_be_r,
+              gen_helper_sve_st2ss_be_r,
+              gen_helper_sve_st2dd_be_r },
+            { gen_helper_sve_st3bb_r,
+              gen_helper_sve_st3hh_be_r,
+              gen_helper_sve_st3ss_be_r,
+              gen_helper_sve_st3dd_be_r },
+            { gen_helper_sve_st4bb_r,
+              gen_helper_sve_st4hh_be_r,
+              gen_helper_sve_st4ss_be_r,
+              gen_helper_sve_st4dd_be_r } } },
+        { { { gen_helper_sve_st2bb_r_mte,
+              gen_helper_sve_st2hh_le_r_mte,
+              gen_helper_sve_st2ss_le_r_mte,
+              gen_helper_sve_st2dd_le_r_mte },
+            { gen_helper_sve_st3bb_r_mte,
+              gen_helper_sve_st3hh_le_r_mte,
+              gen_helper_sve_st3ss_le_r_mte,
+              gen_helper_sve_st3dd_le_r_mte },
+            { gen_helper_sve_st4bb_r_mte,
+              gen_helper_sve_st4hh_le_r_mte,
+              gen_helper_sve_st4ss_le_r_mte,
+              gen_helper_sve_st4dd_le_r_mte } },
+          { { gen_helper_sve_st2bb_r_mte,
+              gen_helper_sve_st2hh_be_r_mte,
+              gen_helper_sve_st2ss_be_r_mte,
+              gen_helper_sve_st2dd_be_r_mte },
+            { gen_helper_sve_st3bb_r_mte,
+              gen_helper_sve_st3hh_be_r_mte,
+              gen_helper_sve_st3ss_be_r_mte,
+              gen_helper_sve_st3dd_be_r_mte },
+            { gen_helper_sve_st4bb_r_mte,
+              gen_helper_sve_st4hh_be_r_mte,
+              gen_helper_sve_st4ss_be_r_mte,
+              gen_helper_sve_st4dd_be_r_mte } } },
     };
     gen_helper_gvec_mem *fn;
     int be = s->be_data == MO_BE;
 
     if (nreg == 0) {
         /* ST1 */
-        fn = fn_single[be][msz][esz];
+        fn = fn_single[s->mte_active[0]][be][msz][esz];
+        nreg = 1;
     } else {
         /* ST2, ST3, ST4 -- msz == esz, enforced by encoding */
         assert(msz == esz);
-        fn = fn_multiple[be][nreg - 1][msz];
+        fn = fn_multiple[s->mte_active[0]][be][nreg - 1][msz];
     }
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), 0, true, fn);
+    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), nreg, true, fn);
 }
 
 static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
-- 
2.25.1



Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13ACFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75FA2072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEhc8Qj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75FA2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIG1-0005x1-26
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyo-0004w3-B2
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:06 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:36607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHym-0003fe-Ac
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:05 -0400
Received: by mail-pg1-x52b.google.com with SMTP id t7so572829pgt.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XUP7fLUyNu7aJ/azDCnH0EjQhulMay9kUPV+jtINGnw=;
 b=KEhc8Qj2H4cBL5zFIOrVv9smT58yCnDEJXTViSyMCmY9+AOVN1BsJ4weduNBFWPhG9
 piPoZgYCuqFNUCpWvpxEFEslyb4xCtSJDiYydrPrpPW8ms1hfWMMeNfPdLGR/7AII8+0
 WRMx0SKOtycAAfkFyq8Vt/2ueBlxcsiItj6e9jX3IVN1WLEQxDfgC65AztwWx8DE2RVB
 xnLEpbxgMSKt7A2N5aYPYvl8jcdB55dmzBksTee5aX+hHAcc3fKQ1zA1IOTOKdfhope2
 a/e6VPCDKXHsoKG9UQrHeYKEYqnxySOoLCqq+5SEvHAPI9alD/uW+NPXM7Pm0uTvv6Qr
 AVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XUP7fLUyNu7aJ/azDCnH0EjQhulMay9kUPV+jtINGnw=;
 b=QMpBkbrh1tFI5xgmjHjJ5mO46MCQIGkzLXiyYEB6F14yktHSqNr2zatfEEspoHsJmr
 Us5u0hMpn32Iuihgtku8mIekFBkClSHwyTITg7TWeXPoDbnYpAlhbWjzQU96w41s/fEM
 wbZPgK/q51bZuSkOM1rPgz8ymtb/bkqQY3+fKrvzS86XQC9mstnXqIuV0u7rLkQWe6D7
 K5zvCJiJ7CabPSH2SUkIwSN65EFepTCAUrVEKbfbEVPtT1ESNKmpL53OpEwM8IJJC3d3
 JHB92R1lRdALxeLdq2LZUBgmk5tDpaevYdF4cdvxnKLjawQjH8zqdLK6r3imIlyaRv+9
 0iUg==
X-Gm-Message-State: AOAM533cH/h1myFcHNydif9wnurXBnI3FhwaG14FykGzeh2pBEUVhntA
 Z8Cas/bcX/LwSBDCtFJnLmlq8GrK2gI=
X-Google-Smtp-Source: ABdhPJyjDTTP8TroAWBENOvING8jbh/Icx6r9gHMobJxv7cxWPol2aLcVWuDFsMiaTWVwJuqugWY4Q==
X-Received: by 2002:a63:5f11:: with SMTP id t17mr25479831pgb.177.1591146842122; 
 Tue, 02 Jun 2020 18:14:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:14:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 33/42] target/arm: Add mte helpers for sve scalar + int
 ff/nf loads
Date: Tue,  2 Jun 2020 18:13:08 -0700
Message-Id: <20200603011317.473934-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because the elements are sequential, we can eliminate many tests all
at once when the tag hits TCMA, or if the page(s) are not Tagged.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  98 ++++++++++++++++
 target/arm/sve_helper.c    |  98 ++++++++++++++--
 target/arm/translate-sve.c | 232 +++++++++++++++++++++++++------------
 3 files changed, 342 insertions(+), 86 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 8cead615b1..700ed0e1cb 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1288,6 +1288,55 @@ DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ldff1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1hh_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1hh_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1ss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1ss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1319,6 +1368,55 @@ DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ldnf1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 8d69ccd0c4..85bf8e5de3 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4923,7 +4923,7 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
  */
 static inline QEMU_ALWAYS_INLINE
 void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
-                   uint32_t desc, const uintptr_t retaddr,
+                   uint32_t desc, const uintptr_t retaddr, uint32_t mtedesc,
                    const int esz, const int msz, const SVEContFault fault,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
@@ -4955,13 +4955,22 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     mem_off = info.mem_off_first[0];
     flags = info.page[0].flags;
 
+    /* Since TBI must be set for MTE, !mtedesc => !mte_active. */
+    if (info.page[0].attrs.target_tlb_bit1) {
+        mtedesc = 0;
+    }
+
     if (fault == FAULT_FIRST) {
+        /* Trapping mte check for the first-fault element.  */
+        if (mtedesc) {
+            mte_check1(env, mtedesc, addr + mem_off, retaddr);
+        }
+
         /*
          * Special handling of the first active element,
          * if it crosses a page boundary or is MMIO.
          */
         bool is_split = mem_off == info.mem_off_split;
-        /* TODO: MTE check. */
         if (unlikely(flags != 0) || unlikely(is_split)) {
             /*
              * Use the slow path for cross-page handling.
@@ -4997,7 +5006,10 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                 /* Watchpoint hit, see below. */
                 goto do_fault;
             }
-            /* TODO: MTE check. */
+            if (mtedesc &&
+                !mte_probe1(env, mtedesc, addr + mem_off, retaddr)) {
+                goto do_fault;
+            }
             /*
              * Use the slow path for cross-page handling.
              * This is RAM, without a watchpoint, and will not trap.
@@ -5045,7 +5057,10 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                      & BP_MEM_READ)) {
                     goto do_fault;
                 }
-                /* TODO: MTE check. */
+                if (mtedesc &&
+                    !mte_probe1(env, mtedesc, addr + mem_off, retaddr)) {
+                    goto do_fault;
+                }
                 host_fn(vd, reg_off, host + mem_off);
             }
             reg_off += 1 << esz;
@@ -5083,44 +5098,103 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     record_fault(env, reg_off, reg_max);
 }
 
-#define DO_LDFF1_LDNF1_1(PART, ESZ) \
+static inline QEMU_ALWAYS_INLINE
+void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
+                       uint32_t desc, const uintptr_t retaddr,
+                       const int esz, const int msz, const SVEContFault fault,
+                       sve_ldst1_host_fn *host_fn,
+                       sve_ldst1_tlb_fn *tlb_fn)
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
+    sve_ldnfff1_r(env, vg, addr, desc, retaddr, mtedesc,
+                  esz, msz, fault, host_fn, tlb_fn);
+}
+
+#define DO_LDFF1_LDNF1_1(PART, ESZ)                                     \
 void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
                                  target_ulong addr, uint32_t desc)      \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_FIRST, \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
                                  target_ulong addr, uint32_t desc)      \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO,    \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_NO, \
+                  sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_r_mte)(CPUARMState *env, void *vg,        \
+                                     target_ulong addr, uint32_t desc)  \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
+                      sve_ld1##PART##_host, sve_ld1##PART##_tlb);       \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_r_mte)(CPUARMState *env, void *vg,        \
+                                     target_ulong addr, uint32_t desc)  \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO, \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }
 
-#define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ) \
+#define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ)                                \
 void HELPER(sve_ldff1##PART##_le_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_le_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldff1##PART##_be_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_be_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
+                      sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
+                      sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
+                      sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
+                      sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
 }
 
 DO_LDFF1_LDNF1_1(bb,  MO_8)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c6029b032d..a1dc325104 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4720,104 +4720,188 @@ static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
 
 static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a)
 {
-    static gen_helper_gvec_mem * const fns[2][16] = {
-        /* Little-endian */
-        { gen_helper_sve_ldff1bb_r,
-          gen_helper_sve_ldff1bhu_r,
-          gen_helper_sve_ldff1bsu_r,
-          gen_helper_sve_ldff1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][2][16] = {
+        { /* mte inactive, little-endian */
+          { gen_helper_sve_ldff1bb_r,
+            gen_helper_sve_ldff1bhu_r,
+            gen_helper_sve_ldff1bsu_r,
+            gen_helper_sve_ldff1bdu_r,
 
-          gen_helper_sve_ldff1sds_le_r,
-          gen_helper_sve_ldff1hh_le_r,
-          gen_helper_sve_ldff1hsu_le_r,
-          gen_helper_sve_ldff1hdu_le_r,
+            gen_helper_sve_ldff1sds_le_r,
+            gen_helper_sve_ldff1hh_le_r,
+            gen_helper_sve_ldff1hsu_le_r,
+            gen_helper_sve_ldff1hdu_le_r,
 
-          gen_helper_sve_ldff1hds_le_r,
-          gen_helper_sve_ldff1hss_le_r,
-          gen_helper_sve_ldff1ss_le_r,
-          gen_helper_sve_ldff1sdu_le_r,
+            gen_helper_sve_ldff1hds_le_r,
+            gen_helper_sve_ldff1hss_le_r,
+            gen_helper_sve_ldff1ss_le_r,
+            gen_helper_sve_ldff1sdu_le_r,
 
-          gen_helper_sve_ldff1bds_r,
-          gen_helper_sve_ldff1bss_r,
-          gen_helper_sve_ldff1bhs_r,
-          gen_helper_sve_ldff1dd_le_r },
+            gen_helper_sve_ldff1bds_r,
+            gen_helper_sve_ldff1bss_r,
+            gen_helper_sve_ldff1bhs_r,
+            gen_helper_sve_ldff1dd_le_r },
 
-        /* Big-endian */
-        { gen_helper_sve_ldff1bb_r,
-          gen_helper_sve_ldff1bhu_r,
-          gen_helper_sve_ldff1bsu_r,
-          gen_helper_sve_ldff1bdu_r,
+          /* mte inactive, big-endian */
+          { gen_helper_sve_ldff1bb_r,
+            gen_helper_sve_ldff1bhu_r,
+            gen_helper_sve_ldff1bsu_r,
+            gen_helper_sve_ldff1bdu_r,
 
-          gen_helper_sve_ldff1sds_be_r,
-          gen_helper_sve_ldff1hh_be_r,
-          gen_helper_sve_ldff1hsu_be_r,
-          gen_helper_sve_ldff1hdu_be_r,
+            gen_helper_sve_ldff1sds_be_r,
+            gen_helper_sve_ldff1hh_be_r,
+            gen_helper_sve_ldff1hsu_be_r,
+            gen_helper_sve_ldff1hdu_be_r,
 
-          gen_helper_sve_ldff1hds_be_r,
-          gen_helper_sve_ldff1hss_be_r,
-          gen_helper_sve_ldff1ss_be_r,
-          gen_helper_sve_ldff1sdu_be_r,
+            gen_helper_sve_ldff1hds_be_r,
+            gen_helper_sve_ldff1hss_be_r,
+            gen_helper_sve_ldff1ss_be_r,
+            gen_helper_sve_ldff1sdu_be_r,
 
-          gen_helper_sve_ldff1bds_r,
-          gen_helper_sve_ldff1bss_r,
-          gen_helper_sve_ldff1bhs_r,
-          gen_helper_sve_ldff1dd_be_r },
+            gen_helper_sve_ldff1bds_r,
+            gen_helper_sve_ldff1bss_r,
+            gen_helper_sve_ldff1bhs_r,
+            gen_helper_sve_ldff1dd_be_r } },
+
+        { /* mte active, little-endian */
+          { gen_helper_sve_ldff1bb_r_mte,
+            gen_helper_sve_ldff1bhu_r_mte,
+            gen_helper_sve_ldff1bsu_r_mte,
+            gen_helper_sve_ldff1bdu_r_mte,
+
+            gen_helper_sve_ldff1sds_le_r_mte,
+            gen_helper_sve_ldff1hh_le_r_mte,
+            gen_helper_sve_ldff1hsu_le_r_mte,
+            gen_helper_sve_ldff1hdu_le_r_mte,
+
+            gen_helper_sve_ldff1hds_le_r_mte,
+            gen_helper_sve_ldff1hss_le_r_mte,
+            gen_helper_sve_ldff1ss_le_r_mte,
+            gen_helper_sve_ldff1sdu_le_r_mte,
+
+            gen_helper_sve_ldff1bds_r_mte,
+            gen_helper_sve_ldff1bss_r_mte,
+            gen_helper_sve_ldff1bhs_r_mte,
+            gen_helper_sve_ldff1dd_le_r_mte },
+
+          /* mte active, big-endian */
+          { gen_helper_sve_ldff1bb_r_mte,
+            gen_helper_sve_ldff1bhu_r_mte,
+            gen_helper_sve_ldff1bsu_r_mte,
+            gen_helper_sve_ldff1bdu_r_mte,
+
+            gen_helper_sve_ldff1sds_be_r_mte,
+            gen_helper_sve_ldff1hh_be_r_mte,
+            gen_helper_sve_ldff1hsu_be_r_mte,
+            gen_helper_sve_ldff1hdu_be_r_mte,
+
+            gen_helper_sve_ldff1hds_be_r_mte,
+            gen_helper_sve_ldff1hss_be_r_mte,
+            gen_helper_sve_ldff1ss_be_r_mte,
+            gen_helper_sve_ldff1sdu_be_r_mte,
+
+            gen_helper_sve_ldff1bds_r_mte,
+            gen_helper_sve_ldff1bss_r_mte,
+            gen_helper_sve_ldff1bhs_r_mte,
+            gen_helper_sve_ldff1dd_be_r_mte } },
     };
 
     if (sve_access_check(s)) {
         TCGv_i64 addr = new_tmp_a64(s);
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
-        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 0, false,
-                   fns[s->be_data == MO_BE][a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 1, false,
+                   fns[s->mte_active[0]][s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
 
 static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    static gen_helper_gvec_mem * const fns[2][16] = {
-        /* Little-endian */
-        { gen_helper_sve_ldnf1bb_r,
-          gen_helper_sve_ldnf1bhu_r,
-          gen_helper_sve_ldnf1bsu_r,
-          gen_helper_sve_ldnf1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][2][16] = {
+        { /* mte inactive, little-endian */
+          { gen_helper_sve_ldnf1bb_r,
+            gen_helper_sve_ldnf1bhu_r,
+            gen_helper_sve_ldnf1bsu_r,
+            gen_helper_sve_ldnf1bdu_r,
 
-          gen_helper_sve_ldnf1sds_le_r,
-          gen_helper_sve_ldnf1hh_le_r,
-          gen_helper_sve_ldnf1hsu_le_r,
-          gen_helper_sve_ldnf1hdu_le_r,
+            gen_helper_sve_ldnf1sds_le_r,
+            gen_helper_sve_ldnf1hh_le_r,
+            gen_helper_sve_ldnf1hsu_le_r,
+            gen_helper_sve_ldnf1hdu_le_r,
 
-          gen_helper_sve_ldnf1hds_le_r,
-          gen_helper_sve_ldnf1hss_le_r,
-          gen_helper_sve_ldnf1ss_le_r,
-          gen_helper_sve_ldnf1sdu_le_r,
+            gen_helper_sve_ldnf1hds_le_r,
+            gen_helper_sve_ldnf1hss_le_r,
+            gen_helper_sve_ldnf1ss_le_r,
+            gen_helper_sve_ldnf1sdu_le_r,
 
-          gen_helper_sve_ldnf1bds_r,
-          gen_helper_sve_ldnf1bss_r,
-          gen_helper_sve_ldnf1bhs_r,
-          gen_helper_sve_ldnf1dd_le_r },
+            gen_helper_sve_ldnf1bds_r,
+            gen_helper_sve_ldnf1bss_r,
+            gen_helper_sve_ldnf1bhs_r,
+            gen_helper_sve_ldnf1dd_le_r },
 
-        /* Big-endian */
-        { gen_helper_sve_ldnf1bb_r,
-          gen_helper_sve_ldnf1bhu_r,
-          gen_helper_sve_ldnf1bsu_r,
-          gen_helper_sve_ldnf1bdu_r,
+          /* mte inactive, big-endian */
+          { gen_helper_sve_ldnf1bb_r,
+            gen_helper_sve_ldnf1bhu_r,
+            gen_helper_sve_ldnf1bsu_r,
+            gen_helper_sve_ldnf1bdu_r,
 
-          gen_helper_sve_ldnf1sds_be_r,
-          gen_helper_sve_ldnf1hh_be_r,
-          gen_helper_sve_ldnf1hsu_be_r,
-          gen_helper_sve_ldnf1hdu_be_r,
+            gen_helper_sve_ldnf1sds_be_r,
+            gen_helper_sve_ldnf1hh_be_r,
+            gen_helper_sve_ldnf1hsu_be_r,
+            gen_helper_sve_ldnf1hdu_be_r,
 
-          gen_helper_sve_ldnf1hds_be_r,
-          gen_helper_sve_ldnf1hss_be_r,
-          gen_helper_sve_ldnf1ss_be_r,
-          gen_helper_sve_ldnf1sdu_be_r,
+            gen_helper_sve_ldnf1hds_be_r,
+            gen_helper_sve_ldnf1hss_be_r,
+            gen_helper_sve_ldnf1ss_be_r,
+            gen_helper_sve_ldnf1sdu_be_r,
 
-          gen_helper_sve_ldnf1bds_r,
-          gen_helper_sve_ldnf1bss_r,
-          gen_helper_sve_ldnf1bhs_r,
-          gen_helper_sve_ldnf1dd_be_r },
+            gen_helper_sve_ldnf1bds_r,
+            gen_helper_sve_ldnf1bss_r,
+            gen_helper_sve_ldnf1bhs_r,
+            gen_helper_sve_ldnf1dd_be_r } },
+
+        { /* mte inactive, little-endian */
+          { gen_helper_sve_ldnf1bb_r_mte,
+            gen_helper_sve_ldnf1bhu_r_mte,
+            gen_helper_sve_ldnf1bsu_r_mte,
+            gen_helper_sve_ldnf1bdu_r_mte,
+
+            gen_helper_sve_ldnf1sds_le_r_mte,
+            gen_helper_sve_ldnf1hh_le_r_mte,
+            gen_helper_sve_ldnf1hsu_le_r_mte,
+            gen_helper_sve_ldnf1hdu_le_r_mte,
+
+            gen_helper_sve_ldnf1hds_le_r_mte,
+            gen_helper_sve_ldnf1hss_le_r_mte,
+            gen_helper_sve_ldnf1ss_le_r_mte,
+            gen_helper_sve_ldnf1sdu_le_r_mte,
+
+            gen_helper_sve_ldnf1bds_r_mte,
+            gen_helper_sve_ldnf1bss_r_mte,
+            gen_helper_sve_ldnf1bhs_r_mte,
+            gen_helper_sve_ldnf1dd_le_r_mte },
+
+          /* mte inactive, big-endian */
+          { gen_helper_sve_ldnf1bb_r_mte,
+            gen_helper_sve_ldnf1bhu_r_mte,
+            gen_helper_sve_ldnf1bsu_r_mte,
+            gen_helper_sve_ldnf1bdu_r_mte,
+
+            gen_helper_sve_ldnf1sds_be_r_mte,
+            gen_helper_sve_ldnf1hh_be_r_mte,
+            gen_helper_sve_ldnf1hsu_be_r_mte,
+            gen_helper_sve_ldnf1hdu_be_r_mte,
+
+            gen_helper_sve_ldnf1hds_be_r_mte,
+            gen_helper_sve_ldnf1hss_be_r_mte,
+            gen_helper_sve_ldnf1ss_be_r_mte,
+            gen_helper_sve_ldnf1sdu_be_r_mte,
+
+            gen_helper_sve_ldnf1bds_r_mte,
+            gen_helper_sve_ldnf1bss_r_mte,
+            gen_helper_sve_ldnf1bhs_r_mte,
+            gen_helper_sve_ldnf1dd_be_r_mte } },
     };
 
     if (sve_access_check(s)) {
@@ -4827,8 +4911,8 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
         TCGv_i64 addr = new_tmp_a64(s);
 
         tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), off);
-        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 0, false,
-                   fns[s->be_data == MO_BE][a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 1, false,
+                   fns[s->mte_active[0]][s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
-- 
2.25.1



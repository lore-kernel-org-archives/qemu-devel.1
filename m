Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C74CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F2A20767
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SqvfTTsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F2A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofNv-00078W-HJ
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6U-00014Z-C3
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:44045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6R-00023n-KR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:37 -0400
Received: by mail-pf1-x430.google.com with SMTP id p11so4040356pff.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gley5PTlIZ/vE7ww6YedmRvipYFC/oolvxk7pzA/zSY=;
 b=SqvfTTsRcJJmOEaaxuMbmYNEA17iAQhZWv6ubmMdsxPmzd1IN38TAUPLPa2PH1kmuk
 QWZ3YcE5QGsY/i9FefsDhM6Ud1gMlHjL4OSJSC+1XC1o/XGSpUsuZGRmIG6RiVWAo8xU
 qZDJDH92fjdOkiNvAjSce4zhAGKwLpLZVKfQ+65F3INPkaPegMOeNGcJLV53B/qPnyt3
 DGj2KyeDCN+9Zyq9tSi+i4ScCOeyFF1RqIvswLrDQ3bS/x0kOwPyWlQjM3dAFPnFh6aP
 0KgiwiougoVb1OH6vFJHAtRvUL82wAhdZyqXXB3uNreO6VzPkHdNCywZpfnbo0USRi/W
 SZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gley5PTlIZ/vE7ww6YedmRvipYFC/oolvxk7pzA/zSY=;
 b=SVYZGsWy7OuBy7GBGRG6XKysepFiQU+TaNzFTWEAKE39s/jgVPTnZ434isoom8HQ2+
 f43H5R3eOfNEPpfiOex844LM32MylGQV8SsSxeSdD8neEnBrLYiY9zJrlwEx4xt68VWG
 kMPepDmtcGdwNgbgNBUAFkJpZzuPXVB3Px7e97DZy4izxka2gPEoLDZKrHC5s7MGipPL
 ZRtYNtfZrAts8UUko3Mg2ItPLiYi2zsyWHi3eKaKdvnsjE/5nIzK+CmgYborwNVr84Lf
 7pWle+jnVE6vSQWqjxO9crglsVciXRvur2VyGTSRZQfSqXmXjtIPOnSQZpbfWxcOdix6
 EYSQ==
X-Gm-Message-State: AOAM532dlttVdvl7jx9Zhn0Hgz2+tMkpI2a3gBc4LQd7+T8Hb1bz2dwz
 puKaQCmnWgON1VD7pcBzH6ktzVyKBn0=
X-Google-Smtp-Source: ABdhPJxKo+6PhDYMFBZNtegsm0nHh+zmdl//g383hueFASFgbI9Bt3DsDTe9Our07pBWgbUB8A8CNA==
X-Received: by 2002:a62:58c4:: with SMTP id m187mr811615pfb.216.1593142353601; 
 Thu, 25 Jun 2020 20:32:33 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 35/46] target/arm: Add mte helpers for sve scalar + int
 ff/nf loads
Date: Thu, 25 Jun 2020 20:31:33 -0700
Message-Id: <20200626033144.790098-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/arm/helper-sve.h    |  98 ++++++++++++++++
 target/arm/sve_helper.c    |  99 ++++++++++++++--
 target/arm/translate-sve.c | 232 +++++++++++++++++++++++++------------
 3 files changed, 343 insertions(+), 86 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 1425f33c92..f48752eb42 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1285,6 +1285,55 @@ DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
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
@@ -1316,6 +1365,55 @@ DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
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
index ded9cedd18..7aca4ad384 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4794,7 +4794,7 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
  */
 static inline QEMU_ALWAYS_INLINE
 void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
-                   uint32_t desc, const uintptr_t retaddr,
+                   uint32_t desc, const uintptr_t retaddr, uint32_t mtedesc,
                    const int esz, const int msz, const SVEContFault fault,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
@@ -4826,13 +4826,25 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     mem_off = info.mem_off_first[0];
     flags = info.page[0].flags;
 
+    /*
+     * Disable MTE checking if the Tagged bit is not set.  Since TBI must
+     * be set within MTEDESC for MTE, !mtedesc => !mte_active.
+     */
+    if (arm_tlb_mte_tagged(&info.page[0].attrs)) {
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
@@ -4868,7 +4880,9 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                 /* Watchpoint hit, see below. */
                 goto do_fault;
             }
-            /* TODO: MTE check. */
+            if (mtedesc && !mte_probe1(env, mtedesc, addr + mem_off)) {
+                goto do_fault;
+            }
             /*
              * Use the slow path for cross-page handling.
              * This is RAM, without a watchpoint, and will not trap.
@@ -4916,7 +4930,9 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                      & BP_MEM_READ)) {
                     goto do_fault;
                 }
-                /* TODO: MTE check. */
+                if (mtedesc && !mte_probe1(env, mtedesc, addr + mem_off)) {
+                    goto do_fault;
+                }
                 host_fn(vd, reg_off, host + mem_off);
             }
             reg_off += 1 << esz;
@@ -4954,44 +4970,103 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
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
index daac8589f3..e4fbe48493 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4773,104 +4773,188 @@ static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
 
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
@@ -4880,8 +4964,8 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
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



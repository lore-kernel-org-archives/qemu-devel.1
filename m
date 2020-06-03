Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AC0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848652072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oD+lUQwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848652072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIDV-0000Qc-NA
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyl-0004o0-QT
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyj-0003fB-Pw
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:14:03 -0400
Received: by mail-pl1-x642.google.com with SMTP id x11so194564plv.9
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2xPAi+lk3cEpSYCm7Piwq8ZTxTMvoTDJuamxmBX9DsE=;
 b=oD+lUQwnw303Lh4blXue88J2Mmhns6ykjvw7hQp5soCq7gOWNbh9348mnnqad7w+Jp
 CEcuO9TrRR8Das6pRDP1WkSkR6Zv84z//z73Q4tfNXJKkRFl82VAAqCG4EQgouD3mBg4
 paWCnCkBoKF6wzkjxgFpd3Z7h9Xs29freaSRly5+Dqmwh8z5gbE2Q1yZ2OHWRstAU5YJ
 4HGP5gSf4Y15atW7hp4yijgjCcwwUbNttxfnbzvgOZQIe61eM16yKsdgeC/i2BLLsnFj
 byk80A/VGfvsayIp6r/SbJk49chPRYFc16g5f41jiBorJTHuQEZLqJvEOmJPyjugI/mf
 U7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2xPAi+lk3cEpSYCm7Piwq8ZTxTMvoTDJuamxmBX9DsE=;
 b=YQG01gk6EeFUnnTujb+1uc/1OC7Ma9ADYEvOO+nvZQS+zfrLafLA6CKlywf8X0I2+L
 /r0IYUk1rtyRMNA5qqKNaiA29g2gmGPKe1RLsMUNRv4Hb0RIuUUwxCheUZ4v9TYmhTDf
 fiZ/g4rKlw2/CEm7a3jzbD2Q29rH8ue20f8G71/RFmXYXhrMZHL81tK89HPm+RcaUyTo
 oiQYnZGHhCbJ3BGPBrBKzvmYX99RxRsvJXggfVe4W0/76Bh1kkdxJUAS1bV7N151rS0+
 BIIC42WJdrVC7vGA5oEA9XHBAaxBRiKSmmQUlpgD9XlkDHm5Zh0lCZCny37bWD9+wnyN
 kcEQ==
X-Gm-Message-State: AOAM530tLHa9bGOTdbf3YQoOxmQcC7KQFQqW24eErC/YNjK8WvrtPYdY
 UUrCmdmEdP8D8nbFd5l4JinDUA3+rR4=
X-Google-Smtp-Source: ABdhPJwPTc1zAAPcT7LNUnqMf+ygfJd/j5xEKrm8spljizBz9AhjtqWBc6nYMX+O7eGFKCd1E/DKDg==
X-Received: by 2002:a17:902:6947:: with SMTP id
 k7mr27701820plt.258.1591146839586; 
 Tue, 02 Jun 2020 18:13:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 31/42] target/arm: Add mte helpers for sve scalar + int
 loads
Date: Tue,  2 Jun 2020 18:13:06 -0700
Message-Id: <20200603011317.473934-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
 target/arm/helper-sve.h    |  58 ++++++++++
 target/arm/internals.h     |   6 +
 target/arm/sve_helper.c    | 218 ++++++++++++++++++++++++++++++-------
 target/arm/translate-sve.c | 186 ++++++++++++++++++++++---------
 4 files changed, 377 insertions(+), 91 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 197cd72999..d65c11c008 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1199,6 +1199,64 @@ DEF_HELPER_FLAGS_4(sve_ld1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ld1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1hsu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hdu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hds_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1hsu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hdu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1hds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1sds_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1sds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ldff1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index cc485603a8..2b70446bb9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1310,6 +1310,12 @@ void arm_log_exception(int idx);
 #define LOG2_TAG_GRANULE 4
 #define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
 
+/*
+ * The SVE simd_data field, for memory ops, contains either
+ * rd (5 bits) or a shift count (2 bits).
+ */
+#define SVE_MTEDESC_SHIFT 5
+
 /* Bits within a descriptor passed to the helper_mte_check* functions. */
 FIELD(MTEDESC, MIDX,  0, 4)
 FIELD(MTEDESC, TBI,   4, 2)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 507fba37c9..ca9aacb1c0 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4522,15 +4522,89 @@ static void sve_cont_ldst_watchpoints(SVEContLdSt *info, CPUARMState *env,
 #endif
 }
 
+typedef uint64_t mte_check_fn(CPUARMState *, uint32_t, uint64_t, uintptr_t);
+
+static inline QEMU_ALWAYS_INLINE
+void sve_cont_ldst_mte_check_int(SVEContLdSt *info, CPUARMState *env,
+                                 uint64_t *vg, target_ulong addr, int esize,
+                                 int msize, uint32_t mtedesc, uintptr_t ra,
+                                 mte_check_fn *check)
+{
+    intptr_t mem_off, reg_off, reg_last;
+
+    /* Process the page only if MemAttr == Tagged. */
+    if (info->page[0].attrs.target_tlb_bit1) {
+        mem_off = info->mem_off_first[0];
+        reg_off = info->reg_off_first[0];
+        reg_last = info->reg_off_split;
+        if (reg_last < 0) {
+            reg_last = info->reg_off_last[0];
+        }
+
+        do {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    check(env, mtedesc, addr, ra);
+                }
+                reg_off += esize;
+                mem_off += msize;
+            } while (reg_off <= reg_last && (reg_off & 63));
+        } while (reg_off <= reg_last);
+    }
+
+    mem_off = info->mem_off_first[1];
+    if (mem_off >= 0 && info->page[1].attrs.target_tlb_bit1) {
+        reg_off = info->reg_off_first[1];
+        reg_last = info->reg_off_last[1];
+
+        do {
+            uint64_t pg = vg[reg_off >> 6];
+            do {
+                if ((pg >> (reg_off & 63)) & 1) {
+                    check(env, mtedesc, addr, ra);
+                }
+                reg_off += esize;
+                mem_off += msize;
+            } while (reg_off & 63);
+        } while (reg_off <= reg_last);
+    }
+}
+
+typedef void sve_cont_ldst_mte_check_fn(SVEContLdSt *info, CPUARMState *env,
+                                        uint64_t *vg, target_ulong addr,
+                                        int esize, int msize, uint32_t mtedesc,
+                                        uintptr_t ra);
+
+static void sve_cont_ldst_mte_check1(SVEContLdSt *info, CPUARMState *env,
+                                     uint64_t *vg, target_ulong addr,
+                                     int esize, int msize, uint32_t mtedesc,
+                                     uintptr_t ra)
+{
+    sve_cont_ldst_mte_check_int(info, env, vg, addr, esize, msize,
+                                mtedesc, ra, mte_check1);
+}
+
+static void sve_cont_ldst_mte_checkN(SVEContLdSt *info, CPUARMState *env,
+                                     uint64_t *vg, target_ulong addr,
+                                     int esize, int msize, uint32_t mtedesc,
+                                     uintptr_t ra)
+{
+    sve_cont_ldst_mte_check_int(info, env, vg, addr, esize, msize,
+                                mtedesc, ra, mte_checkN);
+}
+
+
 /*
  * Common helper for all contiguous 1,2,3,4-register predicated stores.
  */
 static inline QEMU_ALWAYS_INLINE
 void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
                uint32_t desc, const uintptr_t retaddr,
-               const int esz, const int msz, const int N,
+               const int esz, const int msz, const int N, uint32_t mtedesc,
                sve_ldst1_host_fn *host_fn,
-               sve_ldst1_tlb_fn *tlb_fn)
+               sve_ldst1_tlb_fn *tlb_fn,
+               sve_cont_ldst_mte_check_fn *mte_check_fn)
 {
     const unsigned rd = simd_data(desc);
     const intptr_t reg_max = simd_oprsz(desc);
@@ -4555,7 +4629,14 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
     sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, N << msz,
                               BP_MEM_READ, retaddr);
 
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
@@ -4661,26 +4742,67 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
     }
 }
 
-#define DO_LD1_1(NAME, ESZ) \
-void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
-                            target_ulong addr, uint32_t desc)  \
-{                                                              \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, 1,      \
-              sve_##NAME##_host, sve_##NAME##_tlb);            \
+static inline QEMU_ALWAYS_INLINE
+void sve_ldN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
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
+    sve_ldN_r(env, vg, addr, desc, ra, esz, msz, N, mtedesc, host_fn, tlb_fn,
+              N == 1 ? sve_cont_ldst_mte_check1 : sve_cont_ldst_mte_checkN);
 }
 
-#define DO_LD1_2(NAME, ESZ, MSZ) \
-void HELPER(sve_##NAME##_le_r)(CPUARMState *env, void *vg,        \
-                               target_ulong addr, uint32_t desc)  \
-{                                                                 \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,          \
-              sve_##NAME##_le_host, sve_##NAME##_le_tlb);         \
-}                                                                 \
-void HELPER(sve_##NAME##_be_r)(CPUARMState *env, void *vg,        \
-                               target_ulong addr, uint32_t desc)  \
-{                                                                 \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,          \
-              sve_##NAME##_be_host, sve_##NAME##_be_tlb);         \
+#define DO_LD1_1(NAME, ESZ)                                             \
+void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,                 \
+                            target_ulong addr, uint32_t desc)           \
+{                                                                       \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, 1, 0,            \
+              sve_##NAME##_host, sve_##NAME##_tlb, NULL);               \
+}                                                                       \
+void HELPER(sve_##NAME##_r_mte)(CPUARMState *env, void *vg,             \
+                                target_ulong addr, uint32_t desc)       \
+{                                                                       \
+    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, 1,           \
+                  sve_##NAME##_host, sve_##NAME##_tlb);                 \
+}
+
+#define DO_LD1_2(NAME, ESZ, MSZ)                                        \
+void HELPER(sve_##NAME##_le_r)(CPUARMState *env, void *vg,              \
+                               target_ulong addr, uint32_t desc)        \
+{                                                                       \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1, 0,             \
+              sve_##NAME##_le_host, sve_##NAME##_le_tlb, NULL);         \
+}                                                                       \
+void HELPER(sve_##NAME##_be_r)(CPUARMState *env, void *vg,              \
+                               target_ulong addr, uint32_t desc)        \
+{                                                                       \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1, 0,             \
+              sve_##NAME##_be_host, sve_##NAME##_be_tlb, NULL);         \
+}                                                                       \
+void HELPER(sve_##NAME##_le_r_mte)(CPUARMState *env, void *vg,          \
+                                 target_ulong addr, uint32_t desc)      \
+{                                                                       \
+    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,            \
+                  sve_##NAME##_le_host, sve_##NAME##_le_tlb);           \
+}                                                                       \
+void HELPER(sve_##NAME##_be_r_mte)(CPUARMState *env, void *vg,          \
+                                 target_ulong addr, uint32_t desc)      \
+{                                                                       \
+    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,            \
+                  sve_##NAME##_be_host, sve_##NAME##_be_tlb);           \
 }
 
 DO_LD1_1(ld1bb,  MO_8)
@@ -4706,26 +4828,44 @@ DO_LD1_2(ld1dd,  MO_64, MO_64)
 #undef DO_LD1_1
 #undef DO_LD1_2
 
-#define DO_LDN_1(N) \
-void HELPER(sve_ld##N##bb_r)(CPUARMState *env, void *vg,        \
-                             target_ulong addr, uint32_t desc)  \
-{                                                               \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), MO_8, MO_8, N,      \
-              sve_ld1bb_host, sve_ld1bb_tlb);                   \
+#define DO_LDN_1(N)                                                     \
+void HELPER(sve_ld##N##bb_r)(CPUARMState *env, void *vg,                \
+                             target_ulong addr, uint32_t desc)          \
+{                                                                       \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), MO_8, MO_8, N, 0,           \
+              sve_ld1bb_host, sve_ld1bb_tlb, NULL);                     \
+}                                                                       \
+void HELPER(sve_ld##N##bb_r_mte)(CPUARMState *env, void *vg,            \
+                                 target_ulong addr, uint32_t desc)      \
+{                                                                       \
+    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), MO_8, MO_8, N,          \
+                  sve_ld1bb_host, sve_ld1bb_tlb);                       \
 }
 
-#define DO_LDN_2(N, SUFF, ESZ) \
-void HELPER(sve_ld##N##SUFF##_le_r)(CPUARMState *env, void *vg,       \
-                                    target_ulong addr, uint32_t desc) \
-{                                                                     \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,              \
-              sve_ld1##SUFF##_le_host, sve_ld1##SUFF##_le_tlb);       \
-}                                                                     \
-void HELPER(sve_ld##N##SUFF##_be_r)(CPUARMState *env, void *vg,       \
-                                    target_ulong addr, uint32_t desc) \
-{                                                                     \
-    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,              \
-              sve_ld1##SUFF##_be_host, sve_ld1##SUFF##_be_tlb);       \
+#define DO_LDN_2(N, SUFF, ESZ)                                          \
+void HELPER(sve_ld##N##SUFF##_le_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
+{                                                                       \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N, 0,             \
+              sve_ld1##SUFF##_le_host, sve_ld1##SUFF##_le_tlb, NULL);   \
+}                                                                       \
+void HELPER(sve_ld##N##SUFF##_be_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
+{                                                                       \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N, 0,             \
+              sve_ld1##SUFF##_be_host, sve_ld1##SUFF##_be_tlb, NULL);   \
+}                                                                       \
+void HELPER(sve_ld##N##SUFF##_le_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,            \
+                  sve_ld1##SUFF##_le_host, sve_ld1##SUFF##_le_tlb);     \
+}                                                                       \
+void HELPER(sve_ld##N##SUFF##_be_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldN_r_mte(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,            \
+                  sve_ld1##SUFF##_be_host, sve_ld1##SUFF##_be_tlb);     \
 }
 
 DO_LDN_1(2)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4b3b879815..48ef25cb32 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4522,18 +4522,32 @@ static const uint8_t dtype_esz[16] = {
 };
 
 static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
-                       int dtype, gen_helper_gvec_mem *fn)
+                       int dtype, uint32_t mte_n, bool is_write,
+                       gen_helper_gvec_mem *fn)
 {
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
     TCGv_i32 t_desc;
-    int desc;
+    int desc = 0;
 
-    /* For e.g. LD4, there are not enough arguments to pass all 4
+    /*
+     * For e.g. LD4, there are not enough arguments to pass all 4
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
+     * TODO: mte_n check here while callers are updated.
      */
-    desc = simd_desc(vsz, vsz, zt);
+    if (mte_n && s->mte_active[0]) {
+        int msz = dtype_msz(dtype);
+
+        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
+        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
+        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
+        desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << msz);
+        desc = FIELD_DP32(desc, MTEDESC, TSIZE, mte_n << msz);
+        desc <<= SVE_MTEDESC_SHIFT;
+    }
+    desc = simd_desc(vsz, vsz, zt | desc);
     t_desc = tcg_const_i32(desc);
     t_pg = tcg_temp_new_ptr();
 
@@ -4547,64 +4561,132 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 static void do_ld_zpa(DisasContext *s, int zt, int pg,
                       TCGv_i64 addr, int dtype, int nreg)
 {
-    static gen_helper_gvec_mem * const fns[2][16][4] = {
-        /* Little-endian */
-        { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
+    static gen_helper_gvec_mem * const fns[2][2][16][4] = {
+        { /* mte inactive, little-endian */
+          { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
             gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
-          { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
 
-          { gen_helper_sve_ld1sds_le_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hh_le_r, gen_helper_sve_ld2hh_le_r,
-            gen_helper_sve_ld3hh_le_r, gen_helper_sve_ld4hh_le_r },
-          { gen_helper_sve_ld1hsu_le_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hdu_le_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1sds_le_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hh_le_r, gen_helper_sve_ld2hh_le_r,
+              gen_helper_sve_ld3hh_le_r, gen_helper_sve_ld4hh_le_r },
+            { gen_helper_sve_ld1hsu_le_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hdu_le_r, NULL, NULL, NULL },
 
-          { gen_helper_sve_ld1hds_le_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hss_le_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1ss_le_r, gen_helper_sve_ld2ss_le_r,
-            gen_helper_sve_ld3ss_le_r, gen_helper_sve_ld4ss_le_r },
-          { gen_helper_sve_ld1sdu_le_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hds_le_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hss_le_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1ss_le_r, gen_helper_sve_ld2ss_le_r,
+              gen_helper_sve_ld3ss_le_r, gen_helper_sve_ld4ss_le_r },
+            { gen_helper_sve_ld1sdu_le_r, NULL, NULL, NULL },
 
-          { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1dd_le_r, gen_helper_sve_ld2dd_le_r,
-            gen_helper_sve_ld3dd_le_r, gen_helper_sve_ld4dd_le_r } },
+            { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1dd_le_r, gen_helper_sve_ld2dd_le_r,
+              gen_helper_sve_ld3dd_le_r, gen_helper_sve_ld4dd_le_r } },
 
-        /* Big-endian */
-        { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
-            gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
-          { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
+          /* mte inactive, big-endian */
+          { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
+              gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
+            { gen_helper_sve_ld1bhu_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bsu_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bdu_r, NULL, NULL, NULL },
 
-          { gen_helper_sve_ld1sds_be_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hh_be_r, gen_helper_sve_ld2hh_be_r,
-            gen_helper_sve_ld3hh_be_r, gen_helper_sve_ld4hh_be_r },
-          { gen_helper_sve_ld1hsu_be_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hdu_be_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1sds_be_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hh_be_r, gen_helper_sve_ld2hh_be_r,
+              gen_helper_sve_ld3hh_be_r, gen_helper_sve_ld4hh_be_r },
+            { gen_helper_sve_ld1hsu_be_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hdu_be_r, NULL, NULL, NULL },
 
-          { gen_helper_sve_ld1hds_be_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1hss_be_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1ss_be_r, gen_helper_sve_ld2ss_be_r,
-            gen_helper_sve_ld3ss_be_r, gen_helper_sve_ld4ss_be_r },
-          { gen_helper_sve_ld1sdu_be_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hds_be_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hss_be_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1ss_be_r, gen_helper_sve_ld2ss_be_r,
+              gen_helper_sve_ld3ss_be_r, gen_helper_sve_ld4ss_be_r },
+            { gen_helper_sve_ld1sdu_be_r, NULL, NULL, NULL },
 
-          { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
-          { gen_helper_sve_ld1dd_be_r, gen_helper_sve_ld2dd_be_r,
-            gen_helper_sve_ld3dd_be_r, gen_helper_sve_ld4dd_be_r } }
+            { gen_helper_sve_ld1bds_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
+            { gen_helper_sve_ld1dd_be_r, gen_helper_sve_ld2dd_be_r,
+              gen_helper_sve_ld3dd_be_r, gen_helper_sve_ld4dd_be_r } } },
+
+        { /* mte active, little-endian */
+          { { gen_helper_sve_ld1bb_r_mte,
+              gen_helper_sve_ld2bb_r_mte,
+              gen_helper_sve_ld3bb_r_mte,
+              gen_helper_sve_ld4bb_r_mte },
+            { gen_helper_sve_ld1bhu_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bsu_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bdu_r_mte, NULL, NULL, NULL },
+
+            { gen_helper_sve_ld1sds_le_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hh_le_r_mte,
+              gen_helper_sve_ld2hh_le_r_mte,
+              gen_helper_sve_ld3hh_le_r_mte,
+              gen_helper_sve_ld4hh_le_r_mte },
+            { gen_helper_sve_ld1hsu_le_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hdu_le_r_mte, NULL, NULL, NULL },
+
+            { gen_helper_sve_ld1hds_le_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hss_le_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1ss_le_r_mte,
+              gen_helper_sve_ld2ss_le_r_mte,
+              gen_helper_sve_ld3ss_le_r_mte,
+              gen_helper_sve_ld4ss_le_r_mte },
+            { gen_helper_sve_ld1sdu_le_r_mte, NULL, NULL, NULL },
+
+            { gen_helper_sve_ld1bds_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bss_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bhs_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1dd_le_r_mte,
+              gen_helper_sve_ld2dd_le_r_mte,
+              gen_helper_sve_ld3dd_le_r_mte,
+              gen_helper_sve_ld4dd_le_r_mte } },
+
+          /* mte active, big-endian */
+          { { gen_helper_sve_ld1bb_r_mte,
+              gen_helper_sve_ld2bb_r_mte,
+              gen_helper_sve_ld3bb_r_mte,
+              gen_helper_sve_ld4bb_r_mte },
+            { gen_helper_sve_ld1bhu_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bsu_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bdu_r_mte, NULL, NULL, NULL },
+
+            { gen_helper_sve_ld1sds_be_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hh_be_r_mte,
+              gen_helper_sve_ld2hh_be_r_mte,
+              gen_helper_sve_ld3hh_be_r_mte,
+              gen_helper_sve_ld4hh_be_r_mte },
+            { gen_helper_sve_ld1hsu_be_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hdu_be_r_mte, NULL, NULL, NULL },
+
+            { gen_helper_sve_ld1hds_be_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1hss_be_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1ss_be_r_mte,
+              gen_helper_sve_ld2ss_be_r_mte,
+              gen_helper_sve_ld3ss_be_r_mte,
+              gen_helper_sve_ld4ss_be_r_mte },
+            { gen_helper_sve_ld1sdu_be_r_mte, NULL, NULL, NULL },
+
+            { gen_helper_sve_ld1bds_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bss_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1bhs_r_mte, NULL, NULL, NULL },
+            { gen_helper_sve_ld1dd_be_r_mte,
+              gen_helper_sve_ld2dd_be_r_mte,
+              gen_helper_sve_ld3dd_be_r_mte,
+              gen_helper_sve_ld4dd_be_r_mte } } },
     };
-    gen_helper_gvec_mem *fn = fns[s->be_data == MO_BE][dtype][nreg];
+    gen_helper_gvec_mem *fn
+        = fns[s->mte_active[0]][s->be_data == MO_BE][dtype][nreg];
 
-    /* While there are holes in the table, they are not
+    /*
+     * While there are holes in the table, they are not
      * accessible via the instruction encoding.
      */
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, dtype, fn);
+    do_mem_zpa(s, zt, pg, addr, dtype, nreg, false, fn);
 }
 
 static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
@@ -4686,7 +4768,7 @@ static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a)
         TCGv_i64 addr = new_tmp_a64(s);
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
-        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype,
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 0, false,
                    fns[s->be_data == MO_BE][a->dtype]);
     }
     return true;
@@ -4745,7 +4827,7 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
         TCGv_i64 addr = new_tmp_a64(s);
 
         tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), off);
-        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype,
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 0, false,
                    fns[s->be_data == MO_BE][a->dtype]);
     }
     return true;
@@ -4947,7 +5029,7 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         fn = fn_multiple[be][nreg - 1][msz];
     }
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), fn);
+    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), 0, true, fn);
 }
 
 static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
-- 
2.25.1



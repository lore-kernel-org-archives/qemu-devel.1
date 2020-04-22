Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07429C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7EAA20747
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPea3epQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7EAA20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR7Iz-0006Jl-V9
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74v-0001CF-GA
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74s-0006OG-DS
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:41 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR74r-0006JU-Ug
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:38 -0400
Received: by mail-pl1-x641.google.com with SMTP id n24so422250plp.13
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kAjJuC8E6QocqpgcZFzGlZ3iBSLxUs4KOHUk+pvyTWc=;
 b=mPea3epQd8fn6acRviE37rsYywYW8IdPLb5a2WnFJSrPd/POhHRq3OnVP4kFXelPdq
 kIhpiuAbJXRUAo00TPNNQVnBQDKvB+fFMcF3FpvW5rpE5orWST6aPx8APTmANdrrRAxo
 6BQPUjJa+mHrN87y4ShMQGq4mCOu4kJ7iQLqyOFGOgvqSJxGDrPXkJBsRpKIiQ8xZi/i
 8rrpUEDClG9VNZc5spxmH7/4YgauFGur5ndvanGvszDNp+NiiQMT76Rr3bNOyCQ0lDJ5
 nwStRZChUjUzrYC0gS3zLwI7uhdN3WeYnSNAQ9mfu9wf3xLeOaMCMSn6spiakzvSCWJw
 Sepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kAjJuC8E6QocqpgcZFzGlZ3iBSLxUs4KOHUk+pvyTWc=;
 b=cYFf9lIEba/Tv95pCP+68rAMMq2KzUuXvX/aQy99lyrWh51RcQiQlHkWwfX/9rfEtf
 0VYZeDwbDC8CxCzmIXsRacCx2SjgpqXyGsWLwm4L34SyldcFIlR6HkJkAffIcIAM3hwI
 LDmTixg2dLejk4HlwU4J8P69sMFokrFG/ctH8zYjWzmVGZZDsr/EVMS7Lk/285GWc69j
 ygWEGvrWeP32S2ZAuprjmcAMIp3np2p+EMx8Zlz7YKTOSbSC50qUfCELpgJFXVjGfDOQ
 h3ZNzC7UdjgI2H5sRv/cjQVZI5Ec6Pc4OwlhuYg3Q04qfWyk8ypVVbcoBZeXWmJhgGOU
 3+BA==
X-Gm-Message-State: AGi0PuYrouWl5aSrVMs2HaLRjorqCg8CqFcPVu6sWeO8618VkyP1dAth
 BqCaNZiU//L1r7ciOyJ6MGAzBhLju28=
X-Google-Smtp-Source: APiQypK8MR/Hq9hCc/bbwwiJPAdotgSA9b9iquvVNF1cGddYz+60rmFDDVvAGNExqkBTPnI1A6jMZg==
X-Received: by 2002:a17:90b:3110:: with SMTP id
 gc16mr9347810pjb.155.1587530015239; 
 Tue, 21 Apr 2020 21:33:35 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm4129613pfd.107.2020.04.21.21.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 21:33:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/18] target/arm: Remove sve_memopidx
Date: Tue, 21 Apr 2020 21:33:09 -0700
Message-Id: <20200422043309.18430-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422043309.18430-1-richard.henderson@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

None of the sve helpers use TCGMemOpIdx any longer, so we can
stop passing it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     |  5 -----
 target/arm/sve_helper.c    | 14 +++++++-------
 target/arm/translate-sve.c | 17 +++--------------
 3 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index e633aff36e..a833e3941d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -979,11 +979,6 @@ static inline int arm_num_ctx_cmps(ARMCPU *cpu)
     }
 }
 
-/* Note make_memop_idx reserves 4 bits for mmu_idx, and MO_BSWAP is bit 3.
- * Thus a TCGMemOpIdx, without any MO_ALIGN bits, fits in 8 bits.
- */
-#define MEMOPIDX_SHIFT  8
-
 /**
  * v7m_using_psp: Return true if using process stack pointer
  * Return true if the CPU is currently using the process stack
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fffde4b6ec..f482fdd285 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4440,7 +4440,7 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
+    const unsigned rd = simd_data(desc);
     const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off, reg_last, mem_off;
     SVEContLdSt info;
@@ -4696,7 +4696,7 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
 {
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
+    const unsigned rd = simd_data(desc);
     void *vd = &env->vfp.zregs[rd];
     const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off, mem_off, reg_last;
@@ -4921,7 +4921,7 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr, uint32_t desc,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
+    const unsigned rd = simd_data(desc);
     const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off, reg_last, mem_off;
     SVEContLdSt info;
@@ -5127,9 +5127,9 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     const int mmu_idx = cpu_mmu_index(env, false);
     const intptr_t reg_max = simd_oprsz(desc);
+    const int scale = simd_data(desc);
     ARMVectorReg scratch;
     intptr_t reg_off;
     SVEHostPage info, info2;
@@ -5272,10 +5272,10 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                  sve_ldst1_tlb_fn *tlb_fn)
 {
     const int mmu_idx = cpu_mmu_index(env, false);
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
+    const intptr_t reg_max = simd_oprsz(desc);
+    const int scale = simd_data(desc);
     const int esize = 1 << esz;
     const int msize = 1 << msz;
-    const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off;
     SVEHostPage info;
     target_ulong addr, in_page;
@@ -5426,9 +5426,9 @@ void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     const int mmu_idx = cpu_mmu_index(env, false);
     const intptr_t reg_max = simd_oprsz(desc);
+    const int scale = simd_data(desc);
     void *host[ARM_MAX_VQ * 4];
     intptr_t reg_off, i;
     SVEHostPage info, info2;
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b35bad245e..7bd7de80e6 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4584,11 +4584,6 @@ static const uint8_t dtype_esz[16] = {
     3, 2, 1, 3
 };
 
-static TCGMemOpIdx sve_memopidx(DisasContext *s, int dtype)
-{
-    return make_memop_idx(s->be_data | dtype_mop[dtype], get_mem_index(s));
-}
-
 static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                        int dtype, gen_helper_gvec_mem *fn)
 {
@@ -4601,9 +4596,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
      */
-    desc = sve_memopidx(s, dtype);
-    desc |= zt << MEMOPIDX_SHIFT;
-    desc = simd_desc(vsz, vsz, desc);
+    desc = simd_desc(vsz, vsz, zt);
     t_desc = tcg_const_i32(desc);
     t_pg = tcg_temp_new_ptr();
 
@@ -4835,9 +4828,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
     int desc, poff;
 
     /* Load the first quadword using the normal predicated load helpers.  */
-    desc = sve_memopidx(s, msz_dtype(s, msz));
-    desc |= zt << MEMOPIDX_SHIFT;
-    desc = simd_desc(16, 16, desc);
+    desc = simd_desc(16, 16, zt);
     t_desc = tcg_const_i32(desc);
 
     poff = pred_full_reg_offset(s, pg);
@@ -5066,9 +5057,7 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
     TCGv_i32 t_desc;
     int desc;
 
-    desc = sve_memopidx(s, msz_dtype(s, msz));
-    desc |= scale << MEMOPIDX_SHIFT;
-    desc = simd_desc(vsz, vsz, desc);
+    desc = simd_desc(vsz, vsz, scale);
     t_desc = tcg_const_i32(desc);
 
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
-- 
2.20.1



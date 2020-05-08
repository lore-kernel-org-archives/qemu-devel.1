Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19FFC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE902173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UncVX11W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE902173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5Ax-0007TC-ED
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pT-0004iv-L2
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:42417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pS-0007Ew-20
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id k19so852636pll.9
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mTyI6RTbdq5lxnfMwBSiPFloUeeqJIpM4PV70ndWeTw=;
 b=UncVX11WOrsTf91UVQub2DRa9BQO6ACHS5e3sXusvuOYIep/TCk4tH0oRWywQbwDud
 zzlvfaGkihrOO0nImRWiX5JwXaLDu6DLfs99jfCxTMxbB8uZmg+JOzVwOfvSMvUGCC8H
 SPnH5oChDXHPDg9NLy7VPuSLZ0gDZ8eOe9pSy1PgIVqJTylEVE1u9LhKUVWkRqLI2iP4
 9+kFWxcVSg1XL7MNIQayzWBmxe/GmQMPVdYi8a9Zuk2lPL5BWPeDxZOYAvYTITGchx9/
 lakrnCejANKfg/VkbxZkQKYEa+vojhHaEbH+GVxXnvHo6ZtqI4O3y/bPg+xvE81PvDwP
 nYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mTyI6RTbdq5lxnfMwBSiPFloUeeqJIpM4PV70ndWeTw=;
 b=tyfSHDnUqNAsWHdUm4cOqW75nwwppi/jqQKyPO4B38etdT2iGcF7P7Y4d8zGk4w4Oh
 LhOLJKEZhGgyk17eK60Fw8kDkge0iLw6h+SidNU4Ckd9oGf7SULBGkAGmNKmSWQ/3wU8
 3QZzrJCvpa7xykRiJEjcHzWnL5PLhVQnD21F/uun5Xmk8kqilQCRjlGdnHtDPljWAfkN
 2j2Rp68rKVozHbCH/qPsuqxW1VgokwovO06irACB8/GOb+XyFVpIZaUPQwYF+yT9KGe4
 hWdpAUA+kLj2oSkATXE/dO+N3yZIASQdZK5sJDWpopPLoNQ32igB7GSCml8xsDApsDia
 Jv0Q==
X-Gm-Message-State: AGi0PubwkoSCmicam/iQk1lOdh1uhgXmtKyObQKV94SiW5OoOz7Vhxmm
 /YsQqfltxtDQ7yc59N0JnKP8kLJENiE=
X-Google-Smtp-Source: APiQypLl1K4+egzmwa8m+tW0yM0cJUiRVyRNJyykR71c55q/PLYRjzlmZeY1eZYc0H4QF0C/S25OEg==
X-Received: by 2002:a17:90b:155:: with SMTP id
 em21mr6523462pjb.59.1588951340145; 
 Fri, 08 May 2020 08:22:20 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/16] target/arm: Pass pointer to qc to qrdmla/qrdmls
Date: Fri,  8 May 2020 08:21:57 -0700
Message-Id: <20200508152200.6547-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass a pointer directly to env->vfp.qc[0], rather than env.
This will allow SVE2, which does not modify QC, to pass a
pointer to dummy storage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c  | 18 ++++++++---
 target/arm/vec_helper.c | 70 +++++++++++++++++++++++------------------
 2 files changed, 54 insertions(+), 34 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8321644f25..0e2cf6028a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3629,6 +3629,18 @@ static const uint8_t neon_2rm_sizes[] = {
     [NEON_2RM_VCVT_UF] = 0x4,
 };
 
+static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
+                            uint32_t opr_sz, uint32_t max_sz,
+                            gen_helper_gvec_3_ptr *fn)
+{
+    TCGv_ptr qc_ptr = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(qc_ptr, cpu_env, offsetof(CPUARMState, vfp.qc));
+    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, qc_ptr,
+                       opr_sz, max_sz, 0, fn);
+    tcg_temp_free_ptr(qc_ptr);
+}
+
 void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                           uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
 {
@@ -3636,8 +3648,7 @@ void gen_gvec_sqrdmlah_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
         gen_helper_gvec_qrdmlah_s16, gen_helper_gvec_qrdmlah_s32
     };
     tcg_debug_assert(vece >= 1 && vece <= 2);
-    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, cpu_env,
-                       opr_sz, max_sz, 0, fns[vece - 1]);
+    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
 }
 
 void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
@@ -3647,8 +3658,7 @@ void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
         gen_helper_gvec_qrdmlsh_s16, gen_helper_gvec_qrdmlsh_s32
     };
     tcg_debug_assert(vece >= 1 && vece <= 2);
-    tcg_gen_gvec_3_ptr(rd_ofs, rn_ofs, rm_ofs, cpu_env,
-                       opr_sz, max_sz, 0, fns[vece - 1]);
+    gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
 }
 
 #define GEN_CMP0(NAME, COND)                                            \
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 096fea67ef..6aa2ca0827 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -36,8 +36,6 @@
 #define H4(x)  (x)
 #endif
 
-#define SET_QC() env->vfp.qc[0] = 1
-
 static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
 {
     uint64_t *d = vd + opr_sz;
@@ -49,8 +47,8 @@ static void clear_tail(void *vd, uintptr_t opr_sz, uintptr_t max_sz)
 }
 
 /* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
-static uint16_t inl_qrdmlah_s16(CPUARMState *env, int16_t src1,
-                                int16_t src2, int16_t src3)
+static int16_t inl_qrdmlah_s16(int16_t src1, int16_t src2,
+                               int16_t src3, uint32_t *sat)
 {
     /* Simplify:
      * = ((a3 << 16) + ((e1 * e2) << 1) + (1 << 15)) >> 16
@@ -60,7 +58,7 @@ static uint16_t inl_qrdmlah_s16(CPUARMState *env, int16_t src1,
     ret = ((int32_t)src3 << 15) + ret + (1 << 14);
     ret >>= 15;
     if (ret != (int16_t)ret) {
-        SET_QC();
+        *sat = 1;
         ret = (ret < 0 ? -0x8000 : 0x7fff);
     }
     return ret;
@@ -69,30 +67,30 @@ static uint16_t inl_qrdmlah_s16(CPUARMState *env, int16_t src1,
 uint32_t HELPER(neon_qrdmlah_s16)(CPUARMState *env, uint32_t src1,
                                   uint32_t src2, uint32_t src3)
 {
-    uint16_t e1 = inl_qrdmlah_s16(env, src1, src2, src3);
-    uint16_t e2 = inl_qrdmlah_s16(env, src1 >> 16, src2 >> 16, src3 >> 16);
+    uint32_t *sat = &env->vfp.qc[0];
+    uint16_t e1 = inl_qrdmlah_s16(src1, src2, src3, sat);
+    uint16_t e2 = inl_qrdmlah_s16(src1 >> 16, src2 >> 16, src3 >> 16, sat);
     return deposit32(e1, 16, 16, e2);
 }
 
 void HELPER(gvec_qrdmlah_s16)(void *vd, void *vn, void *vm,
-                              void *ve, uint32_t desc)
+                              void *vq, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     int16_t *d = vd;
     int16_t *n = vn;
     int16_t *m = vm;
-    CPUARMState *env = ve;
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 2; ++i) {
-        d[i] = inl_qrdmlah_s16(env, n[i], m[i], d[i]);
+        d[i] = inl_qrdmlah_s16(n[i], m[i], d[i], vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
 /* Signed saturating rounding doubling multiply-subtract high half, 16-bit */
-static uint16_t inl_qrdmlsh_s16(CPUARMState *env, int16_t src1,
-                                int16_t src2, int16_t src3)
+static int16_t inl_qrdmlsh_s16(int16_t src1, int16_t src2,
+                               int16_t src3, uint32_t *sat)
 {
     /* Similarly, using subtraction:
      * = ((a3 << 16) - ((e1 * e2) << 1) + (1 << 15)) >> 16
@@ -102,7 +100,7 @@ static uint16_t inl_qrdmlsh_s16(CPUARMState *env, int16_t src1,
     ret = ((int32_t)src3 << 15) - ret + (1 << 14);
     ret >>= 15;
     if (ret != (int16_t)ret) {
-        SET_QC();
+        *sat = 1;
         ret = (ret < 0 ? -0x8000 : 0x7fff);
     }
     return ret;
@@ -111,85 +109,97 @@ static uint16_t inl_qrdmlsh_s16(CPUARMState *env, int16_t src1,
 uint32_t HELPER(neon_qrdmlsh_s16)(CPUARMState *env, uint32_t src1,
                                   uint32_t src2, uint32_t src3)
 {
-    uint16_t e1 = inl_qrdmlsh_s16(env, src1, src2, src3);
-    uint16_t e2 = inl_qrdmlsh_s16(env, src1 >> 16, src2 >> 16, src3 >> 16);
+    uint32_t *sat = &env->vfp.qc[0];
+    uint16_t e1 = inl_qrdmlsh_s16(src1, src2, src3, sat);
+    uint16_t e2 = inl_qrdmlsh_s16(src1 >> 16, src2 >> 16, src3 >> 16, sat);
     return deposit32(e1, 16, 16, e2);
 }
 
 void HELPER(gvec_qrdmlsh_s16)(void *vd, void *vn, void *vm,
-                              void *ve, uint32_t desc)
+                              void *vq, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     int16_t *d = vd;
     int16_t *n = vn;
     int16_t *m = vm;
-    CPUARMState *env = ve;
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 2; ++i) {
-        d[i] = inl_qrdmlsh_s16(env, n[i], m[i], d[i]);
+        d[i] = inl_qrdmlsh_s16(n[i], m[i], d[i], vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
 /* Signed saturating rounding doubling multiply-accumulate high half, 32-bit */
-uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
-                                  int32_t src2, int32_t src3)
+static int32_t inl_qrdmlah_s32(int32_t src1, int32_t src2,
+                               int32_t src3, uint32_t *sat)
 {
     /* Simplify similarly to int_qrdmlah_s16 above.  */
     int64_t ret = (int64_t)src1 * src2;
     ret = ((int64_t)src3 << 31) + ret + (1 << 30);
     ret >>= 31;
     if (ret != (int32_t)ret) {
-        SET_QC();
+        *sat = 1;
         ret = (ret < 0 ? INT32_MIN : INT32_MAX);
     }
     return ret;
 }
 
+uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
+                                  int32_t src2, int32_t src3)
+{
+    uint32_t *sat = &env->vfp.qc[0];
+    return inl_qrdmlah_s32(src1, src2, src3, sat);
+}
+
 void HELPER(gvec_qrdmlah_s32)(void *vd, void *vn, void *vm,
-                              void *ve, uint32_t desc)
+                              void *vq, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     int32_t *d = vd;
     int32_t *n = vn;
     int32_t *m = vm;
-    CPUARMState *env = ve;
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        d[i] = helper_neon_qrdmlah_s32(env, n[i], m[i], d[i]);
+        d[i] = inl_qrdmlah_s32(n[i], m[i], d[i], vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
 /* Signed saturating rounding doubling multiply-subtract high half, 32-bit */
-uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
-                                  int32_t src2, int32_t src3)
+static int32_t inl_qrdmlsh_s32(int32_t src1, int32_t src2,
+                               int32_t src3, uint32_t *sat)
 {
     /* Simplify similarly to int_qrdmlsh_s16 above.  */
     int64_t ret = (int64_t)src1 * src2;
     ret = ((int64_t)src3 << 31) - ret + (1 << 30);
     ret >>= 31;
     if (ret != (int32_t)ret) {
-        SET_QC();
+        *sat = 1;
         ret = (ret < 0 ? INT32_MIN : INT32_MAX);
     }
     return ret;
 }
 
+uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
+                                  int32_t src2, int32_t src3)
+{
+    uint32_t *sat = &env->vfp.qc[0];
+    return inl_qrdmlsh_s32(src1, src2, src3, sat);
+}
+
 void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
-                              void *ve, uint32_t desc)
+                              void *vq, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
     int32_t *d = vd;
     int32_t *n = vn;
     int32_t *m = vm;
-    CPUARMState *env = ve;
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        d[i] = helper_neon_qrdmlsh_s32(env, n[i], m[i], d[i]);
+        d[i] = inl_qrdmlsh_s32(n[i], m[i], d[i], vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.20.1



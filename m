Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8E9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5588F2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkEO5hoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5588F2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmdd-0008Su-JP
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmD1-0003kJ-Vx
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmCy-0003Lo-10
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:31:27 -0400
Received: by mail-pl1-x642.google.com with SMTP id g12so1902470pll.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O3Adn0LIZdppVT7s8KoucB90L9YBmhvJ5WyeRB5Ut38=;
 b=wkEO5hoPebikHuFMMYbOmefJYepRbc8l6kZAKMX+LUbsi6nENbefeYBcsbeKsLwzaC
 f7wMchbtEiuFt9xVEN0Cs2XpTcM0UmTXAtxQGm7EuZKjTwFHaTuohh2gFGqSBaFm2cZL
 A80ZrFQDPua8YGwh2aqE3NMyEshl0D8MBOLEiHYB2AC7Q9KFdDYL7hAcfR1zSfEFtrRk
 PzBz2LjCA07mt6lZigLxdGBzF1+GmvoZFLCKu0HEky52Faw7Cn/XgXE+pIm1M7EsuHIm
 4DPdy+EvrWMMpcjX6dFUBHWXVEg4LzSXUNb99XVRcTwHx6dYHh9rBr7aLdcgxV3UVnKe
 eHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O3Adn0LIZdppVT7s8KoucB90L9YBmhvJ5WyeRB5Ut38=;
 b=Vbo55wN9kY4DOoZu/if9g1BGg8Sn3npDUu+Xb+aX5yt/hEq5sU6uqgppEYFNyMss3R
 C17LJSH2nKIV/u+KbJTRLgdraIz2TLYA8KoUjvWArA3dYGXbw5ETDeNFDZzd9paC9+ar
 uXs8KJA4lYKN85fRIY/WtDo4qXLLDQH80kTmCU1PiOBUalN8MNw0eGW//v2otKlUoIbY
 5vHe9Fwubczf/x4MR9UY9Z4NwxyAAx0HNEI+zOAZeYpvjBwjfe5nu0KMire637P5zJbD
 fidk3C6Vn5iOdsOL06ibkuvdXgaBPx+RI07AAGDIUws8lpPH4r2JyVjukMQhL646wFzO
 EyCw==
X-Gm-Message-State: AOAM532BLx4gn/8w+uNWWWO55gcHqC7oazwuYnvP+7RFNDReybGeMx0i
 CtXL4bSg4ts1REyYs3YoVhFNB8xb3Lw=
X-Google-Smtp-Source: ABdhPJwZwvG+FvdpHjtFR1/z4qJZNjSyzobGtdUXoo6Ni/sCrsQYR4ECsavheQfuXUk+76b+GzmCfg==
X-Received: by 2002:a17:902:710b:: with SMTP id
 a11mr2167254pll.156.1592454682127; 
 Wed, 17 Jun 2020 21:31:22 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o1sm974337pjf.17.2020.06.17.21.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:31:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 068/100] target/arm: Pass separate addend to FCMLA helpers
Date: Wed, 17 Jun 2020 21:26:12 -0700
Message-Id: <20200618042644.1685561-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For SVE, we potentially have a 4th argument coming from the
movprfx instruction.  Currently we do not optimize movprfx,
so the problem is not visible.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             | 20 ++++++-------
 target/arm/translate-a64.c      | 27 ++++++++++++++----
 target/arm/translate-neon.inc.c | 10 ++++---
 target/arm/translate-sve.c      |  5 ++--
 target/arm/vec_helper.c         | 50 +++++++++++++--------------------
 5 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index dd32a11b9d..331f77c908 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -595,16 +595,16 @@ DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_fcaddd, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(gvec_fcmlah, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcmlah_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcmlas, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(gvec_fcmlad, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fcmlah, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fcmlah_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fcmlas, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(gvec_fcmlad, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_frecpe_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_frecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7366553f8d..341b11f98d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -616,6 +616,22 @@ static void gen_gvec_op4_ool(DisasContext *s, bool is_q, int rd, int rn,
                        is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
 }
 
+/* Expand a 4-operand + fpstatus pointer + simd data value operation using
+ * an out-of-line helper.
+ */
+static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
+                              int rm, int ra, bool is_fp16, int data,
+                              gen_helper_gvec_4_ptr *fn)
+{
+    TCGv_ptr fpst = get_fpstatus_ptr(is_fp16);
+    tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       vec_full_reg_offset(s, ra), fpst,
+                       is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
+    tcg_temp_free_ptr(fpst);
+}
+
 /* Set ZF and NF based on a 64 bit result. This is alas fiddlier
  * than the 32 bit equivalent.
  */
@@ -11732,15 +11748,15 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         rot = extract32(opcode, 0, 2);
         switch (size) {
         case 1:
-            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, true, rot,
+            gen_gvec_op4_fpst(s, is_q, rd, rn, rm, rd, true, rot,
                               gen_helper_gvec_fcmlah);
             break;
         case 2:
-            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, false, rot,
+            gen_gvec_op4_fpst(s, is_q, rd, rn, rm, rd, false, rot,
                               gen_helper_gvec_fcmlas);
             break;
         case 3:
-            gen_gvec_op3_fpst(s, is_q, rd, rn, rm, false, rot,
+            gen_gvec_op4_fpst(s, is_q, rd, rn, rm, rd, false, rot,
                               gen_helper_gvec_fcmlad);
             break;
         default:
@@ -12994,9 +13010,10 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         {
             int rot = extract32(insn, 13, 2);
             int data = (index << 2) | rot;
-            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+            tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, rd),
                                vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm), fpst,
+                               vec_full_reg_offset(s, rm),
+                               vec_full_reg_offset(s, rd), fpst,
                                is_q ? 16 : 8, vec_full_reg_size(s), data,
                                size == MO_64
                                ? gen_helper_gvec_fcmlas_idx
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index d4556dfb4e..f79995cf50 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -58,7 +58,7 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
 {
     int opr_sz;
     TCGv_ptr fpst;
-    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+    gen_helper_gvec_4_ptr *fn_gvec_ptr;
 
     if (!dc_isar_feature(aa32_vcma, s)
         || (!a->size && !dc_isar_feature(aa32_fp16_arith, s))) {
@@ -82,9 +82,10 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
     opr_sz = (1 + a->q) * 8;
     fpst = get_fpstatus_ptr(1);
     fn_gvec_ptr = a->size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+    tcg_gen_gvec_4_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
+                       vfp_reg_offset(1, a->vd),
                        fpst, opr_sz, opr_sz, a->rot,
                        fn_gvec_ptr);
     tcg_temp_free_ptr(fpst);
@@ -194,7 +195,7 @@ static bool trans_VFML(DisasContext *s, arg_VFML *a)
 
 static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
 {
-    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+    gen_helper_gvec_4_ptr *fn_gvec_ptr;
     int opr_sz;
     TCGv_ptr fpst;
 
@@ -223,9 +224,10 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
                    : gen_helper_gvec_fcmlah_idx);
     opr_sz = (1 + a->q) * 8;
     fpst = get_fpstatus_ptr(1);
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+    tcg_gen_gvec_4_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
+                       vfp_reg_offset(1, a->vd),
                        fpst, opr_sz, opr_sz,
                        (a->index << 2) | a->rot, fn_gvec_ptr);
     tcg_temp_free_ptr(fpst);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 835ccc0cee..26497f0a6d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4391,7 +4391,7 @@ static bool trans_FCMLA_zpzzz(DisasContext *s, arg_FCMLA_zpzzz *a)
 
 static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCMLA_zzxz *a)
 {
-    static gen_helper_gvec_3_ptr * const fns[2] = {
+    static gen_helper_gvec_4_ptr * const fns[2] = {
         gen_helper_gvec_fcmlah_idx,
         gen_helper_gvec_fcmlas_idx,
     };
@@ -4401,9 +4401,10 @@ static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCMLA_zzxz *a)
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         TCGv_ptr status = get_fpstatus_ptr(a->esz == MO_16);
-        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
+                           vec_full_reg_offset(s, a->ra),
                            status, vsz, vsz,
                            a->index * 4 + a->rot,
                            fns[a->esz - 1]);
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 5a8de167f3..5c0760de05 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -609,13 +609,11 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm,
+void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm, void *va,
                          void *vfpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
-    float16 *d = vd;
-    float16 *n = vn;
-    float16 *m = vm;
+    float16 *d = vd, *n = vn, *m = vm, *a = va;
     float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
@@ -632,19 +630,17 @@ void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm,
         float16 e4 = e2;
         float16 e3 = m[H2(i + 1 - flip)] ^ neg_imag;
 
-        d[H2(i)] = float16_muladd(e2, e1, d[H2(i)], 0, fpst);
-        d[H2(i + 1)] = float16_muladd(e4, e3, d[H2(i + 1)], 0, fpst);
+        d[H2(i)] = float16_muladd(e2, e1, a[H2(i)], 0, fpst);
+        d[H2(i + 1)] = float16_muladd(e4, e3, a[H2(i + 1)], 0, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm,
+void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm, void *va,
                              void *vfpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
-    float16 *d = vd;
-    float16 *n = vn;
-    float16 *m = vm;
+    float16 *d = vd, *n = vn, *m = vm, *a = va;
     float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
@@ -668,20 +664,18 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm,
             float16 e2 = n[H2(j + flip)];
             float16 e4 = e2;
 
-            d[H2(j)] = float16_muladd(e2, e1, d[H2(j)], 0, fpst);
-            d[H2(j + 1)] = float16_muladd(e4, e3, d[H2(j + 1)], 0, fpst);
+            d[H2(j)] = float16_muladd(e2, e1, a[H2(j)], 0, fpst);
+            d[H2(j + 1)] = float16_muladd(e4, e3, a[H2(j + 1)], 0, fpst);
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm,
+void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm, void *va,
                          void *vfpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
-    float32 *d = vd;
-    float32 *n = vn;
-    float32 *m = vm;
+    float32 *d = vd, *n = vn, *m = vm, *a = va;
     float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
@@ -698,19 +692,17 @@ void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm,
         float32 e4 = e2;
         float32 e3 = m[H4(i + 1 - flip)] ^ neg_imag;
 
-        d[H4(i)] = float32_muladd(e2, e1, d[H4(i)], 0, fpst);
-        d[H4(i + 1)] = float32_muladd(e4, e3, d[H4(i + 1)], 0, fpst);
+        d[H4(i)] = float32_muladd(e2, e1, a[H4(i)], 0, fpst);
+        d[H4(i + 1)] = float32_muladd(e4, e3, a[H4(i + 1)], 0, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm,
+void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm, void *va,
                              void *vfpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
-    float32 *d = vd;
-    float32 *n = vn;
-    float32 *m = vm;
+    float32 *d = vd, *n = vn, *m = vm, *a = va;
     float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
@@ -734,20 +726,18 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm,
             float32 e2 = n[H4(j + flip)];
             float32 e4 = e2;
 
-            d[H4(j)] = float32_muladd(e2, e1, d[H4(j)], 0, fpst);
-            d[H4(j + 1)] = float32_muladd(e4, e3, d[H4(j + 1)], 0, fpst);
+            d[H4(j)] = float32_muladd(e2, e1, a[H4(j)], 0, fpst);
+            d[H4(j + 1)] = float32_muladd(e4, e3, a[H4(j + 1)], 0, fpst);
         }
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm,
+void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm, void *va,
                          void *vfpst, uint32_t desc)
 {
     uintptr_t opr_sz = simd_oprsz(desc);
-    float64 *d = vd;
-    float64 *n = vn;
-    float64 *m = vm;
+    float64 *d = vd, *n = vn, *m = vm, *a = va;
     float_status *fpst = vfpst;
     intptr_t flip = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t neg_imag = extract32(desc, SIMD_DATA_SHIFT + 1, 1);
@@ -764,8 +754,8 @@ void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm,
         float64 e4 = e2;
         float64 e3 = m[i + 1 - flip] ^ neg_imag;
 
-        d[i] = float64_muladd(e2, e1, d[i], 0, fpst);
-        d[i + 1] = float64_muladd(e4, e3, d[i + 1], 0, fpst);
+        d[i] = float64_muladd(e2, e1, a[i], 0, fpst);
+        d[i + 1] = float64_muladd(e4, e3, a[i + 1], 0, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.25.1



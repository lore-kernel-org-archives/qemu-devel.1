Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DCEC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:37:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB50922208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZVQy1Vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB50922208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMC0-0004nx-0s
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHl-0000nC-Qx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:08 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHj-0007Cz-DS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:05 -0400
Received: by mail-pj1-x1042.google.com with SMTP id u3so3459832pjr.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=58nX2w8XZEafvNzYoIWAzJayUresjRPt/UjUBIAFJac=;
 b=uZVQy1ViuyfYDbMPPE7YvK4Y9+FB5XDD/dFSgvzno4pQ5vlab2TJQkxvIJZptzjoN9
 x5nxeV97veXDh+naEomoLsGqabsVAU/bDB2dP9NXrNRvqf4jsIjAx4EAA2w1f+Z7xQug
 r/epfqTKe9TyGyPb3yd555gW/5tsozhERJbI2El8w8QMvbk6OoPHZR/5dRciN7aZfi8D
 K7l1EZs/ho1TeWbEmYB8NLSdebckzzDTW7cE6txm4CZq3Lrl4EgzzSrJMsjbht32Z8rz
 N5Lm4WS8xrYPtqwxoNHLSWvItNGedl63alkON14tUU85uzgjRkxaenB1QMSwddc1/euY
 e9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=58nX2w8XZEafvNzYoIWAzJayUresjRPt/UjUBIAFJac=;
 b=QDvEwqmHtIwAUcLIDIXmBSGk4QuHUO+4bFKjwBk8gwu+wAgaXq8WtllmkMwP5MlqoE
 DcIp3QF967+oK/QzSKVXnyI98QOTIdcQQvfZu649Q2W5wLMRWHsUlDMS2Ad6P5MoVlBx
 VG5354NFVaerGMZ1GxIQZCl28oRC6Y1lHxSMpScVLHBIbUOFC+hRx1zA5nCAIWcMc9n/
 4W6fcIejeO7Z7EifyOHtq93Paj4Kk17T+aYOZKlR4JAxDoofIzGlVhrWDi6A2BgHjyED
 awWWsYEK3WpFJE3/pVOMrQQ8kuPveQe2YGQDRKTUejkvxFTzX9dsUmVtrCBOrq/eJLuC
 PtZg==
X-Gm-Message-State: AOAM531zPxR+VTiH1o7Vm/7lfq1veVtiqPXfq1p9NVGrFWgRim2lVSFE
 ueDACfTzC56uwZSAUJU5zAnDOvkdAd8b/A==
X-Google-Smtp-Source: ABdhPJyiXMWdG03k5SQEj8GkPmy8d2JwryT/Hbsf1z8+jTPBtXS7VW5LpAeGYhSVMAPxIsnqSTA8Og==
X-Received: by 2002:a17:902:b206:b029:d2:e7b:2e65 with SMTP id
 t6-20020a170902b206b02900d20e7b2e65mr1902901plr.18.1600454341115; 
 Fri, 18 Sep 2020 11:39:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 52/81] target/arm: Pass separate addend to FCMLA helpers
Date: Fri, 18 Sep 2020 11:37:22 -0700
Message-Id: <20200918183751.2787647-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
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
 target/arm/translate-sve.c      |  5 ++--
 target/arm/vec_helper.c         | 50 +++++++++++++--------------------
 target/arm/translate-neon.c.inc | 10 ++++---
 5 files changed, 61 insertions(+), 51 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 97222bd256..8b3dc9b4e3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -616,16 +616,16 @@ DEF_HELPER_FLAGS_5(gvec_fcadds, TCG_CALL_NO_RWG,
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
 
 DEF_HELPER_FLAGS_5(neon_paddh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(neon_pmaxh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1a9251db67..0a463058f0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -703,6 +703,22 @@ static void gen_gvec_op4_ool(DisasContext *s, bool is_q, int rd, int rn,
                        is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
 }
 
+/* Expand a 4-operand + fpstatus pointer + simd data value operation using
+ * an out-of-line helper.
+ */
+static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
+                              int rm, int ra, bool is_fp16, int data,
+                              gen_helper_gvec_4_ptr *fn)
+{
+    TCGv_ptr fpst = fpstatus_ptr(is_fp16 ? FPST_FPCR_F16 : FPST_FPCR);
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
@@ -12224,15 +12240,15 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
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
@@ -13483,9 +13499,10 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
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
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 66303dac54..10200f0207 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4387,7 +4387,7 @@ static bool trans_FCMLA_zpzzz(DisasContext *s, arg_FCMLA_zpzzz *a)
 
 static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCMLA_zzxz *a)
 {
-    static gen_helper_gvec_3_ptr * const fns[2] = {
+    static gen_helper_gvec_4_ptr * const fns[2] = {
         gen_helper_gvec_fcmlah_idx,
         gen_helper_gvec_fcmlas_idx,
     };
@@ -4397,9 +4397,10 @@ static bool trans_FCMLA_zzxz(DisasContext *s, arg_FCMLA_zzxz *a)
     if (sve_access_check(s)) {
         unsigned vsz = vec_full_reg_size(s);
         TCGv_ptr status = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
-        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+        tcg_gen_gvec_4_ptr(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
+                           vec_full_reg_offset(s, a->ra),
                            status, vsz, vsz,
                            a->index * 4 + a->rot,
                            fns[a->esz - 1]);
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index d7ef31915b..82e12b51c1 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -657,13 +657,11 @@ void HELPER(gvec_fcaddd)(void *vd, void *vn, void *vm,
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
@@ -680,19 +678,17 @@ void HELPER(gvec_fcmlah)(void *vd, void *vn, void *vm,
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
@@ -716,20 +712,18 @@ void HELPER(gvec_fcmlah_idx)(void *vd, void *vn, void *vm,
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
@@ -746,19 +740,17 @@ void HELPER(gvec_fcmlas)(void *vd, void *vn, void *vm,
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
@@ -782,20 +774,18 @@ void HELPER(gvec_fcmlas_idx)(void *vd, void *vn, void *vm,
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
@@ -812,8 +802,8 @@ void HELPER(gvec_fcmlad)(void *vd, void *vn, void *vm,
         float64 e4 = e2;
         float64 e3 = m[i + 1 - flip] ^ neg_imag;
 
-        d[i] = float64_muladd(e2, e1, d[i], 0, fpst);
-        d[i + 1] = float64_muladd(e4, e3, d[i + 1], 0, fpst);
+        d[i] = float64_muladd(e2, e1, a[i], 0, fpst);
+        d[i + 1] = float64_muladd(e4, e3, a[i + 1], 0, fpst);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 7efe3d9556..499ebeb325 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -165,7 +165,7 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
 {
     int opr_sz;
     TCGv_ptr fpst;
-    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+    gen_helper_gvec_4_ptr *fn_gvec_ptr;
 
     if (!dc_isar_feature(aa32_vcma, s)
         || (a->size == MO_16 && !dc_isar_feature(aa32_fp16_arith, s))) {
@@ -190,9 +190,10 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
     fpst = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
     fn_gvec_ptr = (a->size == MO_16) ?
         gen_helper_gvec_fcmlah : gen_helper_gvec_fcmlas;
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+    tcg_gen_gvec_4_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
+                       vfp_reg_offset(1, a->vd),
                        fpst, opr_sz, opr_sz, a->rot,
                        fn_gvec_ptr);
     tcg_temp_free_ptr(fpst);
@@ -303,7 +304,7 @@ static bool trans_VFML(DisasContext *s, arg_VFML *a)
 
 static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
 {
-    gen_helper_gvec_3_ptr *fn_gvec_ptr;
+    gen_helper_gvec_4_ptr *fn_gvec_ptr;
     int opr_sz;
     TCGv_ptr fpst;
 
@@ -332,9 +333,10 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
         gen_helper_gvec_fcmlah_idx : gen_helper_gvec_fcmlas_idx;
     opr_sz = (1 + a->q) * 8;
     fpst = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+    tcg_gen_gvec_4_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
+                       vfp_reg_offset(1, a->vd),
                        fpst, opr_sz, opr_sz,
                        (a->index << 2) | a->rot, fn_gvec_ptr);
     tcg_temp_free_ptr(fpst);
-- 
2.25.1



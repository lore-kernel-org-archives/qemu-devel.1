Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5DFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B3223A75
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmVif8Ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B3223A75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y9A-0006CN-OJ
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6y6U-0002oW-Ko
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:28:18 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6y6S-00040C-Qi
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:28:18 -0400
Received: by mail-pj1-x1041.google.com with SMTP id f9so5653082pju.4
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D1VJrUQknShqmnmzu8X8w1cJRuHx820LA67l/SpR/wI=;
 b=WmVif8ArPf0sdlGrhV/s/zKZGtvIaxy/aOyK09OYvPdy1oSxGR/pblFFX7sTBnZxVj
 rgYuuolNwN0G3RqTYUnL9AOR0TKKNCCov/uFEKu2KcE62MXZjMeJwFHqb13XcnQbP9NH
 F/MyD8YVDCB7K+frcYVEx4gl2O3q09F/b+ZPNFofurzUZS2iDQ88/1+K3dgf/VI/PLz7
 iHzmUInH0x0GdkdHNm91F6rCqXtH7nVokTtTvekG8BmC6MzVNX1ui/Okle3vOYJnWrH+
 /1RFKCugh3a3MQcsgPN+Q90nh1JWdS68qVQICNGq4jZ6iP/s/taoRX6D4uqvE3S+XFPv
 DWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D1VJrUQknShqmnmzu8X8w1cJRuHx820LA67l/SpR/wI=;
 b=ZUMp3PvBcy//An/314dcFzERoJbUGlEHAR384E2lfKjrt2QJ8M3BtAXroz4s/FWVb5
 Du9xYPK7AzyP7Mmc0sDlOjmBCS4NB8HeTeUjNycwmHRaJ1W64DgZgAvDLh8e2WNRrkkT
 yStC+kmIlBfIbDyqjxBS3d7EqGkxWsv3q8eNd7/+h+j+AXZQNScO+kjGGJoJUuvKfIYs
 KqKDrO3x9eCEMryu5b2A630LZx/dg42G+BxvPWp8LFOH0fWOwCL7F8E0cezDsShBEnf5
 KpSwjNf144YNt0xmqRmhLc+PeD0iqyFPSGCuGpvag15vp+aD4k2uZzMs/PyNKhn1DmI/
 jaBA==
X-Gm-Message-State: AOAM5321PLyC18018pF5UVvecltQaOAe0Iu2cTmpBnZVRY/eoucM9SGG
 movwJlseLoIuM7anxNHG3ll76+SRGpdpPg==
X-Google-Smtp-Source: ABdhPJwX8ilxBh5q0IfY1WH99QRcdmPu68ss52Ytcvq14V4uPRQsEUr14yJFQPLO0Qh9FImTcz9V/A==
X-Received: by 2002:aa7:9552:: with SMTP id w18mr695754pfq.150.1597455134318; 
 Fri, 14 Aug 2020 18:32:14 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/20] target/arm: Convert sq{,
 r}dmulh to gvec for aa64 advsimd
Date: Fri, 14 Aug 2020 18:31:45 -0700
Message-Id: <20200815013145.539409-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        | 10 ++++++++
 target/arm/translate-a64.c | 33 ++++++++++++++++++--------
 target/arm/vec_helper.c    | 48 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 378bb1898b..3ca73a1764 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -776,6 +776,16 @@ DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_mls_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(neon_sqdmulh_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqdmulh_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(neon_sqrdmulh_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(neon_sqrdmulh_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c74c6e854c..d4da12268c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -697,6 +697,20 @@ static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
     tcg_temp_free_ptr(fpst);
 }
 
+/* Expand a 3-operand + qc + operation using an out-of-line helper.  */
+static void gen_gvec_op3_qc(DisasContext *s, bool is_q, int rd, int rn,
+                            int rm, gen_helper_gvec_3_ptr *fn)
+{
+    TCGv_ptr qc_ptr = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(qc_ptr, cpu_env, offsetof(CPUARMState, vfp.qc));
+    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm), qc_ptr,
+                       is_q ? 16 : 8, vec_full_reg_size(s), 0, fn);
+    tcg_temp_free_ptr(qc_ptr);
+}
+
 /* Set ZF and NF based on a 64 bit result. This is alas fiddlier
  * than the 32 bit equivalent.
  */
@@ -11753,6 +11767,15 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_mla, size);
         }
         return;
+    case 0x16: /* SQDMULH, SQRDMULH */
+        {
+            static gen_helper_gvec_3_ptr * const fns[2][2] = {
+                { gen_helper_neon_sqdmulh_h, gen_helper_neon_sqrdmulh_h },
+                { gen_helper_neon_sqdmulh_s, gen_helper_neon_sqrdmulh_s },
+            };
+            gen_gvec_op3_qc(s, is_q, rd, rn, rm, fns[size - 1][u]);
+        }
+        return;
     case 0x11:
         if (!u) { /* CMTST */
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_cmtst, size);
@@ -11864,16 +11887,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genenvfn = fns[size][u];
                 break;
             }
-            case 0x16: /* SQDMULH, SQRDMULH */
-            {
-                static NeonGenTwoOpEnvFn * const fns[2][2] = {
-                    { gen_helper_neon_qdmulh_s16, gen_helper_neon_qrdmulh_s16 },
-                    { gen_helper_neon_qdmulh_s32, gen_helper_neon_qrdmulh_s32 },
-                };
-                assert(size == 1 || size == 2);
-                genenvfn = fns[size - 1][u];
-                break;
-            }
             default:
                 g_assert_not_reached();
             }
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index fb53684ce3..73d62c4e4f 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -109,6 +109,30 @@ void HELPER(gvec_qrdmlsh_s16)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(neon_sqdmulh_h)(void *vd, void *vn, void *vm,
+                            void *vq, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = do_sqrdmlah_h(n[i], m[i], 0, false, false, vq);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(neon_sqrdmulh_h)(void *vd, void *vn, void *vm,
+                             void *vq, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = do_sqrdmlah_h(n[i], m[i], 0, false, true, vq);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 32-bit */
 static int32_t do_sqrdmlah_s(int32_t src1, int32_t src2, int32_t src3,
                              bool neg, bool round, uint32_t *sat)
@@ -172,6 +196,30 @@ void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(neon_sqdmulh_s)(void *vd, void *vn, void *vm,
+                            void *vq, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = do_sqrdmlah_s(n[i], m[i], 0, false, false, vq);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(neon_sqrdmulh_s)(void *vd, void *vn, void *vm,
+                             void *vq, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = do_sqrdmlah_s(n[i], m[i], 0, false, true, vq);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 /* Integer 8 and 16-bit dot-product.
  *
  * Note that for the loops herein, host endianness does not matter
-- 
2.25.1



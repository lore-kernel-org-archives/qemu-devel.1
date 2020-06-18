Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6685C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8268921852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8MqqfYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8268921852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmrV-000073-Ou
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEE-0005xg-Bs
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:42 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEC-0003ZK-JQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:42 -0400
Received: by mail-pj1-x1042.google.com with SMTP id k2so1967982pjs.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QYWLjCAC1bjiMEtNtx+p9mrduvwzbVheqlkAGXRrIF8=;
 b=E8MqqfYxYiseAKFXUz0qb5r/ciM/KuqNowv0tnKGm8ORIURCNmRJmQrYPJ3H4Ltodf
 ODhEZJuPDmSkW6IHQgRhlgjQ9d3J2AWPNtE2YY5FsQ0YQW6vVgeBJS9DKJWjtJerBcsQ
 cixhTUiS3CoRr/LI15oCyulLV6FyJtcXie/qWsVNjmKhRto2rs5KWyQwrBBXa/O6+Lyc
 xc11BnEf0e/fASRwNLD4ozcKcCIlsAmD8iQTRewykvfgTe4S16LjG0u4X4MzVUR116YU
 SdUCUsRozInATprVl8pTCvsRUgF+pOHnBrdN0a2DSNjweJ/nDvf01ZO/HRrxa9aA+v9S
 X7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QYWLjCAC1bjiMEtNtx+p9mrduvwzbVheqlkAGXRrIF8=;
 b=VaxmlVd97xZDFfLa9McRaFM61Qu3nn/cd9SIGC2uhP5p6SKEOaqwE9JoomgclfHpfI
 RayNRA9SX2+Egl35CRO3vuy0pAqz3RMDHY8MSxj2otqQnVcX31H1FPXfJUg+F7Ht/JpJ
 bLYRmJFP2s0fIhKayMFcjW66bTc7zNd3/oJwRu2yC5iZ/futEZgbTZLnC80jrnJEKlMJ
 8Z2rn5hxmiuNpsLBx5LA2Jum+VBqTFPz8Qcg6yyWzihoGVxzXiAJWUQDDFFl9RM2+LD9
 1EmlnoOstAXiNkZC4SjR7DrhaXrBfFhMug09yEeLkEniOGWmWFilDmL6H1PoNnfbQoNJ
 bTmA==
X-Gm-Message-State: AOAM532bftST28rPc+BjnSGKvelICcbuVWx0jER5ZqrzWcrfAMsGq5p1
 htDeiE1guJxPpJGgqe8cMSyRz5D3jRU=
X-Google-Smtp-Source: ABdhPJxAVAedkVO6v2dUC9B/Kdl6qqf5hqIX173ZZhpGYqxWQJGcHAjog6CDDpEaFWl/Qjr6p9R5ag==
X-Received: by 2002:a17:90a:6e2:: with SMTP id
 k89mr2454789pjk.74.1592454758869; 
 Wed, 17 Jun 2020 21:32:38 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d2sm1165766pgp.56.2020.06.17.21.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:32:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 080/100] target/arm: Use helper_neon_sq{,
 r}dmul_* for aa64 advsimd
Date: Wed, 17 Jun 2020 21:26:24 -0700
Message-Id: <20200618042644.1685561-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        | 10 ++++++++
 target/arm/translate-a64.c | 33 +++++++++++++++++--------
 target/arm/vec_helper.c    | 49 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index ce6ff95672..e1cac31e95 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -807,6 +807,16 @@ DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
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
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5ef6ecfbf1..7c98938077 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -605,6 +605,20 @@ static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
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
 /* Expand a 4-operand operation using an out-of-line helper.  */
 static void gen_gvec_op4_ool(DisasContext *s, bool is_q, int rd, int rn,
                              int rm, int ra, int data, gen_helper_gvec_4 *fn)
@@ -11270,6 +11284,15 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
@@ -11381,16 +11404,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
index 766555a5d6..d73c1afe30 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -194,6 +194,30 @@ void HELPER(sve2_sqrdmlsh_h)(void *vd, void *vn, void *vm,
     }
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
 void HELPER(sve2_sqdmulh_h)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
@@ -291,6 +315,7 @@ void HELPER(sve2_sqrdmlah_s)(void *vd, void *vn, void *vm,
     }
 }
 
+
 void HELPER(sve2_sqrdmlsh_s)(void *vd, void *vn, void *vm,
                              void *va, uint32_t desc)
 {
@@ -303,6 +328,30 @@ void HELPER(sve2_sqrdmlsh_s)(void *vd, void *vn, void *vm,
     }
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
 void HELPER(sve2_sqdmulh_s)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
-- 
2.25.1



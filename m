Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78062C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408FF2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acMING7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408FF2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBap0-000572-HJ
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBad3-0005bv-6d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:25:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBad1-0004Pm-7t
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:25:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id z9so288439wmk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nu72P525ZWsOYSw7UDEIWb9/3JC8nEVuqmcqR/cOqbI=;
 b=acMING7o0xT9i8qfzmgrPW62rI7d32kaR04wVUp3FVwiWSLgR3h2RURPArsjY0tvFn
 j5Ha7bUnPMHDB1xorBwRrGHKHvIafD4yslylgIkhnVQNr8rSvfraTnXtNRHn4ZH8vtKS
 TFqRhn3ItL8HU0z2mrLIO6twxcg/rltMDcv19TVS/xoqcf3KAgA9Y61o3tR11CKgrN4e
 A+XiUZzaH7QrIgrVlRi6f6MNJh1uDjg/Mp8sPUeCKB6XS5hc63+SnhvIycCC8EafRoWg
 7wMxv75q0Y39ARhaVAo8ykJ+EeXwbNsrp2ldpFBjOIkCsiPmiI3d+aJhp/aggWxGB/py
 Q4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nu72P525ZWsOYSw7UDEIWb9/3JC8nEVuqmcqR/cOqbI=;
 b=WOSYXfZB/uctOn6JrOQrMujoDfhPZv+Yl2rjYEWbsmk88x913Xv2s4yHk4QULundUU
 fOQSAUp900EZkKg3Dl4KZFnYJ+pEd8AeMZjOjg+CRAWYyQ39/wMsRgB4hhp+AO9Ga7D4
 0dSbNddHsP05WrrheXjQnv/xiVgYXvX5vzKvLdqQCgFoN5DldCFlQMPeaTnXs2tObe/B
 sc28XNlzcLJwMRIvU1ZJ0cJbmxzq5PXFcyzad1eSkabwa9+LeF4LmRZu0wlaFL5T/XeK
 FjVMiVbS+SLrLBzYlyJX76mhsO1/EEMN/5nxO/O2wQVm/8d7aQP8N/0msKjG9VITpIqB
 wBNA==
X-Gm-Message-State: AOAM531xKTlNU8UWquymQ7aUa2cc4uPpiBOMEwzjsip2nkaK3VKkbQgF
 1e7trse+XFennfXcaMUp/hV0ZMV2fSsID1M7
X-Google-Smtp-Source: ABdhPJykBjfiEXjGEmrxPF08gTyOJLNBMpOhRGQtVWjha4zUTpfdJWdGa//e2oV4d1TdtdusEtdNDg==
X-Received: by 2002:a1c:9910:: with SMTP id b16mr732772wme.79.1598606697533;
 Fri, 28 Aug 2020 02:24:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/35] target/arm: Convert sq{, r}dmulh to gvec for aa64 advsimd
Date: Fri, 28 Aug 2020 10:24:13 +0100
Message-Id: <20200828092413.22206-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-21-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        | 10 ++++++++
 target/arm/translate-a64.c | 33 ++++++++++++++++++--------
 target/arm/vec_helper.c    | 48 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 378bb1898be..3ca73a1764a 100644
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
index a50b2f0cb13..4ba6918b606 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -678,6 +678,20 @@ static void gen_gvec_op3_fpst(DisasContext *s, bool is_q, int rd, int rn,
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
@@ -11734,6 +11748,15 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
@@ -11845,16 +11868,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
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
index 9e93a8a154d..a6c53d2ab6c 100644
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
2.20.1



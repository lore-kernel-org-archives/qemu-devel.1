Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C1BC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFFF23B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7WPSr9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFFF23B30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k70EP-0000sO-K8
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 13:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k70Dh-0000Pm-4N
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:43:53 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k70Df-0005DA-CR
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:43:52 -0400
Received: by mail-oi1-x244.google.com with SMTP id o21so11082051oie.12
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zTB6EmS659aVNk9guq/xoJniox/gT5O8Z9/PsHuviR0=;
 b=J7WPSr9H6Uv8XIX6kkH7GuxqNvaDlPcE+cUlUh5B9l7naWSHAZMYLTt89khtdA7NpE
 +UryUTEBC/tTGcYZX61gTmldhC/WbS6HJXoRA4YZqwa6oqhhyfnnb0IiK6NINS9LEQKA
 uZmQ6Qmf9eXnWYqbb8zO22gma/uwPuYjcHtmBUXQoNjkwuZ8JaZWSsrTpRWlhXKGJAHa
 peXYzWvw3jHrS77ScxoZz/+1abZg03N2c3o9UxQzCmJZSVhvTwRj1nmFsh5VS0cbY4Wk
 lk6yOhFoBoXFQpekpWVSL5bT2QxxkStsjEozF2KIqhJxUhJ42vqLxoaCgGRczCYusy8A
 OzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zTB6EmS659aVNk9guq/xoJniox/gT5O8Z9/PsHuviR0=;
 b=dOlBPplHkykQaEZfB8+qcrHo+z7nm3P5mXfa2FPcEbD4n7iSr1q0nm9j55kTaWgEzu
 +8Hf7+RtZH7+iPUuS2shk5/di+q43ELMrnI1MJzfaI/FuMoy38xHG87jjMAygOS/U3p5
 jKIhMxPoCwW5jmkqS2/TRzWQTaK+F0zfYNgYTaYe3RPuaVsFmBlPachOiybJhCXWlmhM
 ch+Sz7kgs0PmJyyJOQ6+ZTZA8tpyFIKEsMoUSl1JiePwbaU+fUn+hbQHiFmr+bRNKVMu
 Q04mtnaA92UNZ6Qazve9mhnQer6xZXAjUCrD1PSlilC5uPkVXe8TasjP/E1fpEAfrydq
 Ux5Q==
X-Gm-Message-State: AOAM531UJ6YJJBChLSUTL1SmhSd1b4MP16RLpHMjILgd2TkT0dnMo+Su
 GTOOpSnBDrySAIUMuJbrQKPHrlL/ZQjeQA==
X-Google-Smtp-Source: ABdhPJz+9Ff/nZN+rkrHOkuAohzghQ6lT4tZ5IZp4dL2Gkco2+9ucDOjCoT/0tVvWO9bDI/MimqVPQ==
X-Received: by 2002:a17:90a:c208:: with SMTP id
 e8mr4218187pjt.73.1597455131996; 
 Fri, 14 Aug 2020 18:32:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/20] target/arm: Convert integer multiply (indexed) to gvec
 for aa64 advsimd
Date: Fri, 14 Aug 2020 18:31:43 -0700
Message-Id: <20200815013145.539409-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x244.google.com
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
 target/arm/helper.h        |  4 ++++
 target/arm/translate-a64.c | 16 ++++++++++++++++
 target/arm/vec_helper.c    | 29 +++++++++++++++++++++++++----
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 759639a63a..d0573a53c8 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -758,6 +758,10 @@ DEF_HELPER_FLAGS_4(gvec_uaba_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uaba_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uaba_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_mul_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_mul_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_mul_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 42aa695dff..d08960a1c8 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13507,6 +13507,22 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                                data, gen_helper_gvec_fmlal_idx_a64);
         }
         return;
+
+    case 0x08: /* MUL */
+        if (!is_long && !is_scalar) {
+            static gen_helper_gvec_3 * const fns[3] = {
+                gen_helper_gvec_mul_idx_h,
+                gen_helper_gvec_mul_idx_s,
+                gen_helper_gvec_mul_idx_d,
+            };
+            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm),
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               index, fns[size - 1]);
+            return;
+        }
+        break;
     }
 
     if (size == 3) {
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index bbd1141dfc..aa1de36921 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -711,6 +711,27 @@ DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
  */
 
 #define DO_MUL_IDX(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                                          \
+    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    intptr_t idx = simd_data(desc);                                        \
+    TYPE *d = vd, *n = vn, *m = vm;                                        \
+    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
+        TYPE mm = m[H(i + idx)];                                           \
+        for (j = 0; j < segment; j++) {                                    \
+            d[i + j] = n[i + j] * mm;                                      \
+        }                                                                  \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
+DO_MUL_IDX(gvec_mul_idx_h, uint16_t, H2)
+DO_MUL_IDX(gvec_mul_idx_s, uint32_t, H4)
+DO_MUL_IDX(gvec_mul_idx_d, uint64_t, )
+
+#undef DO_MUL_IDX
+
+#define DO_FMUL_IDX(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
     intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
@@ -725,11 +746,11 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
     clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
-DO_MUL_IDX(gvec_fmul_idx_h, float16, H2)
-DO_MUL_IDX(gvec_fmul_idx_s, float32, H4)
-DO_MUL_IDX(gvec_fmul_idx_d, float64, )
+DO_FMUL_IDX(gvec_fmul_idx_h, float16, H2)
+DO_FMUL_IDX(gvec_fmul_idx_s, float32, H4)
+DO_FMUL_IDX(gvec_fmul_idx_d, float64, )
 
-#undef DO_MUL_IDX
+#undef DO_FMUL_IDX
 
 #define DO_FMLA_IDX(NAME, TYPE, H)                                         \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
-- 
2.25.1



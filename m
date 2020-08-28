Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC5C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561762075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYYsOiZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561762075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaoN-0003tI-I9
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBad0-0005UG-Lo
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacy-0004PK-UT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id z9so288374wmk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Z6R8Fmxg67F2WiAfIJwqQmrX2nY6ej9nF/dPNS6hEbA=;
 b=IYYsOiZQcLizQP8uyXfXpyvnnz5hGHoZyJ8Vr+n5uSH3QdpLrzH5lvglTkIwJNOyrz
 x0DqcNHf87IIx3nSgOIZGRzV6F1uJga12XciFSwmILQSsAg9KFt8iyQZWMS1Fw6j0+Vl
 O9OfOL7UrQan/9nrjUQXMxam3D8EWX6zFNclZeGmsgJ3QwU7Ps3AGUlpSyChoXikzImb
 4b8bjG0OMTC+Py843LIx0KQR26eYOoJQ+csrbxtt0wSZg2V/p9TqG+BeB1H2OVXyGLrV
 YUSuiNi8+hdnVwzpNQt9+NeyO6J0sO2wyAOrjhOf2Npbo9qj7OBMzSd5SYIEduuqZwzw
 SXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z6R8Fmxg67F2WiAfIJwqQmrX2nY6ej9nF/dPNS6hEbA=;
 b=cuso9mIIlIYG8dGY6DNSjG70B013i0/pRu9MrG73eCjYG0zNa04n8SGNvRUHxDmwat
 scsx5Q04TfD2+v1A6eDIqROEteTUaa2OV2Dkt+YKWW/yER7xyE5rOkOHYSTLziB4HLS1
 uc78zU7mEbQagxqgcXBU36E8L/ZbFWLnB7aE3mj5ychKEXNuSDC7J+23nH4SsWS22Q3p
 voF8QTYDOLp5GaK4jcAstntnzHlGdr7QxZwc2eJxaAYZAAm+Z6QuOhVTDJ3FvVytt7bF
 Kdi+fYaeHtWIBTXUJmixeetUQuW8ZOTydlZk3l+RzrcCqkSpflr+I1x+F7EvDVN67INJ
 Es+w==
X-Gm-Message-State: AOAM531YG4ZoQbwxoaAwNWhedxM6pbxhXrPlnMt3+Nq1jgsmBSifdTsw
 beQX5KsPAeT55SV+1WujdBMqORbWMJ23/XYJ
X-Google-Smtp-Source: ABdhPJymdfVCWVDBo8uxAzD8WZP+TfO4KzAmQ/o6MbWPbhmcCq9XJXBZCVxjCaazd5Lfe4qguMyXUw==
X-Received: by 2002:a1c:24d5:: with SMTP id k204mr661822wmk.159.1598606695219; 
 Fri, 28 Aug 2020 02:24:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/35] target/arm: Convert integer multiply (indexed) to gvec
 for aa64 advsimd
Date: Fri, 28 Aug 2020 10:24:11 +0100
Message-Id: <20200828092413.22206-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
Message-id: 20200815013145.539409-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h        |  4 ++++
 target/arm/translate-a64.c | 16 ++++++++++++++++
 target/arm/vec_helper.c    | 29 +++++++++++++++++++++++++----
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 759639a63a2..d0573a53c80 100644
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
index 115dc946e75..abbd6421a28 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13488,6 +13488,22 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
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
index 9f10be03ed7..155b6368cb3 100644
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
2.20.1



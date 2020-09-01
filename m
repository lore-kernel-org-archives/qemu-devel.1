Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD42CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8291620FC3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plVQaa36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8291620FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8EG-0004Ob-Ks
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD848-0000yP-PP
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD847-0006JZ-0O
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:19:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id l9so1557456wme.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=orWFWQdBiy0l07k+YHsGr48Jib1CJiHPrId3hecl41Y=;
 b=plVQaa36olI7jLkZunCQSvlsWYa4zD5cCR7MqSu+S2+MkcN1mLmAkCXwrp5ekGb+ez
 5xZiIBDq/rgwjhBL3cpp3oqGIAZyYrCGQm2h/4muZghWGIttwNiiwy46mnLtxwfeiRMj
 nYjQAr7lQYHtkIswbUNl0FsdnI9EtLcibmhJIiZz6FzNo62QbWLjoo36EAHQJbcYPQTz
 7I8HmyIbVscB63JFasbBKxRsR1WG4Oklg8jQrxVxy5zvu00fRN6v4+efsEWsOmgtZf5F
 7aAxBtwDaA+vzPU8/CZmKhoVhk2TKbsZKfX4trL0QXGSaMQe8GMeBgua/FQUVcoDarlY
 rYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=orWFWQdBiy0l07k+YHsGr48Jib1CJiHPrId3hecl41Y=;
 b=fzDqeB1/XRJovmEq+81kichVtlebvuBqg1fJE9+EAwAoXvNKJyj4D4ylElJ1BdW3l/
 p8Uoyvvf3EcDdmILx7M9R4q/qyegiUaPQakIewThhprnKDZ7vkgDGRQkAZp20eBwsN+x
 7GrDswxV7ZVbp/nXuWwsm8ypfB7lN1YUQAvKkBhY2K4NDPjwHp/YFaWvFdsT+1LY0/QY
 Px18lqtcifadU2BGIS4MPGopKJit8AJJK/0JnmOEzmQvvxjqNdnyFJt8EOoWvozaFH8Y
 t0Y3Hn3tTsEjfAW6F4o/7e4kweLJgz9avPAf/ePq2SLSKholnsUgZTIHxb/qGihrpHrv
 y92w==
X-Gm-Message-State: AOAM530fVaRBlZmdYGDWwPCnhEO18bbO0vBZOwiavOoqRrRGvDmdsTTA
 tua9La1ON7Cd4vu05O0URPTliKeAK12UlDUA
X-Google-Smtp-Source: ABdhPJx95xR4hWCucp7+RXV9wN54OnzanXiL7t+r35sCIGD/jNzrf7vPCyJs9kUFtZePV4Xn2Bw6DA==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr2292967wmh.20.1598973557267;
 Tue, 01 Sep 2020 08:19:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.19.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:19:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/47] target/arm/vec_helper: Add gvec fp indexed
 multiply-and-add operations
Date: Tue,  1 Sep 2020 16:18:18 +0100
Message-Id: <20200901151823.29785-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Add gvec helpers for doing Neon-style indexed non-fused fp
multiply-and-accumulate operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200828183354.27913-44-peter.maydell@linaro.org
---
 target/arm/helper.h     | 10 ++++++++++
 target/arm/vec_helper.c | 27 ++++++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index cbdbf824d8d..8defd7c8019 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -740,6 +740,16 @@ DEF_HELPER_FLAGS_5(gvec_fmul_idx_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_fmul_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_nf_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_nf_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index b27b90e1dd8..a973454e4f4 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1085,7 +1085,7 @@ DO_MLA_IDX(gvec_mls_idx_d, uint64_t, -,   )
 
 #undef DO_MLA_IDX
 
-#define DO_FMUL_IDX(NAME, TYPE, H) \
+#define DO_FMUL_IDX(NAME, ADD, TYPE, H)                                    \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
     intptr_t i, j, oprsz = simd_oprsz(desc);                               \
@@ -1095,16 +1095,33 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
     for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
         TYPE mm = m[H(i + idx)];                                           \
         for (j = 0; j < segment; j++) {                                    \
-            d[i + j] = TYPE##_mul(n[i + j], mm, stat);                     \
+            d[i + j] = TYPE##_##ADD(d[i + j],                              \
+                                    TYPE##_mul(n[i + j], mm, stat), stat); \
         }                                                                  \
     }                                                                      \
     clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
-DO_FMUL_IDX(gvec_fmul_idx_h, float16, H2)
-DO_FMUL_IDX(gvec_fmul_idx_s, float32, H4)
-DO_FMUL_IDX(gvec_fmul_idx_d, float64, )
+#define float16_nop(N, M, S) (M)
+#define float32_nop(N, M, S) (M)
+#define float64_nop(N, M, S) (M)
 
+DO_FMUL_IDX(gvec_fmul_idx_h, nop, float16, H2)
+DO_FMUL_IDX(gvec_fmul_idx_s, nop, float32, H4)
+DO_FMUL_IDX(gvec_fmul_idx_d, nop, float64, )
+
+/*
+ * Non-fused multiply-accumulate operations, for Neon. NB that unlike
+ * the fused ops below they assume accumulate both from and into Vd.
+ */
+DO_FMUL_IDX(gvec_fmla_nf_idx_h, add, float16, H2)
+DO_FMUL_IDX(gvec_fmla_nf_idx_s, add, float32, H4)
+DO_FMUL_IDX(gvec_fmls_nf_idx_h, sub, float16, H2)
+DO_FMUL_IDX(gvec_fmls_nf_idx_s, sub, float32, H4)
+
+#undef float16_nop
+#undef float32_nop
+#undef float64_nop
 #undef DO_FMUL_IDX
 
 #define DO_FMLA_IDX(NAME, TYPE, H)                                         \
-- 
2.20.1



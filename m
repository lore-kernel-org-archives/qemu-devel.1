Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5DAC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:54:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A326C2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfX91rQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A326C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjVm-0008Af-Oh
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjDB-0003Ux-Ny
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjD7-000674-N2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:53 -0400
Received: by mail-wr1-x42e.google.com with SMTP id b18so51527wrs.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gov6OrVq+v77edQml+nkA/s6hx0NTnYGiTc0gLPrxvY=;
 b=VfX91rQuGgQU8qCylnV+9lie6il/R3sbdp4/60On0vG8doJevfzAh6st8gPNtNoGUt
 xq+LDnVRM5vlg+ipcrcK6fZ9FjODloMBzs+o/Wlb4BhFUbVlCCc0976GNsBfP6MMum8N
 pZ0r280TJychIX9oU4vXMOFmMc6SAtNN5JP5T/MJWu0X3HqbESqv0ch1qQa6NrD6Jq8u
 yEGdLSUSIhR7zHnQrHGuOxFdS0GsPCM7eBMZVttZoHDn6cSw8TMwifdQMFNrG1TfBAYU
 ZppuRg7Bxxsi041xIW3QgikDGfSNg4yt+p4z2nVDgu80P4iHKuxkzdoaaOKAgV2hrxwl
 FZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gov6OrVq+v77edQml+nkA/s6hx0NTnYGiTc0gLPrxvY=;
 b=tpFVlltkJSx1yMtL9x1fddQA70A78u6KAgC2RKmKqkbUADbQAht0D3XC1s/ET1QE1W
 SF+O5BfyLxF9a1CPTjTdkoO11xrB92jdObahtXl7o0QgOkHoJBt/7ldbKMBl8b95yILt
 WD5qdw+Xbj5p5K8tOmRVfAtvqU17UGgERMuITMMlEhUb0bfYG/1/wN+MmCge9YF+BxIp
 oHanoPEWrzBwreLfiIqj8D35JoRdyz5HKjVNveQnf+1kwBsDKOIDbTzAolhs1Twtuo3V
 SKREFERKD9I5TdUeZw1Ut3AuEx3FCEmiBkenPI1PFOofriquQlA87ttJiXiw33mDQLzy
 PztQ==
X-Gm-Message-State: AOAM5339D7jcFVWPNiosiFUW7C9sEMTgMVrEKcDt/V7NXs7YlrFsslH7
 cmZjBafC6uwioniHuvfvkK8EX/WOZwsUBl/M
X-Google-Smtp-Source: ABdhPJwZsS8qcLGpFSegT2TdRbBon4TAZwNp8ztChBSLZtj1Q6cUBmYRSRnjFUbAtslzPoWRGq3mYQ==
X-Received: by 2002:a5d:61d2:: with SMTP id q18mr265146wrv.404.1598639688086; 
 Fri, 28 Aug 2020 11:34:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 43/45] target/arm/vec_helper: Add gvec fp indexed
 multiply-and-add operations
Date: Fri, 28 Aug 2020 19:33:52 +0100
Message-Id: <20200828183354.27913-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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



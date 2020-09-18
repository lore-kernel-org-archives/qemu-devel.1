Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AECFC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B81521D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxr3bq6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B81521D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMM5-0006Bk-Or
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI9-00010O-Qi
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:29 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHy-0007EV-3Q
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:29 -0400
Received: by mail-pg1-x544.google.com with SMTP id k14so3973227pgi.9
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lFJ8kTFmIiX5tpGTknCea588jF44LhIYKzuEd0gTcfs=;
 b=bxr3bq6eWIPh4qOlnsTf0jmJiEbtbfjt6recMWPnZUBh4K9EA853OJrZJEqhf4zeOi
 sDSRSV4oqn/TSbdSkXBlEzInCS0C6kzH2p6h/l6AJ+itGIv18Mt9A6u8KTSieiHa/HLI
 wpxSMACTKKDVdcDtPaB17Gy6B73TNHiuxS87yJvuSVwUcerTIBknaGMSGTha/XWHZdTM
 +vjjL+1Df/0LMrqvJ/rlBb8Fng6wsQ4D+jA2UD/sN3KiackpPU7/2YhuTX2YvxV264Z+
 Togcg142LDEcRWCFWu9u8G6BZlTzY1Jklw2iRixtY4i8Aq7dSs/eZ16et2dCOYcOjCwu
 ulXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lFJ8kTFmIiX5tpGTknCea588jF44LhIYKzuEd0gTcfs=;
 b=NlyaUBFFZif5G6xyfGFJNhLD6RxjJLo820nxO7PJlKaZN+tosvI6vxA8J/3rU/3qEZ
 VMVKlRhFIPd577wD/apMrJeuB+A89yzc6cWritNeo+T+DKE9vQy/FfwYQuX6wpj6ueLn
 caKiq2yBcPpKXSrwsjJ1bgWv7/+xseoOwIQJTgevtNK7XiV8qaiN2+ny7daDhwyb8TWF
 z2ZBKVJpl+CWgLvQLvmYIv5v4WczrlLIwoQECaJmxJfqy0oAayzM0sgU3QMECkr3AFBs
 EI9KALk4C2TMOf4hKdGk88osraos7TLC34kfCa1UFr3fzVs9Md31rV+hGMMQ1htZCva9
 th1A==
X-Gm-Message-State: AOAM533WGJ40HSmQWl9XCKD28eG9MPEvm99r+841C1hAtXBTrsrjUfnJ
 nZvVcTOJisoFHWrvQdK0dYx3C4yeaCRTjg==
X-Google-Smtp-Source: ABdhPJyh2iVlx8kkZdmvYawNnls3IM2hIllweNMd41N2eaf91iQQ8rxyhwvlfKHKX0iwQo4yRt+46w==
X-Received: by 2002:a63:4b63:: with SMTP id k35mr29021279pgl.235.1600454354815; 
 Fri, 18 Sep 2020 11:39:14 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 61/81] target/arm: Implement SVE2 signed saturating
 doubling multiply high
Date: Fri, 18 Sep 2020 11:37:31 -0700
Message-Id: <20200918183751.2787647-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        | 10 +++++
 target/arm/sve.decode      |  4 ++
 target/arm/translate-sve.c | 18 ++++++++
 target/arm/vec_helper.c    | 84 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8b3dc9b4e3..fa7b2b7dd7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -944,6 +944,16 @@ DEF_HELPER_FLAGS_5(neon_sqrdmulh_h, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(neon_sqrdmulh_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqdmulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqrdmulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_xar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 #ifdef TARGET_AARCH64
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 400940a18d..6879870cc1 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1214,6 +1214,10 @@ SMULH_zzz       00000100 .. 1 ..... 0110 10 ..... .....  @rd_rn_rm
 UMULH_zzz       00000100 .. 1 ..... 0110 11 ..... .....  @rd_rn_rm
 PMUL_zzz        00000100 00 1 ..... 0110 01 ..... .....  @rd_rn_rm_e0
 
+# SVE2 signed saturating doubling multiply high (unpredicated)
+SQDMULH_zzz     00000100 .. 1 ..... 0111 00 ..... .....  @rd_rn_rm
+SQRDMULH_zzz    00000100 .. 1 ..... 0111 01 ..... .....  @rd_rn_rm
+
 ### SVE2 Integer - Predicated
 
 SADALP_zpzz     01000100 .. 000 100 101 ... ..... .....  @rdm_pg_rn
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c30aed211f..298c328ce0 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6434,6 +6434,24 @@ static bool trans_PMUL_zzz(DisasContext *s, arg_rrr_esz *a)
     return do_sve2_zzz_ool(s, a, gen_helper_gvec_pmul_b);
 }
 
+static bool trans_SQDMULH_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_sqdmulh_b, gen_helper_sve2_sqdmulh_h,
+        gen_helper_sve2_sqdmulh_s, gen_helper_sve2_sqdmulh_d,
+    };
+    return do_sve2_zzz_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_SQRDMULH_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_sqrdmulh_b, gen_helper_sve2_sqrdmulh_h,
+        gen_helper_sve2_sqrdmulh_s, gen_helper_sve2_sqrdmulh_d,
+    };
+    return do_sve2_zzz_ool(s, a, fns[a->esz]);
+}
+
 /*
  * SVE2 Integer - Predicated
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 82e12b51c1..f3a19821cd 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -81,6 +81,26 @@ void HELPER(sve2_sqrdmlsh_b)(void *vd, void *vn, void *vm,
     }
 }
 
+void HELPER(sve2_sqdmulh_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = do_sqrdmlah_b(n[i], m[i], 0, false, false);
+    }
+}
+
+void HELPER(sve2_sqrdmulh_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = do_sqrdmlah_b(n[i], m[i], 0, false, true);
+    }
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
 int16_t do_sqrdmlah_h(int16_t src1, int16_t src2, int16_t src3,
                       bool neg, bool round, uint32_t *sat)
@@ -198,6 +218,28 @@ void HELPER(sve2_sqrdmlsh_h)(void *vd, void *vn, void *vm,
     }
 }
 
+void HELPER(sve2_sqdmulh_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm;
+    uint32_t discard;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = do_sqrdmlah_h(n[i], m[i], 0, false, false, &discard);
+    }
+}
+
+void HELPER(sve2_sqrdmulh_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm;
+    uint32_t discard;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = do_sqrdmlah_h(n[i], m[i], 0, false, true, &discard);
+    }
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 32-bit */
 int32_t do_sqrdmlah_s(int32_t src1, int32_t src2, int32_t src3,
                       bool neg, bool round, uint32_t *sat)
@@ -309,6 +351,28 @@ void HELPER(sve2_sqrdmlsh_s)(void *vd, void *vn, void *vm,
     }
 }
 
+void HELPER(sve2_sqdmulh_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm;
+    uint32_t discard;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = do_sqrdmlah_s(n[i], m[i], 0, false, false, &discard);
+    }
+}
+
+void HELPER(sve2_sqrdmulh_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm;
+    uint32_t discard;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = do_sqrdmlah_s(n[i], m[i], 0, false, true, &discard);
+    }
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 64-bit */
 static int64_t do_sat128_d(Int128 r)
 {
@@ -368,6 +432,26 @@ void HELPER(sve2_sqrdmlsh_d)(void *vd, void *vn, void *vm,
     }
 }
 
+void HELPER(sve2_sqdmulh_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = do_sqrdmlah_d(n[i], m[i], 0, false, false);
+    }
+}
+
+void HELPER(sve2_sqrdmulh_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = do_sqrdmlah_d(n[i], m[i], 0, false, true);
+    }
+}
+
 /* Integer 8 and 16-bit dot-product.
  *
  * Note that for the loops herein, host endianness does not matter
-- 
2.25.1



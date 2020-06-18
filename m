Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6936C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2DD2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEIjk1S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2DD2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmj2-0004Ud-Jy
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDm-00053A-6u
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:36831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDc-0003Qs-QN
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id x22so2208052pfn.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xryn60mUb+1VPetuivKQ29qI398g95ST3GkV5ymH0cg=;
 b=zEIjk1S+NpLUjusnRPcU5tCnn3Ubd1ABcLCPKoxatEAjwcaCer7OfMz1WIz+v+N0OO
 mE4AQGXWJMv2mGPV42+L+iud5WyY6WlWWKpPl24I8XPNf2i1c4iMzg+mD6wsOoD+PrrW
 Rro5Ntwxtl+vux9jfdov6quYKgXaUa82kqecqY2dbZdM0V8uo+idu2gjpZ8qzPVBLE7r
 o/zNM+RJ4GDmqW6adTy4HCkLLVpuj+A/JTXOMSK/8fbPae41um5x51jZgdGnIe9Yrcaq
 WSRHQtvfrJfap3x2imBrLUSLy/tMCoNoZe0lr4aSbZcIwiC17t6ckSZI5I+HpxJoWEIx
 fgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xryn60mUb+1VPetuivKQ29qI398g95ST3GkV5ymH0cg=;
 b=DMudk7qmDWm2bslLVEPV/8uFB9apM51Pu1dB69YdttZnvBAnySF5gVeSx7hzuR4yi6
 juy5hsBBBSA4pFATwN63cL3Gty4ztQsFDRvEk54VcZyO3DtnEhcMkRQzCHEqD200EWV6
 1ClKznpwlHLA77E6jJOWW0yHnEYRnI+Jl0vHjYCrEXaEPdTLgMhCXueFjolfDexPq25S
 9/j0Pywc6l6eobb50InvNpA/oX5hHFLrAxrQYGmjQibdH54QVJBZAJSB2Z+ilZfGhdGi
 3DQd4FEvD+Ct+WifkkUzW73HsJ5V4J8SeNf6ePOPM1FfWbUUlpoyohpbHPfdoV0o1Z4U
 38zw==
X-Gm-Message-State: AOAM533NUPQEGs/53O18yGnlR5T7XUmbC9jQSQnPnEakI8Fa3zGz6mq5
 FiNW6/tMpHGvPwkXlDPeMBSpZ1xzloc=
X-Google-Smtp-Source: ABdhPJwAF7eFs/HC6eAzyJB1Dnda5qQonCqgmeLitAM1LQcQ58uaojSNCq2cghdar5g+XhsbTFa4vQ==
X-Received: by 2002:a63:481:: with SMTP id 123mr1749555pge.2.1592454721597;
 Wed, 17 Jun 2020 21:32:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s15sm1162840pgv.5.2020.06.17.21.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:32:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 075/100] target/arm: Implement SVE2 saturating multiply-add
 high (indexed)
Date: Wed, 17 Jun 2020 21:26:19 -0700
Message-Id: <20200618042644.1685561-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/arm/helper-sve.h    | 14 +++++++++++++
 target/arm/sve.decode      |  8 ++++++++
 target/arm/sve_helper.c    | 40 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  8 ++++++++
 4 files changed, 70 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 2929ad48a7..c86dcf0c55 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2177,3 +2177,17 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 467a93052f..5fc76b7fc3 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -793,6 +793,14 @@ MLS_zzxz_h      01000100 .. 1 ..... 000011 ..... .....          @rrxr_h
 MLS_zzxz_s      01000100 .. 1 ..... 000011 ..... .....          @rrxr_s
 MLS_zzxz_d      01000100 .. 1 ..... 000011 ..... .....          @rrxr_d
 
+# SVE2 saturating multiply-add high (indexed)
+SQRDMLAH_zzxz_h 01000100 .. 1 ..... 000100 ..... .....          @rrxr_h
+SQRDMLAH_zzxz_s 01000100 .. 1 ..... 000100 ..... .....          @rrxr_s
+SQRDMLAH_zzxz_d 01000100 .. 1 ..... 000100 ..... .....          @rrxr_d
+SQRDMLSH_zzxz_h 01000100 .. 1 ..... 000101 ..... .....          @rrxr_h
+SQRDMLSH_zzxz_s 01000100 .. 1 ..... 000101 ..... .....          @rrxr_s
+SQRDMLSH_zzxz_d 01000100 .. 1 ..... 000101 ..... .....          @rrxr_d
+
 # SVE2 integer multiply (indexed)
 MUL_zzx_h       01000100 .. 1 ..... 111110 ..... .....          @rrx_h
 MUL_zzx_s       01000100 .. 1 ..... 111110 ..... .....          @rrx_s
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 24c733fea1..b3a87fb0b7 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1487,9 +1487,49 @@ DO_CMLA(sve2_sqrdcmlah_zzzz_h, int16_t, H2, DO_SQRDMLAH_H)
 DO_CMLA(sve2_sqrdcmlah_zzzz_s, int32_t, H4, DO_SQRDMLAH_S)
 DO_CMLA(sve2_sqrdcmlah_zzzz_d, int64_t,   , DO_SQRDMLAH_D)
 
+#undef DO_SQRDMLAH_B
+#undef DO_SQRDMLAH_H
+#undef DO_SQRDMLAH_S
+#undef DO_SQRDMLAH_D
 #undef do_cmla
 #undef DO_CMLA
 
+#define DO_ZZXZ(NAME, TYPE, H, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
+{                                                                       \
+    intptr_t oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);     \
+    intptr_t i, j, idx = simd_data(desc);                               \
+    TYPE *d = vd, *a = va, *n = vn, *m = (TYPE *)vm + H(idx);           \
+    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {               \
+        TYPE mm = m[i];                                                 \
+        for (j = 0; j < segment; j++) {                                 \
+            d[i + j] = OP(n[i + j], mm, a[i + j]);                      \
+        }                                                               \
+    }                                                                   \
+}
+
+#define DO_SQRDMLAH_H(N, M, A) \
+    ({ uint32_t discard; do_sqrdmlah_h(N, M, A, false, true, &discard); })
+#define DO_SQRDMLAH_S(N, M, A) \
+    ({ uint32_t discard; do_sqrdmlah_s(N, M, A, false, true, &discard); })
+#define DO_SQRDMLAH_D(N, M, A) do_sqrdmlah_d(N, M, A, false, true)
+
+DO_ZZXZ(sve2_sqrdmlah_idx_h, int16_t, H2, DO_SQRDMLAH_H)
+DO_ZZXZ(sve2_sqrdmlah_idx_s, int32_t, H4, DO_SQRDMLAH_S)
+DO_ZZXZ(sve2_sqrdmlah_idx_d, int64_t,   , DO_SQRDMLAH_D)
+
+#define DO_SQRDMLSH_H(N, M, A) \
+    ({ uint32_t discard; do_sqrdmlah_h(N, M, A, true, true, &discard); })
+#define DO_SQRDMLSH_S(N, M, A) \
+    ({ uint32_t discard; do_sqrdmlah_s(N, M, A, true, true, &discard); })
+#define DO_SQRDMLSH_D(N, M, A) do_sqrdmlah_d(N, M, A, true, true)
+
+DO_ZZXZ(sve2_sqrdmlsh_idx_h, int16_t, H2, DO_SQRDMLSH_H)
+DO_ZZXZ(sve2_sqrdmlsh_idx_s, int32_t, H4, DO_SQRDMLSH_S)
+DO_ZZXZ(sve2_sqrdmlsh_idx_d, int64_t,   , DO_SQRDMLSH_D)
+
+#undef DO_ZZXZ
+
 #define DO_BITPERM(NAME, TYPE, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0fb88f4aa5..2903e46f91 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3891,6 +3891,14 @@ DO_SVE2_RRXR(trans_MLS_zzxz_h, gen_helper_gvec_mls_idx_h)
 DO_SVE2_RRXR(trans_MLS_zzxz_s, gen_helper_gvec_mls_idx_s)
 DO_SVE2_RRXR(trans_MLS_zzxz_d, gen_helper_gvec_mls_idx_d)
 
+DO_SVE2_RRXR(trans_SQRDMLAH_zzxz_h, gen_helper_sve2_sqrdmlah_idx_h)
+DO_SVE2_RRXR(trans_SQRDMLAH_zzxz_s, gen_helper_sve2_sqrdmlah_idx_s)
+DO_SVE2_RRXR(trans_SQRDMLAH_zzxz_d, gen_helper_sve2_sqrdmlah_idx_d)
+
+DO_SVE2_RRXR(trans_SQRDMLSH_zzxz_h, gen_helper_sve2_sqrdmlsh_idx_h)
+DO_SVE2_RRXR(trans_SQRDMLSH_zzxz_s, gen_helper_sve2_sqrdmlsh_idx_s)
+DO_SVE2_RRXR(trans_SQRDMLSH_zzxz_d, gen_helper_sve2_sqrdmlsh_idx_d)
+
 #undef DO_SVE2_RRXR
 
 /*
-- 
2.25.1



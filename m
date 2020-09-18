Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB53BC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6757221534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNCEAK1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6757221534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLZw-00025K-BE
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGn-0007WB-IB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:05 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:36288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGl-00073B-LT
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:05 -0400
Received: by mail-pj1-x1031.google.com with SMTP id b17so3463731pji.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vx8ZZ5+u/yR5WaW2fHP7h6lNyV8dijeNGCAPaQJ2js0=;
 b=bNCEAK1T71C5Ps/H0eB8lTYwc9J3Uu7fCW2gKcVs38T+8YkOApzzdiYDIVfgMxAl6/
 DIyYZ4pvOMJYWchy6gOfgSp3CBsai/G/LHsJ37MzcKl5XqUQY6IpAcyfUPpw8W6fjUG+
 1I/W/0JL/sYfW3zZ3UtGsi8fDlV191fSnrSAZ3lB1rkprvH2iu+2tOEimqd8BdOl4sTV
 0exRc3fpPSpQdnJgnNRPzUsaSV+DypcOr0xOJ+v8ww/nCG3Tnb6EfPofp5Koq2hP3EFC
 ZvmNHniLRtnvzQYneggZz1pKcga8C7Yf8oDDhBr4j6YrM0eJ1yI3j9w3ojT9eOodYTG6
 0+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vx8ZZ5+u/yR5WaW2fHP7h6lNyV8dijeNGCAPaQJ2js0=;
 b=IX7SMGNO2QcMSYaUfafcqtFckRSpJhF84gR86+HsLDcVBcrHGiBMJLCBfxF3XfPeZw
 +/RtCj55R5of8lD0q5WoRMwCBdAIGRMlBrTEF2+jA5u1Drca9cpVWfpF6LBDHXM8XTO7
 tM3DL+Z7SHlwKgsNX23jHFvxN4xDiGi8ehDorflH1wbo3vdnASg4i3hjFy+pJuvlyvCr
 tJgLmPtBZzahxtum+6Tmz3gycIwhAc9NqOuV6y9WE/8B0rfzQfc5c3OltfSeeLjsxJux
 RFd9eBLHBjcXQoJ/yanx9kYw6pXR0iNVb4l+P0rFN2mgCU0mIGZ6Ak6IDyYEZj+D0zLH
 TZig==
X-Gm-Message-State: AOAM5336cInxE0xdb4I0MKu9SnCfNsrXsKip3vfwH7jN588byx99F5Hi
 5jlQx2JD2Pm3yGwwR+G4mlBpSrc3hSh1QQ==
X-Google-Smtp-Source: ABdhPJz0nkAWTtopeYcUMPe5R7IxcKsRPXoNhqw7DHm8sShICsnG37dMyKfmGri95vl4VuZpluTG9Q==
X-Received: by 2002:a17:90a:1548:: with SMTP id
 y8mr14151686pja.113.1600454281981; 
 Fri, 18 Sep 2020 11:38:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/81] target/arm: Implement SVE2 integer pairwise add and
 accumulate long
Date: Fri, 18 Sep 2020 11:36:36 -0700
Message-Id: <20200918183751.2787647-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 target/arm/helper-sve.h    | 14 ++++++++++++
 target/arm/sve.decode      |  5 +++++
 target/arm/sve_helper.c    | 44 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 39 +++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4411c47120..e185405cdc 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -158,6 +158,20 @@ DEF_HELPER_FLAGS_5(sve_umulh_zpzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_umulh_zpzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_sadalp_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sadalp_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sadalp_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_uadalp_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uadalp_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uadalp_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_sdiv_zpzz_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_sdiv_zpzz_d, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 2c71d9e446..4f54a30538 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1100,3 +1100,8 @@ MUL_zzz         00000100 .. 1 ..... 0110 00 ..... .....  @rd_rn_rm
 SMULH_zzz       00000100 .. 1 ..... 0110 10 ..... .....  @rd_rn_rm
 UMULH_zzz       00000100 .. 1 ..... 0110 11 ..... .....  @rd_rn_rm
 PMUL_zzz        00000100 00 1 ..... 0110 01 ..... .....  @rd_rn_rm_e0
+
+### SVE2 Integer - Predicated
+
+SADALP_zpzz     01000100 .. 000 100 101 ... ..... .....  @rdm_pg_rn
+UADALP_zpzz     01000100 .. 000 101 101 ... ..... .....  @rdm_pg_rn
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index c983cd4356..4705722b71 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -517,6 +517,50 @@ DO_ZPZZ_D(sve_asr_zpzz_d, int64_t, DO_ASR)
 DO_ZPZZ_D(sve_lsr_zpzz_d, uint64_t, DO_LSR)
 DO_ZPZZ_D(sve_lsl_zpzz_d, uint64_t, DO_LSL)
 
+static inline uint16_t do_sadalp_h(uint16_t n, uint16_t m)
+{
+    int8_t n1 = n, n2 = n >> 8;
+    return m + n1 + n2;
+}
+
+static inline uint32_t do_sadalp_s(uint32_t n, uint32_t m)
+{
+    int16_t n1 = n, n2 = n >> 16;
+    return m + n1 + n2;
+}
+
+static inline uint64_t do_sadalp_d(uint64_t n, uint64_t m)
+{
+    int32_t n1 = n, n2 = n >> 32;
+    return m + n1 + n2;
+}
+
+DO_ZPZZ(sve2_sadalp_zpzz_h, int16_t, H1_2, do_sadalp_h)
+DO_ZPZZ(sve2_sadalp_zpzz_s, int32_t, H1_4, do_sadalp_s)
+DO_ZPZZ_D(sve2_sadalp_zpzz_d, uint64_t, do_sadalp_d)
+
+static inline uint16_t do_uadalp_h(uint16_t n, uint16_t m)
+{
+    uint8_t n1 = n, n2 = n >> 8;
+    return m + n1 + n2;
+}
+
+static inline uint32_t do_uadalp_s(uint32_t n, uint32_t m)
+{
+    uint16_t n1 = n, n2 = n >> 16;
+    return m + n1 + n2;
+}
+
+static inline uint64_t do_uadalp_d(uint64_t n, uint64_t m)
+{
+    uint32_t n1 = n, n2 = n >> 32;
+    return m + n1 + n2;
+}
+
+DO_ZPZZ(sve2_uadalp_zpzz_h, int16_t, H1_2, do_uadalp_h)
+DO_ZPZZ(sve2_uadalp_zpzz_s, int32_t, H1_4, do_uadalp_s)
+DO_ZPZZ_D(sve2_uadalp_zpzz_d, uint64_t, do_uadalp_d)
+
 #undef DO_ZPZZ
 #undef DO_ZPZZ_D
 
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 04c5a2c8bd..56e9e60a89 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5855,3 +5855,42 @@ static bool trans_PMUL_zzz(DisasContext *s, arg_rrr_esz *a)
 {
     return do_sve2_zzz_ool(s, a, gen_helper_gvec_pmul_b);
 }
+
+/*
+ * SVE2 Integer - Predicated
+ */
+
+static bool do_sve2_zpzz_ool(DisasContext *s, arg_rprr_esz *a,
+                             gen_helper_gvec_4 *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zpzz_ool(s, a, fn);
+}
+
+static bool trans_SADALP_zpzz(DisasContext *s, arg_rprr_esz *a)
+{
+    static gen_helper_gvec_4 * const fns[3] = {
+        gen_helper_sve2_sadalp_zpzz_h,
+        gen_helper_sve2_sadalp_zpzz_s,
+        gen_helper_sve2_sadalp_zpzz_d,
+    };
+    if (a->esz == 0) {
+        return false;
+    }
+    return do_sve2_zpzz_ool(s, a, fns[a->esz - 1]);
+}
+
+static bool trans_UADALP_zpzz(DisasContext *s, arg_rprr_esz *a)
+{
+    static gen_helper_gvec_4 * const fns[3] = {
+        gen_helper_sve2_uadalp_zpzz_h,
+        gen_helper_sve2_uadalp_zpzz_s,
+        gen_helper_sve2_uadalp_zpzz_d,
+    };
+    if (a->esz == 0) {
+        return false;
+    }
+    return do_sve2_zpzz_ool(s, a, fns[a->esz - 1]);
+}
-- 
2.25.1



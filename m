Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DE7C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8FA21534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2VgAbzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8FA21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLZb-0001qD-MK
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGx-0007vy-DG
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:15 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:37395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGv-00074P-9O
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id u9so3435010plk.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mY+15TD6kdMcYrFiZPjyUpAWKa7gPFK7CgZYkOafutw=;
 b=H2VgAbzdnQVsUM925aCWYQZoY064D/c921JbfRXlqwiBe7eljVsGjjGPi2CV2cEWt7
 /nRb3s9wzWQ6iOY2/ZylWs0UXbJk9aSD9ByiKfEQNsD9BOekPsX2qPp5nSO1F+3ZRoYF
 dXmJdRNNQt7JkAStTx00FDVVUAjWi7ZTR/I8qBjUZyUSA02nQvKsBuF1HCk7JWKnt7U6
 Oqg3TYsky9/8kNvK/PHfw72VjzGX4nh+iEYh0B5XIlHDRGNPvjmlwNn8C2qo/h2ACzUd
 CCBDTn070h58M+KY5zphxBDxqWpWsvsBP5OwGnQz2MU/tRSf2vxuUedRwlamBUEH06s/
 +VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mY+15TD6kdMcYrFiZPjyUpAWKa7gPFK7CgZYkOafutw=;
 b=ab/R1VpQrMqN5dv3Twehn/mha+DKBSHHRQ6mYaqFOkUyNmF3t6ySmjAfDRF5+pGRAa
 h98kOV2fTO7tCOcFabexNEwbDeyJacqazfXjG9jUXhtiQ7nmapAD34irYd/aTs7/e+sJ
 F/HlMOn608gyA17yIAicHF8fuheufVrBY5UPBhNM6T8DYzmSOGKya14g3YpJwaLxmZ3P
 ClutpslkgC9G40Qgzm+RWtSD8KYiZxitP8ENcxxstMkgaUA7HTu3PB0BnMxm1SmqJZ/B
 z9lo50EZg+iqqrJkxCzJOuK3yUvICtcdynMiOCy6g/Gn+QYtoGONSNG0t9DLMUEOVchl
 Zivw==
X-Gm-Message-State: AOAM532Qo2BG3BKr2ZiiiuMyqWi3eZSQYrhmDoZwDLigf80XCMH35U2U
 H0M5SyiPbOF26iXY+cr3mZBiyrN/pjN0ng==
X-Google-Smtp-Source: ABdhPJwUiXFEfp26qwJFHMekDTuYmgfD8T1jfzMdQG3+U2uk81AYx/SMpiT6jmPaX4hPYBEQwjukzQ==
X-Received: by 2002:a17:90a:d18b:: with SMTP id
 fu11mr13773335pjb.203.1600454291534; 
 Fri, 18 Sep 2020 11:38:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/81] target/arm: Implement SVE2 integer add/subtract long
Date: Fri, 18 Sep 2020 11:36:43 -0700
Message-Id: <20200918183751.2787647-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
v2: Fix select offsets (laurent desnogues).
---
 target/arm/helper-sve.h    | 24 ++++++++++++++++++++
 target/arm/sve.decode      | 19 ++++++++++++++++
 target/arm/sve_helper.c    | 43 +++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 46 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index ae06619d7d..676ddfbb2d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1367,6 +1367,30 @@ DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_saddl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_saddl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_saddl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_ssubl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_ssubl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_ssubl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sabdl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sabdl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sabdl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_uaddl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uaddl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uaddl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_usubl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_usubl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_usubl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_uabdl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uabdl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uabdl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index d018aef3dc..70712039e4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1159,3 +1159,22 @@ SUQADD          01000100 .. 011 100 100 ... ..... .....  @rdn_pg_rm
 USQADD          01000100 .. 011 101 100 ... ..... .....  @rdn_pg_rm
 SQSUB_zpzz      01000100 .. 011 110 100 ... ..... .....  @rdm_pg_rn # SQSUBR
 UQSUB_zpzz      01000100 .. 011 111 100 ... ..... .....  @rdm_pg_rn # UQSUBR
+
+#### SVE2 Widening Integer Arithmetic
+
+## SVE2 integer add/subtract long
+
+SADDLB          01000101 .. 0 ..... 00 0000 ..... .....  @rd_rn_rm
+SADDLT          01000101 .. 0 ..... 00 0001 ..... .....  @rd_rn_rm
+UADDLB          01000101 .. 0 ..... 00 0010 ..... .....  @rd_rn_rm
+UADDLT          01000101 .. 0 ..... 00 0011 ..... .....  @rd_rn_rm
+
+SSUBLB          01000101 .. 0 ..... 00 0100 ..... .....  @rd_rn_rm
+SSUBLT          01000101 .. 0 ..... 00 0101 ..... .....  @rd_rn_rm
+USUBLB          01000101 .. 0 ..... 00 0110 ..... .....  @rd_rn_rm
+USUBLT          01000101 .. 0 ..... 00 0111 ..... .....  @rd_rn_rm
+
+SABDLB          01000101 .. 0 ..... 00 1100 ..... .....  @rd_rn_rm
+SABDLT          01000101 .. 0 ..... 00 1101 ..... .....  @rd_rn_rm
+UABDLB          01000101 .. 0 ..... 00 1110 ..... .....  @rd_rn_rm
+UABDLT          01000101 .. 0 ..... 00 1111 ..... .....  @rd_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index d3c7e0e03c..ca39b0f6f1 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1113,6 +1113,49 @@ DO_ZZW(sve_lsl_zzw_s, uint32_t, uint64_t, H1_4, DO_LSL)
 #undef DO_ZPZ
 #undef DO_ZPZ_D
 
+/*
+ * Three-operand expander, unpredicated, in which the two inputs are
+ * selected from the top or bottom half of the wide column.
+ */
+#define DO_ZZZ_TB(NAME, TYPEW, TYPEN, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)          \
+{                                                                       \
+    intptr_t i, opr_sz = simd_oprsz(desc);                              \
+    int sel1 = extract32(desc, SIMD_DATA_SHIFT, 1) * sizeof(TYPEN);     \
+    int sel2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(TYPEN); \
+    for (i = 0; i < opr_sz; i += sizeof(TYPEW)) {                       \
+        TYPEW nn = *(TYPEN *)(vn + HN(i + sel1));                       \
+        TYPEW mm = *(TYPEN *)(vm + HN(i + sel2));                       \
+        *(TYPEW *)(vd + HW(i)) = OP(nn, mm);                            \
+    }                                                                   \
+}
+
+DO_ZZZ_TB(sve2_saddl_h, int16_t, int8_t, H1_2, H1, DO_ADD)
+DO_ZZZ_TB(sve2_saddl_s, int32_t, int16_t, H1_4, H1_2, DO_ADD)
+DO_ZZZ_TB(sve2_saddl_d, int64_t, int32_t,     , H1_4, DO_ADD)
+
+DO_ZZZ_TB(sve2_ssubl_h, int16_t, int8_t, H1_2, H1, DO_SUB)
+DO_ZZZ_TB(sve2_ssubl_s, int32_t, int16_t, H1_4, H1_2, DO_SUB)
+DO_ZZZ_TB(sve2_ssubl_d, int64_t, int32_t,     , H1_4, DO_SUB)
+
+DO_ZZZ_TB(sve2_sabdl_h, int16_t, int8_t, H1_2, H1, DO_ABD)
+DO_ZZZ_TB(sve2_sabdl_s, int32_t, int16_t, H1_4, H1_2, DO_ABD)
+DO_ZZZ_TB(sve2_sabdl_d, int64_t, int32_t,     , H1_4, DO_ABD)
+
+DO_ZZZ_TB(sve2_uaddl_h, uint16_t, uint8_t, H1_2, H1, DO_ADD)
+DO_ZZZ_TB(sve2_uaddl_s, uint32_t, uint16_t, H1_4, H1_2, DO_ADD)
+DO_ZZZ_TB(sve2_uaddl_d, uint64_t, uint32_t,     , H1_4, DO_ADD)
+
+DO_ZZZ_TB(sve2_usubl_h, uint16_t, uint8_t, H1_2, H1, DO_SUB)
+DO_ZZZ_TB(sve2_usubl_s, uint32_t, uint16_t, H1_4, H1_2, DO_SUB)
+DO_ZZZ_TB(sve2_usubl_d, uint64_t, uint32_t,     , H1_4, DO_SUB)
+
+DO_ZZZ_TB(sve2_uabdl_h, uint16_t, uint8_t, H1_2, H1, DO_ABD)
+DO_ZZZ_TB(sve2_uabdl_s, uint32_t, uint16_t, H1_4, H1_2, DO_ABD)
+DO_ZZZ_TB(sve2_uabdl_d, uint64_t, uint32_t,     , H1_4, DO_ABD)
+
+#undef DO_ZZZ_TB
+
 /* Two-operand reduction expander, controlled by a predicate.
  * The difference between TYPERED and TYPERET has to do with
  * sign-extension.  E.g. for SMAX, TYPERED must be signed,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f3e979bfb7..cbbce6a3e2 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5980,3 +5980,49 @@ DO_SVE2_ZPZZ(SQSUB_zpzz, sqsub)
 DO_SVE2_ZPZZ(UQSUB_zpzz, uqsub)
 DO_SVE2_ZPZZ(SUQADD, suqadd)
 DO_SVE2_ZPZZ(USQADD, usqadd)
+
+/*
+ * SVE2 Widening Integer Arithmetic
+ */
+
+static bool do_sve2_zzw_ool(DisasContext *s, arg_rrr_esz *a,
+                            gen_helper_gvec_3 *fn, int data)
+{
+    if (fn == NULL || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, data, fn);
+    }
+    return true;
+}
+
+#define DO_SVE2_ZZZ_TB(NAME, name, SEL1, SEL2) \
+static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)               \
+{                                                                       \
+    static gen_helper_gvec_3 * const fns[4] = {                         \
+        NULL,                       gen_helper_sve2_##name##_h,         \
+        gen_helper_sve2_##name##_s, gen_helper_sve2_##name##_d,         \
+    };                                                                  \
+    return do_sve2_zzw_ool(s, a, fns[a->esz], (SEL2 << 1) | SEL1);      \
+}
+
+DO_SVE2_ZZZ_TB(SADDLB, saddl, false, false)
+DO_SVE2_ZZZ_TB(SSUBLB, ssubl, false, false)
+DO_SVE2_ZZZ_TB(SABDLB, sabdl, false, false)
+
+DO_SVE2_ZZZ_TB(UADDLB, uaddl, false, false)
+DO_SVE2_ZZZ_TB(USUBLB, usubl, false, false)
+DO_SVE2_ZZZ_TB(UABDLB, uabdl, false, false)
+
+DO_SVE2_ZZZ_TB(SADDLT, saddl, true, true)
+DO_SVE2_ZZZ_TB(SSUBLT, ssubl, true, true)
+DO_SVE2_ZZZ_TB(SABDLT, sabdl, true, true)
+
+DO_SVE2_ZZZ_TB(UADDLT, uaddl, true, true)
+DO_SVE2_ZZZ_TB(USUBLT, usubl, true, true)
+DO_SVE2_ZZZ_TB(UABDLT, uabdl, true, true)
-- 
2.25.1



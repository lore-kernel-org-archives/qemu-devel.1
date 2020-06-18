Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5782EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F18217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AHG2zyic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F18217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmO2-0007zs-9s
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmA3-0004iB-TV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:28:27 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmA1-0002Xo-FK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:28:23 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ga6so1968368pjb.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h00R6dVS3F0Sq9dcwfhb98t+34Lf5pTbnE2weSMIic0=;
 b=AHG2zyicp2s8ByAA4twRzZlgjumt/vDJgPZgptIwO4sbuQcnGvsL5F7mOvvFy+yMzP
 WlHFTCkZceWj+zSpQp/Ox/MhBDhfkUUrQT0QJIDULD/+b4MY4iHKWkNIjA0wbyZu9IX6
 U4GB/ObRlfaYPL9TNz7L/TpzPTbsayc566HzVu2+5blqOZOPoiuflPtpZV1rDsX+UqiH
 hlGuRtEB1Uj1a9ucyoTYoEP1BaqktaOqAXy61t+/4p9kMka+fXF4qlbkTS1/6GuYhr7D
 FjSsSyzhgJtILKVx3vzhKn0pFB4OHr1FYL8EEmManLsJQ5KZl/H51tv5weUn3bisZMTa
 YKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h00R6dVS3F0Sq9dcwfhb98t+34Lf5pTbnE2weSMIic0=;
 b=INBcXqGQLIS4rXVdQDzd4exBfBMg7HMFlJvSqteWgXtZYu+fsQ7DBg3DilK4sNFBqf
 BBSog7TUQfZFFunMNwTNYp4ZYAChRRxCPrZyG7/Xdh0R3VW8FBQHglnSJdPktbXhKHPC
 7af/UdZ3+iRFbEGkTUdt6xgHLzBZp4NfqXs4FKzetwf46sdmUzZlpTeoefbufYjrhF7u
 ODYvpbv6fKNESfd5gkJH94RymadYj1iBqIcaFhKqI6VY88M1GSnOBNrhVgKWXqLSm2Sy
 0YUFKRgt9npB8H2cdHl1x2teXBzPGm2eaU67DK/PAKMfsZ7qYUxTaaDiEgNmmEIMGJh0
 InWQ==
X-Gm-Message-State: AOAM532AWDBRNxupmbP4CbDJwVFVaL/BJlaoXvjIeiiTGNS3yn2TqgGO
 TpSxenDZOs92E39Um4W21I+PhCVVOVM=
X-Google-Smtp-Source: ABdhPJwwf4hZD575w8eOBLi3OpVeMMg233W8ImDylpbnePe4lZQKAOiKkabA/DY6kI8UP2K3jqhvTQ==
X-Received: by 2002:a17:902:bc84:: with SMTP id
 bb4mr2242508plb.55.1592454499706; 
 Wed, 17 Jun 2020 21:28:19 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l134sm1154412pga.50.2020.06.17.21.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:28:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 024/100] target/arm: Implement SVE2 integer add/subtract
 long
Date: Wed, 17 Jun 2020 21:25:28 -0700
Message-Id: <20200618042644.1685561-25-richard.henderson@linaro.org>
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
v2: Fix select offsets (laurent desnogues).
---
 target/arm/helper-sve.h    | 24 ++++++++++++++++++++
 target/arm/sve.decode      | 19 ++++++++++++++++
 target/arm/sve_helper.c    | 43 +++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 46 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index be5b0aec5b..d16d85d2d7 100644
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
index 7a287bd8a6..84fc0ade2c 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1162,3 +1162,22 @@ SUQADD          01000100 .. 011 100 100 ... ..... .....  @rdn_pg_rm
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
index ba80d24b21..8653e1ed05 100644
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
index b377abea15..13b3ef1a2c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5536,3 +5536,49 @@ DO_SVE2_ZPZZ(SQSUB_zpzz, sqsub)
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



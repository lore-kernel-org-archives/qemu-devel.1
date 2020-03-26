Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A289AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:15:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6022420714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UC7RaQjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6022420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbiw-0004Tp-G5
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcX-0002cq-8O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcV-0001ee-Mr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:05 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcV-0001dX-H3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id i13so3553621pfe.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6gFXa7U00jC32XzVhB/bZg7gt2oypaZr80DxmsTe9GI=;
 b=UC7RaQjBnyI9Jsd1QHYb4JunreupUSW8ZCngkDpMBSwvQOxyLaqftlmlP5XFuK+nze
 QyGHtHWGh//fU+Qaf5L7e0rY3w0oZ8q+XycCkbTXNsxv0UaDXibcCf2oIaZ5sn5aNUjF
 OO0jKglu9zcYUtZ/AwGqb2IUpR/+V90dtejgWmLQb+ZqRPQaRA+LmBICmqdXJQD9fGvw
 ku4AL7MNAh65IjqrF5lphjGQY/VHQLwHWtCGJ1+etq4UTRmG5jl6LmhneasoxctYHHSI
 e6CEzWtynYSVEOccw4jB9AbUUzZCSGXLBUfWhtcGQ0AbXZOISjPsqrR2M1S3SVyo+hN+
 Qgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6gFXa7U00jC32XzVhB/bZg7gt2oypaZr80DxmsTe9GI=;
 b=WwygLfA/3gaauGV3xEOSn1sWaTUdLjEtSaWMEhEMy3TIpbw5nXMaCalJKFqemL5CjO
 tpiS2i3vAI03cmK4etjasokA8cReCG4KmUhiAzJ+Z8qIF+yaWiYEpxN+FLfB6y2Ir+eh
 Be+ob7Zmpq+i9EWbb9r559wZ19H3r0rs8fVp+CJ6zb1wRmq6qgbAP/zjaMftLZc6fhCq
 21oiqEiTAboOEjli72pW37xX/7ao+UDfMzDeS8LXDjcJTbezK/fEOPCreRzrEZ25GmfB
 NMsiont1iGeeIgk6qNxFiPdNBkCq8kDAGgJ1O2Nzc1hh/AtyW+g8JScs/N1cW5or2mJf
 Njww==
X-Gm-Message-State: ANhLgQ3XEK3QB737IfH40NC2sg1q1qN80uI9jEZ4RVDXlz+TMuBYXuYf
 0WfVlCcTB1FBTHTpF1OxJNLridgH8Hs=
X-Google-Smtp-Source: ADFU+vt56MvLnhu81r+GJWVg0oIEDFWEYDoC9gjAoBVja7kBc+4HtJxVTFlbTqgidp/n1V+XPiBPpQ==
X-Received: by 2002:aa7:9790:: with SMTP id o16mr11614378pfp.322.1585264142088; 
 Thu, 26 Mar 2020 16:09:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/31] target/arm: Implement SVE2 bitwise shift left long
Date: Thu, 26 Mar 2020 16:08:24 -0700
Message-Id: <20200326230838.31112-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  8 +++++++
 target/arm/sve.decode      |  8 +++++++
 target/arm/sve_helper.c    | 34 ++++++++++++++++++++++++++
 target/arm/translate-sve.c | 49 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 943839e2dc..9c0c41ba80 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2372,3 +2372,11 @@ DEF_HELPER_FLAGS_4(sve2_umull_zzz_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sve2_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_pmull_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_sshll_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sshll_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sshll_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_ushll_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_ushll_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_ushll_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 440cff4597..36ef9de563 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1207,3 +1207,11 @@ SMULLB_zzz      01000101 .. 0 ..... 011 100 ..... .....  @rd_rn_rm
 SMULLT_zzz      01000101 .. 0 ..... 011 101 ..... .....  @rd_rn_rm
 UMULLB_zzz      01000101 .. 0 ..... 011 110 ..... .....  @rd_rn_rm
 UMULLT_zzz      01000101 .. 0 ..... 011 111 ..... .....  @rd_rn_rm
+
+## SVE2 bitwise shift left long
+
+# Note bit23 == 0 is handled by esz > 0 in do_sve2_shll_tb.
+SSHLLB          01000101 .. 0 ..... 1010 00 ..... .....  @rd_rn_tszimm_shl
+SSHLLT          01000101 .. 0 ..... 1010 01 ..... .....  @rd_rn_tszimm_shl
+USHLLB          01000101 .. 0 ..... 1010 10 ..... .....  @rd_rn_tszimm_shl
+USHLLT          01000101 .. 0 ..... 1010 11 ..... .....  @rd_rn_tszimm_shl
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 130697f3d9..e0a701c446 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -625,6 +625,8 @@ DO_ZPZZ(sve2_sqrshl_zpzz_h, int16_t, H1_2, do_sqrshl_h)
 DO_ZPZZ(sve2_sqrshl_zpzz_s, int32_t, H1_4, do_sqrshl_s)
 DO_ZPZZ_D(sve2_sqrshl_zpzz_d, int64_t, do_sqrshl_d)
 
+#undef do_sqrshl_d
+
 #define do_uqrshl_b(n, m) \
    ({ uint32_t discard; do_uqrshl_bhs(n, m, 8, true, &discard); })
 #define do_uqrshl_h(n, m) \
@@ -639,6 +641,8 @@ DO_ZPZZ(sve2_uqrshl_zpzz_h, uint16_t, H1_2, do_uqrshl_h)
 DO_ZPZZ(sve2_uqrshl_zpzz_s, uint32_t, H1_4, do_uqrshl_s)
 DO_ZPZZ_D(sve2_uqrshl_zpzz_d, uint64_t, do_uqrshl_d)
 
+#undef do_uqrshl_d
+
 #define DO_HADD_BHS(n, m)  (((int64_t)n + m) >> 1)
 #define DO_HADD_D(n, m)    ((n >> 1) + (m >> 1) + (n & m & 1))
 
@@ -1192,6 +1196,36 @@ DO_ZZZ_WTB(sve2_usubw_d, uint64_t, uint32_t, DO_SUB)
 
 #undef DO_ZZZ_WTB
 
+#define DO_ZZI_SHLL(NAME, TYPE, TYPEN, OP) \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)           \
+{                                                              \
+    intptr_t i, opr_sz = simd_oprsz(desc);                     \
+    int sel = (simd_data(desc) & 1) * sizeof(TYPE);            \
+    int shift = simd_data(desc) >> 1;                          \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {               \
+        TYPE nn = (TYPEN)(*(TYPE *)(vn + i) >> sel);           \
+        *(TYPE *)(vd + i) = OP(nn, shift);                     \
+    }                                                          \
+}
+
+#define DO_SSHLL_H(val, sh)  do_sqrshl_bhs(val, sh, 16, false, NULL)
+#define DO_SSHLL_S(val, sh)  do_sqrshl_bhs(val, sh, 32, false, NULL)
+#define DO_SSHLL_D(val, sh)  do_sqrshl_d(val, sh, false, NULL)
+
+DO_ZZI_SHLL(sve2_sshll_h, int16_t, int8_t, DO_SSHLL_H)
+DO_ZZI_SHLL(sve2_sshll_s, int32_t, int16_t, DO_SSHLL_S)
+DO_ZZI_SHLL(sve2_sshll_d, int64_t, int32_t, DO_SSHLL_D)
+
+#define DO_USHLL_H(val, sh)  do_uqrshl_bhs(val, sh, 16, false, NULL)
+#define DO_USHLL_S(val, sh)  do_uqrshl_bhs(val, sh, 32, false, NULL)
+#define DO_USHLL_D(val, sh)  do_uqrshl_d(val, sh, false, NULL)
+
+DO_ZZI_SHLL(sve2_ushll_h, uint16_t, uint8_t, DO_USHLL_H)
+DO_ZZI_SHLL(sve2_ushll_s, uint32_t, uint16_t, DO_USHLL_S)
+DO_ZZI_SHLL(sve2_ushll_d, uint64_t, uint32_t, DO_USHLL_D)
+
+#undef DO_ZZI_SHLL
+
 /* Two-operand reduction expander, controlled by a predicate.
  * The difference between TYPERED and TYPERET has to do with
  * sign-extension.  E.g. for SMAX, TYPERED must be signed,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 67416a25ce..9873b83feb 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6105,3 +6105,52 @@ DO_SVE2_ZZZ_WTB(UADDWB, uaddw, false)
 DO_SVE2_ZZZ_WTB(UADDWT, uaddw, true)
 DO_SVE2_ZZZ_WTB(USUBWB, usubw, false)
 DO_SVE2_ZZZ_WTB(USUBWT, usubw, true)
+
+static bool do_sve2_shll_tb(DisasContext *s, arg_rri_esz *a,
+                            bool sel, bool uns)
+{
+    static gen_helper_gvec_2 * const fns[2][3] = {
+        { gen_helper_sve2_sshll_h,
+          gen_helper_sve2_sshll_s,
+          gen_helper_sve2_sshll_d },
+        { gen_helper_sve2_ushll_h,
+          gen_helper_sve2_ushll_s,
+          gen_helper_sve2_ushll_d },
+    };
+
+    if (a->esz <= 0 || !dc_isar_feature(aa64_sve2, s)) {
+        /*
+         * For < 0, invalid tsz encoding -- see tszimm_esz.
+         * For = 0, not a widening operation; note this implies bit23 = 0.
+         */
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vsz, vsz, (a->imm << 1) | sel,
+                           fns[uns][a->esz - 1]);
+    }
+    return true;
+}
+
+static bool trans_SSHLLB(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_shll_tb(s, a, false, false);
+}
+
+static bool trans_SSHLLT(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_shll_tb(s, a, true, false);
+}
+
+static bool trans_USHLLB(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_shll_tb(s, a, false, true);
+}
+
+static bool trans_USHLLT(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_shll_tb(s, a, true, true);
+}
-- 
2.20.1



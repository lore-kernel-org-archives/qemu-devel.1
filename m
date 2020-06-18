Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EA7217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iruke6T9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EA7217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmRR-0006Xm-2r
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmAs-0006cm-8I
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:14 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmAq-0002rV-5W
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:13 -0400
Received: by mail-pl1-x643.google.com with SMTP id n9so1921934plk.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P2fu+q0bkter4ohl3pZuETeLPDrFsyFL3xwA8FtOvRo=;
 b=iruke6T9PQgo/qfYGTDJUUBTrFmTtVxFfvj1dm5F1z0KlfMIDmlDfSmIoEVgphWAiz
 v/nfKF1OfzAmul/MNRAkvAempqYWCl1Na1/dIbVao0qM2yQIwayqCV17QfAGpKfW2NUJ
 6Jxs43UyG9glMEbywScz1+3zSzgcw9PgBltEf8ahUBNaY2YXd4nkjRjHQc2fOc2FXr+M
 dlqj5vx1lqDr+lYyKbTyv+0LKmZlTiRDGJ/tu8IkBRr4liWMJNRB9oKNSA9GBBrrErdK
 L1/hARK6LUq3ukZ53YGSsZ3xjj+Ujn5cyxecA8oJMLvREnJdOIa0xpwM//v7eibdKxVB
 UVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P2fu+q0bkter4ohl3pZuETeLPDrFsyFL3xwA8FtOvRo=;
 b=aW8CgykwtzI85PodwTePkTSkRh5coWTQSxTQhovp+SC40LXBZN6vzx9biwb9bdqFhx
 cVz6MNCvhydZNYXbhuVN/02ucgjS1lwopnHDRcYYoEA0EzK43BhkoPHDERz0+SzdS2R7
 Vn1Vk/+i/5hG1v8i5I6Ilx2nrr5HFWDzXjpNGvQjY7vsqdJO0IyDRpsw/AN4YcS/sR52
 VHG7EE1S4trt+gFdCPtQKvChoXSgweXopSgiAkBYmDcGy3A9fBuRLVpqbJevRMaCL3FE
 Qfx1slrOy04CYtoHjBt/j98+CBTpy6xvRcXqtkVazH1L7GFO5PDlOOCxHh/AA1t8eZHB
 VxDg==
X-Gm-Message-State: AOAM531CglxfkRp+Hgsl+BEjLBBGhPpKFu70KLCG843naTu+virIVhMq
 SG4hhmjYHkbnHdoTt4B1XHb+pOO75p8=
X-Google-Smtp-Source: ABdhPJwz0tQjxEBppZQlCmD5h9XLdvInxaPbuXotTVPiUQMm4HdyeTdURd39J5qb7DGy56c0sClyHg==
X-Received: by 2002:a17:902:9e0c:: with SMTP id
 d12mr2130756plq.197.1592454550264; 
 Wed, 17 Jun 2020 21:29:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id mu17sm972324pjb.53.2020.06.17.21.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:29:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 039/100] target/arm: Implement SVE2 saturating extract
 narrow
Date: Wed, 17 Jun 2020 21:25:43 -0700
Message-Id: <20200618042644.1685561-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
 target/arm/helper-sve.h    |  24 ++++
 target/arm/sve.decode      |  12 ++
 target/arm/sve_helper.c    |  56 +++++++++
 target/arm/translate-sve.c | 248 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 335 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index cfd90f83eb..3fff364778 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1931,3 +1931,27 @@ DEF_HELPER_FLAGS_5(sve2_uabal_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_5(sve2_adcl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_adcl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_sqxtnb_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqxtnb_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqxtnb_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_uqxtnb_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqxtnb_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqxtnb_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_sqxtunb_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqxtunb_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqxtunb_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_sqxtnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqxtnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqxtnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_uqxtnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqxtnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqxtnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_sqxtunt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqxtunt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqxtunt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index b5450b1d4d..733f9a3db4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1272,3 +1272,15 @@ SLI             01000101 .. 0 ..... 11110 1 ..... .....  @rd_rn_tszimm_shl
 # TODO: Use @rda and %reg_movprfx here.
 SABA            01000101 .. 0 ..... 11111 0 ..... .....  @rd_rn_rm
 UABA            01000101 .. 0 ..... 11111 1 ..... .....  @rd_rn_rm
+
+#### SVE2 Narrowing
+
+## SVE2 saturating extract narrow
+
+# Bits 23, 18-16 are zero, limited in the translator via esz < 3 & imm == 0.
+SQXTNB          01000101 .. 1 ..... 010 000 ..... .....  @rd_rn_tszimm_shl
+SQXTNT          01000101 .. 1 ..... 010 001 ..... .....  @rd_rn_tszimm_shl
+UQXTNB          01000101 .. 1 ..... 010 010 ..... .....  @rd_rn_tszimm_shl
+UQXTNT          01000101 .. 1 ..... 010 011 ..... .....  @rd_rn_tszimm_shl
+SQXTUNB         01000101 .. 1 ..... 010 100 ..... .....  @rd_rn_tszimm_shl
+SQXTUNT         01000101 .. 1 ..... 010 101 ..... .....  @rd_rn_tszimm_shl
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 184b946a5b..0861fd0277 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1264,6 +1264,62 @@ DO_ZZZW_ACC(sve2_uabal_d, uint64_t, uint32_t,     , H1_4, DO_ABD)
 
 #undef DO_ZZZW_ACC
 
+#define DO_XTNB(NAME, TYPE, OP) \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)         \
+{                                                            \
+    intptr_t i, opr_sz = simd_oprsz(desc);                   \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {             \
+        TYPE nn = *(TYPE *)(vn + i);                         \
+        nn = OP(nn) & MAKE_64BIT_MASK(0, sizeof(TYPE) * 4);  \
+        *(TYPE *)(vd + i) = nn;                              \
+    }                                                        \
+}
+
+#define DO_XTNT(NAME, TYPE, TYPEN, H, OP)                               \
+void HELPER(NAME)(void *vd, void *vn, uint32_t desc)                    \
+{                                                                       \
+    intptr_t i, opr_sz = simd_oprsz(desc), odd = H(sizeof(TYPEN));      \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {                        \
+        TYPE nn = *(TYPE *)(vn + i);                                    \
+        *(TYPEN *)(vd + i + odd) = OP(nn);                              \
+    }                                                                   \
+}
+
+#define DO_SQXTN_H(n)  do_sat_bhs(n, INT8_MIN, INT8_MAX)
+#define DO_SQXTN_S(n)  do_sat_bhs(n, INT16_MIN, INT16_MAX)
+#define DO_SQXTN_D(n)  do_sat_bhs(n, INT32_MIN, INT32_MAX)
+
+DO_XTNB(sve2_sqxtnb_h, int16_t, DO_SQXTN_H)
+DO_XTNB(sve2_sqxtnb_s, int32_t, DO_SQXTN_S)
+DO_XTNB(sve2_sqxtnb_d, int64_t, DO_SQXTN_D)
+
+DO_XTNT(sve2_sqxtnt_h, int16_t, int8_t, H1, DO_SQXTN_H)
+DO_XTNT(sve2_sqxtnt_s, int32_t, int16_t, H1_2, DO_SQXTN_S)
+DO_XTNT(sve2_sqxtnt_d, int64_t, int32_t, H1_4, DO_SQXTN_D)
+
+#define DO_UQXTN_H(n)  do_sat_bhs(n, 0, UINT8_MAX)
+#define DO_UQXTN_S(n)  do_sat_bhs(n, 0, UINT16_MAX)
+#define DO_UQXTN_D(n)  do_sat_bhs(n, 0, UINT32_MAX)
+
+DO_XTNB(sve2_uqxtnb_h, uint16_t, DO_UQXTN_H)
+DO_XTNB(sve2_uqxtnb_s, uint32_t, DO_UQXTN_S)
+DO_XTNB(sve2_uqxtnb_d, uint64_t, DO_UQXTN_D)
+
+DO_XTNT(sve2_uqxtnt_h, uint16_t, uint8_t, H1, DO_UQXTN_H)
+DO_XTNT(sve2_uqxtnt_s, uint32_t, uint16_t, H1_2, DO_UQXTN_S)
+DO_XTNT(sve2_uqxtnt_d, uint64_t, uint32_t, H1_4, DO_UQXTN_D)
+
+DO_XTNB(sve2_sqxtunb_h, int16_t, DO_UQXTN_H)
+DO_XTNB(sve2_sqxtunb_s, int32_t, DO_UQXTN_S)
+DO_XTNB(sve2_sqxtunb_d, int64_t, DO_UQXTN_D)
+
+DO_XTNT(sve2_sqxtunt_h, int16_t, int8_t, H1, DO_UQXTN_H)
+DO_XTNT(sve2_sqxtunt_s, int32_t, int16_t, H1_2, DO_UQXTN_S)
+DO_XTNT(sve2_sqxtunt_d, int64_t, int32_t, H1_4, DO_UQXTN_D)
+
+#undef DO_XTNB
+#undef DO_XTNT
+
 void HELPER(sve2_adcl_s)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 45b24826ac..d71228fe5a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5759,22 +5759,22 @@ static void gen_ushll_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t imm)
 static bool do_sve2_shll_tb(DisasContext *s, arg_rri_esz *a,
                             bool sel, bool uns)
 {
-    static const TCGOpcode sshll_list[] = { 
+    static const TCGOpcode sshll_list[] = {
         INDEX_op_shli_vec, INDEX_op_sari_vec, 0
     };
-    static const TCGOpcode ushll_list[] = { 
+    static const TCGOpcode ushll_list[] = {
         INDEX_op_shli_vec, INDEX_op_shri_vec, 0
     };
     static const GVecGen2i ops[2][3] = {
-        { { .fniv = gen_sshll_vec, 
+        { { .fniv = gen_sshll_vec,
             .opt_opc = sshll_list,
             .fno = gen_helper_sve2_sshll_h,
             .vece = MO_16 },
-          { .fniv = gen_sshll_vec, 
+          { .fniv = gen_sshll_vec,
             .opt_opc = sshll_list,
             .fno = gen_helper_sve2_sshll_s,
             .vece = MO_32 },
-          { .fniv = gen_sshll_vec, 
+          { .fniv = gen_sshll_vec,
             .opt_opc = sshll_list,
             .fno = gen_helper_sve2_sshll_d,
             .vece = MO_64 } },
@@ -6025,3 +6025,241 @@ static bool trans_UABA(DisasContext *s, arg_rrr_esz *a)
 {
     return do_sve2_fn_zzz(s, a, gen_gvec_uaba);
 }
+
+static bool do_sve2_narrow_extract(DisasContext *s, arg_rri_esz *a,
+                                   const GVecGen2 ops[3])
+{
+    if (a->esz < 0 || a->esz > MO_32 || a->imm != 0 ||
+        !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2(vec_full_reg_offset(s, a->rd),
+                        vec_full_reg_offset(s, a->rn),
+                        vsz, vsz, &ops[a->esz]);
+    }
+    return true;
+}
+
+static const TCGOpcode sqxtn_list[] = {
+    INDEX_op_shli_vec, INDEX_op_smin_vec, INDEX_op_smax_vec, 0
+};
+
+static void gen_sqxtnb_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+    int64_t mask = (1ull << halfbits) - 1;
+    int64_t min = -1ull << (halfbits - 1);
+    int64_t max = -min - 1;
+
+    tcg_gen_dupi_vec(vece, t, min);
+    tcg_gen_smax_vec(vece, d, n, t);
+    tcg_gen_dupi_vec(vece, t, max);
+    tcg_gen_smin_vec(vece, d, d, t);
+    tcg_gen_dupi_vec(vece, t, mask);
+    tcg_gen_and_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_SQXTNB(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2 ops[3] = {
+        { .fniv = gen_sqxtnb_vec,
+          .opt_opc = sqxtn_list,
+          .fno = gen_helper_sve2_sqxtnb_h,
+          .vece = MO_16 },
+        { .fniv = gen_sqxtnb_vec,
+          .opt_opc = sqxtn_list,
+          .fno = gen_helper_sve2_sqxtnb_s,
+          .vece = MO_32 },
+        { .fniv = gen_sqxtnb_vec,
+          .opt_opc = sqxtn_list,
+          .fno = gen_helper_sve2_sqxtnb_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_narrow_extract(s, a, ops);
+}
+
+static void gen_sqxtnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+    int64_t mask = (1ull << halfbits) - 1;
+    int64_t min = -1ull << (halfbits - 1);
+    int64_t max = -min - 1;
+
+    tcg_gen_dupi_vec(vece, t, min);
+    tcg_gen_smax_vec(vece, n, n, t);
+    tcg_gen_dupi_vec(vece, t, max);
+    tcg_gen_smin_vec(vece, n, n, t);
+    tcg_gen_shli_vec(vece, n, n, halfbits);
+    tcg_gen_dupi_vec(vece, t, mask);
+    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_SQXTNT(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2 ops[3] = {
+        { .fniv = gen_sqxtnt_vec,
+          .opt_opc = sqxtn_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_sqxtnt_h,
+          .vece = MO_16 },
+        { .fniv = gen_sqxtnt_vec,
+          .opt_opc = sqxtn_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_sqxtnt_s,
+          .vece = MO_32 },
+        { .fniv = gen_sqxtnt_vec,
+          .opt_opc = sqxtn_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_sqxtnt_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_narrow_extract(s, a, ops);
+}
+
+static const TCGOpcode uqxtn_list[] = {
+    INDEX_op_shli_vec, INDEX_op_umin_vec, 0
+};
+
+static void gen_uqxtnb_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+    int64_t max = (1ull << halfbits) - 1;
+
+    tcg_gen_dupi_vec(vece, t, max);
+    tcg_gen_umin_vec(vece, d, n, t);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_UQXTNB(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2 ops[3] = {
+        { .fniv = gen_uqxtnb_vec,
+          .opt_opc = uqxtn_list,
+          .fno = gen_helper_sve2_uqxtnb_h,
+          .vece = MO_16 },
+        { .fniv = gen_uqxtnb_vec,
+          .opt_opc = uqxtn_list,
+          .fno = gen_helper_sve2_uqxtnb_s,
+          .vece = MO_32 },
+        { .fniv = gen_uqxtnb_vec,
+          .opt_opc = uqxtn_list,
+          .fno = gen_helper_sve2_uqxtnb_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_narrow_extract(s, a, ops);
+}
+
+static void gen_uqxtnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+    int64_t max = (1ull << halfbits) - 1;
+
+    tcg_gen_dupi_vec(vece, t, max);
+    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_shli_vec(vece, n, n, halfbits);
+    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_UQXTNT(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2 ops[3] = {
+        { .fniv = gen_uqxtnt_vec,
+          .opt_opc = uqxtn_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_uqxtnt_h,
+          .vece = MO_16 },
+        { .fniv = gen_uqxtnt_vec,
+          .opt_opc = uqxtn_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_uqxtnt_s,
+          .vece = MO_32 },
+        { .fniv = gen_uqxtnt_vec,
+          .opt_opc = uqxtn_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_uqxtnt_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_narrow_extract(s, a, ops);
+}
+
+static const TCGOpcode sqxtun_list[] = {
+    INDEX_op_shli_vec, INDEX_op_umin_vec, INDEX_op_smax_vec, 0
+};
+
+static void gen_sqxtunb_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+    int64_t max = (1ull << halfbits) - 1;
+
+    tcg_gen_dupi_vec(vece, t, 0);
+    tcg_gen_smax_vec(vece, d, n, t);
+    tcg_gen_dupi_vec(vece, t, max);
+    tcg_gen_umin_vec(vece, d, d, t);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_SQXTUNB(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2 ops[3] = {
+        { .fniv = gen_sqxtunb_vec,
+          .opt_opc = sqxtun_list,
+          .fno = gen_helper_sve2_sqxtunb_h,
+          .vece = MO_16 },
+        { .fniv = gen_sqxtunb_vec,
+          .opt_opc = sqxtun_list,
+          .fno = gen_helper_sve2_sqxtunb_s,
+          .vece = MO_32 },
+        { .fniv = gen_sqxtunb_vec,
+          .opt_opc = sqxtun_list,
+          .fno = gen_helper_sve2_sqxtunb_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_narrow_extract(s, a, ops);
+}
+
+static void gen_sqxtunt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+    int64_t max = (1ull << halfbits) - 1;
+
+    tcg_gen_dupi_vec(vece, t, 0);
+    tcg_gen_smax_vec(vece, d, n, t);
+    tcg_gen_dupi_vec(vece, t, max);
+    tcg_gen_umin_vec(vece, d, d, t);
+    tcg_gen_shli_vec(vece, n, n, halfbits);
+    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_SQXTUNT(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2 ops[3] = {
+        { .fniv = gen_sqxtunt_vec,
+          .opt_opc = sqxtun_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_sqxtunt_h,
+          .vece = MO_16 },
+        { .fniv = gen_sqxtunt_vec,
+          .opt_opc = sqxtun_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_sqxtunt_s,
+          .vece = MO_32 },
+        { .fniv = gen_sqxtunt_vec,
+          .opt_opc = sqxtun_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_sqxtunt_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_narrow_extract(s, a, ops);
+}
-- 
2.25.1



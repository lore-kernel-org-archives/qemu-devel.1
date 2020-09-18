Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C80C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F80821D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWb2PWZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F80821D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMRq-0003rI-GZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLID-00019q-LW
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:33 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI7-0007H6-RA
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:33 -0400
Received: by mail-pf1-x442.google.com with SMTP id b124so3979312pfg.13
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EL2EE96fcJ4VPdkqktR5iGr09g3MJ0ZNNIfN1LzNyPw=;
 b=pWb2PWZ/y58gDWTwmtUfT0uUIo6Zrg8B+baEEpeAAJhq4d6ZScn0g9HpxUL/vMbKt5
 TyzISfpwLPSEetTXpzjIvuAIbDjC24QIDn44lWcOrtelayvAIUF7urbLMNB0iOzG4SUf
 sgneTx9aVQnZ30xOOAK8eqcM9HyuatTfQF2NXhgB8NrUxfW419IHtv6eYSXZGQaQtT/P
 aaz4cceY3infUNU5dLjWY5YWW0Pmq+H5yFrGWkePLdc+pnx+4TST5Adau4NHk+Sr7/9M
 SBr083ON6M9uQxcAGu37keE4YtabHaGeXPNTPRiASZbgNJYLpdG0/VjzP2d6rWN5bxcm
 vBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EL2EE96fcJ4VPdkqktR5iGr09g3MJ0ZNNIfN1LzNyPw=;
 b=OVxtQ3iwVgbcivfDFeOXTNDa0Q47yt0vU8pAD8kA94gapF5+GQUNPJlmQnwAMyDf66
 W6JRBuVJpDXcoeRM4o53G1GqW8v+DjYmW7cCp/7JsmZOURvW9JAZd34fUldfL5zAxtOW
 W9kvhdS7mlObMO/yqdEwUoAztrNvCtfFaQIQStTx3LbTq+ErawQk/yfT7KZfpuf6K2pg
 j5X0VCRuP3eUp79sp48JGY5qc0o5U8vISnYMIucxd2wIZj3afI28ZB8P9QrGupO1ats1
 MjztG3awOOluUCB02EvPUhk08tsLYZ0JMVzBh3bKj+6zhWcC/0Uwz5pqc9OWapS3Rjjl
 SwaQ==
X-Gm-Message-State: AOAM533W3phplWAMDT0xZNAvWssEvoqwU5d7I//T9o5bmTj4OPnkcIcA
 8wFTHn8+2yYkyZrGM+OzAjfu3TpZLPwJMw==
X-Google-Smtp-Source: ABdhPJzr2epTQuX43U9d8TFRvNKch2ch0OS9dwogYUg0jVZh/dTQ4G28eLImCoOyQOvYsgCgWl2uhg==
X-Received: by 2002:a62:2c09:0:b029:142:2501:34f8 with SMTP id
 s9-20020a622c090000b0290142250134f8mr17057257pfs.81.1600454366034; 
 Fri, 18 Sep 2020 11:39:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 70/81] target/arm: Implement SVE2 TBL, TBX
Date: Fri, 18 Sep 2020 11:37:40 -0700
Message-Id: <20200918183751.2787647-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200428144352.9275-1-steplong@quicinc.com>
[rth: rearrange the macros a little and rebase]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 10 +++++
 target/arm/sve.decode      |  5 +++
 target/arm/sve_helper.c    | 90 ++++++++++++++++++++++++++++++--------
 target/arm/translate-sve.c | 33 ++++++++++++++
 4 files changed, 119 insertions(+), 19 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 671b3a8804..b46723ebe3 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -661,6 +661,16 @@ DEF_HELPER_FLAGS_4(sve_tbl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_tbl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_tbl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_tbl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_tbl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_tbl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_tbl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_tbx_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_tbx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_tbx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_tbx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sve_sunpk_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_sunpk_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_sunpk_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5f2fad4754..609ecce520 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -560,6 +560,11 @@ TBL             00000101 .. 1 ..... 001100 ..... .....          @rd_rn_rm
 # SVE unpack vector elements
 UNPK            00000101 esz:2 1100 u:1 h:1 001110 rn:5 rd:5
 
+# SVE2 Table Lookup (three sources)
+
+TBL_sve2        00000101 .. 1 ..... 001010 ..... .....          @rd_rn_rm
+TBX             00000101 .. 1 ..... 001011 ..... .....          @rd_rn_rm
+
 ### SVE Permute - Predicates Group
 
 # SVE permute predicate elements
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b2f24d5cfd..e651c0e9f1 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3034,28 +3034,80 @@ void HELPER(sve_rev_d)(void *vd, void *vn, uint32_t desc)
     }
 }
 
-#define DO_TBL(NAME, TYPE, H) \
-void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
-{                                                              \
-    intptr_t i, opr_sz = simd_oprsz(desc);                     \
-    uintptr_t elem = opr_sz / sizeof(TYPE);                    \
-    TYPE *d = vd, *n = vn, *m = vm;                            \
-    ARMVectorReg tmp;                                          \
-    if (unlikely(vd == vn)) {                                  \
-        n = memcpy(&tmp, vn, opr_sz);                          \
-    }                                                          \
-    for (i = 0; i < elem; i++) {                               \
-        TYPE j = m[H(i)];                                      \
-        d[H(i)] = j < elem ? n[H(j)] : 0;                      \
-    }                                                          \
+typedef void tb_impl_fn(void *, void *, void *, void *, uintptr_t, bool);
+
+static inline void do_tbl1(void *vd, void *vn, void *vm, uint32_t desc,
+                           bool is_tbx, tb_impl_fn *fn)
+{
+    ARMVectorReg scratch;
+    uintptr_t oprsz = simd_oprsz(desc);
+
+    if (unlikely(vd == vn)) {
+        vn = memcpy(&scratch, vn, oprsz);
+    }
+
+    fn(vd, vn, NULL, vm, oprsz, is_tbx);
 }
 
-DO_TBL(sve_tbl_b, uint8_t, H1)
-DO_TBL(sve_tbl_h, uint16_t, H2)
-DO_TBL(sve_tbl_s, uint32_t, H4)
-DO_TBL(sve_tbl_d, uint64_t, )
+static inline void do_tbl2(void *vd, void *vn0, void *vn1, void *vm,
+                           uint32_t desc, bool is_tbx, tb_impl_fn *fn)
+{
+    ARMVectorReg scratch;
+    uintptr_t oprsz = simd_oprsz(desc);
 
-#undef TBL
+    if (unlikely(vd == vn0)) {
+        vn0 = memcpy(&scratch, vn0, oprsz);
+        if (vd == vn1) {
+            vn1 = vn0;
+        }
+    } else if (unlikely(vd == vn1)) {
+        vn1 = memcpy(&scratch, vn1, oprsz);
+    }
+
+    fn(vd, vn0, vn1, vm, oprsz, is_tbx);
+}
+
+#define DO_TB(SUFF, TYPE, H)                                            \
+static inline void do_tb_##SUFF(void *vd, void *vt0, void *vt1,         \
+                                void *vm, uintptr_t oprsz, bool is_tbx) \
+{                                                                       \
+    TYPE *d = vd, *tbl0 = vt0, *tbl1 = vt1, *indexes = vm;              \
+    uintptr_t i, nelem = oprsz / sizeof(TYPE);                          \
+    for (i = 0; i < nelem; ++i) {                                       \
+        TYPE index = indexes[H1(i)], val = 0;                           \
+        if (index < nelem) {                                            \
+            val = tbl0[H(index)];                                       \
+        } else {                                                        \
+            index -= nelem;                                             \
+            if (tbl1 && index < nelem) {                                \
+                val = tbl1[H(index)];                                   \
+            } else if (is_tbx) {                                        \
+                continue;                                               \
+            }                                                           \
+        }                                                               \
+        d[H(i)] = val;                                                  \
+    }                                                                   \
+}                                                                       \
+void HELPER(sve_tbl_##SUFF)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                                       \
+    do_tbl1(vd, vn, vm, desc, false, do_tb_##SUFF);                     \
+}                                                                       \
+void HELPER(sve2_tbl_##SUFF)(void *vd, void *vn0, void *vn1,            \
+                             void *vm, uint32_t desc)                   \
+{                                                                       \
+    do_tbl2(vd, vn0, vn1, vm, desc, false, do_tb_##SUFF);               \
+}                                                                       \
+void HELPER(sve2_tbx_##SUFF)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                                       \
+    do_tbl1(vd, vn, vm, desc, true, do_tb_##SUFF);                      \
+}
+
+DO_TB(b, uint8_t, H1)
+DO_TB(h, uint16_t, H2)
+DO_TB(s, uint32_t, H4)
+DO_TB(d, uint64_t,   )
+
+#undef DO_TB
 
 #define DO_UNPK(NAME, TYPED, TYPES, HD, HS) \
 void HELPER(NAME)(void *vd, void *vn, uint32_t desc)           \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index cb493d838d..e8fef28750 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2417,6 +2417,39 @@ static bool trans_TBL(DisasContext *s, arg_rrr_esz *a)
     return true;
 }
 
+static bool trans_TBL_sve2(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_4 * const fns[4] = {
+        gen_helper_sve2_tbl_b, gen_helper_sve2_tbl_h,
+        gen_helper_sve2_tbl_s, gen_helper_sve2_tbl_d
+    };
+
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_ool_zzzz(s, fns[a->esz], a->rd, a->rn,
+                          (a->rn + 1) % 32, a->rm, 0);
+    }
+    return true;
+}
+
+static bool trans_TBX(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_tbx_b, gen_helper_sve2_tbx_h,
+        gen_helper_sve2_tbx_s, gen_helper_sve2_tbx_d
+    };
+
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_ool_zzz(s, fns[a->esz], a->rd, a->rn, a->rm, 0);
+    }
+    return true;
+}
+
 static bool trans_UNPK(DisasContext *s, arg_UNPK *a)
 {
     static gen_helper_gvec_2 * const fns[4][2] = {
-- 
2.25.1



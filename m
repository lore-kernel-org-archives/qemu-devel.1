Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD169C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5399721534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+U70K9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5399721534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLa9-0002qI-50
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLH9-0008OZ-0K
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:27 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLH6-00076w-SS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:26 -0400
Received: by mail-pg1-x544.google.com with SMTP id 67so3961252pgd.12
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XoAuPYstkxIPHMjsuTl0OhwsFdxzci4ZF6atqOZrAS0=;
 b=M+U70K9GGYgXGutulYLqbnyxz6r419vFY8pkw6ycvFsRQPr0siGdAgDKLbhlIdojnL
 q6HXRTL1WBDsihUNwycinJ7pcsF3S9tp0zGK4vzenvzN5xiRU/Dz8ekC5Y5MpyEd/xt/
 FyfVwzoZL5VJZWXS8xcBfu3Qwc+pGS17pdesGD0Xu4adbO4Kjsz9d1TEOKXuV39MxWiz
 U6NRkCu14rgHkePhN2XltxHToeuswrTc4AIO9zXSDylgD+mrDBHZYDIZpC4FxU6p+Res
 ukSgqgVAhAsWJWrQXEiE15L45YxnJ8DuJRn9YrD6vgan135uywkXxPaNGlYVp6vsJB1w
 DWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XoAuPYstkxIPHMjsuTl0OhwsFdxzci4ZF6atqOZrAS0=;
 b=XsUUo/Gx7tN5P2CdH6T0V4q74GwsUp8AI/ivIIRAf90EdVpb3hDvwrIv5P88Mv2eGT
 MGA0fFy2F7yS0JYvGhCBcjTLtwRvnD81HB1XW/s8QixKn+p3rtRSRyBsaNupJ07qK3Xi
 K0wijRFuorwdWeR/9ieLhgA7n5RdABF+Q1M5iTpLE66nFrV16yO5IlEuLgypVQqEL//U
 KFOIkRzS/92p5LMUIO0mAfgkMMD//N8xzahiUvg5xhYxIrq7oD7bF5n8U+8jbrPXfcnz
 I/LQY0yunzMPQy5qKbgYJ6RbwfjTqbZPVLfCV/Yn1FBRG/ZUpejm3HMQui352gwcSOLB
 NxTA==
X-Gm-Message-State: AOAM531XCNmuT9tGPdllRl9ppjAKAxeQ73xai9tUyJkA55svuJGv+wCK
 iPFCt8pHgrY7RzbUMjIvdqfzGSAikaGgbg==
X-Google-Smtp-Source: ABdhPJy28XsVQeLigDRc0OPqpJswlWcUqc+NMHqenSJFEY+0Va5xoTLFxy3masR+KtSJVnWUrsLSXA==
X-Received: by 2002:a63:c5b:: with SMTP id 27mr13066794pgm.80.1600454302881;
 Fri, 18 Sep 2020 11:38:22 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 22/81] target/arm: Implement SVE2 integer absolute
 difference and accumulate long
Date: Fri, 18 Sep 2020 11:36:52 -0700
Message-Id: <20200918183751.2787647-23-richard.henderson@linaro.org>
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
v2: Fix select offsetting and argument order (laurent desnogues).
---
 target/arm/helper-sve.h    | 14 ++++++++++
 target/arm/sve.decode      | 12 +++++++++
 target/arm/sve_helper.c    | 23 ++++++++++++++++
 target/arm/translate-sve.c | 55 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index b399fb2576..d5dfd4edea 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2402,3 +2402,17 @@ DEF_HELPER_FLAGS_4(sve2_sqcadd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqcadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqcadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqcadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sabal_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sabal_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sabal_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_uabal_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uabal_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uabal_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 655cb5c12f..6cf09847a0 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -70,6 +70,7 @@
 &rpr_s          rd pg rn s
 &rprr_s         rd pg rn rm s
 &rprr_esz       rd pg rn rm esz
+&rrrr_esz       rd ra rn rm esz
 &rprrr_esz      rd pg rn rm ra esz
 &rpri_esz       rd pg rn imm esz
 &ptrue          rd esz pat s
@@ -119,6 +120,10 @@
 @rdn_i8s        ........ esz:2 ...... ... imm:s8 rd:5 \
                 &rri_esz rn=%reg_movprfx
 
+# Four operand, vector element size
+@rda_rn_rm      ........ esz:2 . rm:5 ... ... rn:5 rd:5 \
+                &rrrr_esz ra=%reg_movprfx
+
 # Three operand with "memory" size, aka immediate left shift
 @rd_rn_msz_rm   ........ ... rm:5 .... imm:2 rn:5 rd:5          &rrri
 
@@ -1235,3 +1240,10 @@ CADD_rot90      01000101 .. 00000 0 11011 0 ..... .....  @rdn_rm
 CADD_rot270     01000101 .. 00000 0 11011 1 ..... .....  @rdn_rm
 SQCADD_rot90    01000101 .. 00000 1 11011 0 ..... .....  @rdn_rm
 SQCADD_rot270   01000101 .. 00000 1 11011 1 ..... .....  @rdn_rm
+
+## SVE2 integer absolute difference and accumulate long
+
+SABALB          01000101 .. 0 ..... 1100 00 ..... .....  @rda_rn_rm
+SABALT          01000101 .. 0 ..... 1100 01 ..... .....  @rda_rn_rm
+UABALB          01000101 .. 0 ..... 1100 10 ..... .....  @rda_rn_rm
+UABALT          01000101 .. 0 ..... 1100 11 ..... .....  @rda_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b8541168bf..cc8450c44e 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1241,6 +1241,29 @@ DO_ZZZ_NTB(sve2_eoril_d, uint64_t,     , DO_EOR)
 
 #undef DO_ZZZ_NTB
 
+#define DO_ZZZW_ACC(NAME, TYPEW, TYPEN, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    intptr_t sel1 = simd_data(desc) * sizeof(TYPEN);            \
+    for (i = 0; i < opr_sz; i += sizeof(TYPEW)) {               \
+        TYPEW nn = *(TYPEN *)(vn + HN(i + sel1));               \
+        TYPEW mm = *(TYPEN *)(vm + HN(i + sel1));               \
+        TYPEW aa = *(TYPEW *)(va + HW(i));                      \
+        *(TYPEW *)(vd + HW(i)) = OP(nn, mm) + aa;               \
+    }                                                           \
+}
+
+DO_ZZZW_ACC(sve2_sabal_h, int16_t, int8_t, H1_2, H1, DO_ABD)
+DO_ZZZW_ACC(sve2_sabal_s, int32_t, int16_t, H1_4, H1_2, DO_ABD)
+DO_ZZZW_ACC(sve2_sabal_d, int64_t, int32_t,     , H1_4, DO_ABD)
+
+DO_ZZZW_ACC(sve2_uabal_h, uint16_t, uint8_t, H1_2, H1, DO_ABD)
+DO_ZZZW_ACC(sve2_uabal_s, uint32_t, uint16_t, H1_4, H1_2, DO_ABD)
+DO_ZZZW_ACC(sve2_uabal_d, uint64_t, uint32_t,     , H1_4, DO_ABD)
+
+#undef DO_ZZZW_ACC
+
 #define DO_BITPERM(NAME, TYPE, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 95a81eb101..7b3720e8ef 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -163,6 +163,18 @@ static void gen_gvec_ool_zzz(DisasContext *s, gen_helper_gvec_3 *fn,
                        vsz, vsz, data, fn);
 }
 
+/* Invoke an out-of-line helper on 4 Zregs. */
+static void gen_gvec_ool_zzzz(DisasContext *s, gen_helper_gvec_4 *fn,
+                              int rd, int rn, int rm, int ra, int data)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       vec_full_reg_offset(s, ra),
+                       vsz, vsz, data, fn);
+}
+
 /* Invoke an out-of-line helper on 2 Zregs and a predicate. */
 static void gen_gvec_ool_zzp(DisasContext *s, gen_helper_gvec_3 *fn,
                              int rd, int rn, int pg, int data)
@@ -6326,3 +6338,46 @@ static bool trans_SQCADD_rot270(DisasContext *s, arg_rrr_esz *a)
 {
     return do_cadd(s, a, true, true);
 }
+
+static bool do_sve2_zzzz_ool(DisasContext *s, arg_rrrr_esz *a,
+                             gen_helper_gvec_4 *fn, int data)
+{
+    if (fn == NULL || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_ool_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, data);
+    }
+    return true;
+}
+
+static bool do_abal(DisasContext *s, arg_rrrr_esz *a, bool uns, bool sel)
+{
+    static gen_helper_gvec_4 * const fns[2][4] = {
+        { NULL,                    gen_helper_sve2_sabal_h,
+          gen_helper_sve2_sabal_s, gen_helper_sve2_sabal_d },
+        { NULL,                    gen_helper_sve2_uabal_h,
+          gen_helper_sve2_uabal_s, gen_helper_sve2_uabal_d },
+    };
+    return do_sve2_zzzz_ool(s, a, fns[uns][a->esz], sel);
+}
+
+static bool trans_SABALB(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_abal(s, a, false, false);
+}
+
+static bool trans_SABALT(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_abal(s, a, false, true);
+}
+
+static bool trans_UABALB(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_abal(s, a, true, false);
+}
+
+static bool trans_UABALT(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_abal(s, a, true, true);
+}
-- 
2.25.1



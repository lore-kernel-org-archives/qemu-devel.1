Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D4CC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:26:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C069522208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZuYZr4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C069522208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJM23-0001a5-VI
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHK-0000LM-0e
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:38 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHG-000793-On
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id f2so3990380pgd.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sw3fn0l1rQhTFIrGVphb8kkMpbmZh0rgVNt+StOMsvU=;
 b=rZuYZr4PtyjCIVZnT5OT69edQLdxT/ZuDmKUvVuLOGM+IjeJatHK1Y2FuBhOryXG2O
 a6n5fbqarRCtusN5AXthxZpXG89+abgHYaf3kKKWVPJRZGcG/WmeMiep8r2XSPJmW1XF
 XpZqETfgmNFPS1v/k5U5oWAWPOE8lurINxTvwb96kIl8AHxXximmhn2bCCEtXNeDvX+m
 AB49Ht4+x5tHjSqAzSMElS1PbQPr5Ruw0B2vSFxx0y7iT0r+iAiUblmbJDKIWm9cngoi
 idU4fk3tX/Vn/+SeaUyjWitqZ7abtxDp2+GkGGtPU/XvpNiMV3FLxHoPno6qXtR4q9Si
 yK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sw3fn0l1rQhTFIrGVphb8kkMpbmZh0rgVNt+StOMsvU=;
 b=Nui3Ot9i3/t1VNmc7yYggOqtOJsD8zAa0EROF6+YcqaivP8kwVnAoPVRH/8Rq2F/+U
 Zd68NKUvztVw3DXTFo3NQL0WDID5Icf5P2IoobguNiFaKhJiNkvHckKv+SV414sJg/fB
 CkgJ5so8YWyQk+7H0mv2ohkAnPFDQUYVaAS8UkTcF1BfW4wELvErxpyPM2Xk5w1LOmvX
 cKzcXUZGi4IrLrgMMAw0wr07D9oO4MI+jAkXGevgybn/ILSrt534srGuWFbhMHn2Y8zQ
 qCF0jhujDWhpfShZPk3cMESyBDco+EBq/Wi6tIkxSOVD4I1zThzPgaqZDVkocNTPgoho
 1hMg==
X-Gm-Message-State: AOAM532tkfSnP9AIMNAm2nr58T+U3uCWdLTrx6wYswOhdkEpozkBD4HB
 XrMvgFBpFN3mnVAMlktpSAZo6z6M0XIY8Q==
X-Google-Smtp-Source: ABdhPJyrBEKXnUhxc2JJOKfaP5y1AX21Gb+BkZdVybR/ovZP0jBTR3vCSe9dfcR4eS4jnzfAXxjnSA==
X-Received: by 2002:aa7:99c2:0:b029:142:440b:fa28 with SMTP id
 v2-20020aa799c20000b0290142440bfa28mr14540611pfi.30.1600454313028; 
 Fri, 18 Sep 2020 11:38:33 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/81] target/arm: Implement SVE2 SQSHRUN, SQRSHRUN
Date: Fri, 18 Sep 2020 11:37:00 -0700
Message-Id: <20200918183751.2787647-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
 target/arm/helper-sve.h    | 16 +++++++
 target/arm/sve.decode      |  4 ++
 target/arm/sve_helper.c    | 35 ++++++++++++++
 target/arm/translate-sve.c | 98 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index f4bf3f9a40..8ca99b5c3c 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2460,6 +2460,22 @@ DEF_HELPER_FLAGS_3(sve2_rshrnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_rshrnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_rshrnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sve2_sqshrunb_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqshrunb_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqshrunb_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_sqshrunt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqshrunt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqshrunt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_sqrshrunb_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqrshrunb_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqrshrunb_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_sqrshrunt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqrshrunt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_sqrshrunt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 7cc4b6cc43..cade628cfd 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1288,6 +1288,10 @@ SQXTUNT         01000101 .. 1 ..... 010 101 ..... .....  @rd_rn_tszimm_shl
 ## SVE2 bitwise shift right narrow
 
 # Bit 23 == 0 is handled by esz > 0 in the translator.
+SQSHRUNB        01000101 .. 1 ..... 00 0000 ..... .....  @rd_rn_tszimm_shr
+SQSHRUNT        01000101 .. 1 ..... 00 0001 ..... .....  @rd_rn_tszimm_shr
+SQRSHRUNB       01000101 .. 1 ..... 00 0010 ..... .....  @rd_rn_tszimm_shr
+SQRSHRUNT       01000101 .. 1 ..... 00 0011 ..... .....  @rd_rn_tszimm_shr
 SHRNB           01000101 .. 1 ..... 00 0100 ..... .....  @rd_rn_tszimm_shr
 SHRNT           01000101 .. 1 ..... 00 0101 ..... .....  @rd_rn_tszimm_shr
 RSHRNB          01000101 .. 1 ..... 00 0110 ..... .....  @rd_rn_tszimm_shr
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 27907ed1a5..df324f0498 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1873,6 +1873,16 @@ static inline uint64_t do_urshr(uint64_t x, unsigned sh)
     }
 }
 
+static inline int64_t do_srshr(int64_t x, unsigned sh)
+{
+    if (likely(sh < 64)) {
+        return (x >> sh) + ((x >> (sh - 1)) & 1);
+    } else {
+        /* Rounding the sign bit always produces 0. */
+        return 0;
+    }
+}
+
 DO_ZPZI(sve_asr_zpzi_b, int8_t, H1, DO_SHR)
 DO_ZPZI(sve_asr_zpzi_h, int16_t, H1_2, DO_SHR)
 DO_ZPZI(sve_asr_zpzi_s, int32_t, H1_4, DO_SHR)
@@ -1935,6 +1945,31 @@ DO_SHRNT(sve2_rshrnt_h, uint16_t, uint8_t, H1_2, H1, do_urshr)
 DO_SHRNT(sve2_rshrnt_s, uint32_t, uint16_t, H1_4, H1_2, do_urshr)
 DO_SHRNT(sve2_rshrnt_d, uint64_t, uint32_t,     , H1_4, do_urshr)
 
+#define DO_SQSHRUN_H(x, sh) do_sat_bhs((int64_t)(x) >> sh, 0, UINT8_MAX)
+#define DO_SQSHRUN_S(x, sh) do_sat_bhs((int64_t)(x) >> sh, 0, UINT16_MAX)
+#define DO_SQSHRUN_D(x, sh) \
+    do_sat_bhs((int64_t)(x) >> (sh < 64 ? sh : 63), 0, UINT32_MAX)
+
+DO_SHRNB(sve2_sqshrunb_h, int16_t, uint8_t, DO_SQSHRUN_H)
+DO_SHRNB(sve2_sqshrunb_s, int32_t, uint16_t, DO_SQSHRUN_S)
+DO_SHRNB(sve2_sqshrunb_d, int64_t, uint32_t, DO_SQSHRUN_D)
+
+DO_SHRNT(sve2_sqshrunt_h, int16_t, uint8_t, H1_2, H1, DO_SQSHRUN_H)
+DO_SHRNT(sve2_sqshrunt_s, int32_t, uint16_t, H1_4, H1_2, DO_SQSHRUN_S)
+DO_SHRNT(sve2_sqshrunt_d, int64_t, uint32_t,     , H1_4, DO_SQSHRUN_D)
+
+#define DO_SQRSHRUN_H(x, sh) do_sat_bhs(do_srshr(x, sh), 0, UINT8_MAX)
+#define DO_SQRSHRUN_S(x, sh) do_sat_bhs(do_srshr(x, sh), 0, UINT16_MAX)
+#define DO_SQRSHRUN_D(x, sh) do_sat_bhs(do_srshr(x, sh), 0, UINT32_MAX)
+
+DO_SHRNB(sve2_sqrshrunb_h, int16_t, uint8_t, DO_SQRSHRUN_H)
+DO_SHRNB(sve2_sqrshrunb_s, int32_t, uint16_t, DO_SQRSHRUN_S)
+DO_SHRNB(sve2_sqrshrunb_d, int64_t, uint32_t, DO_SQRSHRUN_D)
+
+DO_SHRNT(sve2_sqrshrunt_h, int16_t, uint8_t, H1_2, H1, DO_SQRSHRUN_H)
+DO_SHRNT(sve2_sqrshrunt_s, int32_t, uint16_t, H1_4, H1_2, DO_SQRSHRUN_S)
+DO_SHRNT(sve2_sqrshrunt_d, int64_t, uint32_t,     , H1_4, DO_SQRSHRUN_D)
+
 #undef DO_SHRNB
 #undef DO_SHRNT
 
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ad31066296..3751544e95 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6868,6 +6868,104 @@ static bool trans_RSHRNT(DisasContext *s, arg_rri_esz *a)
     return do_sve2_shr_narrow(s, a, ops);
 }
 
+static void gen_sqshrunb_vec(unsigned vece, TCGv_vec d,
+                             TCGv_vec n, int64_t shr)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+
+    tcg_gen_sari_vec(vece, n, n, shr);
+    tcg_gen_dupi_vec(vece, t, 0);
+    tcg_gen_smax_vec(vece, n, n, t);
+    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
+    tcg_gen_umin_vec(vece, d, n, t);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_SQSHRUNB(DisasContext *s, arg_rri_esz *a)
+{
+    static const TCGOpcode vec_list[] = {
+        INDEX_op_sari_vec, INDEX_op_smax_vec, INDEX_op_umin_vec, 0
+    };
+    static const GVecGen2i ops[3] = {
+        { .fniv = gen_sqshrunb_vec,
+          .opt_opc = vec_list,
+          .fno = gen_helper_sve2_sqshrunb_h,
+          .vece = MO_16 },
+        { .fniv = gen_sqshrunb_vec,
+          .opt_opc = vec_list,
+          .fno = gen_helper_sve2_sqshrunb_s,
+          .vece = MO_32 },
+        { .fniv = gen_sqshrunb_vec,
+          .opt_opc = vec_list,
+          .fno = gen_helper_sve2_sqshrunb_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_shr_narrow(s, a, ops);
+}
+
+static void gen_sqshrunt_vec(unsigned vece, TCGv_vec d,
+                             TCGv_vec n, int64_t shr)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+
+    tcg_gen_sari_vec(vece, n, n, shr);
+    tcg_gen_dupi_vec(vece, t, 0);
+    tcg_gen_smax_vec(vece, n, n, t);
+    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
+    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_shli_vec(vece, n, n, halfbits);
+    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_SQSHRUNT(DisasContext *s, arg_rri_esz *a)
+{
+    static const TCGOpcode vec_list[] = {
+        INDEX_op_shli_vec, INDEX_op_sari_vec,
+        INDEX_op_smax_vec, INDEX_op_umin_vec, 0
+    };
+    static const GVecGen2i ops[3] = {
+        { .fniv = gen_sqshrunt_vec,
+          .opt_opc = vec_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_sqshrunt_h,
+          .vece = MO_16 },
+        { .fniv = gen_sqshrunt_vec,
+          .opt_opc = vec_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_sqshrunt_s,
+          .vece = MO_32 },
+        { .fniv = gen_sqshrunt_vec,
+          .opt_opc = vec_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_sqshrunt_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_shr_narrow(s, a, ops);
+}
+
+static bool trans_SQRSHRUNB(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2i ops[3] = {
+        { .fno = gen_helper_sve2_sqrshrunb_h },
+        { .fno = gen_helper_sve2_sqrshrunb_s },
+        { .fno = gen_helper_sve2_sqrshrunb_d },
+    };
+    return do_sve2_shr_narrow(s, a, ops);
+}
+
+static bool trans_SQRSHRUNT(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2i ops[3] = {
+        { .fno = gen_helper_sve2_sqrshrunt_h },
+        { .fno = gen_helper_sve2_sqrshrunt_s },
+        { .fno = gen_helper_sve2_sqrshrunt_d },
+    };
+    return do_sve2_shr_narrow(s, a, ops);
+}
+
 static bool do_sve2_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
                             gen_helper_gvec_4_ptr *fn)
 {
-- 
2.25.1



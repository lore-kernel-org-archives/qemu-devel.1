Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42113C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBBF2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fALb17rR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBBF2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmWh-000144-AG
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmBS-0008Jw-7R
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:41196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmBQ-0002vA-E6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id y17so1903052plb.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v34eE94sfWfwyVAx0ktD5v8kg14QIRjqD4a5YuKEJKQ=;
 b=fALb17rRtqEKN2BIVGkdkuxmYaLd/Gt7Dd5KMiHnrk3/2ScaMWo6fk/UmkKB7Yoa7U
 S8LGHK/DufE9aseXoDmGM1r7St68w1mI2oePmQtO8Iw2gHYdQT8LAprzW1L8I+0TEZNh
 X3CjmNTxMZpodJ9ojyiwMrDk9VWDsSsdHqLE2my363EZURmh0xBRrvPNfE2h0/uaMe5q
 IKf6/h2ZzCBFTf57ukUzunWu9DSMMJ2m6XGcmmMrflOdt0YISV65743/p6Vb67ilqFvu
 QCDHXysRDOSXbW4/2ckwYpOSZ0pGRkLsJAcZvZY3Vr0nC20AVN73cllrekCEYi+2zB9m
 rk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v34eE94sfWfwyVAx0ktD5v8kg14QIRjqD4a5YuKEJKQ=;
 b=etR8g3H0RYOJeat5/OZrS3YRU97yZHjUvv1VYwH5ZnlwC6JdFKWneLiRbvLfE0FQ9h
 R2L7rnh8LYlfW2C3wC8WIM3llQbrXV5JWumUTLIsjCagae7FlZdSGu0s/vkQIYqvCMBJ
 Rvp1ZpKTEd+Wy7VLBtaSIA7gxdwdbh3kfAkxXhpFNU0JCgsbYWOhBRxdZcWtbFnGnyiC
 qHTpiPo3V+DrSYikf/x+t1r4TPIurr/SWobqBN5OcqTbTmLP8Y/xcsYCrCLP+S8xP9IP
 yqBnXaLdmLX1h4qhnN3eZ5TPLo1ofOA0BH53lweBY4r4bboczViWJwMM5neqPs/MfRX5
 gH9g==
X-Gm-Message-State: AOAM532W5uD6wNQVZeHoIxEDv3pELVdIxuQ/T9Kr/eMBj3j71Btawlop
 fZ+MjyLxuDf9KsaY66nzpIcxHoVTOzs=
X-Google-Smtp-Source: ABdhPJycEtIrvuBdnsbwe1pv9029x+VwyvmeNn4NIFFX6RJsWN7361TOMF52UpRjvrTcppE75eRktw==
X-Received: by 2002:a17:90b:4c91:: with SMTP id
 my17mr2140569pjb.81.1592454586378; 
 Wed, 17 Jun 2020 21:29:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id j17sm1157899pgk.66.2020.06.17.21.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:29:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 043/100] target/arm: Implement SVE2 UQSHRN, UQRSHRN
Date: Wed, 17 Jun 2020 21:25:47 -0700
Message-Id: <20200618042644.1685561-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/arm/helper-sve.h    | 16 +++++++
 target/arm/sve.decode      |  4 ++
 target/arm/sve_helper.c    | 24 ++++++++++
 target/arm/translate-sve.c | 93 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 371a1b02e0..3fbee352d8 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1988,6 +1988,22 @@ DEF_HELPER_FLAGS_3(sve2_sqrshrunt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_sqrshrunt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_sqrshrunt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sve2_uqshrnb_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqshrnb_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqshrnb_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_uqshrnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqshrnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqshrnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_uqrshrnb_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqrshrnb_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqrshrnb_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sve2_uqrshrnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqrshrnt_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve2_uqrshrnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index cade628cfd..69915398e7 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1296,6 +1296,10 @@ SHRNB           01000101 .. 1 ..... 00 0100 ..... .....  @rd_rn_tszimm_shr
 SHRNT           01000101 .. 1 ..... 00 0101 ..... .....  @rd_rn_tszimm_shr
 RSHRNB          01000101 .. 1 ..... 00 0110 ..... .....  @rd_rn_tszimm_shr
 RSHRNT          01000101 .. 1 ..... 00 0111 ..... .....  @rd_rn_tszimm_shr
+UQSHRNB         01000101 .. 1 ..... 00 1100 ..... .....  @rd_rn_tszimm_shr
+UQSHRNT         01000101 .. 1 ..... 00 1101 ..... .....  @rd_rn_tszimm_shr
+UQRSHRNB        01000101 .. 1 ..... 00 1110 ..... .....  @rd_rn_tszimm_shr
+UQRSHRNT        01000101 .. 1 ..... 00 1111 ..... .....  @rd_rn_tszimm_shr
 
 ## SVE2 floating-point pairwise operations
 
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 01c717e27e..bc2130f77e 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1950,6 +1950,30 @@ DO_SHRNT(sve2_sqrshrunt_h, int16_t, uint8_t, H1_2, H1, DO_SQRSHRUN_H)
 DO_SHRNT(sve2_sqrshrunt_s, int32_t, uint16_t, H1_4, H1_2, DO_SQRSHRUN_S)
 DO_SHRNT(sve2_sqrshrunt_d, int64_t, uint32_t,     , H1_4, DO_SQRSHRUN_D)
 
+#define DO_UQSHRN_H(x, sh) MIN(x >> sh, UINT8_MAX)
+#define DO_UQSHRN_S(x, sh) MIN(x >> sh, UINT16_MAX)
+#define DO_UQSHRN_D(x, sh) MIN(x >> sh, UINT32_MAX)
+
+DO_SHRNB(sve2_uqshrnb_h, uint16_t, uint8_t, DO_UQSHRN_H)
+DO_SHRNB(sve2_uqshrnb_s, uint32_t, uint16_t, DO_UQSHRN_S)
+DO_SHRNB(sve2_uqshrnb_d, uint64_t, uint32_t, DO_UQSHRN_D)
+
+DO_SHRNT(sve2_uqshrnt_h, uint16_t, uint8_t, H1_2, H1, DO_UQSHRN_H)
+DO_SHRNT(sve2_uqshrnt_s, uint32_t, uint16_t, H1_4, H1_2, DO_UQSHRN_S)
+DO_SHRNT(sve2_uqshrnt_d, uint64_t, uint32_t,     , H1_4, DO_UQSHRN_D)
+
+#define DO_UQRSHRN_H(x, sh) MIN(DO_RSHR(x, sh), UINT8_MAX)
+#define DO_UQRSHRN_S(x, sh) MIN(DO_RSHR(x, sh), UINT16_MAX)
+#define DO_UQRSHRN_D(x, sh) MIN(DO_RSHR(x, sh), UINT32_MAX)
+
+DO_SHRNB(sve2_uqrshrnb_h, uint16_t, uint8_t, DO_UQRSHRN_H)
+DO_SHRNB(sve2_uqrshrnb_s, uint32_t, uint16_t, DO_UQRSHRN_S)
+DO_SHRNB(sve2_uqrshrnb_d, uint64_t, uint32_t, DO_UQRSHRN_D)
+
+DO_SHRNT(sve2_uqrshrnt_h, uint16_t, uint8_t, H1_2, H1, DO_UQRSHRN_H)
+DO_SHRNT(sve2_uqrshrnt_s, uint32_t, uint16_t, H1_4, H1_2, DO_UQRSHRN_S)
+DO_SHRNT(sve2_uqrshrnt_d, uint64_t, uint32_t,     , H1_4, DO_UQRSHRN_D)
+
 #undef DO_SHRNB
 #undef DO_SHRNT
 
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7e89d7b9a8..5234f25eef 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6522,6 +6522,99 @@ static bool trans_SQRSHRUNT(DisasContext *s, arg_rri_esz *a)
     return do_sve2_shr_narrow(s, a, ops);
 }
 
+static void gen_uqshrnb_vec(unsigned vece, TCGv_vec d,
+                            TCGv_vec n, int64_t shr)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+
+    tcg_gen_shri_vec(vece, n, n, shr);
+    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
+    tcg_gen_umin_vec(vece, d, n, t);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_UQSHRNB(DisasContext *s, arg_rri_esz *a)
+{
+    static const TCGOpcode vec_list[] = {
+        INDEX_op_shri_vec, INDEX_op_umin_vec, 0
+    };
+    static const GVecGen2i ops[3] = {
+        { .fniv = gen_uqshrnb_vec,
+          .opt_opc = vec_list,
+          .fno = gen_helper_sve2_uqshrnb_h,
+          .vece = MO_16 },
+        { .fniv = gen_uqshrnb_vec,
+          .opt_opc = vec_list,
+          .fno = gen_helper_sve2_uqshrnb_s,
+          .vece = MO_32 },
+        { .fniv = gen_uqshrnb_vec,
+          .opt_opc = vec_list,
+          .fno = gen_helper_sve2_uqshrnb_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_shr_narrow(s, a, ops);
+}
+
+static void gen_uqshrnt_vec(unsigned vece, TCGv_vec d,
+                            TCGv_vec n, int64_t shr)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    int halfbits = 4 << vece;
+
+    tcg_gen_shri_vec(vece, n, n, shr);
+    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
+    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_shli_vec(vece, n, n, halfbits);
+    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_temp_free_vec(t);
+}
+
+static bool trans_UQSHRNT(DisasContext *s, arg_rri_esz *a)
+{
+    static const TCGOpcode vec_list[] = {
+        INDEX_op_shli_vec, INDEX_op_shri_vec, INDEX_op_umin_vec, 0
+    };
+    static const GVecGen2i ops[3] = {
+        { .fniv = gen_uqshrnt_vec,
+          .opt_opc = vec_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_uqshrnt_h,
+          .vece = MO_16 },
+        { .fniv = gen_uqshrnt_vec,
+          .opt_opc = vec_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_uqshrnt_s,
+          .vece = MO_32 },
+        { .fniv = gen_uqshrnt_vec,
+          .opt_opc = vec_list,
+          .load_dest = true,
+          .fno = gen_helper_sve2_uqshrnt_d,
+          .vece = MO_64 },
+    };
+    return do_sve2_shr_narrow(s, a, ops);
+}
+
+static bool trans_UQRSHRNB(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2i ops[3] = {
+        { .fno = gen_helper_sve2_uqrshrnb_h },
+        { .fno = gen_helper_sve2_uqrshrnb_s },
+        { .fno = gen_helper_sve2_uqrshrnb_d },
+    };
+    return do_sve2_shr_narrow(s, a, ops);
+}
+
+static bool trans_UQRSHRNT(DisasContext *s, arg_rri_esz *a)
+{
+    static const GVecGen2i ops[3] = {
+        { .fno = gen_helper_sve2_uqrshrnt_h },
+        { .fno = gen_helper_sve2_uqrshrnt_s },
+        { .fno = gen_helper_sve2_uqrshrnt_d },
+    };
+    return do_sve2_shr_narrow(s, a, ops);
+}
+
 static bool do_sve2_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
                             gen_helper_gvec_4_ptr *fn)
 {
-- 
2.25.1



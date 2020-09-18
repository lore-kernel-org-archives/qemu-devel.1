Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9DC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8771B208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mq+5oxtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8771B208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJM2y-0002wb-MG
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIO-0001NZ-Rw
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:46 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:45991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLII-0007JQ-13
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:44 -0400
Received: by mail-pg1-x52b.google.com with SMTP id 67so3962894pgd.12
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ot4ZSaRqcI5khQZrBXNt0ZSLnRQc4wVu31DCD3bP540=;
 b=mq+5oxtBogkuL1a/YMae3ZZ3R5/PhVuE1l+1T0swgmE+1OO2RXATXF2yNC8ABSJubC
 Mb8XNdlqkdxkA5QruqVkAnMikIKUuc2qeQZa5WpNmMQcUtKvpVqA0n8MPhKTcnznjxN7
 jIiaheLgounOiJ8Ns/iO44P0T0P0G4vWOFXRQ0M8ZDD8dkoXqQ0fLNCPYps02t7Id594
 cC8oBvMRApyHUGga0ems1yRy44ELkGBndsiNR7Fe7T0SQ5woiTKnXqXFpFZNCNfu2fjz
 /DxaD/WyX/TnUlQF3R6kB/yOD065l3RpzaBgEWiJerGY8zqbYWD/KkgO8o4Pjo3o3vX9
 81Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ot4ZSaRqcI5khQZrBXNt0ZSLnRQc4wVu31DCD3bP540=;
 b=CoqJ/j0Djp1qSrsi8S1ImOi514OTkvRTzA9xbG9V7QIbfYaBys8ytklfchkXM1l/rt
 N7an4xVz2l2THXKs4N3P07WvdrYKXgHuOnB4DVKPXbMqyHiG+eqn6WiKOM4F5T3AAGO2
 JsO0+wW8NUQP2UVg9r8EDVXlwTRGV9TXqSdFRCdI2sgL3YFU4654lJHX/aSQUsXRz/GK
 /m/BbYj+pptofrvqwzRcYtJgEDOTCL4c2jGRbhdYy765KTn+5OBHN8pXa6KZEO4uMt2e
 xiSjGEoo0hsDckp+6UojBdQKZtaY7vnWGZoGcUF+Rs4MbTbKOK06uVUBHY2SrVdlk2WD
 G1HQ==
X-Gm-Message-State: AOAM533/tzIh11bMiPisWv3p6w/wJ3IK1msmkjO0hRGaepA3Q18D6BdE
 3XxrMHWSGimPm3z7s7aws5pNdnMW5GKC8w==
X-Google-Smtp-Source: ABdhPJxHQQlzLc1CdEs7XZ8vQufxmQSKKKHMicg74UBF2q5fqN3D/blTpuYbfuctG8pGfNB2FoVOjw==
X-Received: by 2002:aa7:87da:0:b029:13c:1611:66bf with SMTP id
 i26-20020aa787da0000b029013c161166bfmr33485895pfo.10.1600454376200; 
 Fri, 18 Sep 2020 11:39:36 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 77/81] target/arm: Implement 128-bit ZIP, UZP, TRN
Date: Fri, 18 Sep 2020 11:37:47 -0700
Message-Id: <20200918183751.2787647-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
 target/arm/helper-sve.h    |  3 ++
 target/arm/sve.decode      |  8 ++++++
 target/arm/sve_helper.c    | 29 +++++++++++++------
 target/arm/translate-sve.c | 58 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index f25b403ddb..feed23bbd1 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -689,16 +689,19 @@ DEF_HELPER_FLAGS_4(sve_zip_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_zip_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_zip_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_zip_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_zip_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sve_uzp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_uzp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_uzp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_uzp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uzp_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sve_trn_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_trn_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sve_compact_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_compact_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index e0d093c5d7..4e21274dc4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -592,6 +592,14 @@ UZP2_z          00000101 .. 1 ..... 011 011 ..... .....         @rd_rn_rm
 TRN1_z          00000101 .. 1 ..... 011 100 ..... .....         @rd_rn_rm
 TRN2_z          00000101 .. 1 ..... 011 101 ..... .....         @rd_rn_rm
 
+# SVE2 permute vector segments
+ZIP1_q          00000101 10 1 ..... 000 000 ..... .....         @rd_rn_rm_e0
+ZIP2_q          00000101 10 1 ..... 000 001 ..... .....         @rd_rn_rm_e0
+UZP1_q          00000101 10 1 ..... 000 010 ..... .....         @rd_rn_rm_e0
+UZP2_q          00000101 10 1 ..... 000 011 ..... .....         @rd_rn_rm_e0
+TRN1_q          00000101 10 1 ..... 000 110 ..... .....         @rd_rn_rm_e0
+TRN2_q          00000101 10 1 ..... 000 111 ..... .....         @rd_rn_rm_e0
+
 ### SVE Permute - Predicated Group
 
 # SVE compress active elements
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index dc51cb75fc..12d21dcd65 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3457,36 +3457,45 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)       \
         *(TYPE *)(vd + H(2 * i + 0)) = *(TYPE *)(vn + H(i));         \
         *(TYPE *)(vd + H(2 * i + sizeof(TYPE))) = *(TYPE *)(vm + H(i)); \
     }                                                                \
+    if (sizeof(TYPE) == 16 && unlikely(oprsz & 16)) {                \
+        memset(vd + oprsz - 16, 0, 16);                              \
+    }                                                                \
 }
 
 DO_ZIP(sve_zip_b, uint8_t, H1)
 DO_ZIP(sve_zip_h, uint16_t, H1_2)
 DO_ZIP(sve_zip_s, uint32_t, H1_4)
 DO_ZIP(sve_zip_d, uint64_t, )
+DO_ZIP(sve2_zip_q, Int128, )
 
 #define DO_UZP(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)         \
 {                                                                      \
     intptr_t oprsz = simd_oprsz(desc);                                 \
-    intptr_t oprsz_2 = oprsz / 2;                                      \
     intptr_t odd_ofs = simd_data(desc);                                \
-    intptr_t i;                                                        \
+    intptr_t i, p;                                                     \
     ARMVectorReg tmp_m;                                                \
     if (unlikely((vm - vd) < (uintptr_t)oprsz)) {                      \
         vm = memcpy(&tmp_m, vm, oprsz);                                \
     }                                                                  \
-    for (i = 0; i < oprsz_2; i += sizeof(TYPE)) {                      \
-        *(TYPE *)(vd + H(i)) = *(TYPE *)(vn + H(2 * i + odd_ofs));     \
-    }                                                                  \
-    for (i = 0; i < oprsz_2; i += sizeof(TYPE)) {                      \
-        *(TYPE *)(vd + H(oprsz_2 + i)) = *(TYPE *)(vm + H(2 * i + odd_ofs)); \
-    }                                                                  \
+    i = 0, p = odd_ofs;                                                \
+    do {                                                               \
+        *(TYPE *)(vd + H(i)) = *(TYPE *)(vn + H(p));                   \
+        i += sizeof(TYPE), p += 2 * sizeof(TYPE);                      \
+    } while (p < oprsz);                                               \
+    p -= oprsz;                                                        \
+    do {                                                               \
+        *(TYPE *)(vd + H(i)) = *(TYPE *)(vm + H(p));                   \
+        i += sizeof(TYPE), p += 2 * sizeof(TYPE);                      \
+    } while (p < oprsz);                                               \
+    tcg_debug_assert(i == oprsz);                                      \
 }
 
 DO_UZP(sve_uzp_b, uint8_t, H1)
 DO_UZP(sve_uzp_h, uint16_t, H1_2)
 DO_UZP(sve_uzp_s, uint32_t, H1_4)
 DO_UZP(sve_uzp_d, uint64_t, )
+DO_UZP(sve2_uzp_q, Int128, )
 
 #define DO_TRN(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)         \
@@ -3500,12 +3509,16 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)         \
         *(TYPE *)(vd + H(i + 0)) = ae;                                 \
         *(TYPE *)(vd + H(i + sizeof(TYPE))) = be;                      \
     }                                                                  \
+    if (sizeof(TYPE) == 16 && unlikely(oprsz & 16)) {                  \
+        memset(vd + oprsz - 16, 0, 16);                                \
+    }                                                                  \
 }
 
 DO_TRN(sve_trn_b, uint8_t, H1)
 DO_TRN(sve_trn_h, uint16_t, H1_2)
 DO_TRN(sve_trn_s, uint32_t, H1_4)
 DO_TRN(sve_trn_d, uint64_t, )
+DO_TRN(sve2_trn_q, Int128, )
 
 #undef DO_ZIP
 #undef DO_UZP
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7c6a6a3bda..214788ea23 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2633,6 +2633,32 @@ static bool trans_ZIP2_z(DisasContext *s, arg_rrr_esz *a)
     return do_zip(s, a, true);
 }
 
+static bool do_zip_q(DisasContext *s, arg_rrr_esz *a, bool high)
+{
+    if (!dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        unsigned high_ofs = high ? QEMU_ALIGN_DOWN(vsz, 32) / 2 : 0;
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn) + high_ofs,
+                           vec_full_reg_offset(s, a->rm) + high_ofs,
+                           vsz, vsz, 0, gen_helper_sve2_zip_q);
+    }
+    return true;
+}
+
+static bool trans_ZIP1_q(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_zip_q(s, a, false);
+}
+
+static bool trans_ZIP2_q(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_zip_q(s, a, true);
+}
+
 static gen_helper_gvec_3 * const uzp_fns[4] = {
     gen_helper_sve_uzp_b, gen_helper_sve_uzp_h,
     gen_helper_sve_uzp_s, gen_helper_sve_uzp_d,
@@ -2648,6 +2674,22 @@ static bool trans_UZP2_z(DisasContext *s, arg_rrr_esz *a)
     return do_zzz_data_ool(s, a, 1 << a->esz, uzp_fns[a->esz]);
 }
 
+static bool trans_UZP1_q(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+    return do_zzz_data_ool(s, a, 0, gen_helper_sve2_uzp_q);
+}
+
+static bool trans_UZP2_q(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+    return do_zzz_data_ool(s, a, 16, gen_helper_sve2_uzp_q);
+}
+
 static gen_helper_gvec_3 * const trn_fns[4] = {
     gen_helper_sve_trn_b, gen_helper_sve_trn_h,
     gen_helper_sve_trn_s, gen_helper_sve_trn_d,
@@ -2663,6 +2705,22 @@ static bool trans_TRN2_z(DisasContext *s, arg_rrr_esz *a)
     return do_zzz_data_ool(s, a, 1 << a->esz, trn_fns[a->esz]);
 }
 
+static bool trans_TRN1_q(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+    return do_zzz_data_ool(s, a, 0, gen_helper_sve2_trn_q);
+}
+
+static bool trans_TRN2_q(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2_f64mm, s)) {
+        return false;
+    }
+    return do_zzz_data_ool(s, a, 16, gen_helper_sve2_trn_q);
+}
+
 /*
  *** SVE Permute Vector - Predicated Group
  */
-- 
2.25.1



Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10991C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBA821852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lryj6QBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBA821852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmnz-0000i8-1s
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDr-00053b-6E
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:19 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:38761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDj-0003RL-M1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:18 -0400
Received: by mail-pl1-x62e.google.com with SMTP id d10so15950pls.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ev18dZLP4j/+zxonxhFSbcIdROPJZQRzZNa1PGjpD1k=;
 b=Lryj6QBWlUbYu23UKLwLqxrs5Zh0VJP+Ng9F02c0xQuJWbK4/Wz7lFn2OcW2H+tv+z
 onGScFRW8VzKHmZfjElgaHSDgc/5d73h8X2aGIbpMnL4KfpTfdBBfupxLi9Kz14zaBDY
 gBe0oGvYzZe9xnmNDkjOMQdRZ2gqKc4Sydpi1qqAiPQWbx2MV2i6uSrKLfqOHhFjGpLV
 KxZYDdh0TB3uvbgfrzjJookLW8twEkmsO+eHJkDSC1K9fj8JYcUHt6yW0HTckbZVQSli
 ywAXw4x9zzGtwSniyVh7VfDDWnH18HKgAG3g4ruOKMEH9w5OZNx+eoSoUN9QnDnnc4Gt
 GZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ev18dZLP4j/+zxonxhFSbcIdROPJZQRzZNa1PGjpD1k=;
 b=mrWBwdDLVODZR1/QKYIyhqZ9ZF/K52eAHnp5CoXncghp4p6e4nxXMQKxIV/9aHsAap
 bK6T0LR++VdsLrltNjpgfWnsl9MN0ieeU/c0nyWRw4TCV71KLp2fSa/DfnQjecos+U/7
 gkCuyP8p9Y1stbXwDZ6TqdW7W3fqXaH5rbQPg68i3OOuslhaO88WLR/f0avGuyL9NLSx
 lAyfhkKFr2znrpFDUPvkRjr1yukbzQtshLY/7u/3y2fevlZ4MSgywWVgVlA3Agxu6FPG
 QoDDsd0HWrDisLKMTNY0ol8ahKbelz3CFpAT+odc/te4h5yQ2BiIxmesXDaU+K1tp8t+
 viLg==
X-Gm-Message-State: AOAM530XqgThiqcHbaTmwMLBrNiYx0NazcV0rYIgzOwkexyu6zToKd9w
 NI4GdjGeDTeh+ExilRom0O7qn7Mv9ro=
X-Google-Smtp-Source: ABdhPJyOwt1i3Ac/m9yZ9RI5emOpBXyAfPWyY7lwWDpjNzzvo+idAiFW6puqRiHkupkvj5PuzfY6Vw==
X-Received: by 2002:a17:90b:19c4:: with SMTP id
 nm4mr2484881pjb.66.1592454724297; 
 Wed, 17 Jun 2020 21:32:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s15sm1162840pgv.5.2020.06.17.21.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:32:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 077/100] target/arm: Implement SVE2 integer multiply long
 (indexed)
Date: Wed, 17 Jun 2020 21:26:21 -0700
Message-Id: <20200618042644.1685561-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/arm/helper-sve.h    |  5 +++++
 target/arm/sve.decode      | 16 ++++++++++++++++
 target/arm/sve_helper.c    | 23 +++++++++++++++++++++++
 target/arm/translate-sve.c | 24 ++++++++++++++++++++----
 4 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 08210b2c66..91cce85f17 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2200,3 +2200,8 @@ DEF_HELPER_FLAGS_5(sve2_sqdmlsl_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqdmlsl_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_smull_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_smull_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_umull_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_umull_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 36cdd9dab4..f0a4d86428 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -257,6 +257,12 @@
 @rrx_d          ........ 11 . index:1 rm:4 ...... rn:5 rd:5 \
                 &rrx_esz esz=3
 
+# Two registers and a scalar by index, wide
+@rrxl_s         ........ 10 ... rm:3 ...... rn:5 rd:5 \
+                &rrx_esz index=%index3_19_11 esz=2
+@rrxl_d         ........ 11 ..  rm:4 ...... rn:5 rd:5 \
+                &rrx_esz index=%index2_20_11 esz=3
+
 # Three registers and a scalar by index
 @rrxr_h         ........ 0. . ..      rm:3 ...... rn:5 rd:5 \
                 &rrxr_esz ra=%reg_movprfx index=%index3_22_19 esz=1
@@ -819,6 +825,16 @@ SQDMLSLB_zzxw_d 01000100 .. 1 ..... 0011.0 ..... .....          @rrxw_d
 SQDMLSLT_zzxw_s 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_s
 SQDMLSLT_zzxw_d 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_d
 
+# SVE2 integer multiply long (indexed)
+SMULLB_zzx_s    01000100 .. 1 ..... 1100.0 ..... .....          @rrxl_s
+SMULLB_zzx_d    01000100 .. 1 ..... 1100.0 ..... .....          @rrxl_d
+SMULLT_zzx_s    01000100 .. 1 ..... 1100.1 ..... .....          @rrxl_s
+SMULLT_zzx_d    01000100 .. 1 ..... 1100.1 ..... .....          @rrxl_d
+UMULLB_zzx_s    01000100 .. 1 ..... 1101.0 ..... .....          @rrxl_s
+UMULLB_zzx_d    01000100 .. 1 ..... 1101.0 ..... .....          @rrxl_d
+UMULLT_zzx_s    01000100 .. 1 ..... 1101.1 ..... .....          @rrxl_s
+UMULLT_zzx_d    01000100 .. 1 ..... 1101.1 ..... .....          @rrxl_d
+
 # SVE2 integer multiply (indexed)
 MUL_zzx_h       01000100 .. 1 ..... 111110 ..... .....          @rrx_h
 MUL_zzx_s       01000100 .. 1 ..... 111110 ..... .....          @rrx_s
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 32f5d1d790..4aff792345 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1560,6 +1560,29 @@ DO_ZZXW(sve2_sqdmlsl_idx_d, int64_t, int32_t,     , H1_4, DO_SQDMLSL_D)
 
 #undef DO_ZZXW
 
+#define DO_ZZX(NAME, TYPEW, TYPEN, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)            \
+{                                                                         \
+    intptr_t i, j, oprsz = simd_oprsz(desc);                              \
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1) * sizeof(TYPEN);   \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 1, 3);               \
+    for (i = 0; i < oprsz; i += 16) {                                     \
+        TYPEW mm = *(TYPEN *)(vm + i + idx);                              \
+        for (j = 0; j < 16; j += sizeof(TYPEW)) {                         \
+            TYPEW nn = *(TYPEN *)(vn + HN(i + j + sel));                  \
+            *(TYPEW *)(vd + HW(i + j)) = OP(nn, mm);                      \
+        }                                                                 \
+    }                                                                     \
+}
+
+DO_ZZX(sve2_smull_idx_s, int32_t, int16_t, H1_4, H1_2, DO_MUL)
+DO_ZZX(sve2_smull_idx_d, int64_t, int32_t,     , H1_4, DO_MUL)
+
+DO_ZZX(sve2_umull_idx_s, uint32_t, uint16_t, H1_4, H1_2, DO_MUL)
+DO_ZZX(sve2_umull_idx_d, uint64_t, uint32_t,     , H1_4, DO_MUL)
+
+#undef DO_ZZX
+
 #define DO_BITPERM(NAME, TYPE, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 61e59f369f..d8bb877ba5 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3844,8 +3844,8 @@ DO_RRXR(trans_UDOT_zzxw_d, gen_helper_gvec_udot_idx_h)
 
 #undef DO_RRXR
 
-static bool do_sve2_zzx_ool(DisasContext *s, arg_rrx_esz *a,
-                            gen_helper_gvec_3 *fn)
+static bool do_sve2_zzx_data(DisasContext *s, arg_rrx_esz *a,
+                             gen_helper_gvec_3 *fn, int data)
 {
     if (fn == NULL || !dc_isar_feature(aa64_sve2, s)) {
         return false;
@@ -3855,14 +3855,14 @@ static bool do_sve2_zzx_ool(DisasContext *s, arg_rrx_esz *a,
         tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
                            vec_full_reg_offset(s, a->rn),
                            vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, a->index, fn);
+                           vsz, vsz, data, fn);
     }
     return true;
 }
 
 #define DO_SVE2_RRX(NAME, FUNC) \
     static bool NAME(DisasContext *s, arg_rrx_esz *a)  \
-    { return do_sve2_zzx_ool(s, a, FUNC); }
+    { return do_sve2_zzx_data(s, a, FUNC, a->index); }
 
 DO_SVE2_RRX(trans_MUL_zzx_h, gen_helper_gvec_mul_idx_h)
 DO_SVE2_RRX(trans_MUL_zzx_s, gen_helper_gvec_mul_idx_s)
@@ -3870,6 +3870,22 @@ DO_SVE2_RRX(trans_MUL_zzx_d, gen_helper_gvec_mul_idx_d)
 
 #undef DO_SVE2_RRX
 
+#define DO_SVE2_RRX_TB(NAME, FUNC, TOP) \
+    static bool NAME(DisasContext *s, arg_rrx_esz *a)  \
+    { return do_sve2_zzx_data(s, a, FUNC, (a->index << 1) | TOP); }
+
+DO_SVE2_RRX_TB(trans_SMULLB_zzx_s, gen_helper_sve2_smull_idx_s, false)
+DO_SVE2_RRX_TB(trans_SMULLB_zzx_d, gen_helper_sve2_smull_idx_d, false)
+DO_SVE2_RRX_TB(trans_SMULLT_zzx_s, gen_helper_sve2_smull_idx_s, true)
+DO_SVE2_RRX_TB(trans_SMULLT_zzx_d, gen_helper_sve2_smull_idx_d, true)
+
+DO_SVE2_RRX_TB(trans_UMULLB_zzx_s, gen_helper_sve2_umull_idx_s, false)
+DO_SVE2_RRX_TB(trans_UMULLB_zzx_d, gen_helper_sve2_umull_idx_d, false)
+DO_SVE2_RRX_TB(trans_UMULLT_zzx_s, gen_helper_sve2_umull_idx_s, true)
+DO_SVE2_RRX_TB(trans_UMULLT_zzx_d, gen_helper_sve2_umull_idx_d, true)
+
+#undef DO_SVE2_RRX_TB
+
 static bool do_sve2_zzxz_data(DisasContext *s, arg_rrxr_esz *a,
                               gen_helper_gvec_4 *fn, int data)
 {
-- 
2.25.1



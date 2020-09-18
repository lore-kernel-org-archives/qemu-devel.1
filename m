Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6098BC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FD421707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gc20q2Io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FD421707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLns-00013z-EI
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI2-0000tL-Bb
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:26 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHv-0007EA-01
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:22 -0400
Received: by mail-pg1-x542.google.com with SMTP id 67so3962352pgd.12
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dxBQWue3d1N+N0crqPmWVlgMt5psWuE6mkZzqPJgF8s=;
 b=gc20q2IoSyIGduQXDt5bP2MkvJBnu8aeVmz7/vY6cLVSOGpKQ8HyZXBFnE0Pm8tenZ
 Z6AUky/eslcazE98rravXRKjA1WvF+MOtneD9zXIZ94Ds3+jmC2HRotC1Jbf0BrmGIPj
 Am9PNwjFaeteNZylcFilQGkU/SL1MKnBOrz6c03WP46ZoYwl0UjbxrdSqaeBKEWY7X5d
 41Rbbt0tEEKDetV93haBdPBaF4vSzl1bdHaJmnHb0JzI8lAgbIb+rtZiEhvsNQiUjARb
 skAzMGtTU9mbCf5pht5nAduYMFFlXdS0PV2ljgA90XhiSSzyHkf32GtfT6pxqlJQ+XQs
 P5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dxBQWue3d1N+N0crqPmWVlgMt5psWuE6mkZzqPJgF8s=;
 b=pYGvhfiLwVODcnf9Ss2mD+j75ovTla11BmkwMpNNg7C6M/lETwaCKUKL0E9p66h/LC
 NSG1YS8HMu8yk6dyLT5xtTTW5OJcaBzmPxaiBspc9eraWva57rIhjsC82AHONfRGu+mj
 3wFeLK5+S5gax6x1arfPN9pr+AeWeP44Z/Y3Dnh+bV+NM4ZgkVyAskmUd+YEGm6PGR7I
 v7Mrg33zkfg9bDfrKR7TDjR1gWCmzcjOUIfIgqPY+RxqNRaKDJ3GnumIFobrQmInAqKM
 UGSZb4o3xjeqyiXqlbRfW4PPt5+FEUbLIkJVl4uiRKdmzf0KQmX2xew36umVP1c7RsfI
 MIuw==
X-Gm-Message-State: AOAM532JYtSQK7VanCZ3CMEJsvUcjkoawu+ru6vxUyZ1IfCGVcoZ8BwE
 DH+ELDCJP7dOd96PMuCFiOpE2d53ErXczQ==
X-Google-Smtp-Source: ABdhPJxTImP8HFqYWUCfdztWoFplGTo3nKLS6/GdxiXa3cgmXTbMOqwP9F82qbGezjvM+FPDwB/RTg==
X-Received: by 2002:a63:2022:: with SMTP id g34mr27236745pgg.378.1600454351513; 
 Fri, 18 Sep 2020 11:39:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 59/81] target/arm: Implement SVE2 integer multiply long
 (indexed)
Date: Fri, 18 Sep 2020 11:37:29 -0700
Message-Id: <20200918183751.2787647-60-richard.henderson@linaro.org>
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
 target/arm/helper-sve.h    |  5 +++++
 target/arm/sve.decode      | 16 ++++++++++++++++
 target/arm/sve_helper.c    | 23 +++++++++++++++++++++++
 target/arm/translate-sve.c | 24 ++++++++++++++++++++----
 4 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index d6e94a8b9c..d11598a75a 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2688,3 +2688,8 @@ DEF_HELPER_FLAGS_5(sve2_sqdmlsl_idx_s, TCG_CALL_NO_RWG,
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
index 125da036b8..80449cc569 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1560,6 +1560,29 @@ DO_ZZXW(sve2_sqdmlsl_idx_d, int64_t, int32_t,     , H1_4, DO_SQDMLSL_D)
 
 #undef DO_ZZXW
 
+#define DO_ZZX(NAME, TYPEW, TYPEN, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)            \
+{                                                                         \
+    intptr_t i, j, oprsz = simd_oprsz(desc);                              \
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1) * sizeof(TYPEN);   \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 1, 3) * sizeof(TYPEN); \
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
index 5b694a9243..39e5160e25 100644
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



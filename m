Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368BEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0685321852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phBa5LQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0685321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmo3-0000u7-78
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDm-00053B-7k
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:16 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:42641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDh-0003R6-Nw
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:13 -0400
Received: by mail-pg1-x52a.google.com with SMTP id e9so2327156pgo.9
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YmlI1iPgdiZU+6f6aGNa+wOVY0GBUE/GjYJvvgVxR/g=;
 b=phBa5LQUqeVhV54a/ySll4umj0PtyfdKScKLsMNDzIweOfA348ezp5UYLIzGUq0fuT
 FjkjrJ39peJnI4kaiW9hXcV9D/c4JHnITP8W7btSlMyqNtqMI1BD75m5Y/FaImSSMY5y
 3WVSAXETO5H7VFdMmkjPFpNkhNpX+Nf2PhHLFwZOWkpR7MBMgwfQzttWlK9nXtCZVe/h
 l0SachJ5u58hshi0UObqSZzVlvsYiY1E/YmVO35mXtpqzcl4yQ2QJ0pfImBRVVpIeLWR
 8TUzWY6mOQWkSzAjKf9fuQVbaXxx3Ut1o1K1/qlAFPkX6ej64Tso5jrxIov971y+L4YM
 RpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YmlI1iPgdiZU+6f6aGNa+wOVY0GBUE/GjYJvvgVxR/g=;
 b=pT0JRupGsoGppH+bQTS+nXZk5ZC0qSrWicv98huH2ONKYY5I9udbteU6Jb36UH3DDx
 flz+wSx+dsNSpxT8oFnMK5Pw7ptb+IXaIpMoUdY4yK5B5r7xBRntpPEIfMrD06wYuak2
 nQ0GcwAiM9eN9qiMoar0EdegR7ksfnDS4FsIibdHl5sr2K/EybSuCCLQ3ldwSHr6viUF
 nkoEU2dKh91dIx1ENspMuwuBkS5FG+K28kHo2uvgBwVX+7woonK3cRTCMYv6GOn3fWTx
 y0fuijufd7yBXW0augd4AFpvAirXqONeTp+vPNjYqRxe8XZsttU8XqZu10KwpRyUzqSR
 KqAw==
X-Gm-Message-State: AOAM533Buya5f68adOP+E8NbrpniuzpcZrQybuz4XVs4GBinDnX81riO
 lY9HRwsDHmpBMdjOBczBzEnaaWnuHuU=
X-Google-Smtp-Source: ABdhPJwZwaIIfniordCyTBblV5zkcpWvSKpIw7w48oHWb4uTrD7d14IFn7G6pgIld/mcsNSyCXKgEg==
X-Received: by 2002:a62:cd87:: with SMTP id o129mr1912483pfg.74.1592454723094; 
 Wed, 17 Jun 2020 21:32:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s15sm1162840pgv.5.2020.06.17.21.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:32:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 076/100] target/arm: Implement SVE2 saturating multiply-add
 (indexed)
Date: Wed, 17 Jun 2020 21:26:20 -0700
Message-Id: <20200618042644.1685561-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
 target/arm/helper-sve.h    |  9 +++++++++
 target/arm/sve.decode      | 18 ++++++++++++++++++
 target/arm/sve_helper.c    | 30 ++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 32 ++++++++++++++++++++++++--------
 4 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index c86dcf0c55..08210b2c66 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2191,3 +2191,12 @@ DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sqdmlal_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqdmlal_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqdmlsl_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqdmlsl_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5fc76b7fc3..36cdd9dab4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -30,6 +30,8 @@
 %size_23        23:2
 %dtype_23_13    23:2 13:2
 %index3_22_19   22:1 19:2
+%index3_19_11   19:2 11:1
+%index2_20_11   20:1 11:1
 
 # A combination of tsz:imm3 -- extract esize.
 %tszimm_esz     22:2 5:5 !function=tszimm_esz
@@ -263,6 +265,12 @@
 @rrxr_d         ........ 11 . index:1 rm:4 ...... rn:5 rd:5 \
                 &rrxr_esz ra=%reg_movprfx esz=3
 
+# Three registers and a scalar by index, wide
+@rrxw_s         ........ 10 ... rm:3 ...... rn:5 rd:5 \
+                &rrxr_esz ra=%reg_movprfx index=%index3_19_11 esz=2
+@rrxw_d         ........ 11 ..  rm:4 ...... rn:5 rd:5 \
+                &rrxr_esz ra=%reg_movprfx index=%index2_20_11 esz=3
+
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
@@ -801,6 +809,16 @@ SQRDMLSH_zzxz_h 01000100 .. 1 ..... 000101 ..... .....          @rrxr_h
 SQRDMLSH_zzxz_s 01000100 .. 1 ..... 000101 ..... .....          @rrxr_s
 SQRDMLSH_zzxz_d 01000100 .. 1 ..... 000101 ..... .....          @rrxr_d
 
+# SVE2 saturating multiply-add (indexed)
+SQDMLALB_zzxw_s 01000100 .. 1 ..... 0010.0 ..... .....          @rrxw_s
+SQDMLALB_zzxw_d 01000100 .. 1 ..... 0010.0 ..... .....          @rrxw_d
+SQDMLALT_zzxw_s 01000100 .. 1 ..... 0010.1 ..... .....          @rrxw_s
+SQDMLALT_zzxw_d 01000100 .. 1 ..... 0010.1 ..... .....          @rrxw_d
+SQDMLSLB_zzxw_s 01000100 .. 1 ..... 0011.0 ..... .....          @rrxw_s
+SQDMLSLB_zzxw_d 01000100 .. 1 ..... 0011.0 ..... .....          @rrxw_d
+SQDMLSLT_zzxw_s 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_s
+SQDMLSLT_zzxw_d 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_d
+
 # SVE2 integer multiply (indexed)
 MUL_zzx_h       01000100 .. 1 ..... 111110 ..... .....          @rrx_h
 MUL_zzx_s       01000100 .. 1 ..... 111110 ..... .....          @rrx_s
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index b3a87fb0b7..32f5d1d790 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1530,6 +1530,36 @@ DO_ZZXZ(sve2_sqrdmlsh_idx_d, int64_t,   , DO_SQRDMLSH_D)
 
 #undef DO_ZZXZ
 
+#define DO_ZZXW(NAME, TYPEW, TYPEN, HW, HN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
+{                                                                         \
+    intptr_t i, j, oprsz = simd_oprsz(desc);                              \
+    intptr_t sel = extract32(desc, SIMD_DATA_SHIFT, 1) * sizeof(TYPEN);   \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 1, 3);               \
+    for (i = 0; i < oprsz; i += 16) {                                     \
+        TYPEW mm = *(TYPEN *)(vm + i + idx);                              \
+        for (j = 0; j < 16; j += sizeof(TYPEW)) {                         \
+            TYPEW nn = *(TYPEN *)(vn + HN(i + j + sel));                  \
+            TYPEW aa = *(TYPEW *)(va + HW(i + j));                        \
+            *(TYPEW *)(vd + HW(i + j)) = OP(nn, mm, aa);                  \
+        }                                                                 \
+    }                                                                     \
+}
+
+#define DO_SQDMLAL_S(N, M, A)  DO_SQADD_S(A, do_sqdmull_s(N, M))
+#define DO_SQDMLAL_D(N, M, A)  do_sqadd_d(A, do_sqdmull_d(N, M))
+
+DO_ZZXW(sve2_sqdmlal_idx_s, int32_t, int16_t, H1_4, H1_2, DO_SQDMLAL_S)
+DO_ZZXW(sve2_sqdmlal_idx_d, int64_t, int32_t,     , H1_4, DO_SQDMLAL_D)
+
+#define DO_SQDMLSL_S(N, M, A)  DO_SQSUB_S(A, do_sqdmull_s(N, M))
+#define DO_SQDMLSL_D(N, M, A)  do_sqsub_d(A, do_sqdmull_d(N, M))
+
+DO_ZZXW(sve2_sqdmlsl_idx_s, int32_t, int16_t, H1_4, H1_2, DO_SQDMLSL_S)
+DO_ZZXW(sve2_sqdmlsl_idx_d, int64_t, int32_t,     , H1_4, DO_SQDMLSL_D)
+
+#undef DO_ZZXW
+
 #define DO_BITPERM(NAME, TYPE, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 2903e46f91..61e59f369f 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3821,21 +3821,21 @@ static bool trans_DOT_zzzz(DisasContext *s, arg_DOT_zzzz *a)
  * SVE Multiply - Indexed
  */
 
-static bool do_zzxz_ool(DisasContext *s, arg_rrxr_esz *a,
-                        gen_helper_gvec_4 *fn)
+static bool do_zzxz_data(DisasContext *s, arg_rrxr_esz *a,
+                         gen_helper_gvec_4 *fn, int data)
 {
     if (fn == NULL) {
         return false;
     }
     if (sve_access_check(s)) {
-        gen_gvec_ool_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, a->index);
+        gen_gvec_ool_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, data);
     }
     return true;
 }
 
 #define DO_RRXR(NAME, FUNC) \
     static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
-    { return do_zzxz_ool(s, a, FUNC); }
+    { return do_zzxz_data(s, a, FUNC, a->index); }
 
 DO_RRXR(trans_SDOT_zzxw_s, gen_helper_gvec_sdot_idx_b)
 DO_RRXR(trans_SDOT_zzxw_d, gen_helper_gvec_sdot_idx_h)
@@ -3870,18 +3870,18 @@ DO_SVE2_RRX(trans_MUL_zzx_d, gen_helper_gvec_mul_idx_d)
 
 #undef DO_SVE2_RRX
 
-static bool do_sve2_zzxz_ool(DisasContext *s, arg_rrxr_esz *a,
-                             gen_helper_gvec_4 *fn)
+static bool do_sve2_zzxz_data(DisasContext *s, arg_rrxr_esz *a,
+                              gen_helper_gvec_4 *fn, int data)
 {
     if (!dc_isar_feature(aa64_sve2, s)) {
         return false;
     }
-    return do_zzxz_ool(s, a, fn);
+    return do_zzxz_data(s, a, fn, data);
 }
 
 #define DO_SVE2_RRXR(NAME, FUNC) \
     static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
-    { return do_sve2_zzxz_ool(s, a, FUNC); }
+    { return do_sve2_zzxz_data(s, a, FUNC, a->index); }
 
 DO_SVE2_RRXR(trans_MLA_zzxz_h, gen_helper_gvec_mla_idx_h)
 DO_SVE2_RRXR(trans_MLA_zzxz_s, gen_helper_gvec_mla_idx_s)
@@ -3901,6 +3901,22 @@ DO_SVE2_RRXR(trans_SQRDMLSH_zzxz_d, gen_helper_sve2_sqrdmlsh_idx_d)
 
 #undef DO_SVE2_RRXR
 
+#define DO_SVE2_RRXR_TB(NAME, FUNC, TOP) \
+    static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
+    { return do_sve2_zzxz_data(s, a, FUNC, (a->index << 1) | TOP); }
+
+DO_SVE2_RRXR_TB(trans_SQDMLALB_zzxw_s, gen_helper_sve2_sqdmlal_idx_s, false)
+DO_SVE2_RRXR_TB(trans_SQDMLALB_zzxw_d, gen_helper_sve2_sqdmlal_idx_d, false)
+DO_SVE2_RRXR_TB(trans_SQDMLALT_zzxw_s, gen_helper_sve2_sqdmlal_idx_s, true)
+DO_SVE2_RRXR_TB(trans_SQDMLALT_zzxw_d, gen_helper_sve2_sqdmlal_idx_d, true)
+
+DO_SVE2_RRXR_TB(trans_SQDMLSLB_zzxw_s, gen_helper_sve2_sqdmlsl_idx_s, false)
+DO_SVE2_RRXR_TB(trans_SQDMLSLB_zzxw_d, gen_helper_sve2_sqdmlsl_idx_d, false)
+DO_SVE2_RRXR_TB(trans_SQDMLSLT_zzxw_s, gen_helper_sve2_sqdmlsl_idx_s, true)
+DO_SVE2_RRXR_TB(trans_SQDMLSLT_zzxw_d, gen_helper_sve2_sqdmlsl_idx_d, true)
+
+#undef DO_SVE2_RRXR_TB
+
 /*
  *** SVE Floating Point Multiply-Add Indexed Group
  */
-- 
2.25.1



Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B9BC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E11322208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4e12Sbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E11322208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMcp-0004JJ-VA
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIU-0001QW-Rn
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:56 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIO-0007K6-H1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:50 -0400
Received: by mail-pf1-x442.google.com with SMTP id w7so3996317pfi.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dgqa26KZVdKCtc03FsTaVbtOnIm76ZLnoLwFdbk/1bU=;
 b=Y4e12SbuIi8Jn/JBd/8XyYpSJ6yTFkJO6choFAuLQ7uC8u9NtV5ySFs2S1nDwZ3wSV
 nqv2Y49zRlWKmn9hCYol1ehE+KWS7z3QbgArJXM6F4blO36wMKQMlFr6OLMEUkpnXr4O
 HV5pBggmVtk1baLSPHONBQ+SCKJgYmSfScoHjZvbS8HWt5G56byqtcfMYO0aa/y5zCP/
 4wv0iZ+bYZ+MiyfOXVoRVNgsWgju+t5wZqNSq3FaGeYmN7mL4XaIcgzPBDoIhaiFbi4j
 1ygQEiOZTg6RM3voYigPB31tcsxysIxZ/Wn12cZ7c6WNFzGo1RUHr3zO8xh3dWoaezb9
 9qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dgqa26KZVdKCtc03FsTaVbtOnIm76ZLnoLwFdbk/1bU=;
 b=qv+qqmDxc/bguw43c7FFi0QUaDyqRFqGEe78RmmNAvOJCmGlnCZWt+gwEkCJlyqJyf
 8LVUSbcNDFQmPmCx30zJUyX9d6fhxwqKb9qnd3CMwQRD0u/rfKmkGXCv9ag/gFWQEAVy
 a4TTBauiM59k5rw/836Fg20iGtsh6/J8O7dMf5tUMPU+gUcGO+4+RTiVdqqtpjAfzvLO
 SFS+CaT0v2+Qf61XNLIe51M1edsZsVcc4HD0sWyztwVB/jk5LjcQYAO0bfv3m0nWAsKW
 P2/0nUpjCL33wavZskOKIhX8qPjqiiEVca5rFasAT1pd081rYEqq6EoD+ld7QdObCA88
 IUPQ==
X-Gm-Message-State: AOAM532QeHc3+3hZ2ezOr73dCLOjQfOdXst4xzpOXQTyo80qNyWp8vur
 AlohhpQkppzuaYw+XKmOqAdlo185hNDjGw==
X-Google-Smtp-Source: ABdhPJyR7zPMTurcuPHoZLWYvSlnVkKPjXV/Q8wT+AEUsxD24crWalceBiYTe9sO2cG6lKeoAltvcg==
X-Received: by 2002:a62:503:0:b029:13e:d13d:a0f9 with SMTP id
 3-20020a6205030000b029013ed13da0f9mr32930391pff.21.1600454379946; 
 Fri, 18 Sep 2020 11:39:39 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 80/81] target/arm: Implement SVE2 complex integer dot
 product
Date: Fri, 18 Sep 2020 11:37:50 -0700
Message-Id: <20200918183751.2787647-81-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 10 ++++
 target/arm/sve.decode      |  9 ++++
 target/arm/sve_helper.c    | 99 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 17 +++++++
 4 files changed, 135 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 9542f01c42..4af5e1a5ce 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2784,3 +2784,13 @@ DEF_HELPER_FLAGS_5(sve2_fcvtlt_sd, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(flogb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(flogb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(flogb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_cdot_zzzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_cdot_zzzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_cdot_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_cdot_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 6708c048e0..84232ff9e5 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -811,6 +811,9 @@ MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 DOT_zzzz        01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5 \
                 ra=%reg_movprfx
 
+# SVE2 complex dot product (vectors)
+CDOT_zzzz       01000100 esz:2 0 rm:5 0001 rot:2 rn:5 rd:5  ra=%reg_movprfx
+
 #### SVE Multiply - Indexed
 
 # SVE integer dot product (indexed)
@@ -849,6 +852,12 @@ SQDMLSLB_zzxw_d 01000100 .. 1 ..... 0011.0 ..... .....          @rrxw_d
 SQDMLSLT_zzxw_s 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_s
 SQDMLSLT_zzxw_d 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_d
 
+# SVE2 complex integer dot product (indexed)
+CDOT_zzxw_s     01000100 10 1 index:2 rm:3 0100 rot:2 rn:5 rd:5 \
+                ra=%reg_movprfx
+CDOT_zzxw_d     01000100 11 1 index:1 rm:4 0100 rot:2 rn:5 rd:5 \
+                ra=%reg_movprfx
+
 # SVE2 complex integer multiply-add (indexed)
 CMLA_zzxz_h     01000100 10 1 index:2 rm:3 0110 rot:2 rn:5 rd:5 \
                 ra=%reg_movprfx
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ef04a0f95a..0ff5e0baf8 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1592,6 +1592,105 @@ void HELPER(sve2_sqrdcmlah_idx_s)(void *vd, void *vn, void *vm,
     do_cmla_idx_s(vd, vn, vm, va, desc, do_sqrdcmlah_s);
 }
 
+/* Note N and M are 4 elements bundled into one unit. */
+static int32_t do_cdot_s(uint32_t n, uint32_t m, int32_t a,
+                         int sel_a, int sel_b, int sub_i)
+{
+    for (int i = 0; i <= 1; i++) {
+        int32_t elt1_r = (int8_t)(n >> (16 * i));
+        int32_t elt1_i = (int8_t)(n >> (16 * i + 8));
+        int32_t elt2_a = (int8_t)(m >> (16 * i + 8 * sel_a));
+        int32_t elt2_b = (int8_t)(m >> (16 * i + 8 * sel_b));
+
+        a += elt1_r * elt2_a + elt1_i * elt2_b * sub_i;
+    }
+    return a;
+}
+
+static int64_t do_cdot_d(uint64_t n, uint64_t m, int64_t a,
+                         int sel_a, int sel_b, int sub_i)
+{
+    for (int i = 0; i <= 1; i++) {
+        int64_t elt1_r = (int16_t)(n >> (32 * i + 0));
+        int64_t elt1_i = (int16_t)(n >> (32 * i + 16));
+        int64_t elt2_a = (int16_t)(m >> (32 * i + 16 * sel_a));
+        int64_t elt2_b = (int16_t)(m >> (32 * i + 16 * sel_b));
+
+        a += elt1_r * elt2_a + elt1_i * elt2_b * sub_i;
+    }
+    return a;
+}
+
+void HELPER(sve2_cdot_zzzz_s)(void *vd, void *vn, void *vm,
+                              void *va, uint32_t desc)
+{
+    int opr_sz = simd_oprsz(desc);
+    int rot = simd_data(desc);
+    int sel_a = rot & 1;
+    int sel_b = sel_a ^ 1;
+    int sub_i = (rot == 0 || rot == 3 ? -1 : 1);
+    uint32_t *d = vd, *n = vn, *m = vm, *a = va;
+
+    for (int e = 0; e < opr_sz / 4; e++) {
+        d[e] = do_cdot_s(n[e], m[e], a[e], sel_a, sel_b, sub_i);
+    }
+}
+
+void HELPER(sve2_cdot_zzzz_d)(void *vd, void *vn, void *vm,
+                              void *va, uint32_t desc)
+{
+    int opr_sz = simd_oprsz(desc);
+    int rot = simd_data(desc);
+    int sel_a = rot & 1;
+    int sel_b = sel_a ^ 1;
+    int sub_i = (rot == 0 || rot == 3 ? -1 : 1);
+    uint64_t *d = vd, *n = vn, *m = vm, *a = va;
+
+    for (int e = 0; e < opr_sz / 8; e++) {
+        d[e] = do_cdot_d(n[e], m[e], a[e], sel_a, sel_b, sub_i);
+    }
+}
+
+void HELPER(sve2_cdot_idx_s)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    int opr_sz = simd_oprsz(desc);
+    int rot = extract32(desc, SIMD_DATA_SHIFT, 2);
+    int idx = H4(extract32(desc, SIMD_DATA_SHIFT + 2, 2));
+    int sel_a = rot & 1;
+    int sel_b = sel_a ^ 1;
+    int sub_i = (rot == 0 || rot == 3 ? -1 : 1);
+    uint32_t *d = vd, *n = vn, *m = vm, *a = va;
+
+    for (int seg = 0; seg < opr_sz / 4; seg += 4) {
+        uint32_t seg_m = m[seg + idx];
+        for (int e = 0; e < 4; e++) {
+            d[seg + e] = do_cdot_s(n[seg + e], seg_m, a[seg + e],
+                                   sel_a, sel_b, sub_i);
+        }
+    }
+}
+
+void HELPER(sve2_cdot_idx_d)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    int seg, opr_sz = simd_oprsz(desc);
+    int rot = extract32(desc, SIMD_DATA_SHIFT, 2);
+    int idx = extract32(desc, SIMD_DATA_SHIFT + 2, 2);
+    int sel_a = rot & 1;
+    int sel_b = sel_a ^ 1;
+    int sub_i = (rot == 0 || rot == 3 ? -1 : 1);
+    uint64_t *d = vd, *n = vn, *m = vm, *a = va;
+
+    for (seg = 0; seg < opr_sz / 8; seg += 2) {
+        uint64_t seg_m = m[seg + idx];
+        for (int e = 0; e < 2; e++) {
+            d[seg + e] = do_cdot_d(n[seg + e], seg_m, a[seg + e],
+                                   sel_a, sel_b, sub_i);
+        }
+    }
+}
+
 #define DO_ZZXZ(NAME, TYPE, H, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
 {                                                                       \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 92d1297a5c..4893968cdb 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4151,6 +4151,9 @@ DO_SVE2_RRXR_ROT(CMLA_zzxz_s, gen_helper_sve2_cmla_idx_s)
 DO_SVE2_RRXR_ROT(SQRDCMLAH_zzxz_h, gen_helper_sve2_sqrdcmlah_idx_h)
 DO_SVE2_RRXR_ROT(SQRDCMLAH_zzxz_s, gen_helper_sve2_sqrdcmlah_idx_s)
 
+DO_SVE2_RRXR_ROT(CDOT_zzxw_s, gen_helper_sve2_cdot_idx_s)
+DO_SVE2_RRXR_ROT(CDOT_zzxw_d, gen_helper_sve2_cdot_idx_d)
+
 #undef DO_SVE2_RRXR_ROT
 
 /*
@@ -8355,6 +8358,20 @@ static bool trans_CMLA_zzzz(DisasContext *s, arg_CMLA_zzzz *a)
     return true;
 }
 
+static bool trans_CDOT_zzzz(DisasContext *s, arg_CMLA_zzzz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s) || a->esz < MO_32) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_helper_gvec_4 *fn = (a->esz == MO_32
+                                 ? gen_helper_sve2_cdot_zzzz_s
+                                 : gen_helper_sve2_cdot_zzzz_d);
+        gen_gvec_ool_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, a->rot);
+    }
+    return true;
+}
+
 static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_SQRDCMLAH_zzzz *a)
 {
     static gen_helper_gvec_4 * const fns[] = {
-- 
2.25.1



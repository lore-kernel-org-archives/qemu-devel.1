Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 606B621883
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BRv34tvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 606B621883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmaR-0001P6-Ij
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmC7-0001pq-Ps
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:30:31 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:44846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmC5-00037D-Kz
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:30:31 -0400
Received: by mail-pg1-x532.google.com with SMTP id r18so2322675pgk.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3Ntrsa5EJ8+kWOgKRzK6JthMDOrcB+tj1Dx4KhO3lJM=;
 b=BRv34tvSHSGYNsadWWB69WYaqlTYXs91sBzm2drRoYhIdONwFzSC5VFuoj3ysFwagF
 rC75upJpm443h9iS4UfaQdlVDxVlev9IUQDSxLmo48AvDp8YXVsCbvYrByY8XEaNR8q6
 sOHYxUJ/X9i7x16tM92PVW40MC1CCq3oEcxy2fCQkUlp3d76ivt4uIYX9nPIcKZHozZZ
 NwwlWraSPFB2CVryB6lLbUe1xuA8nFtC1ZsM1uUHJTL45sNYnV2bE0Eketk92W0E7fGk
 NKcJZrhqkstk+GcDH2X32IgsixACUVen7b1n+NrX+iDOS8UyAmCgnjl/TiIgp11LKPrO
 LWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Ntrsa5EJ8+kWOgKRzK6JthMDOrcB+tj1Dx4KhO3lJM=;
 b=WV7BfOSGCGelDwMy+HRVDPgQjPaRpNCz4UzPXELUe6zhyCZCPJtam89ilyYSkrSjuX
 KjI4+e7+9vM5YwWVUe8dg6R3BUH5WQ/lG/N8d7JssIMwk+PPgGEM1tSu6X00J6EJYtz+
 UpC8F5B/CzM3EZ0gilu5hCM83RNeJiVDnEQJMGg6Ork6PPpLYBMB1OsrN605dlFKDUcS
 abRt7NYWCZ6eP7IUvDD6QSvyOWFaIHpnirW0VUicT+UKeiH+JN5KdWDxr+morWIin7B9
 LiJuMWwXKdJO7zQPWD2oX/gLH8Eg0b23ju/dcHraMH/ZF77zKEmGvrhvQ8jpAqdo1Pj9
 O3EQ==
X-Gm-Message-State: AOAM530xZxYUSBDNuUuUT0TkcAH04PeTQG7KOlm0vjlLTxXg3mIBcrrh
 snGx3+kzSwZsao1NJ26MZWkUaoUBQU4=
X-Google-Smtp-Source: ABdhPJy5v5yjBNZg0j8QBdcr5Ll6ut8VJKglckHUGBuzzSUZtwHMWe/Im5tr+1Uf6MScwuZZ77PbnA==
X-Received: by 2002:a63:d652:: with SMTP id d18mr1901712pgj.164.1592454627657; 
 Wed, 17 Jun 2020 21:30:27 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i191sm1298861pfe.99.2020.06.17.21.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:30:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 051/100] target/arm: Implement SVE2 saturating multiply-add
 high
Date: Wed, 17 Jun 2020 21:25:55 -0700
Message-Id: <20200618042644.1685561-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

SVE2 has two additional sizes of the operation and unlike NEON,
there is no saturation flag.  Create new entry points for SVE2
that do not set QC.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        |  17 ++++
 target/arm/sve.decode      |   5 ++
 target/arm/translate-sve.c |  18 ++++
 target/arm/vec_helper.c    | 163 +++++++++++++++++++++++++++++++++++--
 4 files changed, 196 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 236fa438c6..643fc3a017 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -557,6 +557,23 @@ DEF_HELPER_FLAGS_5(gvec_qrdmlah_s32, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_qrdmlsh_s32, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index d0d24978bb..177b3cc803 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1346,3 +1346,8 @@ SQDMLSLT_zzzw   01000100 .. 0 ..... 0110 11 ..... .....  @rda_rn_rm
 
 SQDMLALBT       01000100 .. 0 ..... 00001 0 ..... .....  @rda_rn_rm
 SQDMLSLBT       01000100 .. 0 ..... 00001 1 ..... .....  @rda_rn_rm
+
+## SVE2 saturating multiply-add high
+
+SQRDMLAH_zzzz   01000100 .. 0 ..... 01110 0 ..... .....  @rda_rn_rm
+SQRDMLSH_zzzz   01000100 .. 0 ..... 01110 1 ..... .....  @rda_rn_rm
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 00488915aa..28dc89c3a4 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7123,3 +7123,21 @@ static bool trans_SQDMLSLBT(DisasContext *s, arg_rrrr_esz *a)
 {
     return do_sqdmlsl_zzzw(s, a, false, true);
 }
+
+static bool trans_SQRDMLAH_zzzz(DisasContext *s, arg_rrrr_esz *a)
+{
+    static gen_helper_gvec_4 * const fns[] = {
+        gen_helper_sve2_sqrdmlah_b, gen_helper_sve2_sqrdmlah_h,
+        gen_helper_sve2_sqrdmlah_s, gen_helper_sve2_sqrdmlah_d,
+    };
+    return do_sve2_zzzz_ool(s, a, fns[a->esz], 0);
+}
+
+static bool trans_SQRDMLSH_zzzz(DisasContext *s, arg_rrrr_esz *a)
+{
+    static gen_helper_gvec_4 * const fns[] = {
+        gen_helper_sve2_sqrdmlsh_b, gen_helper_sve2_sqrdmlsh_h,
+        gen_helper_sve2_sqrdmlsh_s, gen_helper_sve2_sqrdmlsh_d,
+    };
+    return do_sve2_zzzz_ool(s, a, fns[a->esz], 0);
+}
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index b0ae51f95f..4b7afd7be5 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -22,6 +22,7 @@
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
+#include "qemu/int128.h"
 #include "vec_internal.h"
 
 /* Note that vector data is stored in host-endian 64-bit chunks,
@@ -36,15 +37,55 @@
 #define H4(x)  (x)
 #endif
 
+/* Signed saturating rounding doubling multiply-accumulate high half, 8-bit */
+static int8_t do_sqrdmlah_b(int8_t src1, int8_t src2, int8_t src3,
+                            bool neg, bool round)
+{
+    /*
+     * Simplify:
+     * = ((a3 << 8) + ((e1 * e2) << 1) + (round << 7)) >> 8
+     * = ((a3 << 7) + (e1 * e2) + (round << 6)) >> 7
+     */
+    int32_t ret = (int32_t)src1 * src2;
+    if (neg) {
+        ret = -ret;
+    }
+    ret += ((int32_t)src3 << 7) + (round << 6);
+    ret >>= 7;
+
+    if (ret != (int8_t)ret) {
+        ret = (ret < 0 ? INT8_MIN : INT8_MAX);
+    }
+    return ret;
+}
+
+void HELPER(sve2_sqrdmlah_b)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int8_t *d = vd, *n = vn, *m = vm, *a = va;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = do_sqrdmlah_b(n[i], m[i], a[i], false, true);
+    }
+}
+
+void HELPER(sve2_sqrdmlsh_b)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int8_t *d = vd, *n = vn, *m = vm, *a = va;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = do_sqrdmlah_b(n[i], m[i], a[i], true, true);
+    }
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
 static int16_t do_sqrdmlah_h(int16_t src1, int16_t src2, int16_t src3,
                              bool neg, bool round, uint32_t *sat)
 {
-    /*
-     * Simplify:
-     * = ((a3 << 16) + ((e1 * e2) << 1) + (1 << 15)) >> 16
-     * = ((a3 << 15) + (e1 * e2) + (1 << 14)) >> 15
-     */
+    /* Simplify similarly to do_sqrdmlah_b above.  */
     int32_t ret = (int32_t)src1 * src2;
     if (neg) {
         ret = -ret;
@@ -109,16 +150,40 @@ void HELPER(gvec_qrdmlsh_s16)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(sve2_sqrdmlah_h)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm, *a = va;
+    uint32_t discard;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = do_sqrdmlah_h(n[i], m[i], a[i], false, true, &discard);
+    }
+}
+
+void HELPER(sve2_sqrdmlsh_h)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm, *a = va;
+    uint32_t discard;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = do_sqrdmlah_h(n[i], m[i], a[i], true, true, &discard);
+    }
+}
+
 /* Signed saturating rounding doubling multiply-accumulate high half, 32-bit */
 static int32_t do_sqrdmlah_s(int32_t src1, int32_t src2, int32_t src3,
                              bool neg, bool round, uint32_t *sat)
 {
-    /* Simplify similarly to int_qrdmlah_s16 above.  */
+    /* Simplify similarly to do_sqrdmlah_b above.  */
     int64_t ret = (int64_t)src1 * src2;
     if (neg) {
         ret = -ret;
     }
-    ret = ((int64_t)src3 << 31) + (round << 30);
+    ret += ((int64_t)src3 << 31) + (round << 30);
     ret >>= 31;
 
     if (ret != (int32_t)ret) {
@@ -172,6 +237,90 @@ void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(sve2_sqrdmlah_s)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm, *a = va;
+    uint32_t discard;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = do_sqrdmlah_s(n[i], m[i], a[i], false, true, &discard);
+    }
+}
+
+void HELPER(sve2_sqrdmlsh_s)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm, *a = va;
+    uint32_t discard;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = do_sqrdmlah_s(n[i], m[i], a[i], true, true, &discard);
+    }
+}
+
+/* Signed saturating rounding doubling multiply-accumulate high half, 64-bit */
+static int64_t do_sat128_d(Int128 r)
+{
+    int64_t ls = int128_getlo(r);
+    int64_t hs = int128_gethi(r);
+
+    if (unlikely(hs != (ls >> 63))) {
+        return hs < 0 ? INT64_MIN : INT64_MAX;
+    }
+    return ls;
+}
+
+static int64_t do_sqrdmlah_d(int64_t n, int64_t m, int64_t a,
+                             bool neg, bool round)
+{
+    uint64_t l, h;
+    Int128 r, t;
+
+    /* As in do_sqrdmlah_b, but with 128-bit arithmetic. */
+    muls64(&l, &h, m, n);
+    r = int128_make128(l, h);
+    if (neg) {
+        r = int128_neg(r);
+    }
+    if (a) {
+        t = int128_exts64(a);
+        t = int128_lshift(t, 63);
+        r = int128_add(r, t);
+    }
+    if (round) {
+        t = int128_exts64(1ll << 62);
+        r = int128_add(r, t);
+    }
+    r = int128_rshift(r, 63);
+
+    return do_sat128_d(r);
+}
+
+void HELPER(sve2_sqrdmlah_d)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int64_t *d = vd, *n = vn, *m = vm, *a = va;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = do_sqrdmlah_d(n[i], m[i], a[i], false, true);
+    }
+}
+
+void HELPER(sve2_sqrdmlsh_d)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int64_t *d = vd, *n = vn, *m = vm, *a = va;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        d[i] = do_sqrdmlah_d(n[i], m[i], a[i], true, true);
+    }
+}
+
 /* Integer 8 and 16-bit dot-product.
  *
  * Note that for the loops herein, host endianness does not matter
-- 
2.25.1



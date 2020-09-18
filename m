Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0E8C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF76C208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjuzX5QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF76C208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJM4O-0004zD-Ry
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI7-0000uV-Cb
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:27 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:41909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHv-0007Dv-G2
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:27 -0400
Received: by mail-pg1-x536.google.com with SMTP id y1so3976581pgk.8
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KFpgXc3wDM39uIXZhQQA2BpO+t4rSB0v97/ARha6/jc=;
 b=pjuzX5QVtmD6pC9IaFEHD3+4352P66KU2f/Kkxdbg7XEs3IqlUYSdmYZ4i5ktmJu7h
 /fAN9EwfQB3k/3mjVBo4rukIyQxVu6b1lU08xllC83DS9IpPgkEHCeUO2rYp37dk2EDI
 fy3bEDUG0zkdus4uzUtW5vuj6pedyWfZxZ38OOS7k9nLsD5itekXrRczEFE4xm6Qis5t
 k9Mug3I+m/iSfzN5cr4xR1X+2VRCGk8XneDtonH3X2/M7VSSbwNwbZOnu6ml5Rm5HZ0/
 M4nmC+o59QoflDZAnsUNN7uF6WRcfujaoFRp2vhimzdrneUxVqzGsnfAu4MOYVHVuwWU
 ro6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KFpgXc3wDM39uIXZhQQA2BpO+t4rSB0v97/ARha6/jc=;
 b=Fl3ucPBautwhc7l/VMsS0MAAHpicVRd1ftDZELOK/L6UHl1G4Ac6pxrOSGB+qzahHP
 A6A6Hba5hNaoyLai4dVjxPufuPl15dbgelJaT+OxUjaZqhbfh29HOEN1aFwOgwqy0oKa
 +NAsOK9XYbQdEztShloQqdcQiv1ROfIC850YZaBs8sKjudT0/LTJ6dB+kH7bsK4f7LTx
 gsHKouT/yAIykVYiq2k/AbZ7BUhBBcnKOKaRC8ykEZr7T01ol+owCtbrg2jgBcq9X1dV
 ejeCfeiRYENQLdx/7+sFI2Cs/UWaQIbm4PNyd+kV7YF67abBNYL5RzjJML/zRZhpAVyT
 FxWg==
X-Gm-Message-State: AOAM531z5fLeSdIsqjdxrmUCaxO8p7p2GOA8WRf9yM6C1ty3/TNL42xX
 m8GvocesgbzfrNDYxMu92a8mwOCFR+IJSQ==
X-Google-Smtp-Source: ABdhPJxW4VsLdtNrJJ/rcjNiLNQs1MYK3LW/jZj6yLTqYWd4rG95tF53/SnDrfe1bJIbVW/TrrKR+g==
X-Received: by 2002:aa7:911a:0:b029:13e:d13d:a13d with SMTP id
 26-20020aa7911a0000b029013ed13da13dmr32966820pfh.37.1600454348766; 
 Fri, 18 Sep 2020 11:39:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 57/81] target/arm: Implement SVE2 saturating multiply-add
 high (indexed)
Date: Fri, 18 Sep 2020 11:37:27 -0700
Message-Id: <20200918183751.2787647-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 target/arm/helper-sve.h    | 14 +++++++++++++
 target/arm/sve.decode      |  8 ++++++++
 target/arm/sve_helper.c    | 40 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  8 ++++++++
 4 files changed, 70 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 2c6d3431ec..4ff7298f67 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2665,3 +2665,17 @@ DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_zzzz_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(fmmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(fmmla_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlah_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdmlsh_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 467a93052f..5fc76b7fc3 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -793,6 +793,14 @@ MLS_zzxz_h      01000100 .. 1 ..... 000011 ..... .....          @rrxr_h
 MLS_zzxz_s      01000100 .. 1 ..... 000011 ..... .....          @rrxr_s
 MLS_zzxz_d      01000100 .. 1 ..... 000011 ..... .....          @rrxr_d
 
+# SVE2 saturating multiply-add high (indexed)
+SQRDMLAH_zzxz_h 01000100 .. 1 ..... 000100 ..... .....          @rrxr_h
+SQRDMLAH_zzxz_s 01000100 .. 1 ..... 000100 ..... .....          @rrxr_s
+SQRDMLAH_zzxz_d 01000100 .. 1 ..... 000100 ..... .....          @rrxr_d
+SQRDMLSH_zzxz_h 01000100 .. 1 ..... 000101 ..... .....          @rrxr_h
+SQRDMLSH_zzxz_s 01000100 .. 1 ..... 000101 ..... .....          @rrxr_s
+SQRDMLSH_zzxz_d 01000100 .. 1 ..... 000101 ..... .....          @rrxr_d
+
 # SVE2 integer multiply (indexed)
 MUL_zzx_h       01000100 .. 1 ..... 111110 ..... .....          @rrx_h
 MUL_zzx_s       01000100 .. 1 ..... 111110 ..... .....          @rrx_s
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index aaf336118b..1facec8ce0 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1487,9 +1487,49 @@ DO_CMLA(sve2_sqrdcmlah_zzzz_h, int16_t, H2, DO_SQRDMLAH_H)
 DO_CMLA(sve2_sqrdcmlah_zzzz_s, int32_t, H4, DO_SQRDMLAH_S)
 DO_CMLA(sve2_sqrdcmlah_zzzz_d, int64_t,   , DO_SQRDMLAH_D)
 
+#undef DO_SQRDMLAH_B
+#undef DO_SQRDMLAH_H
+#undef DO_SQRDMLAH_S
+#undef DO_SQRDMLAH_D
 #undef do_cmla
 #undef DO_CMLA
 
+#define DO_ZZXZ(NAME, TYPE, H, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
+{                                                                       \
+    intptr_t oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);     \
+    intptr_t i, j, idx = simd_data(desc);                               \
+    TYPE *d = vd, *a = va, *n = vn, *m = (TYPE *)vm + H(idx);           \
+    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {               \
+        TYPE mm = m[i];                                                 \
+        for (j = 0; j < segment; j++) {                                 \
+            d[i + j] = OP(n[i + j], mm, a[i + j]);                      \
+        }                                                               \
+    }                                                                   \
+}
+
+#define DO_SQRDMLAH_H(N, M, A) \
+    ({ uint32_t discard; do_sqrdmlah_h(N, M, A, false, true, &discard); })
+#define DO_SQRDMLAH_S(N, M, A) \
+    ({ uint32_t discard; do_sqrdmlah_s(N, M, A, false, true, &discard); })
+#define DO_SQRDMLAH_D(N, M, A) do_sqrdmlah_d(N, M, A, false, true)
+
+DO_ZZXZ(sve2_sqrdmlah_idx_h, int16_t, H2, DO_SQRDMLAH_H)
+DO_ZZXZ(sve2_sqrdmlah_idx_s, int32_t, H4, DO_SQRDMLAH_S)
+DO_ZZXZ(sve2_sqrdmlah_idx_d, int64_t,   , DO_SQRDMLAH_D)
+
+#define DO_SQRDMLSH_H(N, M, A) \
+    ({ uint32_t discard; do_sqrdmlah_h(N, M, A, true, true, &discard); })
+#define DO_SQRDMLSH_S(N, M, A) \
+    ({ uint32_t discard; do_sqrdmlah_s(N, M, A, true, true, &discard); })
+#define DO_SQRDMLSH_D(N, M, A) do_sqrdmlah_d(N, M, A, true, true)
+
+DO_ZZXZ(sve2_sqrdmlsh_idx_h, int16_t, H2, DO_SQRDMLSH_H)
+DO_ZZXZ(sve2_sqrdmlsh_idx_s, int32_t, H4, DO_SQRDMLSH_S)
+DO_ZZXZ(sve2_sqrdmlsh_idx_d, int64_t,   , DO_SQRDMLSH_D)
+
+#undef DO_ZZXZ
+
 #define DO_BITPERM(NAME, TYPE, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index a6235d78d5..1dd03ae21e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3891,6 +3891,14 @@ DO_SVE2_RRXR(trans_MLS_zzxz_h, gen_helper_gvec_mls_idx_h)
 DO_SVE2_RRXR(trans_MLS_zzxz_s, gen_helper_gvec_mls_idx_s)
 DO_SVE2_RRXR(trans_MLS_zzxz_d, gen_helper_gvec_mls_idx_d)
 
+DO_SVE2_RRXR(trans_SQRDMLAH_zzxz_h, gen_helper_sve2_sqrdmlah_idx_h)
+DO_SVE2_RRXR(trans_SQRDMLAH_zzxz_s, gen_helper_sve2_sqrdmlah_idx_s)
+DO_SVE2_RRXR(trans_SQRDMLAH_zzxz_d, gen_helper_sve2_sqrdmlah_idx_d)
+
+DO_SVE2_RRXR(trans_SQRDMLSH_zzxz_h, gen_helper_sve2_sqrdmlsh_idx_h)
+DO_SVE2_RRXR(trans_SQRDMLSH_zzxz_s, gen_helper_sve2_sqrdmlsh_idx_s)
+DO_SVE2_RRXR(trans_SQRDMLSH_zzxz_d, gen_helper_sve2_sqrdmlsh_idx_d)
+
 #undef DO_SVE2_RRXR
 
 /*
-- 
2.25.1



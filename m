Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68237C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256DD2068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHniPnR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256DD2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAJX-0007Ao-8Z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIY-0005WV-1L
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:01:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:37483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIW-0007PU-HU
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:01:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id y18so1587970plr.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lcNWhrjkDy7FbfNE6oruy9Ivc3Ph5d8bVUFXuqg+mSo=;
 b=RHniPnR8RyR9hIptgoe4WIgiI9pCXPXzApTGnHDIJjgXiWF1y61iAdsjGhUrq0ErnO
 mW58JkYhuPVE0STE8zz3Th8J4mVPeXWWBoIZSxEMx3P3VFBGmqrlm0RqDfEC6/LD0nWl
 aO6RwMXTCTusF/juch+6ACj2L9iv1ssAPvGQXkh7lxEGEgG1y8saaER72Wd7wkGEaIHV
 /9KBofTFXIfIF65s+D1musbm0CsIZbfX/aTVTP6QSFX1ItN2PteajbOA2/MUEtWzlSsH
 gAg3X+U1Z/pfyRubd8CIusP8lFO09g/LAovX21rIDvAXU/xCgWmIu9YTN/l/n4VVbgCG
 aZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lcNWhrjkDy7FbfNE6oruy9Ivc3Ph5d8bVUFXuqg+mSo=;
 b=DFMmGkFpMfFLandImjVOLGGqaIUM9vhqqdnBVKTRXENZJjEC51Jb0wNSonbduCaMER
 28WaoAod9hDmLqPA0YOUvML/qCi7kzaTEbHvlid+KB1vISL/iLiddq8LrIm8q9mtfqX5
 KapibnqMgVM+km9yw2GOQkKBhS8wae9SRn9nkQIhjdix/4GbBNzGFWO5sPYmf63Zxy/y
 gZF0L7Y+pXw4CkJDo3XBfVofZJ+80/KLUYUEkBBZW1soW/otbW9wSk4GxP28djIUUU/m
 rkIhCp06peioYHiSlToG7eu4DJbk32c2F8zUC0F0ewC2X/NYFRhg7/pMScOyJVWkAxgg
 0pSA==
X-Gm-Message-State: AOAM533wW7s7qmCAH4AfYJJKjrrdEF217f0oMCU31Bcf9+6X1ZVBJcE6
 /PAnCtnALU1LJU8oUO2vwj/DSBd9Px8=
X-Google-Smtp-Source: ABdhPJydiGBn/ZjPM/GhYxbFUn4zp69qQPnOHCTM6hz1GsQzvfIUOrDATIMKHJTTxHoMLVN1+hznGg==
X-Received: by 2002:a17:90b:188d:: with SMTP id
 mn13mr165533pjb.84.1591117314235; 
 Tue, 02 Jun 2020 10:01:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h11sm2723630pjk.20.2020.06.02.10.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 10:01:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] tcg: Implement gvec support for rotate by immediate
Date: Tue,  2 Jun 2020 10:01:40 -0700
Message-Id: <20200602170151.321389-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602170151.321389-1-richard.henderson@linaro.org>
References: <20200602170151.321389-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No host backend support yet, but the interfaces for rotli
are in place.  Canonicalize immediate rotate to the left,
based on a survey of architectures, but provide both left
and right shift interfaces to the translators.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  5 +++
 include/tcg/tcg-op-gvec.h    |  6 ++++
 include/tcg/tcg-op.h         |  2 ++
 include/tcg/tcg-opc.h        |  1 +
 include/tcg/tcg.h            |  1 +
 tcg/aarch64/tcg-target.h     |  1 +
 tcg/i386/tcg-target.h        |  1 +
 tcg/ppc/tcg-target.h         |  1 +
 accel/tcg/tcg-runtime-gvec.c | 48 +++++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 68 ++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             | 12 +++++++
 tcg/tcg.c                    |  2 ++
 tcg/README                   |  3 +-
 13 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 4fa61b49b4..cf10c8361e 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -259,6 +259,11 @@ DEF_HELPER_FLAGS_3(gvec_sar16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_rotl8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_rotl16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_rotl32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_rotl64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_shl8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_shl16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_shl32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index cea6497341..1afc3ebf03 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -334,6 +334,10 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 
 void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
@@ -388,5 +392,7 @@ void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
 void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
 void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
 void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_rotl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c);
+void tcg_gen_vec_rotl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c);
 
 #endif
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index e3399d6a5e..848d91ce74 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -999,6 +999,8 @@ void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+void tcg_gen_rotli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 
 void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 9288a04946..a6ab4a147f 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -248,6 +248,7 @@ DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
 DEF(shli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
 DEF(shri_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
 DEF(sari_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
+DEF(rotli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_roti_vec))
 
 DEF(shls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
 DEF(shrs_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index c48bd76b0a..56bedbd03b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -182,6 +182,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index ca214f6909..225a597f84 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -133,6 +133,7 @@ typedef enum {
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          1
+#define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index bfb3f5f6e9..23aabde992 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -183,6 +183,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          1
+#define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 4fa21f0e71..e57b891aa5 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -161,6 +161,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          have_isa_3_00
 #define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index ca449702e6..34b1030365 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -716,6 +716,54 @@ void HELPER(gvec_sar64i)(void *d, void *a, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_rotl8i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = rol8(*(uint8_t *)(a + i), shift);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotl16i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = rol16(*(uint16_t *)(a + i), shift);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotl32i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = rol32(*(uint32_t *)(a + i), shift);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotl64i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = rol64(*(uint64_t *)(a + i), shift);
+    }
+    clear_high(d, oprsz, desc);
+}
+
 void HELPER(gvec_shl8v)(void *d, void *a, void *b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 049a55e700..25300b1577 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2694,6 +2694,74 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
+void tcg_gen_vec_rotl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t mask = dup_const(MO_8, 0xff << c);
+
+    tcg_gen_shli_i64(d, a, c);
+    tcg_gen_shri_i64(a, a, 8 - c);
+    tcg_gen_andi_i64(d, d, mask);
+    tcg_gen_andi_i64(a, a, ~mask);
+    tcg_gen_or_i64(d, d, a);
+}
+
+void tcg_gen_vec_rotl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t mask = dup_const(MO_16, 0xffff << c);
+
+    tcg_gen_shli_i64(d, a, c);
+    tcg_gen_shri_i64(a, a, 16 - c);
+    tcg_gen_andi_i64(d, d, mask);
+    tcg_gen_andi_i64(a, a, ~mask);
+    tcg_gen_or_i64(d, d, a);
+}
+
+void tcg_gen_gvec_rotli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_rotli_vec, 0 };
+    static const GVecGen2i g[4] = {
+        { .fni8 = tcg_gen_vec_rotl8i_i64,
+          .fniv = tcg_gen_rotli_vec,
+          .fno = gen_helper_gvec_rotl8i,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_rotl16i_i64,
+          .fniv = tcg_gen_rotli_vec,
+          .fno = gen_helper_gvec_rotl16i,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_rotli_i32,
+          .fniv = tcg_gen_rotli_vec,
+          .fno = gen_helper_gvec_rotl32i,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_rotli_i64,
+          .fniv = tcg_gen_rotli_vec,
+          .fno = gen_helper_gvec_rotl64i,
+          .opt_opc = vecop_list,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_debug_assert(shift >= 0 && shift < (8 << vece));
+    if (shift == 0) {
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
+    } else {
+        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
+    }
+}
+
+void tcg_gen_gvec_rotri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_debug_assert(vece <= MO_64);
+    tcg_debug_assert(shift >= 0 && shift < (8 << vece));
+    tcg_gen_gvec_rotli(vece, dofs, aofs, -shift & ((8 << vece) - 1),
+                       oprsz, maxsz);
+}
+
 /*
  * Specialized generation vector shifts by a non-constant scalar.
  */
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index b6937e8d64..660ad9be88 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -545,6 +545,18 @@ void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
     do_shifti(INDEX_op_sari_vec, vece, r, a, i);
 }
 
+void tcg_gen_rotli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
+{
+    do_shifti(INDEX_op_rotli_vec, vece, r, a, i);
+}
+
+void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
+{
+    int bits = 8 << vece;
+    tcg_debug_assert(i >= 0 && i < bits);
+    do_shifti(INDEX_op_rotli_vec, vece, r, a, -i & (bits - 1));
+}
+
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
                      TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a2268d9db0..73a3a4fb9e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1661,6 +1661,8 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
         return have_vec && TCG_TARGET_HAS_shv_vec;
+    case INDEX_op_rotli_vec:
+        return have_vec && TCG_TARGET_HAS_roti_vec;
     case INDEX_op_ssadd_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
diff --git a/tcg/README b/tcg/README
index bfa2e4ed24..1e3e4654f4 100644
--- a/tcg/README
+++ b/tcg/README
@@ -605,10 +605,11 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 
 * shri_vec   v0, v1, i2
 * sari_vec   v0, v1, i2
+* rotli_vec  v0, v1, i2
 * shrs_vec   v0, v1, s2
 * sars_vec   v0, v1, s2
 
-  Similarly for logical and arithmetic right shift.
+  Similarly for logical and arithmetic right shift, and left rotate.
 
 * shlv_vec   v0, v1, v2
 
-- 
2.25.1



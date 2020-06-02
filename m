Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646562068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKISla+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646562068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAKq-00028R-LJ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIZ-0005YD-DF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:01:59 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:37290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIX-0007Pj-UR
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:01:59 -0400
Received: by mail-pj1-x1029.google.com with SMTP id m2so1753991pjv.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mu2saZOWPED4vR7UdUs4dqcH4IgZTJumToHiRAA4Yio=;
 b=tKISla+uydoypuCWg63GvRcwgqX7Ror/fhFVAY8weceG+RhSjMiKVMFBH4sCJg00T/
 IYWMs3oNT1Mu0gGKwR6bUd4DCdF+DhIybLRD9hyQlowrQvIl7TXpGrEEZrbfzx5M0Kes
 FryfVVPh5YDUksfdDjdzG8PD7VaizLSEX3+HLdfQ/7y7fa9DZBc+g2V8T8t4acSEEWyx
 PQCBz+t7OK7FOr+SuBvP6WwSeL1pIdlOUOMraGYa3Yayc3bEE1Tfzf09zZ6EbhrCtWod
 cmiXfDvr0aaM7IGglDWGtmjJavRRNy0pqEtt5KGwdrdxOcg0TzhLfH8SefdHOPAiA22V
 Fugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mu2saZOWPED4vR7UdUs4dqcH4IgZTJumToHiRAA4Yio=;
 b=JHeoUcooy57hcPcuZdmqD3lZ9ol5DUNPMsi0ppDu01zVuMybi6jbT0hKIojcO87WsE
 0ftnQEmc6XYdTqkqtATvVy//WWFBSCa2qsPYx4It4r3y8Jmjl3w5mFN1zQzXwAw8VjAV
 xER1jvZmfqG3ZR7lyJk2Uy8yryV0rzXyDcGCVfuT+ZdiRo8GtAchRMJQLJfubAkgcGqp
 M6nxefktIVRV5Pm+RSZGvTayT7GbjUIGlCU9kaxLduasYwI/SAOmpXPKjfFw0WOA9z6X
 DlT9TgwAQmzuKy1PJ8Gp5bmXNxQ5Xfg5uqCTpxzVhqsACYE4D+S9pPvhdnoKLY4+YlMN
 aEEw==
X-Gm-Message-State: AOAM531XW39Lbx+tmkA0JVTSuG9xFJlDZl7Sc1ZUnXxPhlmBE6UIDLDj
 R8r/IJX0ILSGokxqTwUs0k3nWaghNjQ=
X-Google-Smtp-Source: ABdhPJz6aRzlQDR0QhJXKWf57mx2AtPZmdrFBnFdTPkRHgyrr9W7yizLY5tKJ89+ZNG4FqL/R0nJpw==
X-Received: by 2002:a17:90a:266f:: with SMTP id
 l102mr157662pje.190.1591117315795; 
 Tue, 02 Jun 2020 10:01:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h11sm2723630pjk.20.2020.06.02.10.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 10:01:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] tcg: Implement gvec support for rotate by vector
Date: Tue,  2 Jun 2020 10:01:41 -0700
Message-Id: <20200602170151.321389-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602170151.321389-1-richard.henderson@linaro.org>
References: <20200602170151.321389-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

No host backend support yet, but the interfaces for rotlv
and rotrv are in place.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Drop the generic expansion from rot to shift; we can do better
    for each backend, and then this code becomes unused.
---
 accel/tcg/tcg-runtime.h      |  10 +++
 include/tcg/tcg-op-gvec.h    |   4 ++
 include/tcg/tcg-op.h         |   2 +
 include/tcg/tcg-opc.h        |   2 +
 include/tcg/tcg.h            |   1 +
 tcg/aarch64/tcg-target.h     |   1 +
 tcg/i386/tcg-target.h        |   1 +
 tcg/ppc/tcg-target.h         |   1 +
 accel/tcg/tcg-runtime-gvec.c |  96 +++++++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 122 +++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  10 +++
 tcg/tcg.c                    |   3 +
 tcg/README                   |   4 +-
 13 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index cf10c8361e..4eda24e63a 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -279,6 +279,16 @@ DEF_HELPER_FLAGS_4(gvec_sar16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sar32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sar64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_rotl8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_rotl16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_rotl32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_rotl64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_rotr8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_rotr16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_rotr32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_rotr64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_eq8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_eq16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_eq32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index 1afc3ebf03..2d768f1160 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -356,6 +356,10 @@ void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotlv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotrv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 
 void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                       uint32_t aofs, uint32_t bofs,
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 848d91ce74..5523ee7810 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -1009,6 +1009,8 @@ void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+void tcg_gen_rotlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index a6ab4a147f..69f98d6523 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -257,6 +257,8 @@ DEF(sars_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
 DEF(shlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(shrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(sarv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
+DEF(rotlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rotv_vec))
+DEF(rotrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rotv_vec))
 
 DEF(cmp_vec, 1, 2, 1, IMPLVEC)
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 56bedbd03b..b2cb30305c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -183,6 +183,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 225a597f84..a5477bbc07 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -134,6 +134,7 @@ typedef enum {
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 23aabde992..4c806c97db 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -184,6 +184,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index e57b891aa5..7993422526 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -162,6 +162,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_neg_vec          have_isa_3_00
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 34b1030365..521da4a813 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -908,6 +908,102 @@ void HELPER(gvec_sar64v)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_rotl8v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        uint8_t sh = *(uint8_t *)(b + i) & 7;
+        *(uint8_t *)(d + i) = rol8(*(uint8_t *)(a + i), sh);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotl16v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        uint8_t sh = *(uint16_t *)(b + i) & 15;
+        *(uint16_t *)(d + i) = rol16(*(uint16_t *)(a + i), sh);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotl32v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        uint8_t sh = *(uint32_t *)(b + i) & 31;
+        *(uint32_t *)(d + i) = rol32(*(uint32_t *)(a + i), sh);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotl64v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint8_t sh = *(uint64_t *)(b + i) & 63;
+        *(uint64_t *)(d + i) = rol64(*(uint64_t *)(a + i), sh);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotr8v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        uint8_t sh = *(uint8_t *)(b + i) & 7;
+        *(uint8_t *)(d + i) = ror8(*(uint8_t *)(a + i), sh);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotr16v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        uint8_t sh = *(uint16_t *)(b + i) & 15;
+        *(uint16_t *)(d + i) = ror16(*(uint16_t *)(a + i), sh);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotr32v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        uint8_t sh = *(uint32_t *)(b + i) & 31;
+        *(uint32_t *)(d + i) = ror32(*(uint32_t *)(a + i), sh);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotr64v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        uint8_t sh = *(uint64_t *)(b + i) & 63;
+        *(uint64_t *)(d + i) = ror64(*(uint64_t *)(a + i), sh);
+    }
+    clear_high(d, oprsz, desc);
+}
+
 #define DO_CMP1(NAME, TYPE, OP)                                            \
 void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                \
 {                                                                          \
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 25300b1577..2b71725883 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -3171,6 +3171,128 @@ void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
+/*
+ * Similarly for rotates.
+ */
+
+static void tcg_gen_rotlv_mod_vec(unsigned vece, TCGv_vec d,
+                                  TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_rotlv_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+static void tcg_gen_rotl_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_andi_i32(t, b, 31);
+    tcg_gen_rotl_i32(d, a, t);
+    tcg_temp_free_i32(t);
+}
+
+static void tcg_gen_rotl_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(t, b, 63);
+    tcg_gen_rotl_i64(d, a, t);
+    tcg_temp_free_i64(t);
+}
+
+void tcg_gen_gvec_rotlv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_rotlv_vec, 0 };
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_rotlv_mod_vec,
+          .fno = gen_helper_gvec_rotl8v,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_rotlv_mod_vec,
+          .fno = gen_helper_gvec_rotl16v,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_rotl_mod_i32,
+          .fniv = tcg_gen_rotlv_mod_vec,
+          .fno = gen_helper_gvec_rotl32v,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_rotl_mod_i64,
+          .fniv = tcg_gen_rotlv_mod_vec,
+          .fno = gen_helper_gvec_rotl64v,
+          .opt_opc = vecop_list,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+static void tcg_gen_rotrv_mod_vec(unsigned vece, TCGv_vec d,
+                                  TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(d);
+
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_rotrv_vec(vece, d, a, t);
+    tcg_temp_free_vec(t);
+}
+
+static void tcg_gen_rotr_mod_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    tcg_gen_andi_i32(t, b, 31);
+    tcg_gen_rotr_i32(d, a, t);
+    tcg_temp_free_i32(t);
+}
+
+static void tcg_gen_rotr_mod_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(t, b, 63);
+    tcg_gen_rotr_i64(d, a, t);
+    tcg_temp_free_i64(t);
+}
+
+void tcg_gen_gvec_rotrv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_rotrv_vec, 0 };
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_rotrv_mod_vec,
+          .fno = gen_helper_gvec_rotr8v,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_rotrv_mod_vec,
+          .fno = gen_helper_gvec_rotr16v,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_rotr_mod_i32,
+          .fniv = tcg_gen_rotrv_mod_vec,
+          .fno = gen_helper_gvec_rotr32v,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_rotr_mod_i64,
+          .fniv = tcg_gen_rotrv_mod_vec,
+          .fno = gen_helper_gvec_rotr64v,
+          .opt_opc = vecop_list,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
 static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                            uint32_t oprsz, TCGCond cond)
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 660ad9be88..488f9bd27b 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -696,6 +696,16 @@ void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     do_op3_nofail(vece, r, a, b, INDEX_op_sarv_vec);
 }
 
+void tcg_gen_rotlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3_nofail(vece, r, a, b, INDEX_op_rotlv_vec);
+}
+
+void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3_nofail(vece, r, a, b, INDEX_op_rotrv_vec);
+}
+
 static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
                       TCGv_i32 s, TCGOpcode opc_s, TCGOpcode opc_v)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 73a3a4fb9e..bd6ffab79b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1663,6 +1663,9 @@ bool tcg_op_supported(TCGOpcode op)
         return have_vec && TCG_TARGET_HAS_shv_vec;
     case INDEX_op_rotli_vec:
         return have_vec && TCG_TARGET_HAS_roti_vec;
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
+        return have_vec && TCG_TARGET_HAS_rotv_vec;
     case INDEX_op_ssadd_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
diff --git a/tcg/README b/tcg/README
index 1e3e4654f4..a64f67809b 100644
--- a/tcg/README
+++ b/tcg/README
@@ -621,8 +621,10 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 
 * shrv_vec   v0, v1, v2
 * sarv_vec   v0, v1, v2
+* rotlv_vec  v0, v1, v2
+* rotrv_vec  v0, v1, v2
 
-  Similarly for logical and arithmetic right shift.
+  Similarly for logical and arithmetic right shift, and rotates.
 
 * cmp_vec  v0, v1, v2, cond
 
-- 
2.25.1



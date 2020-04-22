Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F80C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC49420575
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovRx8aRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC49420575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4Gh-00033N-Rh
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41i-0002DC-QM
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41d-0002hV-AS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:10 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:42349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41b-0002dB-5C
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:03 -0400
Received: by mail-pg1-x531.google.com with SMTP id g6so248313pgs.9
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I/8aNh0JgOwspHXHoCNpRtPerZWtWFokWr28SOX2pYY=;
 b=ovRx8aRJ1zpE+R+7vOF27VKLX6mBxZB+ifvnDNGFbo1SGa3UXyTedKNGTub1jdHfTa
 F8nVc8oK/NSSWZdQ/fAauoZ3a1JwSV78HH9BkWT9uvRd4RFDQWJtuVwcbj5T6ZGcsPbI
 sSG7aZ315YHZdSldGCvC4ZtVI55QMilCHMqISUbusobPoBdCAvCKr7+1ymvfCQXjzGIO
 HqX4+Xo/4Lm+tbaBISsBsiJbxQf5iwLCe2/CzieDGCcVuJ4t1VdGXMDfYrY9FCnzz/4U
 em/WEJ1OBJx0FMtkOKe0AoXpfvNmiH5VpENfHKeRmkuSMt9kPuKKzUH0mXA5UdT5rkpj
 gv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I/8aNh0JgOwspHXHoCNpRtPerZWtWFokWr28SOX2pYY=;
 b=JI7jdYBA+5iic5mlHZLHhk50k41hbV/IO5RqDr9ScAAxvz9f04M0LF6nY/Pdljrddk
 GmPuMkXi3l6St7k6U9hKH7i01C7sz61zEFon3J+mKhM1zeHn96sj37xRegWF4FMB9/TC
 2UFTSVNL84zOGkHBEWimUB/22m4Ybv/Vh4qn9L0WQoCw2xDWHggYfcZ/Q7VzLjGQ0krt
 xQQk+cqQhCr9W0MuLG2mJ5aQntwqlLuYar7XcV3y9hltY9T8P4+e5uuhSmBA0JNunl1+
 nXDFCnZt+by+KJ134kqSWCcc3CtEfR9oEEhFXHKjd7ObQ2+lqvR/YGYJaaqQq5DaljGx
 ZPPw==
X-Gm-Message-State: AGi0PuZWlNujy1AC+WvHYwnzP2fRMsIZdL6178+bBbWXnzoLzNc6QWgr
 rhWa4C7n/sQguDEDF4xRJIJLd38f5cg=
X-Google-Smtp-Source: APiQypJSxvhrQdhGyLmBMMbH3iorLdJqRHNNP9661MDEy8jq5a78XAtBeL9wN4sh7lXEVtj1Sf2JOA==
X-Received: by 2002:a62:3285:: with SMTP id
 y127mr24596970pfy.234.1587518280416; 
 Tue, 21 Apr 2020 18:18:00 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/36] tcg: Implement gvec support for rotate by vector
Date: Tue, 21 Apr 2020 18:17:15 -0700
Message-Id: <20200422011722.13287-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::531
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No host backend support yet, but the interfaces for rotlv
and rotrv are in place.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
 tcg/tcg-op-vec.c             |  83 ++++++++++++++++++++++++
 tcg/tcg.c                    |   3 +
 tcg/README                   |   4 +-
 13 files changed, 329 insertions(+), 1 deletion(-)

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
index c624e371d5..0468009713 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -996,6 +996,8 @@ void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+void tcg_gen_rotlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c46c096c3e..d80335ba0d 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -254,6 +254,8 @@ DEF(sars_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
 DEF(shlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(shrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
 DEF(sarv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shv_vec))
+DEF(rotlv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rotv_vec))
+DEF(rotrv_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_rotv_vec))
 
 DEF(cmp_vec, 1, 2, 1, IMPLVEC)
 
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index d2034d9334..6bb2e3fe3c 100644
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
index 845cb3de2e..4af92d6b0a 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -129,6 +129,17 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
                 continue;
             }
             break;
+        case INDEX_op_rotlv_vec:
+        case INDEX_op_rotrv_vec:
+            if (tcg_can_emit_vec_op(opc == INDEX_op_rotlv_vec
+                                    ? INDEX_op_rotrv_vec
+                                    : INDEX_op_rotlv_vec, type, vece)) {
+                continue;
+            }
+            if (tcg_can_emit_vec_op(INDEX_op_shlv_vec, type, vece) &&
+                tcg_can_emit_vec_op(INDEX_op_shrv_vec, type, vece)) {
+                continue;
+            }
         default:
             break;
         }
@@ -697,6 +708,78 @@ void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     do_op3_nofail(vece, r, a, b, INDEX_op_sarv_vec);
 }
 
+static void do_rotv(unsigned vece, TCGv_vec r, TCGv_vec a,
+                    TCGv_vec b, bool right)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGTemp *bt = tcgv_vec_temp(b);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGArg bi = temp_arg(bt);
+    TCGType type = rt->base_type;
+    TCGOpcode opc = right ? INDEX_op_rotrv_vec : INDEX_op_rotlv_vec;
+    const TCGOpcode *hold_list;
+    TCGv_vec t;
+    int can;
+
+    tcg_debug_assert(at->base_type >= type);
+    tcg_debug_assert(bt->base_type >= type);
+    tcg_assert_listed_vecop(opc);
+
+    /* Try the requested shift. */
+    can = tcg_can_emit_vec_op(opc, type, vece);
+    if (can) {
+        if (can > 0) {
+            vec_gen_3(opc, type, vece, ri, ai, bi);
+        } else {
+            hold_list = tcg_swap_vecop_list(NULL);
+            tcg_expand_vec_op(opc, type, vece, ri, ai, bi);
+            tcg_swap_vecop_list(hold_list);
+        }
+        return;
+    }
+
+    hold_list = tcg_swap_vecop_list(NULL);
+    t = tcg_temp_new_vec(type);
+    tcg_gen_neg_vec(vece, t, b);
+    tcg_gen_and_vec(vece, t, t, tcg_constant_vec(type, vece, (8 << vece) - 1));
+
+    /* Try the reverse shift. */
+    opc = right ? INDEX_op_rotlv_vec : INDEX_op_rotrv_vec;
+    can = tcg_can_emit_vec_op(opc, type, vece);
+    if (can) {
+        if (can > 0) {
+            vec_gen_3(opc, type, vece, ri, ai, tcgv_vec_arg(t));
+        } else {
+            tcg_expand_vec_op(opc, type, vece, ri, ai, tcgv_vec_arg(t));
+        }
+    } else {
+        /* Fall back to shifts. */
+        if (right) {
+            tcg_gen_shlv_vec(vece, t, a, t);
+            tcg_gen_shrv_vec(vece, r, a, b);
+        } else {
+            tcg_gen_shrv_vec(vece, t, a, t);
+            tcg_gen_shlv_vec(vece, r, a, b);
+        }
+        tcg_gen_or_vec(vece, r, r, t);
+    }
+
+    tcg_temp_free_vec(t);
+    tcg_swap_vecop_list(hold_list);
+}
+
+void tcg_gen_rotlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_rotv(vece, r, a, b, false);
+}
+
+void tcg_gen_rotrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_rotv(vece, r, a, b, true);
+}
+
 static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
                       TCGv_i32 s, TCGOpcode opc_s, TCGOpcode opc_v)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 71409073bb..5a82464610 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1699,6 +1699,9 @@ bool tcg_op_supported(TCGOpcode op)
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
2.20.1



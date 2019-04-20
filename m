Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DA2C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9032F21479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRH8Ra4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9032F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38162 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkdl-0006PJ-PP
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:42:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWi-00005B-De
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWg-00082J-GA
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:08 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWg-000811-7G
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:06 -0400
Received: by mail-pf1-x442.google.com with SMTP id b3so3480545pfd.1
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=N72xGVkYFKWjpoxWm45+VRyg+W9fgYOLsjdxRNRncls=;
	b=PRH8Ra4UXVTJWymwPVmmMzN7rJSJGP4b6L+R5LYPEW90lAEBRgd7wxeforaYEHTLXK
	WQKtDWjec9YuT1DKFethInCc4ejrbqGjcjBG0gKZB6MZfAuEDCcHFTEmw+WV5SubeNBI
	BybJNWVDbMOmI9aSu7lk+6mPWAekuehy/r3tiCQT2VLDhKXwNSY4kcL7GX8lcdYvi8qi
	QgTmgPTC/eJAk7kmwmK7a0/C0baWgIjv/nY9IioacWxBmKldKmjur62pb9OAbq0KBtNN
	ouB2Pi9eJeP4iuGj4rtw+T/1rOk1JvYsqnC7TstcLUxZbnVTZ68+S0kupkBzhzgdOHHv
	3/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=N72xGVkYFKWjpoxWm45+VRyg+W9fgYOLsjdxRNRncls=;
	b=cgxtaP7n0lVKtgijtjEnXOs0uclCyx9tq5x/I6hngSfvwH5EyEk6J1hK3tzsf0zMEq
	2BGFv8UemkbRh+DTUUpdJChlGta7dUy4zWN+nQpelLyj7sFTSlr5oWaBoi8m4T+0Kzhj
	um2EsWG5UAzeePdZTcDPH3ZTNk0jQb5BJ4xTRKhYrFXwMAnrk3dLLR0QGok7ozDzDPqn
	4w7wYKiCRBY436K//X5HOoLGjzOpSMG7TfWZIrE0dE0NWqc9JSDvWM6GQ+ZaqlUs9Bmw
	RNsi6dNKHT9t8IjQ8HSmwtepjSFziFZKwg0l/TTYwLDJVugY1K+E0AvHSV1RGBFCVn6R
	UFNw==
X-Gm-Message-State: APjAAAVKhfHrsThzh+WjiGkzPgPhl2wTF0Dxe30J2uhpMTkCvKSFo1sb
	5kDGHJfp45uBg17ldZcSYh7ad9dsy2I=
X-Google-Smtp-Source: APXvYqwV5pnLys4k/OzdNmSZXGx63j0Xg2poCGyhs31bAt641JfZt4VPCflxauOPxE/VEGA84lJcBQ==
X-Received: by 2002:a62:6807:: with SMTP id d7mr8254995pfc.75.1555745705007;
	Sat, 20 Apr 2019 00:35:05 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:16 -1000
Message-Id: <20190420073442.7488-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 12/38] tcg: Add gvec expanders for variable
 shift
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073416.DIB-oZIKufWQB6XSL7gB4IHZpBuIF3vunZ4TYl3y2pM@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  15 ++++
 tcg/tcg-op-gvec.h            |   7 ++
 tcg/tcg-op.h                 |   4 ++
 accel/tcg/tcg-runtime-gvec.c | 132 +++++++++++++++++++++++++++++++++++
 tcg/tcg-op-gvec.c            |  87 +++++++++++++++++++++++
 tcg/tcg-op-vec.c             |  15 ++++
 6 files changed, 260 insertions(+)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index dfe325625c..ed3ce5fd91 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -254,6 +254,21 @@ DEF_HELPER_FLAGS_3(gvec_sar16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_shl8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shl16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shl32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shl64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_shr8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shr16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shr32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_shr64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_sar8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sar16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sar32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_sar64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_eq8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_eq16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_eq32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 850da32ded..1cd18a959a 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -294,6 +294,13 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                       uint32_t aofs, uint32_t bofs,
                       uint32_t oprsz, uint32_t maxsz);
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 9fff9864f6..833c6330b5 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -986,6 +986,10 @@ void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 
+void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
+
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
 
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index e2c6f24262..7b88f5590c 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -725,6 +725,138 @@ void HELPER(gvec_sar64i)(void *d, void *a, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_shl8v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) << *(uint8_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shl16v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) << *(uint16_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shl32v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) << *(uint32_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shl64v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) << *(uint64_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr8v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) >> *(uint8_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr16v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) >> *(uint16_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr32v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) >> *(uint32_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_shr64v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) >> *(uint64_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar8v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+        *(int8_t *)(d + i) = *(int8_t *)(a + i) >> *(int8_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar16v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
+        *(int16_t *)(d + i) = *(int16_t *)(a + i) >> *(int16_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar32v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+        *(int32_t *)(d + i) = *(int32_t *)(a + i) >> *(int32_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_sar64v)(void *d, void *a, void *b, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+        *(int64_t *)(d + i) = *(int64_t *)(a + i) >> *(int64_t *)(b + i);
+    }
+    clear_high(d, oprsz, desc);
+}
+
 /* If vectors are enabled, the compiler fills in -1 for true.
    Otherwise, we must take care of this by hand.  */
 #ifdef CONFIG_VECTOR16
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index f056018713..5d28184045 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2382,6 +2382,93 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
+void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_shlv_vec,
+          .fno = gen_helper_gvec_shl8v,
+          .opc = INDEX_op_shlv_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_shlv_vec,
+          .fno = gen_helper_gvec_shl16v,
+          .opc = INDEX_op_shlv_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_shl_i32,
+          .fniv = tcg_gen_shlv_vec,
+          .fno = gen_helper_gvec_shl32v,
+          .opc = INDEX_op_shlv_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_shl_i64,
+          .fniv = tcg_gen_shlv_vec,
+          .fno = gen_helper_gvec_shl64v,
+          .opc = INDEX_op_shlv_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_shrv_vec,
+          .fno = gen_helper_gvec_shr8v,
+          .opc = INDEX_op_shrv_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_shrv_vec,
+          .fno = gen_helper_gvec_shr16v,
+          .opc = INDEX_op_shrv_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_shr_i32,
+          .fniv = tcg_gen_shrv_vec,
+          .fno = gen_helper_gvec_shr32v,
+          .opc = INDEX_op_shrv_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_shr_i64,
+          .fniv = tcg_gen_shrv_vec,
+          .fno = gen_helper_gvec_shr64v,
+          .opc = INDEX_op_shrv_vec,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 g[4] = {
+        { .fniv = tcg_gen_sarv_vec,
+          .fno = gen_helper_gvec_sar8v,
+          .opc = INDEX_op_sarv_vec,
+          .vece = MO_8 },
+        { .fniv = tcg_gen_sarv_vec,
+          .fno = gen_helper_gvec_sar16v,
+          .opc = INDEX_op_sarv_vec,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_sar_i32,
+          .fniv = tcg_gen_sarv_vec,
+          .fno = gen_helper_gvec_sar32v,
+          .opc = INDEX_op_sarv_vec,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_sar_i64,
+          .fniv = tcg_gen_sarv_vec,
+          .fno = gen_helper_gvec_sar64v,
+          .opc = INDEX_op_sarv_vec,
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
index ce7987b858..6601cb8a8f 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -481,3 +481,18 @@ void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     do_op3(vece, r, a, b, INDEX_op_umax_vec);
 }
+
+void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_shlv_vec);
+}
+
+void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_shrv_vec);
+}
+
+void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
+{
+    do_op3(vece, r, a, b, INDEX_op_sarv_vec);
+}
-- 
2.17.1



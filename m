Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB553C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:31:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DB6207EA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjErwYD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DB6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCsKN-0004su-Lz
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 18:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCsJF-0003v0-MK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:29:53 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCsJD-00014o-JG
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:29:53 -0400
Received: by mail-pl1-x641.google.com with SMTP id y6so3921180plk.10
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qzG/+wPNG1iJoLQo3NWZTJdQt933K2Vouh6sdpq8zk4=;
 b=WjErwYD9m2quFHbyzB2CWglom+ru2pbIOX6UjmRjuyzP5WCkAydPBfX4vCGR929Wi5
 jw94fCk/aJAG5Z3xHR98zcze1w2bqjv4U+CJrpCAXgetGKJuxspoeA2bXNOoWykPmmIP
 qw640s22b5rHP8FcBabXwpj33r42ckJd4T/5/4gCikzf24X8+tXv166aDnXR5+yeivTY
 jBRiIPLxD8TVJHi9VFcJGafsJIXdkuMolVNx3lx4rSKRU8N1ItSZ9PVBynes+4RMO2Dk
 4PuqUlcngAXgZPBEWwxBMfOp2KUK+7zDAWDwl5ZR+c60J2jZbx/rH+HNtwWJB0JmqTfV
 Yjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qzG/+wPNG1iJoLQo3NWZTJdQt933K2Vouh6sdpq8zk4=;
 b=G6js6c2iOxgsCAjyTnKNhz1St4lqEQI5dJXqcaXhhErLfctjGphJX9/MgDyczDfnkz
 aWiGJ3P6rLPykCHOaivIn9QSpDAqyADpKo5gK4zl9AueNHRjKBjtet2MNoxdDET4cCw3
 abps3jo3kdhkNeCBB3SVpOBGqs8sI+AuNd3DzoH7uOZ0UmocS4T6C+rk5z0ile4MNcz1
 tITreMInBo23VhhzBcFdLUuy+Cm8FhpKU79aJNMeiiNswuQwnLpqx/nZsETcnMG+mQVY
 w08ZEZAkla4RyJyXhyzMRBJu8UAh76eeZdAcBP6smJHJIGVxcFrvN3xYFrSQrhWD865O
 qMDw==
X-Gm-Message-State: AOAM530uMmtfWhBpY4zvXkMTtefUIihfp5sIs6m3Mdd69hgkm9CN8zQ6
 AGUeF/Xwwqkllh8/FKhiwpoHE3DvbkQhWQ==
X-Google-Smtp-Source: ABdhPJzkgwt3XUDZ72MoaCjEwYhXSQl0lh3rupdUJyMW0cuTIcKZfV29Oj7blUt/v2wpRE0DYgiS+g==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr1333624pjj.6.1598912989031; 
 Mon, 31 Aug 2020 15:29:49 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z126sm9391708pfc.94.2020.08.31.15.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 15:29:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] tcg: Adjust simd_desc size encoding
Date: Mon, 31 Aug 2020 15:29:45 -0700
Message-Id: <20200831222945.875453-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831222945.875453-1-richard.henderson@linaro.org>
References: <20200831222945.875453-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: frank.chang@sifive.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With larger vector sizes, it turns out oprsz == maxsz, and we only
need to represent mismatch for oprsz <= 32.  We do, however, need
to represent larger oprsz and do so without reducing SIMD_DATA_BITS.

Reduce the size of the oprsz field and increase the maxsz field.
Steal the oprsz value of 24 to indicate equality with maxsz.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-gvec-desc.h | 38 ++++++++++++++++++++++++-------------
 tcg/tcg-op-gvec.c           | 35 ++++++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
index 0224ac3e78..704bd86454 100644
--- a/include/tcg/tcg-gvec-desc.h
+++ b/include/tcg/tcg-gvec-desc.h
@@ -20,29 +20,41 @@
 #ifndef TCG_TCG_GVEC_DESC_H
 #define TCG_TCG_GVEC_DESC_H
 
-/* ??? These bit widths are set for ARM SVE, maxing out at 256 byte vectors. */
-#define SIMD_OPRSZ_SHIFT   0
-#define SIMD_OPRSZ_BITS    5
+/*
+ * This configuration allows MAXSZ to represent 2048 bytes, and
+ * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.
+ *
+ * Encode this with:
+ *   0, 1, 3 -> 8, 16, 32
+ *   2       -> maxsz
+ *
+ * This steals the input that would otherwise map to 24 to match maxsz.
+ */
+#define SIMD_MAXSZ_SHIFT   0
+#define SIMD_MAXSZ_BITS    8
 
-#define SIMD_MAXSZ_SHIFT   (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
-#define SIMD_MAXSZ_BITS    5
+#define SIMD_OPRSZ_SHIFT   (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
+#define SIMD_OPRSZ_BITS    2
 
-#define SIMD_DATA_SHIFT    (SIMD_MAXSZ_SHIFT + SIMD_MAXSZ_BITS)
+#define SIMD_DATA_SHIFT    (SIMD_OPRSZ_SHIFT + SIMD_OPRSZ_BITS)
 #define SIMD_DATA_BITS     (32 - SIMD_DATA_SHIFT)
 
 /* Create a descriptor from components.  */
 uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data);
 
-/* Extract the operation size from a descriptor.  */
-static inline intptr_t simd_oprsz(uint32_t desc)
-{
-    return (extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS) + 1) * 8;
-}
-
 /* Extract the max vector size from a descriptor.  */
 static inline intptr_t simd_maxsz(uint32_t desc)
 {
-    return (extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) + 1) * 8;
+    return extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) * 8 + 8;
+}
+
+/* Extract the operation size from a descriptor.  */
+static inline intptr_t simd_oprsz(uint32_t desc)
+{
+    uint32_t f = extract32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS);
+    intptr_t o = f * 8 + 8;
+    intptr_t m = simd_maxsz(desc);
+    return f == 2 ? m : o;
 }
 
 /* Extract the operation-specific data from a descriptor.  */
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 7ebd9e8298..ddbe06b71a 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -37,11 +37,21 @@ static const TCGOpcode vecop_list_empty[1] = { 0 };
    of the operand offsets so that we can check them all at once.  */
 static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
 {
-    uint32_t opr_align = oprsz >= 16 ? 15 : 7;
-    uint32_t max_align = maxsz >= 16 || oprsz >= 16 ? 15 : 7;
-    tcg_debug_assert(oprsz > 0);
-    tcg_debug_assert(oprsz <= maxsz);
-    tcg_debug_assert((oprsz & opr_align) == 0);
+    uint32_t max_align;
+
+    switch (oprsz) {
+    case 8:
+    case 16:
+    case 32:
+        tcg_debug_assert(oprsz <= maxsz);
+        break;
+    default:
+        tcg_debug_assert(oprsz == maxsz);
+        break;
+    }
+    tcg_debug_assert(maxsz <= (8 << SIMD_MAXSZ_BITS));
+
+    max_align = maxsz >= 16 ? 15 : 7;
     tcg_debug_assert((maxsz & max_align) == 0);
     tcg_debug_assert((ofs & max_align) == 0);
 }
@@ -77,12 +87,21 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
 {
     uint32_t desc = 0;
 
-    assert(oprsz % 8 == 0 && oprsz <= (8 << SIMD_OPRSZ_BITS));
-    assert(maxsz % 8 == 0 && maxsz <= (8 << SIMD_MAXSZ_BITS));
-    assert(data == sextract32(data, 0, SIMD_DATA_BITS));
+    check_size_align(oprsz, maxsz, 0);
+    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));
 
     oprsz = (oprsz / 8) - 1;
     maxsz = (maxsz / 8) - 1;
+
+    /*
+     * We have just asserted in check_size_align that either
+     * oprsz is {8,16,32} or matches maxsz.  Encode the final
+     * case with '2', as that would otherwise map to 24.
+     */
+    if (oprsz == maxsz) {
+        oprsz = 2;
+    }
+
     desc = deposit32(desc, SIMD_OPRSZ_SHIFT, SIMD_OPRSZ_BITS, oprsz);
     desc = deposit32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS, maxsz);
     desc = deposit32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS, data);
-- 
2.25.1



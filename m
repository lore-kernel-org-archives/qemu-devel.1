Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD0DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A6920C09
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDPPrj8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A6920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFDI-0003yx-Ah
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF5K-0001zC-04
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF5H-0007ZY-Sw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:17 -0400
Received: by mail-wr1-x441.google.com with SMTP id j10so21556315wrw.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ewe6RYNvrMPtXGvRt+OIItTfxTHNlzfYc6x9hP/Letk=;
 b=KDPPrj8kGdB40oU2FH+gCimGrkRl01AUQvVJMJbXNoVZkllYDvzpumAY66Hxe/RHpI
 UYKTlqs7x2quDFVCUetyDslh7lY07mYXvXn2M6HJsAwS2Fyxti37H74A5NJ2nLNEotn9
 IYUtKxzhFTMMKsDgbM9aRQqcLInyt0catja1uW/GMRC8YbNkDRzWqNrmwgw29mLs5Xxt
 j1TxY3zblnObbGQJsj9aKfWVUJg5viO7UvGh57lN0AptJep9CuaNpBzC8We2tur3jckx
 chIVl/kO8LWKVS/NZG9E1D36vS3D3MLQ2rX+RsxWFqPfZMx2DyMdiBgqzGUhRwDkX/Go
 odPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ewe6RYNvrMPtXGvRt+OIItTfxTHNlzfYc6x9hP/Letk=;
 b=eSAwtVPCclnjQF6MEsOTiqxJSVVlUWuX2nrFj82LQwsvt9D/DwPr2938ThYVsG5z7E
 m17Yiv9i+vTw6gfzFkw5CvXove2y3QTPPfotjH9cPYm/f69QGBu5OQXQE2oNL7OP5MJv
 6XQmv/nn6vcEDrALjouVu81uJ8jxnoKCfOiTG6i3LbGb06KKPzf+1BHo90at6q2tlfSk
 Pzqg2pBHH87BX2463CpXm0YpGJsV+rldULRzJ1cXjlOOFm0GxOVHQDj3q8rbiNoVdb3w
 5tZklpJ9sUZu8hiJW6cDVPtnp07GPyWugyhUMXIMN00R4UAiqKgYNbzXBu5BtLb9yFjn
 tY6w==
X-Gm-Message-State: AOAM533urVn3Bcfqli6w2wyKs24kHC0dMPYWJdcBSr15KNjrqjY3bNOm
 3kE41S7fooac4W4A9gB7PwzAqVP6BYRHSw==
X-Google-Smtp-Source: ABdhPJwPiZF1SyXWTZo5y1BwHCSpRAcwuO+UT1vKAcnDajRQeo/cqD523vqqz/kMeAMtSIL11/LDgg==
X-Received: by 2002:adf:f990:: with SMTP id f16mr3958793wrr.311.1592327354387; 
 Tue, 16 Jun 2020 10:09:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:09:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 21/21] target/arm: Move some functions used only in
 translate-neon.inc.c to that file
Date: Tue, 16 Jun 2020 18:08:44 +0100
Message-Id: <20200616170844.13318-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions neon_element_offset(), neon_load_element(),
neon_load_element64(), neon_store_element() and
neon_store_element64() are used only in the translate-neon.inc.c
file, so move their definitions there.

Since the .inc.c file is #included in translate.c this doesn't make
much difference currently, but it's a more logical place to put the
functions and it might be helpful if we ever decide to try to make
the .inc.c files genuinely separate compilation units.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.inc.c | 101 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 101 --------------------------------
 2 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 8cc7f5db544..f6cb9215739 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -54,6 +54,107 @@ static inline int rsub_8(DisasContext *s, int x)
 #include "decode-neon-ls.inc.c"
 #include "decode-neon-shared.inc.c"
 
+/* Return the offset of a 2**SIZE piece of a NEON register, at index ELE,
+ * where 0 is the least significant end of the register.
+ */
+static inline long
+neon_element_offset(int reg, int element, MemOp size)
+{
+    int element_size = 1 << size;
+    int ofs = element * element_size;
+#ifdef HOST_WORDS_BIGENDIAN
+    /* Calculate the offset assuming fully little-endian,
+     * then XOR to account for the order of the 8-byte units.
+     */
+    if (element_size < 8) {
+        ofs ^= 8 - element_size;
+    }
+#endif
+    return neon_reg_offset(reg, 0) + ofs;
+}
+
+static void neon_load_element(TCGv_i32 var, int reg, int ele, MemOp mop)
+{
+    long offset = neon_element_offset(reg, ele, mop & MO_SIZE);
+
+    switch (mop) {
+    case MO_UB:
+        tcg_gen_ld8u_i32(var, cpu_env, offset);
+        break;
+    case MO_UW:
+        tcg_gen_ld16u_i32(var, cpu_env, offset);
+        break;
+    case MO_UL:
+        tcg_gen_ld_i32(var, cpu_env, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void neon_load_element64(TCGv_i64 var, int reg, int ele, MemOp mop)
+{
+    long offset = neon_element_offset(reg, ele, mop & MO_SIZE);
+
+    switch (mop) {
+    case MO_UB:
+        tcg_gen_ld8u_i64(var, cpu_env, offset);
+        break;
+    case MO_UW:
+        tcg_gen_ld16u_i64(var, cpu_env, offset);
+        break;
+    case MO_UL:
+        tcg_gen_ld32u_i64(var, cpu_env, offset);
+        break;
+    case MO_Q:
+        tcg_gen_ld_i64(var, cpu_env, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void neon_store_element(int reg, int ele, MemOp size, TCGv_i32 var)
+{
+    long offset = neon_element_offset(reg, ele, size);
+
+    switch (size) {
+    case MO_8:
+        tcg_gen_st8_i32(var, cpu_env, offset);
+        break;
+    case MO_16:
+        tcg_gen_st16_i32(var, cpu_env, offset);
+        break;
+    case MO_32:
+        tcg_gen_st_i32(var, cpu_env, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void neon_store_element64(int reg, int ele, MemOp size, TCGv_i64 var)
+{
+    long offset = neon_element_offset(reg, ele, size);
+
+    switch (size) {
+    case MO_8:
+        tcg_gen_st8_i64(var, cpu_env, offset);
+        break;
+    case MO_16:
+        tcg_gen_st16_i64(var, cpu_env, offset);
+        break;
+    case MO_32:
+        tcg_gen_st32_i64(var, cpu_env, offset);
+        break;
+    case MO_64:
+        tcg_gen_st_i64(var, cpu_env, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
 {
     int opr_sz;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 581b0b5cde4..408fb7a492f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1133,25 +1133,6 @@ neon_reg_offset (int reg, int n)
     return vfp_reg_offset(0, sreg);
 }
 
-/* Return the offset of a 2**SIZE piece of a NEON register, at index ELE,
- * where 0 is the least significant end of the register.
- */
-static inline long
-neon_element_offset(int reg, int element, MemOp size)
-{
-    int element_size = 1 << size;
-    int ofs = element * element_size;
-#ifdef HOST_WORDS_BIGENDIAN
-    /* Calculate the offset assuming fully little-endian,
-     * then XOR to account for the order of the 8-byte units.
-     */
-    if (element_size < 8) {
-        ofs ^= 8 - element_size;
-    }
-#endif
-    return neon_reg_offset(reg, 0) + ofs;
-}
-
 static TCGv_i32 neon_load_reg(int reg, int pass)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
@@ -1159,94 +1140,12 @@ static TCGv_i32 neon_load_reg(int reg, int pass)
     return tmp;
 }
 
-static void neon_load_element(TCGv_i32 var, int reg, int ele, MemOp mop)
-{
-    long offset = neon_element_offset(reg, ele, mop & MO_SIZE);
-
-    switch (mop) {
-    case MO_UB:
-        tcg_gen_ld8u_i32(var, cpu_env, offset);
-        break;
-    case MO_UW:
-        tcg_gen_ld16u_i32(var, cpu_env, offset);
-        break;
-    case MO_UL:
-        tcg_gen_ld_i32(var, cpu_env, offset);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void neon_load_element64(TCGv_i64 var, int reg, int ele, MemOp mop)
-{
-    long offset = neon_element_offset(reg, ele, mop & MO_SIZE);
-
-    switch (mop) {
-    case MO_UB:
-        tcg_gen_ld8u_i64(var, cpu_env, offset);
-        break;
-    case MO_UW:
-        tcg_gen_ld16u_i64(var, cpu_env, offset);
-        break;
-    case MO_UL:
-        tcg_gen_ld32u_i64(var, cpu_env, offset);
-        break;
-    case MO_Q:
-        tcg_gen_ld_i64(var, cpu_env, offset);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static void neon_store_reg(int reg, int pass, TCGv_i32 var)
 {
     tcg_gen_st_i32(var, cpu_env, neon_reg_offset(reg, pass));
     tcg_temp_free_i32(var);
 }
 
-static void neon_store_element(int reg, int ele, MemOp size, TCGv_i32 var)
-{
-    long offset = neon_element_offset(reg, ele, size);
-
-    switch (size) {
-    case MO_8:
-        tcg_gen_st8_i32(var, cpu_env, offset);
-        break;
-    case MO_16:
-        tcg_gen_st16_i32(var, cpu_env, offset);
-        break;
-    case MO_32:
-        tcg_gen_st_i32(var, cpu_env, offset);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-static void neon_store_element64(int reg, int ele, MemOp size, TCGv_i64 var)
-{
-    long offset = neon_element_offset(reg, ele, size);
-
-    switch (size) {
-    case MO_8:
-        tcg_gen_st8_i64(var, cpu_env, offset);
-        break;
-    case MO_16:
-        tcg_gen_st16_i64(var, cpu_env, offset);
-        break;
-    case MO_32:
-        tcg_gen_st32_i64(var, cpu_env, offset);
-        break;
-    case MO_64:
-        tcg_gen_st_i64(var, cpu_env, offset);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static inline void neon_load_reg64(TCGv_i64 var, int reg)
 {
     tcg_gen_ld_i64(var, cpu_env, vfp_reg_offset(1, reg));
-- 
2.20.1



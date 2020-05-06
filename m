Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6546C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D8C20736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ni0ndTOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D8C20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOus-0004Xr-Dd
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOoC-0004Wp-TX
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:42497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOoB-000322-Pt
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:16 -0400
Received: by mail-pl1-x62f.google.com with SMTP id k19so840419pll.9
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5T7KJt0fc54mlBnT3n+g8HKCVqPFI5bG2HmAN7UzeMM=;
 b=Ni0ndTOTAzGD9lLZwVhYDZ1BPwZUVeSQEyaIDRMAN3+adJjO4CzkeXGW9GLFHHNLE0
 qqI2C+Bk/NTYxlXlt44vavQUSqxYY1fj4Bvbai9wSGQfPef4hnwFfqGuwOWHGR1xUZl6
 chZEdqA/OyDDWxLYI1icvgjhcxY72OdK7h3whhdfSlkMOO9O8TwDUzvXsPme+hxTy6hG
 k1AfyFTVp+cQzvjlB1Am2i50ctzlPsbYJb5qYfhECC9HLbnkQS+d8V1GLdXLG/D4ekAs
 NZQFYQa/caYEIabY4D9wwKmZzltNBYfiGbWAzWyoSZ4ep+Chwdje2j7w8deu9ORLIPPM
 cfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5T7KJt0fc54mlBnT3n+g8HKCVqPFI5bG2HmAN7UzeMM=;
 b=pm6jvkXW0YplcQ8WZ3XTk6qgukspuks8QXP3ylK5PiKvi69StzYPlI2bR+q5dTPhMu
 Jb6OipHws0V3mCbP/lC9Ld0zLOeod0tFuo9YFhQ5ZDU1LeA7k0LGiP6Oz+V8o7eITfWe
 DmtyZFdJHNR7FMnxpS6LG9m3TtJRegjvkjZcTYnlCMVFE0/0E0kEvDG17e9r/KoUynfY
 gBAdXQsQRrLnMBJAgf5P5jSD8bB0AJ/zsv90KN44iiyPcNHyg0IKjWGR/IUfiNMsFbME
 B3B64wPeYILClyM7KMH3GwfW+27wmBLHb0u9J+F1T7XH422SS1S7ukbQ3dVBiI9XFMPG
 C5Og==
X-Gm-Message-State: AGi0PuZ9r76dtLcPCiZ/SjZgV0QgCi85ggG2fNHaeYqrfFuKd0TaqZZQ
 BNN/qBJmjM35/5hhIx60GRBsQ3baZmY=
X-Google-Smtp-Source: APiQypJQprjFmXJv+O3vV4Af/DkLIOky65FvOgvEGyXy2MZYmnUxGD9xKUFNEp0x7t2ShkRzcOct8Q==
X-Received: by 2002:a17:902:bb82:: with SMTP id
 m2mr8934335pls.291.1588789813915; 
 Wed, 06 May 2020 11:30:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/10] tcg: Improve vector tail clearing
Date: Wed,  6 May 2020 11:30:00 -0700
Message-Id: <20200506183002.3192-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Better handling of non-power-of-2 tails as seen with Arm 8-byte
vector operations.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 82 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 19 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 5a6cc19812..43cac1a0bf 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -326,11 +326,34 @@ void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
    in units of LNSZ.  This limits the expansion of inline code.  */
 static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
 {
-    if (oprsz % lnsz == 0) {
-        uint32_t lnct = oprsz / lnsz;
-        return lnct >= 1 && lnct <= MAX_UNROLL;
+    uint32_t q, r;
+
+    if (oprsz < lnsz) {
+        return false;
     }
-    return false;
+
+    q = oprsz / lnsz;
+    r = oprsz % lnsz;
+    tcg_debug_assert((r & 7) == 0);
+
+    if (lnsz < 16) {
+        /* For sizes below 16, accept no remainder. */
+        if (r != 0) {
+            return false;
+        }
+    } else {
+        /*
+         * Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         * In addition, expand_clr needs to handle a multiple of 8.
+         * Thus we can handle the tail with one more operation per
+         * diminishing power of 2.
+         */
+        q += ctpop32(r);
+    }
+
+    return q <= MAX_UNROLL;
 }
 
 static void expand_clr(uint32_t dofs, uint32_t maxsz);
@@ -402,22 +425,31 @@ static void gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
 static TCGType choose_vector_type(const TCGOpcode *list, unsigned vece,
                                   uint32_t size, bool prefer_i64)
 {
-    if (TCG_TARGET_HAS_v256 && check_size_impl(size, 32)) {
-        /*
-         * Recall that ARM SVE allows vector sizes that are not a
-         * power of 2, but always a multiple of 16.  The intent is
-         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
-         * It is hard to imagine a case in which v256 is supported
-         * but v128 is not, but check anyway.
-         */
-        if (tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece)
-            && (size % 32 == 0
-                || tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) {
-            return TCG_TYPE_V256;
-        }
+    /*
+     * Recall that ARM SVE allows vector sizes that are not a
+     * power of 2, but always a multiple of 16.  The intent is
+     * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+     * It is hard to imagine a case in which v256 is supported
+     * but v128 is not, but check anyway.
+     * In addition, expand_clr needs to handle a multiple of 8.
+     */
+    if (TCG_TARGET_HAS_v256 &&
+        check_size_impl(size, 32) &&
+        tcg_can_emit_vecop_list(list, TCG_TYPE_V256, vece) &&
+        (!(size & 16) ||
+         (TCG_TARGET_HAS_v128 &&
+          tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece))) &&
+        (!(size & 8) ||
+         (TCG_TARGET_HAS_v64 &&
+          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {
+        return TCG_TYPE_V256;
     }
-    if (TCG_TARGET_HAS_v128 && check_size_impl(size, 16)
-        && tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece)) {
+    if (TCG_TARGET_HAS_v128 &&
+        check_size_impl(size, 16) &&
+        tcg_can_emit_vecop_list(list, TCG_TYPE_V128, vece) &&
+        (!(size & 8) ||
+         (TCG_TARGET_HAS_v64 &&
+          tcg_can_emit_vecop_list(list, TCG_TYPE_V64, vece)))) {
         return TCG_TYPE_V128;
     }
     if (TCG_TARGET_HAS_v64 && !prefer_i64 && check_size_impl(size, 8)
@@ -432,6 +464,18 @@ static void do_dup_store(TCGType type, uint32_t dofs, uint32_t oprsz,
 {
     uint32_t i = 0;
 
+    tcg_debug_assert(oprsz >= 8);
+
+    /*
+     * This may be expand_clr for the tail of an operation, e.g.
+     * oprsz == 8 && maxsz == 64.  The first 8 bytes of this store
+     * are misaligned wrt the maximum vector size, so do that first.
+     */
+    if (dofs & 8) {
+        tcg_gen_stl_vec(t_vec, cpu_env, dofs + i, TCG_TYPE_V64);
+        i += 8;
+    }
+
     switch (type) {
     case TCG_TYPE_V256:
         /*
-- 
2.20.1



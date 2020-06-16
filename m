Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E0F20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B+oIK/0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E0F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF7W-0006so-5O
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4u-0000zI-A1
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4s-0007QT-Il
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id r9so3583884wmh.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xWDTix/EFrDbpFYcthSvvgWszuD0YBkrPi92WsJkrek=;
 b=B+oIK/0UaCUu8kjSV1lidcxOl9ORLboEDGyaNq6SiX+YIWndub5PlD5ki+csGnIk+q
 T5PMaNZMOubupQ9hvo/HYGFfEW267BZhJIPC1nL090d2/utWXcJrcaW4SSD49aw8+mCF
 L3d+wJkuAGbj3tHtvx0bGNY8d770vw1FR21hP7RBtxXdBEw1k0lAmEiMVMnanKq7t9R+
 qoiklSoGdAjyr1rgCev7OY7y/anUyaA0eVbeEqMXd+cpFWLANQht+LJjBznvD0GPQh3z
 G7Ml+zb9v8OeAJxaj4wZhdwr4mtlYwPH28HlLWQbajMHq/fvXxAWwNhRK+6TxLzM/ymh
 jbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xWDTix/EFrDbpFYcthSvvgWszuD0YBkrPi92WsJkrek=;
 b=WJ0IMx7Xe3+KMY8Tq0vqDo0FbYty8j/VxNyjILlENR3aIydSihmJ1r8futBxIgUT/r
 XvTQ813lwI14TvGWrX+YKST4HHnqemM2Qyv9CGuVi9Dl+0cBEysXF+Nomwj7bHLtpIB3
 kau36iOYacb08Zl0JIitAYLGuY28yBJNx4SHiVaetwkPScu4EISEiihIjqeabMYLxv7h
 B5adT/MAffu7L+4E0Av5pehGBuXrL6n7bvnd+riO1EXUj3aHyGR8yW9u/eDANBbTuzf5
 5SlpmjCerulVKvSCN7F04VtJU5/F81ofK+oUSvqVnOaLfEkgjbg0+5jxHP7Tyn8fYlJ7
 Sstg==
X-Gm-Message-State: AOAM533epIRUsISufdwBVv477u6gCa7ptJDLuFXBbhxa3e/kac63b57K
 s9fHvVufsm5cFu8MoU5RBlVtJ63lsbdP3Q==
X-Google-Smtp-Source: ABdhPJy6/DUOc7a7VNYQHK080uHCs0jcKB17ju9diR0UjJjv71M0YGBk1xQ8h5JgNPSWesKmBfngsw==
X-Received: by 2002:a1c:2b01:: with SMTP id r1mr4463121wmr.26.1592327329086;
 Tue, 16 Jun 2020 10:08:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:08:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/21] target/arm: Convert Neon 2-reg-misc VREV64 to decodetree
Date: Tue, 16 Jun 2020 18:08:24 +0100
Message-Id: <20200616170844.13318-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

Convert the Neon VREV64 insn from the 2-reg-misc grouping to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 12 ++++++++
 target/arm/translate-neon.inc.c | 50 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 24 ++--------------
 3 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 6d890b2161f..e12fdf30957 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -429,6 +429,18 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
                  vm=%vm_dp vd=%vd_dp size=1
     VDUP_scalar  1111 001 1 1 . 11 index:1 100 .... 11 000 q:1 . 0 .... \
                  vm=%vm_dp vd=%vd_dp size=2
+
+    ##################################################################
+    # 2-reg-misc grouping:
+    # 1111 001 11 D 11 size:2 opc1:2 Vd:4 0 opc2:4 q:1 M 0 Vm:4
+    ##################################################################
+
+    &2misc vd vm q size
+
+    @2misc       .... ... .. . .. size:2 .. .... . .... q:1 . . .... \
+                 &2misc vm=%vm_dp vd=%vd_dp
+
+    VREV64       1111 001 11 . 11 .. 00 .... 0 0000 . . 0 .... @2misc
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index a5aa56bbdeb..90431a5383f 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2970,3 +2970,53 @@ static bool trans_VDUP_scalar(DisasContext *s, arg_VDUP_scalar *a)
                          a->q ? 16 : 8, a->q ? 16 : 8);
     return true;
 }
+
+static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
+{
+    int pass, half;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (a->size == 3) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
+        TCGv_i32 tmp[2];
+
+        for (half = 0; half < 2; half++) {
+            tmp[half] = neon_load_reg(a->vm, pass * 2 + half);
+            switch (a->size) {
+            case 0:
+                tcg_gen_bswap32_i32(tmp[half], tmp[half]);
+                break;
+            case 1:
+                gen_swap_half(tmp[half]);
+                break;
+            case 2:
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        }
+        neon_store_reg(a->vd, pass * 2, tmp[1]);
+        neon_store_reg(a->vd, pass * 2 + 1, tmp[0]);
+    }
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6d18892adee..5fca38b5fae 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5092,28 +5092,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
                 switch (op) {
                 case NEON_2RM_VREV64:
-                    for (pass = 0; pass < (q ? 2 : 1); pass++) {
-                        tmp = neon_load_reg(rm, pass * 2);
-                        tmp2 = neon_load_reg(rm, pass * 2 + 1);
-                        switch (size) {
-                        case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-                        case 1: gen_swap_half(tmp); break;
-                        case 2: /* no-op */ break;
-                        default: abort();
-                        }
-                        neon_store_reg(rd, pass * 2 + 1, tmp);
-                        if (size == 2) {
-                            neon_store_reg(rd, pass * 2, tmp2);
-                        } else {
-                            switch (size) {
-                            case 0: tcg_gen_bswap32_i32(tmp2, tmp2); break;
-                            case 1: gen_swap_half(tmp2); break;
-                            default: abort();
-                            }
-                            neon_store_reg(rd, pass * 2, tmp2);
-                        }
-                    }
-                    break;
+                    /* handled by decodetree */
+                    return 1;
                 case NEON_2RM_VPADDL: case NEON_2RM_VPADDL_U:
                 case NEON_2RM_VPADAL: case NEON_2RM_VPADAL_U:
                     for (pass = 0; pass < q + 1; pass++) {
-- 
2.20.1



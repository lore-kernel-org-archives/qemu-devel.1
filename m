Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ECAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B324F20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpTTNQEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B324F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhMr-0005dC-Ud
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGw-0002kJ-2W
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGu-0003Dj-2x
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id g18so11114071wrm.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XEz9aOiwlhiwYQ8HFwvN6jyP04S2sQhksx+qSIIGvQs=;
 b=xpTTNQEeIu+CwzIkSoyWeOQCnNMERKfnZJUuNe1JPB14qRZZIjmghfq2NywOpo6b0I
 3jwrP1Ifz8n7OtgmKGOBJBJGYEyocF3HEF4HIwKnzW2KacBDgJkRFiprw+8E7wTr24dR
 nJEa3Hp9k6Q57kiIY+4LBY0KPeOaWKlBPJn498Pc28RIiaUBowQoIROM0PvggUUvkfo0
 X388NQKwG6Vc1NZu23kf4Xun/Y8AqiQoWS++OvSt20WX2yDKz3sf8vveTmfsqrhqr9iV
 qSYpfuJ+EGQ1yp/ZjXe42eE+g27t+uxbv5JGTe6y6vmV9cwYg8ZbDuaEPN7zBkLgOLhw
 PnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XEz9aOiwlhiwYQ8HFwvN6jyP04S2sQhksx+qSIIGvQs=;
 b=GWSNadnckkG0yYdWYfZjeipxFza2L0VZaKNE3emx4+elFm/sldFy3dbeTaNIi//XKr
 EgNiPNkxy8Whf7Ei8I/I+6dc/xy0Is5bgbW4E9rSFqcWn1JrQL8klJYqzkwVYgziQT73
 RdEC+EgEHV1UMF2qnh67K06agZCeP1/DZTxVraphfDfFVk1TGmGBYsrs1tRtMxINQAD/
 Baa6n2JCbSQsCyc6n/GyxbRLpNTG/mSIdIhuiPzsA6yawhk2OqD+sS2fpkJk+36yUF8C
 edieb1uChRCtnSN6lHUpkw2118RzpUitaWZ9nTIW1DEV0GGk+lKLEf3TNPGG2IDH3DIJ
 dWrA==
X-Gm-Message-State: AOAM533Rz/JZ1FV2k20sfs7rj70jNUlh067iUjbZlTWfadTb8QEHFUHQ
 OIvq7/lj/U+856YNlcn5z5Fwgv0KNdqhZw==
X-Google-Smtp-Source: ABdhPJzjkZPRnYpsiJ5XvP3qMqBcPBqk4zPSsWi26IeV3bbE0gHkkakA8f5Zv8zvl2hYlG38Xk3T1w==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr14668687wrr.266.1592912362243; 
 Tue, 23 Jun 2020 04:39:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/42] target/arm: Convert Neon 2-reg-misc VREV32 and VREV16 to
 decodetree
Date: Tue, 23 Jun 2020 12:38:36 +0100
Message-Id: <20200623113904.28805-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VREV32 and VREV16 insns in the Neon 2-reg-misc group
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-13-peter.maydell@linaro.org
---
 target/arm/translate.h          |  1 +
 target/arm/neon-dp.decode       |  2 ++
 target/arm/translate-neon.inc.c | 55 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 12 ++-----
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 467c5291101..4dbeee4c89f 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -363,6 +363,7 @@ typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 
 /* Function prototype for gen_ functions for calling Neon helpers */
+typedef void NeonGenOneOpFn(TCGv_i32, TCGv_i32);
 typedef void NeonGenOneOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32);
 typedef void NeonGenTwoOpFn(TCGv_i32, TCGv_i32, TCGv_i32);
 typedef void NeonGenTwoOpEnvFn(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 86b1b9e34bf..0a791af46c8 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -445,6 +445,8 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
                  &2misc vm=%vm_dp vd=%vd_dp q=1
 
     VREV64       1111 001 11 . 11 .. 00 .... 0 0000 . . 0 .... @2misc
+    VREV32       1111 001 11 . 11 .. 00 .... 0 0001 . . 0 .... @2misc
+    VREV16       1111 001 11 . 11 .. 00 .... 0 0010 . . 0 .... @2misc
 
     VPADDL_S     1111 001 11 . 11 .. 00 .... 0 0100 . . 0 .... @2misc
     VPADDL_U     1111 001 11 . 11 .. 00 .... 0 0101 . . 0 .... @2misc
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 4967e974386..0a779980d01 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3547,3 +3547,58 @@ DO_2M_CRYPTO(AESIMC, aa32_aes, 0)
 DO_2M_CRYPTO(SHA1H, aa32_sha1, 2)
 DO_2M_CRYPTO(SHA1SU1, aa32_sha1, 2)
 DO_2M_CRYPTO(SHA256SU0, aa32_sha2, 2)
+
+static bool do_2misc(DisasContext *s, arg_2misc *a, NeonGenOneOpFn *fn)
+{
+    int pass;
+
+    /* Handle a 2-reg-misc operation by iterating 32 bits at a time */
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
+    if (!fn) {
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        TCGv_i32 tmp = neon_load_reg(a->vm, pass);
+        fn(tmp, tmp);
+        neon_store_reg(a->vd, pass, tmp);
+    }
+
+    return true;
+}
+
+static bool trans_VREV32(DisasContext *s, arg_2misc *a)
+{
+    static NeonGenOneOpFn * const fn[] = {
+        tcg_gen_bswap32_i32,
+        gen_swap_half,
+        NULL,
+        NULL,
+    };
+    return do_2misc(s, a, fn[a->size]);
+}
+
+static bool trans_VREV16(DisasContext *s, arg_2misc *a)
+{
+    if (a->size != 0) {
+        return false;
+    }
+    return do_2misc(s, a, gen_rev16);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 64b18a95b64..5b50eddd111 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4936,6 +4936,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_AESE: case NEON_2RM_AESMC:
                 case NEON_2RM_SHA1H:
                 case NEON_2RM_SHA1SU1:
+                case NEON_2RM_VREV32:
+                case NEON_2RM_VREV16:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4957,16 +4959,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     for (pass = 0; pass < (q ? 4 : 2); pass++) {
                         tmp = neon_load_reg(rm, pass);
                         switch (op) {
-                        case NEON_2RM_VREV32:
-                            switch (size) {
-                            case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-                            case 1: gen_swap_half(tmp, tmp); break;
-                            default: abort();
-                            }
-                            break;
-                        case NEON_2RM_VREV16:
-                            gen_rev16(tmp, tmp);
-                            break;
                         case NEON_2RM_VCLS:
                             switch (size) {
                             case 0: gen_helper_neon_cls_s8(tmp, tmp); break;
-- 
2.20.1



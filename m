Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0FCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB7521475
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4yfs12Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB7521475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFBT-00010b-1W
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF58-0001Ur-Ar
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:06 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF56-0007V7-Cp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id t18so21579375wru.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MMCxjLv+7WRojX6ZDXGB9ezsqw5NM5e5KUtfRRuMaFY=;
 b=w4yfs12Q65hwrAAX1/Ynd69rOo5J5LYT7c6yDcOAhxkU8fm/nI8hhDEnDauUPbSsuw
 +mHvBINpr9HX4IgAYh/qg4oeidn/9HSDlytlMPnj9Ve/fR+sdzYoxznejmohlQUJPBgc
 j+dGNZsbKK6KO7DAGVLlAVL306bGYTP1aDgyMNb9JAWWfOScKRpsrHb6EKqr+5KnHca5
 f0lfXiUulyI5RNgyIdriWt0w9SJMAwYLvAh0mn90VpMnIdxxUMlSmOSjFTJWZ8cubeb/
 zsa3vo9HXvGOHGolidrK8AG26l5DtM0xIFS29HVH19/Qvw9AXcWRvXWhzqjdnH/zK8AL
 uoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MMCxjLv+7WRojX6ZDXGB9ezsqw5NM5e5KUtfRRuMaFY=;
 b=AzR3JhsnEmcUA6Q4a17WsQyclpwcIhR6KiSLrOXueFd72hTNOMIYV2eRlWm27GOKdn
 w78FJdSKX8Sp8ygkvORHOLHxQYXeUjz8EVm/zx2e/liip4nB7X2Whm4OewJ6wmdYWpRh
 ROGRx9c9sDUUtsRBG4IO5oVHvdfQTpKdlqlvINPniY5PzWTOKaSDPG14BuO5rQ0KMRpN
 xqDARzuZPfKSo/Q6FTIBY5C0+uOpFPvFBmt5cerGtBVJ2l7IuXIsDwNN7UGCVr0dX798
 1Awxsucs44jpKevrVVGbgb14ucduHi/sbF+2EfaP7BPZGlEj3l6hbu5zhAMmnj58eGlo
 SRUA==
X-Gm-Message-State: AOAM530Bttf7rPc3Y1xryniLA+uE0zeeTPRKsDCsvoNa2Kof6gQuroC8
 BXir93mcxP9wdUvEy3H9q6wqkeZh5RhTjQ==
X-Google-Smtp-Source: ABdhPJyak40qlRJBIbW7eSecBXipUig5Mcv7TnQCfiPpHvXK8DQE3gM1VvkzzYUiLK7WjADZytSoeg==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr4466577wrq.153.1592327343039; 
 Tue, 16 Jun 2020 10:09:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:09:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/21] target/arm: Convert Neon 2-reg-misc VREV32 and VREV16
 to decodetree
Date: Tue, 16 Jun 2020 18:08:35 +0100
Message-Id: <20200616170844.13318-13-peter.maydell@linaro.org>
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

Convert the VREV32 and VREV16 insns in the Neon 2-reg-misc group
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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



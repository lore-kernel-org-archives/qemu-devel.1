Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152BDC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D536620707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l00hLy7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D536620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8U5-0004V5-23
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LQ-0007XJ-4Z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LO-000439-7y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id y20so2408215wmi.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=j3vm5HBd/KNBPnEMJP3griKKVe9Ao7Fe0BOQr09ple0=;
 b=l00hLy7yNnoRrGkxFJRtnWwauM4ceuG29qGxv06kIeqAEavPUG2KqgaRJTPOisxuh0
 q1o4wGpVLjT+bv7EUckYQAmfMZ8k4h6+ak+DayysmWXFnO4F146lFyN3PmuqL5TU29Za
 hNR/2WmtewyUTuqHWCjgAImrGHR4XfvY9pBGcGCL0pMquxRThVNB2X6DO93yXkWlpn1w
 QuUB+YJhQUCJkU3wUGs/8fEBG355wvBrjhP2Vy3wIn7N4H0HWHIRb5TsxqVqnqFOVTxk
 Ef5MBn4raw/5qGhaJHevRRxAhIcerdv2afQYMHZD18erIxZBYO36/0+rh7qU7258sgG+
 drSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j3vm5HBd/KNBPnEMJP3griKKVe9Ao7Fe0BOQr09ple0=;
 b=rIsjOPhj0YiYVy9RY+W7gDLs6SUdtA7V+DrbNJ1E9erJkovTDwrzCwO1ezupwNQQ8V
 /aoRlm8KWL7vnNEwgPdxd143A82I12qMNZtd7Kt5EEZCnXDctggUYL9e5RdTVQZ3YPbS
 4aC6vwlzi6HEfm9mp56zketqRb2OXks9Btuuznu9yuOA1u+lUPAQ3kfnTdrUBtYa68a/
 LPvc2yOZzSyB34TdbEK5qzPDAIXncFngCJC8xdzhZL+PoMEx2EwbHFcSt5MjNVH98Be4
 wbDz4K8Llcp/4zMHH39QmQmbtMwjn0oct63YqbKed0HVC/5lIJZQ4a7XFMd2ccfGbI9H
 Rgww==
X-Gm-Message-State: AOAM5311YNmUcw/x4RZCcoNnyXtF8VwwkXO8zgwKveNr/PIIcarB6EM9
 ip5xkhKYH9XE+RGqELTBlgB4mSrua0YCEg==
X-Google-Smtp-Source: ABdhPJwneGo6G29aUoqccu3TzcARN1SW4yzruwhd+802SSszgHHYdT5iZFTFkz4ZQpwMZujZcZKnog==
X-Received: by 2002:a1c:3286:: with SMTP id y128mr2233148wmy.29.1592301444596; 
 Tue, 16 Jun 2020 02:57:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/23] target/arm: Convert Neon VTBL, VTBX to decodetree
Date: Tue, 16 Jun 2020 10:56:55 +0100
Message-Id: <20200616095702.25848-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Convert the Neon VTBL, VTBX instructions to decodetree.  The actual
implementation of the insn is copied across to the new trans function
unchanged except for renaming 'tmp5' to 'tmp4'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  3 ++
 target/arm/translate-neon.inc.c | 56 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 41 +++---------------------
 3 files changed, 63 insertions(+), 37 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 26d60220168..91bc770dfbc 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -419,6 +419,9 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     ##################################################################
     VEXT         1111 001 0 1 . 11 .... .... imm:4 . q:1 . 0 .... \
                  vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+    VTBL         1111 001 1 1 . 11 .... .... 10 len:2 . op:1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 84bc2b239ca..da0e5dbc6fd 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2888,3 +2888,59 @@ static bool trans_VEXT(DisasContext *s, arg_VEXT *a)
     }
     return true;
 }
+
+static bool trans_VTBL(DisasContext *s, arg_VTBL *a)
+{
+    int n;
+    TCGv_i32 tmp, tmp2, tmp3, tmp4;
+    TCGv_ptr ptr1;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    n = a->len + 1;
+    if ((a->vn + n) > 32) {
+        /*
+         * This is UNPREDICTABLE; we choose to UNDEF to avoid the
+         * helper function running off the end of the register file.
+         */
+        return false;
+    }
+    n <<= 3;
+    if (a->op) {
+        tmp = neon_load_reg(a->vd, 0);
+    } else {
+        tmp = tcg_temp_new_i32();
+        tcg_gen_movi_i32(tmp, 0);
+    }
+    tmp2 = neon_load_reg(a->vm, 0);
+    ptr1 = vfp_reg_ptr(true, a->vn);
+    tmp4 = tcg_const_i32(n);
+    gen_helper_neon_tbl(tmp2, tmp2, tmp, ptr1, tmp4);
+    tcg_temp_free_i32(tmp);
+    if (a->op) {
+        tmp = neon_load_reg(a->vd, 1);
+    } else {
+        tmp = tcg_temp_new_i32();
+        tcg_gen_movi_i32(tmp, 0);
+    }
+    tmp3 = neon_load_reg(a->vm, 1);
+    gen_helper_neon_tbl(tmp3, tmp3, tmp, ptr1, tmp4);
+    tcg_temp_free_i32(tmp4);
+    tcg_temp_free_ptr(ptr1);
+    neon_store_reg(a->vd, 0, tmp2);
+    neon_store_reg(a->vd, 1, tmp3);
+    tcg_temp_free_i32(tmp);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index a0822dba5e2..0c6425928f6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5025,13 +5025,12 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
 {
     int op;
     int q;
-    int rd, rn, rm, rd_ofs, rm_ofs;
+    int rd, rm, rd_ofs, rm_ofs;
     int size;
     int pass;
     int u;
     int vec_size;
-    TCGv_i32 tmp, tmp2, tmp3, tmp5;
-    TCGv_ptr ptr1;
+    TCGv_i32 tmp, tmp2, tmp3;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return 1;
@@ -5052,7 +5051,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     q = (insn & (1 << 6)) != 0;
     u = (insn >> 24) & 1;
     VFP_DREG_D(rd, insn);
-    VFP_DREG_N(rn, insn);
     VFP_DREG_M(rm, insn);
     size = (insn >> 20) & 3;
     vec_size = q ? 16 : 8;
@@ -5577,39 +5575,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     break;
                 }
             } else if ((insn & (1 << 10)) == 0) {
-                /* VTBL, VTBX.  */
-                int n = ((insn >> 8) & 3) + 1;
-                if ((rn + n) > 32) {
-                    /* This is UNPREDICTABLE; we choose to UNDEF to avoid the
-                     * helper function running off the end of the register file.
-                     */
-                    return 1;
-                }
-                n <<= 3;
-                if (insn & (1 << 6)) {
-                    tmp = neon_load_reg(rd, 0);
-                } else {
-                    tmp = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(tmp, 0);
-                }
-                tmp2 = neon_load_reg(rm, 0);
-                ptr1 = vfp_reg_ptr(true, rn);
-                tmp5 = tcg_const_i32(n);
-                gen_helper_neon_tbl(tmp2, tmp2, tmp, ptr1, tmp5);
-                tcg_temp_free_i32(tmp);
-                if (insn & (1 << 6)) {
-                    tmp = neon_load_reg(rd, 1);
-                } else {
-                    tmp = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(tmp, 0);
-                }
-                tmp3 = neon_load_reg(rm, 1);
-                gen_helper_neon_tbl(tmp3, tmp3, tmp, ptr1, tmp5);
-                tcg_temp_free_i32(tmp5);
-                tcg_temp_free_ptr(ptr1);
-                neon_store_reg(rd, 0, tmp2);
-                neon_store_reg(rd, 1, tmp3);
-                tcg_temp_free_i32(tmp);
+                /* VTBL, VTBX: handled by decodetree */
+                return 1;
             } else if ((insn & 0x380) == 0) {
                 /* VDUP */
                 int element;
-- 
2.20.1



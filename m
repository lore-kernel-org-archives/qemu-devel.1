Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAA9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B592075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7KOM2Yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B592075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOUu-00041u-Rn
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSn-0001Xe-Nt
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42715)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSm-0003v1-9x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id p5so6428444wrw.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Djjz4PkPajzCOVvVkMNmdQVtqKyvQc7hiJnzv/xaXnc=;
 b=i7KOM2YvB/Tz48ayQSq+VsZueYdhuwRzImGSgEUE6dunkn2mwa5eMaem+pDcx4L4yC
 dMTPTNdzQn2TDCj4PdGwWYTP4m3GShySkJET2zdtRVFZuqLjNjN9ZkbvZ+ahHXClQPgJ
 A2YEvPqm1ht0yfw6UniGYta6rhGuR8mwo5iV8+GIRFb2z+r/nVVOk9/TSyzuLlZZ3Vae
 j4lHaA5VjyjbSfiRbQ1I3FlEp2HXPE3SitdvyL674uyequO3i+KT1SEjI1AEwxQdJ61i
 q4hnHQoSiy7YqVsWQ/cLx4VqThn2h9dj0k5tRXtNFm9zTV+0BTiij2Fwi3rnVYdOH+Z0
 jh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Djjz4PkPajzCOVvVkMNmdQVtqKyvQc7hiJnzv/xaXnc=;
 b=OMb17T6W1C5SFKwWtZvXs4Z//sqywYRwtmP3Q9B4mdIW1DOVCfri8cCcDfcEUzNkEW
 Od4mCsshMc8HHOkqt8hDdDXpe6tz/0muA1sOdPTn7NrSOaBaTC0fgZXJFOAszwGxcYt4
 4uT3QEkP+2BY8/VCAP1hFep0T2wFYk17Vv8dlyvEjd0/hxXQXBiYd70L1XMW400/rAck
 8h/6Sl66N8JqPAT7PS38ZsoITJuC9s0bo2CTkcsQ10A5urOAef1caay60QyIJpCAQ9SY
 n/m19bkYj3kAyPPei21IJFI1zzA6j6Mxn5fb5Uq2Y+iw3+A35KvjuMpOTMU1poPBB1MP
 RFsg==
X-Gm-Message-State: AOAM532qLZN00wYZsJH+Y93fwIsG0rUrnEE14ExB0Bb1pV32IptH76c4
 2/mIoCz71qGmg3tiwOMSVfd5lw==
X-Google-Smtp-Source: ABdhPJySfXYJ+j5mn3YnhJ74pyJkHl7uzV/6DmakdCMikRJ1Py+fEwZw0fEVT+PRHO9iD2mbIsCXLg==
X-Received: by 2002:a05:6000:114e:: with SMTP id
 d14mr9690444wrx.110.1591886744283; 
 Thu, 11 Jun 2020 07:45:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h18sm5271658wru.7.2020.06.11.07.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:45:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 09/10] target/arm: Convert Neon VTBL, VTBX to decodetree
Date: Thu, 11 Jun 2020 15:45:28 +0100
Message-Id: <20200611144529.8873-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200611144529.8873-1-peter.maydell@linaro.org>
References: <20200611144529.8873-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

Convert the Neon VTBL, VTBX instructions to decodetree.  The actual
implementation of the insn is copied across to the new trans function
unchanged except for renaming 'tmp5' to 'tmp4'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index ba0e7091e1a..83d5c3eae31 100644
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
+        return 1;
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



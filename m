Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991D22075E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ai5w5ZdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991D22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOfX-0002Yt-Sk
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSo-0001YD-4m
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42714)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSm-0003u3-QW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id p5so6428361wrw.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0GTBE7suxOurPxe1504VaO03lCFiaXnVjqdBviXZXww=;
 b=ai5w5ZdZrrgo0aPoHFf+EZ9VgHDMubszLdxFSQvuDY9Z4gGuMJ8ICfv689aICkp0rl
 MJ2zFio2pM8tbwhHjp1U/QEo74RLjjWF0c/X+940YnqMyU6ilI2DvPcsZfmgJnQiBcDa
 l535HPdZ1dv2wzJHVZQ2NXOnaqT/rHk60rNg3PcU2dHwzu3GstgpjI9+EPILHZfdusOw
 sfhNtIj+X6Edeaodm+DmDw7wIwAzr8+snrSjjiNIQcpNcYN24TCmOSvB8S9FHH9TkHWM
 /dv6aeFyhGMXCOiCk763CY/QNlRRUhxOyLWDljChY0+ZdV/7VxVz5rv/czj3gjZbLDGI
 KqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0GTBE7suxOurPxe1504VaO03lCFiaXnVjqdBviXZXww=;
 b=SJPt5S8tpTZuJ54RxAGa/ZqS7R27eOxSe5OiOT3CiI7ckF+QEjVHiwpZpJdySCGEWS
 HnraCSIWjfdnREqLy4hX0kbOJZYS8nsOCAC2bkyTqdcAZs4HAhOUtJ9d2bQ4Cm5qltrA
 BKcBnNW/c1sOmLeqGganmixcbEQo1eb/pSNY/+2pi+/oD5NLYB5+xc4h3uU2rfYY1zjA
 NoMOizjg5VEm3Nrvadk7vhnnbRxecGvjf9/+gN/KiV8L+s3pDjgVzOrCnnQKZdqFv64j
 w19OpSO3L1pj4fwFZItxSN4XwIkQME1T7bI4z9CWbMBxDfe2SRUiBftWQgHEDN8irjvo
 z2yQ==
X-Gm-Message-State: AOAM532D8cSRVULz4lnRqNE9ESXDbewhFsoCBOfHhfXdbBEOz1StPio1
 +psMjTBCfEAiARvxyYFYyTWOhw==
X-Google-Smtp-Source: ABdhPJy5pdjQFz42jbgPPi4VLWDNc7AH1r4/FTFQotMaivGG2YT2BlNJihVc838BouDHc3JcjUO5Zg==
X-Received: by 2002:adf:93a3:: with SMTP id 32mr9915226wrp.344.1591886743071; 
 Thu, 11 Jun 2020 07:45:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h18sm5271658wru.7.2020.06.11.07.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:45:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/10] target/arm: Convert Neon VEXT to decodetree
Date: Thu, 11 Jun 2020 15:45:27 +0100
Message-Id: <20200611144529.8873-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200611144529.8873-1-peter.maydell@linaro.org>
References: <20200611144529.8873-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

Convert the Neon VEXT insn to decodetree. Rather than keeping the
old implementation which used fixed temporaries cpu_V0 and cpu_V1
and did the extraction with by-hand shift and logic ops, we use
the TCG extract2 insn.

We don't need to special case 0 or 8 immediates any more as the
optimizer is smart enough to throw away the dead code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  8 +++-
 target/arm/translate-neon.inc.c | 76 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 58 +------------------------
 3 files changed, 85 insertions(+), 57 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 9ff182f56d7..26d60220168 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -413,7 +413,13 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 # return false for size==3.
 ######################################################################
 {
-  # 0b11 subgroup will go here
+  [
+    ##################################################################
+    # Miscellaneous size=0b11 insns
+    ##################################################################
+    VEXT         1111 001 0 1 . 11 .... .... imm:4 . q:1 . 0 .... \
+                 vm=%vm_dp vn=%vn_dp vd=%vd_dp
+  ]
 
   # Subgroup for size != 0b11
   [
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index f054b567c8f..ba0e7091e1a 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2812,3 +2812,79 @@ static bool trans_VQDMLSL_2sc(DisasContext *s, arg_2scalar *a)
 
     return do_2scalar_long(s, a, opfn[a->size], accfn[a->size]);
 }
+
+static bool trans_VEXT(DisasContext *s, arg_VEXT *a)
+{
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
+    if ((a->vn | a->vm | a->vd) & a->q) {
+        return false;
+    }
+
+    if (a->imm > 7 && !a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (!a->q) {
+        /* Extract 64 bits from <Vm:Vn> */
+        TCGv_i64 left, right, dest;
+
+        left = tcg_temp_new_i64();
+        right = tcg_temp_new_i64();
+        dest = tcg_temp_new_i64();
+
+        neon_load_reg64(right, a->vn);
+        neon_load_reg64(left, a->vm);
+        tcg_gen_extract2_i64(dest, right, left, a->imm * 8);
+        neon_store_reg64(dest, a->vd);
+
+        tcg_temp_free_i64(left);
+        tcg_temp_free_i64(right);
+        tcg_temp_free_i64(dest);
+    } else {
+        /* Extract 128 bits from <Vm+1:Vm:Vn+1:Vn> */
+        TCGv_i64 left, middle, right, destleft, destright;
+
+        left = tcg_temp_new_i64();
+        middle = tcg_temp_new_i64();
+        right = tcg_temp_new_i64();
+        destleft = tcg_temp_new_i64();
+        destright = tcg_temp_new_i64();
+
+        if (a->imm < 8) {
+            neon_load_reg64(right, a->vn);
+            neon_load_reg64(middle, a->vn + 1);
+            tcg_gen_extract2_i64(destright, right, middle, a->imm * 8);
+            neon_load_reg64(left, a->vm);
+            tcg_gen_extract2_i64(destleft, middle, left, a->imm * 8);
+        } else {
+            neon_load_reg64(right, a->vn + 1);
+            neon_load_reg64(middle, a->vm);
+            tcg_gen_extract2_i64(destright, right, middle, (a->imm - 8) * 8);
+            neon_load_reg64(left, a->vm + 1);
+            tcg_gen_extract2_i64(destleft, middle, left, (a->imm - 8) * 8);
+        }
+
+        neon_store_reg64(destright, a->vd);
+        neon_store_reg64(destleft, a->vd + 1);
+
+        tcg_temp_free_i64(destright);
+        tcg_temp_free_i64(destleft);
+        tcg_temp_free_i64(right);
+        tcg_temp_free_i64(middle);
+        tcg_temp_free_i64(left);
+    }
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4d39bbf035b..a0822dba5e2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5030,10 +5030,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     int pass;
     int u;
     int vec_size;
-    uint32_t imm;
     TCGv_i32 tmp, tmp2, tmp3, tmp5;
     TCGv_ptr ptr1;
-    TCGv_i64 tmp64;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return 1;
@@ -5076,60 +5074,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 1;
         } else { /* size == 3 */
             if (!u) {
-                /* Extract.  */
-                imm = (insn >> 8) & 0xf;
-
-                if (imm > 7 && !q)
-                    return 1;
-
-                if (q && ((rd | rn | rm) & 1)) {
-                    return 1;
-                }
-
-                if (imm == 0) {
-                    neon_load_reg64(cpu_V0, rn);
-                    if (q) {
-                        neon_load_reg64(cpu_V1, rn + 1);
-                    }
-                } else if (imm == 8) {
-                    neon_load_reg64(cpu_V0, rn + 1);
-                    if (q) {
-                        neon_load_reg64(cpu_V1, rm);
-                    }
-                } else if (q) {
-                    tmp64 = tcg_temp_new_i64();
-                    if (imm < 8) {
-                        neon_load_reg64(cpu_V0, rn);
-                        neon_load_reg64(tmp64, rn + 1);
-                    } else {
-                        neon_load_reg64(cpu_V0, rn + 1);
-                        neon_load_reg64(tmp64, rm);
-                    }
-                    tcg_gen_shri_i64(cpu_V0, cpu_V0, (imm & 7) * 8);
-                    tcg_gen_shli_i64(cpu_V1, tmp64, 64 - ((imm & 7) * 8));
-                    tcg_gen_or_i64(cpu_V0, cpu_V0, cpu_V1);
-                    if (imm < 8) {
-                        neon_load_reg64(cpu_V1, rm);
-                    } else {
-                        neon_load_reg64(cpu_V1, rm + 1);
-                        imm -= 8;
-                    }
-                    tcg_gen_shli_i64(cpu_V1, cpu_V1, 64 - (imm * 8));
-                    tcg_gen_shri_i64(tmp64, tmp64, imm * 8);
-                    tcg_gen_or_i64(cpu_V1, cpu_V1, tmp64);
-                    tcg_temp_free_i64(tmp64);
-                } else {
-                    /* BUGFIX */
-                    neon_load_reg64(cpu_V0, rn);
-                    tcg_gen_shri_i64(cpu_V0, cpu_V0, imm * 8);
-                    neon_load_reg64(cpu_V1, rm);
-                    tcg_gen_shli_i64(cpu_V1, cpu_V1, 64 - (imm * 8));
-                    tcg_gen_or_i64(cpu_V0, cpu_V0, cpu_V1);
-                }
-                neon_store_reg64(cpu_V0, rd);
-                if (q) {
-                    neon_store_reg64(cpu_V1, rd + 1);
-                }
+                /* Extract: handled by decodetree */
+                return 1;
             } else if ((insn & (1 << 11)) == 0) {
                 /* Two register misc.  */
                 op = ((insn >> 12) & 0x30) | ((insn >> 7) & 0xf);
-- 
2.20.1



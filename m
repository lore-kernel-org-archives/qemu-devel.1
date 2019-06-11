Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFA2C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA87A2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k30PTnuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA87A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56332 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haemg-0002O1-1z
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haePx-0007FX-Lj
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePs-0007Q8-Dy
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePr-0007LY-OV
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so1657792wme.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BRekI/r0JrL+EgGXfGboIlXRqShDBnXKTEq1yJIu1yc=;
 b=k30PTnuAiIUQ0JkmxjG5TbQkaxpy3E8kzzy+2yAOwOeYZjSWjhWYeUitqMfdvBMpP8
 V94Ast7boK25xf7YUZ0RMgxXA9LT4nMX7EQ8Dqy63974MwpS7rVUOKAu4HlGw+uMo5QZ
 BS/Mb0UqE2lMdF3GjkRHCplCp9h0eYFXqUoOr2fFz7Y/qhC6PDZJzx/U02E9mO8DCZsf
 5YgxU6rKPJuSB7sH3SES0z7rDqiqVc9xQ6/eX+3g70EBnXfeQ89JcaeOFeekkuJIjNL3
 lNSmpvH+AN37Xsq2jdU/H+2lbVLtvrhXvj6XlhSWi/VF07fPMvK/Hh1FeP73oJ7HzGTP
 CKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BRekI/r0JrL+EgGXfGboIlXRqShDBnXKTEq1yJIu1yc=;
 b=Ez7ar+qX6TmmpPTU9aEv6RB/bhnp5YqEAL5qkImLoG2UGiomzpnX6mKpvk0aqaE0Tq
 7kDmP/fU8LOaQBPS8RRe8id+2jFIs/vAodhSSw7rxXVTDe+8JtRypt+P9rKjlFdFEiT3
 j4k83JRWJ4kYEMHH1ddqEqpuYkSrhX6HOtpjhc1pEy0jq4/XmFoSwNSMhRPAS/93umSs
 klbAKHD0y/fyD6uyQO3YFhyTGf06nwU015gs/bRAlX9Jxg5XN+HZtOdqeXV92fnHjlNo
 zeu9HT9fAbXO8/dVSJhUi2Qhez5aqzCSgBx9n/BT9SjTeFI36OlNoQaG+uIwPWZRJpo5
 TBtg==
X-Gm-Message-State: APjAAAXZ6H4APIAmWOwuh+A3SjmLEn2G60k3jdUSYPNAxkp72vKU8Bng
 kMmCrMLzWMTYhju2grHEZ3W/jw==
X-Google-Smtp-Source: APXvYqy1TQsPi3YmAw+ZBnWnwUM/Z0O0fHNSMuN5QpkGn9C2tYW8OAz8Qo9IZgDts6D2SHdTAQrfJA==
X-Received: by 2002:a1c:b684:: with SMTP id
 g126mr17091029wmf.176.1560250447807; 
 Tue, 11 Jun 2019 03:54:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:22 +0100
Message-Id: <20190611105351.9871-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 13/42] target/arm: Convert
 "single-precision" register moves to decodetree
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

Convert the "single-precision" register moves to decodetree:
 * VMSR
 * VMRS
 * VMOV between general purpose register and single precision

Note that the VMSR/VMRS conversions make our handling of
the "should this UNDEF?" checks consistent between the two
instructions:
 * VMSR to MVFR0, MVFR1, MVFR2 now UNDEF from EL0
   (previously was a nop)
 * VMSR to FPSID now UNDEFs from EL0 or if VFPv3 or better
   (previously was a nop)
 * VMSR to FPINST and FPINST2 now UNDEF if VFPv3 or better
   (previously would write to the register, which had no
   guest-visible effect because we always UNDEF reads)

We also tighten up the decode: we were previously underdecoding
some SBZ or SBO bits.

The conversion of VMOV_single includes the expansion out of the
gen_mov_F0_vreg()/gen_vfp_mrs() and gen_mov_vreg_F0()/gen_vfp_msr()
sequences into the simpler direct load/store of the TCG temp via
neon_{load,store}_reg32(): we know in the new function that we're
always single-precision, we don't need to use the old-and-deprecated
cpu_F0* TCG globals, and we don't happen to have the declaration of
gen_vfp_msr() and gen_vfp_mrs() at the point in the file where the
new function is.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 161 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 148 +-----------------------------
 target/arm/vfp.decode          |   4 +
 3 files changed, 168 insertions(+), 145 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 8b0899fa05c..74c10f9024b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -622,3 +622,164 @@ static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
 
     return true;
 }
+
+static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
+{
+    TCGv_i32 tmp;
+    bool ignore_vfp_enabled = false;
+
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        /*
+         * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
+         * Writes to R15 are UNPREDICTABLE; we choose to undef.
+         */
+        if (a->rt == 15 || a->reg != ARM_VFP_FPSCR) {
+            return false;
+        }
+    }
+
+    switch (a->reg) {
+    case ARM_VFP_FPSID:
+        /*
+         * VFPv2 allows access to FPSID from userspace; VFPv3 restricts
+         * all ID registers to privileged access only.
+         */
+        if (IS_USER(s) && arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+            return false;
+        }
+        ignore_vfp_enabled = true;
+        break;
+    case ARM_VFP_MVFR0:
+    case ARM_VFP_MVFR1:
+        if (IS_USER(s) || !arm_dc_feature(s, ARM_FEATURE_MVFR)) {
+            return false;
+        }
+        ignore_vfp_enabled = true;
+        break;
+    case ARM_VFP_MVFR2:
+        if (IS_USER(s) || !arm_dc_feature(s, ARM_FEATURE_V8)) {
+            return false;
+        }
+        ignore_vfp_enabled = true;
+        break;
+    case ARM_VFP_FPSCR:
+        break;
+    case ARM_VFP_FPEXC:
+        if (IS_USER(s)) {
+            return false;
+        }
+        ignore_vfp_enabled = true;
+        break;
+    case ARM_VFP_FPINST:
+    case ARM_VFP_FPINST2:
+        /* Not present in VFPv3 */
+        if (IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_VFP3)) {
+            return false;
+        }
+        break;
+    default:
+        return false;
+    }
+
+    if (!full_vfp_access_check(s, ignore_vfp_enabled)) {
+        return true;
+    }
+
+    if (a->l) {
+        /* VMRS, move VFP special register to gp register */
+        switch (a->reg) {
+        case ARM_VFP_FPSID:
+        case ARM_VFP_FPEXC:
+        case ARM_VFP_FPINST:
+        case ARM_VFP_FPINST2:
+        case ARM_VFP_MVFR0:
+        case ARM_VFP_MVFR1:
+        case ARM_VFP_MVFR2:
+            tmp = load_cpu_field(vfp.xregs[a->reg]);
+            break;
+        case ARM_VFP_FPSCR:
+            if (a->rt == 15) {
+                tmp = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
+                tcg_gen_andi_i32(tmp, tmp, 0xf0000000);
+            } else {
+                tmp = tcg_temp_new_i32();
+                gen_helper_vfp_get_fpscr(tmp, cpu_env);
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        if (a->rt == 15) {
+            /* Set the 4 flag bits in the CPSR.  */
+            gen_set_nzcv(tmp);
+            tcg_temp_free_i32(tmp);
+        } else {
+            store_reg(s, a->rt, tmp);
+        }
+    } else {
+        /* VMSR, move gp register to VFP special register */
+        switch (a->reg) {
+        case ARM_VFP_FPSID:
+        case ARM_VFP_MVFR0:
+        case ARM_VFP_MVFR1:
+        case ARM_VFP_MVFR2:
+            /* Writes are ignored.  */
+            break;
+        case ARM_VFP_FPSCR:
+            tmp = load_reg(s, a->rt);
+            gen_helper_vfp_set_fpscr(cpu_env, tmp);
+            tcg_temp_free_i32(tmp);
+            gen_lookup_tb(s);
+            break;
+        case ARM_VFP_FPEXC:
+            /*
+             * TODO: VFP subarchitecture support.
+             * For now, keep the EN bit only
+             */
+            tmp = load_reg(s, a->rt);
+            tcg_gen_andi_i32(tmp, tmp, 1 << 30);
+            store_cpu_field(tmp, vfp.xregs[a->reg]);
+            gen_lookup_tb(s);
+            break;
+        case ARM_VFP_FPINST:
+        case ARM_VFP_FPINST2:
+            tmp = load_reg(s, a->rt);
+            store_cpu_field(tmp, vfp.xregs[a->reg]);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    return true;
+}
+
+static bool trans_VMOV_single(DisasContext *s, arg_VMOV_single *a)
+{
+    TCGv_i32 tmp;
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (a->l) {
+        /* VFP to general purpose register */
+        tmp = tcg_temp_new_i32();
+        neon_load_reg32(tmp, a->vn);
+        if (a->rt == 15) {
+            /* Set the 4 flag bits in the CPSR.  */
+            gen_set_nzcv(tmp);
+            tcg_temp_free_i32(tmp);
+        } else {
+            store_reg(s, a->rt, tmp);
+        }
+    } else {
+        /* general purpose register to VFP */
+        tmp = load_reg(s, a->rt);
+        neon_store_reg32(tmp, a->vn);
+        tcg_temp_free_i32(tmp);
+    }
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 08307bb526d..cbb86a49213 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3097,7 +3097,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
     TCGv_i32 addr;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
-    bool ignore_vfp_enabled = false;
 
     if (!arm_dc_feature(s, ARM_FEATURE_VFP)) {
         return 1;
@@ -3133,14 +3132,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
      * for invalid encodings; we will generate incorrect syndrome information
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
      */
-    if ((insn & 0x0fe00fff) == 0x0ee00a10) {
-        rn = (insn >> 16) & 0xf;
-        if (rn == ARM_VFP_FPSID || rn == ARM_VFP_FPEXC || rn == ARM_VFP_MVFR2
-            || rn == ARM_VFP_MVFR1 || rn == ARM_VFP_MVFR0) {
-            ignore_vfp_enabled = true;
-        }
-    }
-    if (!full_vfp_access_check(s, ignore_vfp_enabled)) {
+    if (!vfp_access_check(s)) {
         return 0;
     }
 
@@ -3148,142 +3140,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
     switch ((insn >> 24) & 0xf) {
     case 0xe:
         if (insn & (1 << 4)) {
-            /* single register transfer */
-            rd = (insn >> 12) & 0xf;
-            if (dp) {
-                /* already handled by decodetree */
-                return 1;
-            } else { /* !dp */
-                bool is_sysreg;
-
-                if ((insn & 0x6f) != 0x00)
-                    return 1;
-                rn = VFP_SREG_N(insn);
-
-                is_sysreg = extract32(insn, 21, 1);
-
-                if (arm_dc_feature(s, ARM_FEATURE_M)) {
-                    /*
-                     * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
-                     * Writes to R15 are UNPREDICTABLE; we choose to undef.
-                     */
-                    if (is_sysreg && (rd == 15 || (rn >> 1) != ARM_VFP_FPSCR)) {
-                        return 1;
-                    }
-                }
-
-                if (insn & ARM_CP_RW_BIT) {
-                    /* vfp->arm */
-                    if (is_sysreg) {
-                        /* system register */
-                        rn >>= 1;
-
-                        switch (rn) {
-                        case ARM_VFP_FPSID:
-                            /* VFP2 allows access to FSID from userspace.
-                               VFP3 restricts all id registers to privileged
-                               accesses.  */
-                            if (IS_USER(s)
-                                && arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                                return 1;
-                            }
-                            tmp = load_cpu_field(vfp.xregs[rn]);
-                            break;
-                        case ARM_VFP_FPEXC:
-                            if (IS_USER(s))
-                                return 1;
-                            tmp = load_cpu_field(vfp.xregs[rn]);
-                            break;
-                        case ARM_VFP_FPINST:
-                        case ARM_VFP_FPINST2:
-                            /* Not present in VFP3.  */
-                            if (IS_USER(s)
-                                || arm_dc_feature(s, ARM_FEATURE_VFP3)) {
-                                return 1;
-                            }
-                            tmp = load_cpu_field(vfp.xregs[rn]);
-                            break;
-                        case ARM_VFP_FPSCR:
-                            if (rd == 15) {
-                                tmp = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
-                                tcg_gen_andi_i32(tmp, tmp, 0xf0000000);
-                            } else {
-                                tmp = tcg_temp_new_i32();
-                                gen_helper_vfp_get_fpscr(tmp, cpu_env);
-                            }
-                            break;
-                        case ARM_VFP_MVFR2:
-                            if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
-                                return 1;
-                            }
-                            /* fall through */
-                        case ARM_VFP_MVFR0:
-                        case ARM_VFP_MVFR1:
-                            if (IS_USER(s)
-                                || !arm_dc_feature(s, ARM_FEATURE_MVFR)) {
-                                return 1;
-                            }
-                            tmp = load_cpu_field(vfp.xregs[rn]);
-                            break;
-                        default:
-                            return 1;
-                        }
-                    } else {
-                        gen_mov_F0_vreg(0, rn);
-                        tmp = gen_vfp_mrs();
-                    }
-                    if (rd == 15) {
-                        /* Set the 4 flag bits in the CPSR.  */
-                        gen_set_nzcv(tmp);
-                        tcg_temp_free_i32(tmp);
-                    } else {
-                        store_reg(s, rd, tmp);
-                    }
-                } else {
-                    /* arm->vfp */
-                    if (is_sysreg) {
-                        rn >>= 1;
-                        /* system register */
-                        switch (rn) {
-                        case ARM_VFP_FPSID:
-                        case ARM_VFP_MVFR0:
-                        case ARM_VFP_MVFR1:
-                            /* Writes are ignored.  */
-                            break;
-                        case ARM_VFP_FPSCR:
-                            tmp = load_reg(s, rd);
-                            gen_helper_vfp_set_fpscr(cpu_env, tmp);
-                            tcg_temp_free_i32(tmp);
-                            gen_lookup_tb(s);
-                            break;
-                        case ARM_VFP_FPEXC:
-                            if (IS_USER(s))
-                                return 1;
-                            /* TODO: VFP subarchitecture support.
-                             * For now, keep the EN bit only */
-                            tmp = load_reg(s, rd);
-                            tcg_gen_andi_i32(tmp, tmp, 1 << 30);
-                            store_cpu_field(tmp, vfp.xregs[rn]);
-                            gen_lookup_tb(s);
-                            break;
-                        case ARM_VFP_FPINST:
-                        case ARM_VFP_FPINST2:
-                            if (IS_USER(s)) {
-                                return 1;
-                            }
-                            tmp = load_reg(s, rd);
-                            store_cpu_field(tmp, vfp.xregs[rn]);
-                            break;
-                        default:
-                            return 1;
-                        }
-                    } else {
-                        tmp = load_reg(s, rd);
-                        gen_vfp_msr(tmp);
-                        gen_mov_vreg_F0(0, rn);
-                    }
-                }
-            }
+            /* already handled by decodetree */
+            return 1;
         } else {
             /* data processing */
             bool rd_is_dp = dp;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 8286bdc0729..bb7de403df3 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -62,3 +62,7 @@ VMOV_from_gp ---- 1110 0 0 index:1 0 .... rt:4 1011 .00 1 0000 \
 
 VDUP         ---- 1110 1 b:1 q:1 0 .... rt:4 1011 . 0 e:1 1 0000 \
              vn=%vn_dp
+
+VMSR_VMRS    ---- 1110 111 l:1 reg:4 rt:4 1010 0001 0000
+VMOV_single  ---- 1110 000 l:1 .... rt:4 1010 . 001 0000 \
+             vn=%vn_sp
-- 
2.20.1



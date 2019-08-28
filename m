Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3506EC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:24:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F372053B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdBkp5xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F372053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33Ym-0005IB-DB
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fw-0003EI-Dv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Fu-0008Ma-5W
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:19 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33Ft-0008Lt-So
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:18 -0400
Received: by mail-pl1-x643.google.com with SMTP id m9so390392pls.8
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hSDSzPPDS+CE4fLVLBTTY//0zE1tWf4F3OCm6ELFB/Q=;
 b=QdBkp5xqkAEMAEVMpK6z8+Ps9l3/sy8tGE2qpRq3Epc1xjbMumZx+vgO/6CPHY/iJY
 hkRb/irAEDPR0P3oMPrMYB3ebFrVaq7j0rpx0VbmrnD4ODoMaQoHvcFTYb8vkoVTi/5T
 X8XIkAlcZ6B6Vu4kzOwvpp9r/fd51ZLnkFePCKaYPSfT3oQIeEoIai0BkIyv/BAkwhfh
 I5ooSdknXMPplKdeDBWLTbhVdomj9z0KgKrOWEklzcbrNcOtz4/qVeG3N6xh99o3HAD/
 NesQz1vgYp01rk89ecv3kAyj4CkKBYNtX9SekUMWLKT2wHyXFNZxEJz9RhC6iAb3wtKn
 MBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hSDSzPPDS+CE4fLVLBTTY//0zE1tWf4F3OCm6ELFB/Q=;
 b=Vxp/2pMf7yqRzNSG3x2czUk4rXHiyUcQ405YFz2M11FhNpYMUqWJMKNHcWr9g8msiv
 9ERUTuvcZIrBhlcXSFB0ziye3UUy4F9JCZ3SRdfCOt0+jiXjFAE7ahdwPOq31pl6V8mr
 R6WBqxb0n42k+/BYsOjsxRzGqf0xLq/m3uhqSDtu0QJCKrda7ZZIN3pNkePB7O7lJ78P
 R1SPMWDh6krPlt5D0qrwpDCeqZ0ZfgrQrM/TDlpnBLSqgrbHsvbZJagmtFTDEOfkvfqw
 +85zq+yzujS32hnpWX6hSrFyafwUvCEbx9/Nyp9TbCFoxeh9Y0plLgVh6fvSW09mPRgr
 hm5Q==
X-Gm-Message-State: APjAAAWb/CdzF3JVZPjxNlZt6+55T37EQhR7lzs3LbFe+BPJ2Y/MFTEG
 GfVUNowtwVbuY+ecDDMdI77wNmbUHlU=
X-Google-Smtp-Source: APXvYqxavGWLER2WN3xe2FIPypzXBejjZ1HcdU4DPW6HrhejwnDqLiFC+lZ1AKpCTwluS+aZZpaLQA==
X-Received: by 2002:a17:902:9889:: with SMTP id
 s9mr5974869plp.100.1567019116435; 
 Wed, 28 Aug 2019 12:05:16 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:00 -0700
Message-Id: <20190828190456.30315-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v3 13/69] target/arm: Convert MRS/MSR (banked,
 register)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The m-profile and a-profile decodings overlap.  Only return false
for the case of wrong profile; handle UNDEFINED for permission failure
directly.  This ensures that we don't accidentally pass an insn that
applies to the wrong profile.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 226 ++++++++++++++++++-----------------------
 target/arm/a32.decode  |  14 +++
 target/arm/t32.decode  |  40 ++++++--
 3 files changed, 142 insertions(+), 138 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d1599db2df..491c8bdc8b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8294,6 +8294,93 @@ static bool trans_MSR_imm(DisasContext *s, arg_MSR_imm *a)
     return true;
 }
 
+/*
+ * Miscellaneous instructions
+ */
+
+static bool trans_MRS_bank(DisasContext *s, arg_MRS_bank *a)
+{
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    gen_mrs_banked(s, a->r, a->sysm, a->rd);
+    return true;
+}
+
+static bool trans_MSR_bank(DisasContext *s, arg_MSR_bank *a)
+{
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    gen_msr_banked(s, a->r, a->sysm, a->rn);
+    return true;
+}
+
+static bool trans_MRS_reg(DisasContext *s, arg_MRS_reg *a)
+{
+    TCGv_i32 tmp;
+
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    if (a->r) {
+        if (IS_USER(s)) {
+            unallocated_encoding(s);
+            return true;
+        }
+        tmp = load_cpu_field(spsr);
+    } else {
+        tmp = tcg_temp_new_i32();
+        gen_helper_cpsr_read(tmp, cpu_env);
+    }
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
+static bool trans_MSR_reg(DisasContext *s, arg_MSR_reg *a)
+{
+    TCGv_i32 tmp;
+    uint32_t mask = msr_mask(s, a->mask, a->r);
+
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    tmp = load_reg(s, a->rn);
+    if (gen_set_psr(s, mask, a->r, tmp)) {
+        unallocated_encoding(s);
+    }
+    return true;
+}
+
+static bool trans_MRS_v7m(DisasContext *s, arg_MRS_v7m *a)
+{
+    TCGv_i32 tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    tmp = tcg_const_i32(a->sysm);
+    gen_helper_v7m_mrs(tmp, cpu_env, tmp);
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
+static bool trans_MSR_v7m(DisasContext *s, arg_MSR_v7m *a)
+{
+    TCGv_i32 addr, reg;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_M)) {
+        return false;
+    }
+    addr = tcg_const_i32((a->mask << 10) | a->sysm);
+    reg = load_reg(s, a->rn);
+    gen_helper_v7m_msr(cpu_env, addr, reg);
+    tcg_temp_free_i32(addr);
+    tcg_temp_free_i32(reg);
+    gen_lookup_tb(s);
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -8578,46 +8665,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         sh = (insn >> 4) & 0xf;
         rm = insn & 0xf;
         switch (sh) {
-        case 0x0: /* MSR, MRS */
-            if (insn & (1 << 9)) {
-                /* MSR (banked) and MRS (banked) */
-                int sysm = extract32(insn, 16, 4) |
-                    (extract32(insn, 8, 1) << 4);
-                int r = extract32(insn, 22, 1);
-
-                if (op1 & 1) {
-                    /* MSR (banked) */
-                    gen_msr_banked(s, r, sysm, rm);
-                } else {
-                    /* MRS (banked) */
-                    int rd = extract32(insn, 12, 4);
-
-                    gen_mrs_banked(s, r, sysm, rd);
-                }
-                break;
-            }
-
-            /* MSR, MRS (for PSRs) */
-            if (op1 & 1) {
-                /* PSR = reg */
-                tmp = load_reg(s, rm);
-                i = ((op1 & 2) != 0);
-                if (gen_set_psr(s, msr_mask(s, (insn >> 16) & 0xf, i), i, tmp))
-                    goto illegal_op;
-            } else {
-                /* reg = PSR */
-                rd = (insn >> 12) & 0xf;
-                if (op1 & 2) {
-                    if (IS_USER(s))
-                        goto illegal_op;
-                    tmp = load_cpu_field(spsr);
-                } else {
-                    tmp = tcg_temp_new_i32();
-                    gen_helper_cpsr_read(tmp, cpu_env);
-                }
-                store_reg(s, rd, tmp);
-            }
-            break;
+        case 0x0:
+            /* MSR/MRS (banked/register) */
+            /* All done in decodetree.  Illegal ops already signalled.  */
+            g_assert_not_reached();
         case 0x1:
             if (op1 == 1) {
                 /* branch/exchange thumb (bx).  */
@@ -10471,40 +10522,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 } else {
                     op = (insn >> 20) & 7;
                     switch (op) {
-                    case 0: /* msr cpsr.  */
-                        if (arm_dc_feature(s, ARM_FEATURE_M)) {
-                            tmp = load_reg(s, rn);
-                            /* the constant is the mask and SYSm fields */
-                            addr = tcg_const_i32(insn & 0xfff);
-                            gen_helper_v7m_msr(cpu_env, addr, tmp);
-                            tcg_temp_free_i32(addr);
-                            tcg_temp_free_i32(tmp);
-                            gen_lookup_tb(s);
-                            break;
-                        }
-                        /* fall through */
-                    case 1: /* msr spsr.  */
-                        if (arm_dc_feature(s, ARM_FEATURE_M)) {
-                            goto illegal_op;
-                        }
-
-                        if (extract32(insn, 5, 1)) {
-                            /* MSR (banked) */
-                            int sysm = extract32(insn, 8, 4) |
-                                (extract32(insn, 4, 1) << 4);
-                            int r = op & 1;
-
-                            gen_msr_banked(s, r, sysm, rm);
-                            break;
-                        }
-
-                        /* MSR (for PSRs) */
-                        tmp = load_reg(s, rn);
-                        if (gen_set_psr(s,
-                              msr_mask(s, (insn >> 8) & 0xf, op == 1),
-                              op == 1, tmp))
-                            goto illegal_op;
-                        break;
+                    case 0: /* msr cpsr, in decodetree  */
+                    case 1: /* msr spsr, in decodetree  */
+                        goto illegal_op;
                     case 2: /* cps, nop-hint.  */
                         /* nop hints in decodetree */
                         /* Implemented as NOP in user mode.  */
@@ -10596,61 +10616,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         }
                         gen_exception_return(s, tmp);
                         break;
-                    case 6: /* MRS */
-                        if (extract32(insn, 5, 1) &&
-                            !arm_dc_feature(s, ARM_FEATURE_M)) {
-                            /* MRS (banked) */
-                            int sysm = extract32(insn, 16, 4) |
-                                (extract32(insn, 4, 1) << 4);
-
-                            gen_mrs_banked(s, 0, sysm, rd);
-                            break;
-                        }
-
-                        if (extract32(insn, 16, 4) != 0xf) {
-                            goto illegal_op;
-                        }
-                        if (!arm_dc_feature(s, ARM_FEATURE_M) &&
-                            extract32(insn, 0, 8) != 0) {
-                            goto illegal_op;
-                        }
-
-                        /* mrs cpsr */
-                        tmp = tcg_temp_new_i32();
-                        if (arm_dc_feature(s, ARM_FEATURE_M)) {
-                            addr = tcg_const_i32(insn & 0xff);
-                            gen_helper_v7m_mrs(tmp, cpu_env, addr);
-                            tcg_temp_free_i32(addr);
-                        } else {
-                            gen_helper_cpsr_read(tmp, cpu_env);
-                        }
-                        store_reg(s, rd, tmp);
-                        break;
-                    case 7: /* MRS */
-                        if (extract32(insn, 5, 1) &&
-                            !arm_dc_feature(s, ARM_FEATURE_M)) {
-                            /* MRS (banked) */
-                            int sysm = extract32(insn, 16, 4) |
-                                (extract32(insn, 4, 1) << 4);
-
-                            gen_mrs_banked(s, 1, sysm, rd);
-                            break;
-                        }
-
-                        /* mrs spsr.  */
-                        /* Not accessible in user mode.  */
-                        if (IS_USER(s) || arm_dc_feature(s, ARM_FEATURE_M)) {
-                            goto illegal_op;
-                        }
-
-                        if (extract32(insn, 16, 4) != 0xf ||
-                            extract32(insn, 0, 8) != 0) {
-                            goto illegal_op;
-                        }
-
-                        tmp = load_cpu_field(spsr);
-                        store_reg(s, rd, tmp);
-                        break;
+                    case 6: /* MRS, in decodetree */
+                    case 7: /* MSR, in decodetree */
+                        goto illegal_op;
                     }
                 }
             } else {
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 3d5c5408f9..6ee12c1140 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -29,6 +29,10 @@
 &s_rrrr          s rd rn rm ra
 &rrrr            rd rn rm ra
 &rrr             rd rn rm
+&msr_reg         rn r mask
+&mrs_reg         rd r
+&msr_bank        rn r sysm
+&mrs_bank        rd r sysm
 
 # Data-processing (register)
 
@@ -177,3 +181,13 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
   MSR_imm        .... 0011 0010 .... 1111 .... .... ....      @msr_i r=0
 }
 MSR_imm          .... 0011 0110 .... 1111 .... .... ....      @msr_i r=1
+
+# Miscellaneous instructions
+
+%sysm            8:1 16:4
+
+MRS_bank         ---- 0001 0 r:1 00 .... rd:4 001. 0000 0000  &mrs_bank %sysm
+MSR_bank         ---- 0001 0 r:1 10 .... 1111 001. 0000 rn:4  &msr_bank %sysm
+
+MRS_reg          ---- 0001 0 r:1 00 1111   rd:4 0000 0000 0000  &mrs_reg
+MSR_reg          ---- 0001 0 r:1 10 mask:4 1111 0000 0000 rn:4  &msr_reg
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index ccb7cdd4ef..98b682e7ec 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -26,6 +26,10 @@
 &s_rrrr          !extern s rd rn rm ra
 &rrrr            !extern rd rn rm ra
 &rrr             !extern rd rn rm
+&msr_reg         !extern rn r mask
+&mrs_reg         !extern rd r
+&msr_bank        !extern rn r sysm
+&mrs_bank        !extern rd r sysm
 
 # Data-processing (register)
 
@@ -170,16 +174,34 @@ QDSUB            1111 1010 1000 .... 1111 .... 1011 ....      @rndm
 
 # Branches and miscellaneous control
 
+%msr_sysm        4:1 8:4
+%mrs_sysm        4:1 16:4
+
 {
-  YIELD          1111 0011 1010 1111 1000 0000 0000 0001
-  WFE            1111 0011 1010 1111 1000 0000 0000 0010
-  WFI            1111 0011 1010 1111 1000 0000 0000 0011
+  {
+    YIELD        1111 0011 1010 1111 1000 0000 0000 0001
+    WFE          1111 0011 1010 1111 1000 0000 0000 0010
+    WFI          1111 0011 1010 1111 1000 0000 0000 0011
 
-  # TODO: Implement SEV, SEVL; may help SMP performance.
-  # SEV          1111 0011 1010 1111 1000 0000 0000 0100
-  # SEVL         1111 0011 1010 1111 1000 0000 0000 0101
+    # TODO: Implement SEV, SEVL; may help SMP performance.
+    # SEV        1111 0011 1010 1111 1000 0000 0000 0100
+    # SEVL       1111 0011 1010 1111 1000 0000 0000 0101
 
-  # The canonical nop ends in 0000 0000, but the whole rest
-  # of the space is "reserved hint, behaves as nop".
-  NOP            1111 0011 1010 1111 1000 0000 ---- ----
+    # The canonical nop ends in 0000 0000, but the whole rest
+    # of the space is "reserved hint, behaves as nop".
+    NOP          1111 0011 1010 1111 1000 0000 ---- ----
+  }
+  # Note that the v7m insn overlaps both the normal and banked insn.
+  {
+    MRS_bank     1111 0011 111 r:1 .... 1000 rd:4   001. 0000  \
+                 &mrs_bank sysm=%mrs_sysm
+    MRS_reg      1111 0011 111 r:1 1111 1000 rd:4   0000 0000  &mrs_reg
+    MRS_v7m      1111 0011 111 0   1111 1000 rd:4   sysm:8
+  }
+  {
+    MSR_bank     1111 0011 100 r:1 rn:4 1000 ....   001. 0000  \
+                 &msr_bank sysm=%msr_sysm
+    MSR_reg      1111 0011 100 r:1 rn:4 1000 mask:4 0000 0000  &msr_reg
+    MSR_v7m      1111 0011 100 0   rn:4 1000 mask:2 00 sysm:8
+  }
 }
-- 
2.17.1



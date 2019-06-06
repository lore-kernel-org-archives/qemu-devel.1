Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E644C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B7520868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvvfzaku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B7520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35873 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwVE-0005Fj-EO
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:48:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTP-0003ka-GT
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTK-0003Bw-5m
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:46:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTF-00031B-F8
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:46:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id r18so3319027wrm.10
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=2hMUMrakSCxqu0+AorNAFQDJwafHWVC502jtmxiJQCQ=;
	b=zvvfzakuj3sdQU3phw60fwS15pSc85DsXI1mKipCMlK/Jt2XI/IdNW/JwzaYepMiIw
	0/0A7eos3whg2/nY2eKFx2iQhnQbvuBSNlanqxEbL8ro5uRBtpq92GLSj5ZrqyWSZ+gj
	KqlAKQU9fvwDJ+WAZHlCuryaVYAq03o8daQxEuDP3gGP1i2q4XhmZRryXtGc3LEKJAdm
	oA+CmxBsxkvn7+6MgpIH+CSSg6U3S7P/1hvJG5lUv6i0H62s9zFWVvGSFQjq4tZ4TFIW
	LTRMY72tvnjlHkCasopTKqTN9/TV8vhaRIw96h6EMxiYISAdR/wayw3NJHuhajZMKGWf
	cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=2hMUMrakSCxqu0+AorNAFQDJwafHWVC502jtmxiJQCQ=;
	b=bCSnN4Xu8MV5Im2RrCdmSJZByoNtbXWWFw7oBGVaTDCrZNERYN5oyR4451IqNCle5v
	/iSymDoEv/F6on1Ddoz+A0q2JqRkmeLaH1GLTe81L8Ruyuh2HkOa4acI933dScA8/nS6
	MRZrMWNyqoKMZYudsoV/55Q+fUVNTjgKd7ioJh1rUEwHZkOSNiraTYW7FGTqLo58oLhf
	rNr58zN9kKRHA2c/Bf9axPsC1AOfXfsGdhU+5RaXpPRrx0nVa4x2vRTRc+SltB2B6BYH
	3cZe8mGuGxy2fc9LZOEgUp+HC1NVVY2amLSVChoY71+NG52IuRbKfhT5B8t/qhYbgIqa
	1+jw==
X-Gm-Message-State: APjAAAWx4/N2S2MnbSJT6911T9W1aDE5XluZyyC+xTziVvRmDElg6nKQ
	KrtUBnJLBweKYSGjl3IZ7n4mxA==
X-Google-Smtp-Source: APXvYqx9tn+DRUm0mJ0yXY8gRVkbQNfKGbHdzjhQX1xAuPM/FDAGScX1se1BzQMpByyZVCnkT6nlkQ==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr30611696wre.205.1559843189443;
	Thu, 06 Jun 2019 10:46:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.28
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:43 +0100
Message-Id: <20190606174609.20487-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 16/42] target/arm: Convert the VFP load/store
 multiple insns to decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VFP load/store multiple insns to decodetree.
This includes tightening up the UNDEF checking for pre-VFPv3
CPUs which only have D0-D15 : they now UNDEF for any access
to D16-D31, not merely when the smallest register in the
transfer list is in D16-D31.

This conversion does not try to share code between the single
precision and the double precision versions; this looks a bit
duplicative of code, but it leaves the door open for a future
refactoring which gets rid of the use of the "F0" registers
by inlining the various functions like gen_vfp_ld() and
gen_mov_F0_reg() which are hiding "if (dp) { ... } else { ... }"
conditionalisation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 162 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  97 +-------------------
 target/arm/vfp.decode          |  18 ++++
 3 files changed, 183 insertions(+), 94 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 40f2cac3e2e..32a1805e582 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -926,3 +926,165 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_sp *a)
 
     return true;
 }
+
+static bool trans_VLDM_VSTM_sp(DisasContext *s, arg_VLDM_VSTM_sp *a)
+{
+    uint32_t offset;
+    TCGv_i32 addr;
+    int i, n;
+
+    n = a->imm;
+
+    if (n == 0 || (a->vd + n) > 32) {
+        /*
+         * UNPREDICTABLE cases for bad immediates: we choose to
+         * UNDEF to avoid generating huge numbers of TCG ops
+         */
+        return false;
+    }
+    if (a->rn == 15 && a->w) {
+        /* writeback to PC is UNPREDICTABLE, we choose to UNDEF */
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (s->thumb && a->rn == 15) {
+        /* This is actually UNPREDICTABLE */
+        addr = tcg_temp_new_i32();
+        tcg_gen_movi_i32(addr, s->pc & ~2);
+    } else {
+        addr = load_reg(s, a->rn);
+    }
+    if (a->p) {
+        /* pre-decrement */
+        tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
+    }
+
+    if (s->v8m_stackcheck && a->rn == 13 && a->w) {
+        /*
+         * Here 'addr' is the lowest address we will store to,
+         * and is either the old SP (if post-increment) or
+         * the new SP (if pre-decrement). For post-increment
+         * where the old value is below the limit and the new
+         * value is above, it is UNKNOWN whether the limit check
+         * triggers; we choose to trigger.
+         */
+        gen_helper_v8m_stackcheck(cpu_env, addr);
+    }
+
+    offset = 4;
+    for (i = 0; i < n; i++) {
+        if (a->l) {
+            /* load */
+            gen_vfp_ld(s, false, addr);
+            gen_mov_vreg_F0(false, a->vd + i);
+        } else {
+            /* store */
+            gen_mov_F0_vreg(false, a->vd + i);
+            gen_vfp_st(s, false, addr);
+        }
+        tcg_gen_addi_i32(addr, addr, offset);
+    }
+    if (a->w) {
+        /* writeback */
+        if (a->p) {
+            offset = -offset * n;
+            tcg_gen_addi_i32(addr, addr, offset);
+        }
+        store_reg(s, a->rn, addr);
+    } else {
+        tcg_temp_free_i32(addr);
+    }
+
+    return true;
+}
+
+static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
+{
+    uint32_t offset;
+    TCGv_i32 addr;
+    int i, n;
+
+    n = a->imm >> 1;
+
+    if (n == 0 || (a->vd + n) > 32 || n > 16) {
+        /*
+         * UNPREDICTABLE cases for bad immediates: we choose to
+         * UNDEF to avoid generating huge numbers of TCG ops
+         */
+        return false;
+    }
+    if (a->rn == 15 && a->w) {
+        /* writeback to PC is UNPREDICTABLE, we choose to UNDEF */
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vd + n) > 16) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (s->thumb && a->rn == 15) {
+        /* This is actually UNPREDICTABLE */
+        addr = tcg_temp_new_i32();
+        tcg_gen_movi_i32(addr, s->pc & ~2);
+    } else {
+        addr = load_reg(s, a->rn);
+    }
+    if (a->p) {
+        /* pre-decrement */
+        tcg_gen_addi_i32(addr, addr, -(a->imm << 2));
+    }
+
+    if (s->v8m_stackcheck && a->rn == 13 && a->w) {
+        /*
+         * Here 'addr' is the lowest address we will store to,
+         * and is either the old SP (if post-increment) or
+         * the new SP (if pre-decrement). For post-increment
+         * where the old value is below the limit and the new
+         * value is above, it is UNKNOWN whether the limit check
+         * triggers; we choose to trigger.
+         */
+        gen_helper_v8m_stackcheck(cpu_env, addr);
+    }
+
+    offset = 8;
+    for (i = 0; i < n; i++) {
+        if (a->l) {
+            /* load */
+            gen_vfp_ld(s, true, addr);
+            gen_mov_vreg_F0(true, a->vd + i);
+        } else {
+            /* store */
+            gen_mov_F0_vreg(true, a->vd + i);
+            gen_vfp_st(s, true, addr);
+        }
+        tcg_gen_addi_i32(addr, addr, offset);
+    }
+    if (a->w) {
+        /* writeback */
+        if (a->p) {
+            offset = -offset * n;
+        } else if (a->imm & 1) {
+            offset = 4;
+        } else {
+            offset = 0;
+        }
+
+        if (offset != 0) {
+            tcg_gen_addi_i32(addr, addr, offset);
+        }
+        store_reg(s, a->rn, addr);
+    } else {
+        tcg_temp_free_i32(addr);
+    }
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index de3bde4b55f..a109f058795 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3092,9 +3092,8 @@ static void gen_neon_dup_high16(TCGv_i32 var)
  */
 static int disas_vfp_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rd, rn, rm, op, i, n, offset, delta_d, delta_m, bank_mask;
+    uint32_t rd, rn, rm, op, i, n, delta_d, delta_m, bank_mask;
     int dp, veclen;
-    TCGv_i32 addr;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
 
@@ -3702,98 +3701,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         break;
     case 0xc:
     case 0xd:
-        if ((insn & 0x03e00000) == 0x00400000) {
-            /* Already handled by decodetree */
-            return 1;
-        } else {
-            /* Load/store */
-            rn = (insn >> 16) & 0xf;
-            if (dp)
-                VFP_DREG_D(rd, insn);
-            else
-                rd = VFP_SREG_D(insn);
-            if ((insn & 0x01200000) == 0x01000000) {
-                /* Already handled by decodetree */
-                return 1;
-            } else {
-                /* load/store multiple */
-                int w = insn & (1 << 21);
-                if (dp)
-                    n = (insn >> 1) & 0x7f;
-                else
-                    n = insn & 0xff;
-
-                if (w && !(((insn >> 23) ^ (insn >> 24)) & 1)) {
-                    /* P == U , W == 1  => UNDEF */
-                    return 1;
-                }
-                if (n == 0 || (rd + n) > 32 || (dp && n > 16)) {
-                    /* UNPREDICTABLE cases for bad immediates: we choose to
-                     * UNDEF to avoid generating huge numbers of TCG ops
-                     */
-                    return 1;
-                }
-                if (rn == 15 && w) {
-                    /* writeback to PC is UNPREDICTABLE, we choose to UNDEF */
-                    return 1;
-                }
-
-                if (s->thumb && rn == 15) {
-                    /* This is actually UNPREDICTABLE */
-                    addr = tcg_temp_new_i32();
-                    tcg_gen_movi_i32(addr, s->pc & ~2);
-                } else {
-                    addr = load_reg(s, rn);
-                }
-                if (insn & (1 << 24)) /* pre-decrement */
-                    tcg_gen_addi_i32(addr, addr, -((insn & 0xff) << 2));
-
-                if (s->v8m_stackcheck && rn == 13 && w) {
-                    /*
-                     * Here 'addr' is the lowest address we will store to,
-                     * and is either the old SP (if post-increment) or
-                     * the new SP (if pre-decrement). For post-increment
-                     * where the old value is below the limit and the new
-                     * value is above, it is UNKNOWN whether the limit check
-                     * triggers; we choose to trigger.
-                     */
-                    gen_helper_v8m_stackcheck(cpu_env, addr);
-                }
-
-                if (dp)
-                    offset = 8;
-                else
-                    offset = 4;
-                for (i = 0; i < n; i++) {
-                    if (insn & ARM_CP_RW_BIT) {
-                        /* load */
-                        gen_vfp_ld(s, dp, addr);
-                        gen_mov_vreg_F0(dp, rd + i);
-                    } else {
-                        /* store */
-                        gen_mov_F0_vreg(dp, rd + i);
-                        gen_vfp_st(s, dp, addr);
-                    }
-                    tcg_gen_addi_i32(addr, addr, offset);
-                }
-                if (w) {
-                    /* writeback */
-                    if (insn & (1 << 24))
-                        offset = -offset * n;
-                    else if (dp && (insn & 1))
-                        offset = 4;
-                    else
-                        offset = 0;
-
-                    if (offset != 0)
-                        tcg_gen_addi_i32(addr, addr, offset);
-                    store_reg(s, rn, addr);
-                } else {
-                    tcg_temp_free_i32(addr);
-                }
-            }
-        }
-        break;
+        /* Already handled by decodetree */
+        return 1;
     default:
         /* Should never happen.  */
         return 1;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 8fa7fa0bead..68c9ffcfd3c 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -78,3 +78,21 @@ VLDR_VSTR_sp ---- 1101 u:1 .0 l:1 rn:4 .... 1010 imm:8 \
              vd=%vd_sp
 VLDR_VSTR_dp ---- 1101 u:1 .0 l:1 rn:4 .... 1011 imm:8 \
              vd=%vd_dp
+
+# We split the load/store multiple up into two patterns to avoid
+# overlap with other insns in the "Advanced SIMD load/store and 64-bit move"
+# grouping:
+#   P=0 U=0 W=0 is 64-bit VMOV
+#   P=1 W=0 is VLDR/VSTR
+#   P=U W=1 is UNDEF
+# leaving P=0 U=1 W=x and P=1 U=0 W=1 for load/store multiple.
+# These include FSTM/FLDM.
+VLDM_VSTM_sp ---- 1100 1 . w:1 l:1 rn:4 .... 1010 imm:8 \
+             vd=%vd_sp p=0 u=1
+VLDM_VSTM_dp ---- 1100 1 . w:1 l:1 rn:4 .... 1011 imm:8 \
+             vd=%vd_dp p=0 u=1
+
+VLDM_VSTM_sp ---- 1101 0.1 l:1 rn:4 .... 1010 imm:8 \
+             vd=%vd_sp p=1 u=0 w=1
+VLDM_VSTM_dp ---- 1101 0.1 l:1 rn:4 .... 1011 imm:8 \
+             vd=%vd_dp p=1 u=0 w=1
-- 
2.20.1



Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD8EC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C8B20645
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuOwlMM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C8B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haesX-0007WO-PW
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haePv-0007Ex-Jb
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePr-0007P0-O7
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:37025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePr-0007Kd-AZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id 22so2394337wmg.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I5NVJmv9QCzY5wd+EPvdgPRW/eLGZfdGGf7zbG7fHeQ=;
 b=nuOwlMM/TzG3/QetfCKLe6y7JcVQEY7a1p5n0WW/DH5fyUFWBvwej67bqTYiFEwbfh
 qCI8EdlWY/s2pp/H3Kdilov8e0ZnF0/ljSHtuSb/A2Zi7ES0ftKMHtTTr/6QeNCIWxHu
 NztxKuTwrX9RWszkGSEVsJTuusUsxHBqzwDTYUagoVmrBR9aAFSrkHseuKksNB/T0gtY
 nk2L5rFBXBWH+GpEmrZ6aPiI+Ml4VSEZE6hVoAeSjm8rtEOTb6UNZpx7wuhGv72SHE/k
 UgqpH5R6K3DczpylQ2FkBbA57XwF86262OfLT53fmymIFLCjRaLX8aYTuJgI1lktuQoS
 sJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I5NVJmv9QCzY5wd+EPvdgPRW/eLGZfdGGf7zbG7fHeQ=;
 b=SPsSrCuVyTsd26mviunRUo3afWkFwUvwaApMHat2Esu5s8+48556/iTNa4IXjXg/yz
 D1kBXdXfXlmMN+LIbaiinWX5gqxk8xP6lfkHXTedwJa5t0L3yCMg9j9AfSq174Fc+zXP
 NagOlNjixSibssgbgxWMHrrqHqhTUCRXmQ6ZODitzoV57D0RE8uxHZA7grxaxM0MwxG/
 olCH0aNMjrvA/tYYrTaQ3WzKhKflNqbBZusVK8NbaslDQbllChUcsP60rM8S4adPG7ot
 WdyjUr3Nnv0knvLaCnK1ojh7wAqCnT5+CR71LzbIGP3qd44nTDv4pJvvKZArmzYiIg26
 2Kgg==
X-Gm-Message-State: APjAAAW1MvjOojCrhNVHfImP984Lcf999KXfxurfFeUn7QTpli22mnCz
 6IwLE4XK7hBz3c6VE+093WOydg==
X-Google-Smtp-Source: APXvYqzk5RYp51m019fcKTs1R0s6wvJBZGJJD2fnZbVSjOEY/9h00z/EPcyv8bUw4LII8FKxAcv7gw==
X-Received: by 2002:a1c:a983:: with SMTP id s125mr16393854wme.18.1560250446684; 
 Tue, 11 Jun 2019 03:54:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:21 +0100
Message-Id: <20190611105351.9871-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PATCH v2 12/42] target/arm: Convert
 "double-precision" register moves to decodetree
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

Convert the "double-precision" register moves to decodetree:
this covers VMOV scalar-to-gpreg, VMOV gpreg-to-scalar and VDUP.

Note that the conversion process has tightened up a few of the
UNDEF encoding checks: we now correctly forbid:
 * VMOV-to-gpr with U:opc1:opc2 == 10x00 or x0x10
 * VMOV-from-gpr with opc1:opc2 == 0x10
 * VDUP with B:E == 11
 * VDUP with Q == 1 and Vn<0> == 1

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The accesses of elements < 32 bits could be improved by doing
direct ld/st of the right size rather than 32-bit read-and-shift
or read-modify-write, but we leave this for later cleanup,
since this series is generally trying to stick to fixing
the decode.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 147 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  83 +------------------
 target/arm/vfp.decode          |  36 ++++++++
 3 files changed, 185 insertions(+), 81 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 24358f3d3eb..8b0899fa05c 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -475,3 +475,150 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
 
     return true;
 }
+
+static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
+{
+    /* VMOV scalar to general purpose register */
+    TCGv_i32 tmp;
+    int pass;
+    uint32_t offset;
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+        return false;
+    }
+
+    offset = a->index << a->size;
+    pass = extract32(offset, 2, 1);
+    offset = extract32(offset, 0, 2) * 8;
+
+    if (a->size != 2 && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = neon_load_reg(a->vn, pass);
+    switch (a->size) {
+    case 0:
+        if (offset) {
+            tcg_gen_shri_i32(tmp, tmp, offset);
+        }
+        if (a->u) {
+            gen_uxtb(tmp);
+        } else {
+            gen_sxtb(tmp);
+        }
+        break;
+    case 1:
+        if (a->u) {
+            if (offset) {
+                tcg_gen_shri_i32(tmp, tmp, 16);
+            } else {
+                gen_uxth(tmp);
+            }
+        } else {
+            if (offset) {
+                tcg_gen_sari_i32(tmp, tmp, 16);
+            } else {
+                gen_sxth(tmp);
+            }
+        }
+        break;
+    case 2:
+        break;
+    }
+    store_reg(s, a->rt, tmp);
+
+    return true;
+}
+
+static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
+{
+    /* VMOV general purpose register to scalar */
+    TCGv_i32 tmp, tmp2;
+    int pass;
+    uint32_t offset;
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+        return false;
+    }
+
+    offset = a->index << a->size;
+    pass = extract32(offset, 2, 1);
+    offset = extract32(offset, 0, 2) * 8;
+
+    if (a->size != 2 && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = load_reg(s, a->rt);
+    switch (a->size) {
+    case 0:
+        tmp2 = neon_load_reg(a->vn, pass);
+        tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 8);
+        tcg_temp_free_i32(tmp2);
+        break;
+    case 1:
+        tmp2 = neon_load_reg(a->vn, pass);
+        tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 16);
+        tcg_temp_free_i32(tmp2);
+        break;
+    case 2:
+        break;
+    }
+    neon_store_reg(a->vn, pass, tmp);
+
+    return true;
+}
+
+static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
+{
+    /* VDUP (general purpose register) */
+    TCGv_i32 tmp;
+    int size, vec_size;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && (a->vn & 0x10)) {
+        return false;
+    }
+
+    if (a->b && a->e) {
+        return false;
+    }
+
+    if (a->q && (a->vn & 1)) {
+        return false;
+    }
+
+    vec_size = a->q ? 16 : 8;
+    if (a->b) {
+        size = 0;
+    } else if (a->e) {
+        size = 1;
+    } else {
+        size = 2;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    tmp = load_reg(s, a->rt);
+    tcg_gen_gvec_dup_i32(size, neon_reg_offset(a->vn, 0),
+                         vec_size, vec_size, tmp);
+    tcg_temp_free_i32(tmp);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3661ed57cd3..08307bb526d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3151,87 +3151,8 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             /* single register transfer */
             rd = (insn >> 12) & 0xf;
             if (dp) {
-                int size;
-                int pass;
-
-                VFP_DREG_N(rn, insn);
-                if (insn & 0xf)
-                    return 1;
-                if (insn & 0x00c00060
-                    && !arm_dc_feature(s, ARM_FEATURE_NEON)) {
-                    return 1;
-                }
-
-                pass = (insn >> 21) & 1;
-                if (insn & (1 << 22)) {
-                    size = 0;
-                    offset = ((insn >> 5) & 3) * 8;
-                } else if (insn & (1 << 5)) {
-                    size = 1;
-                    offset = (insn & (1 << 6)) ? 16 : 0;
-                } else {
-                    size = 2;
-                    offset = 0;
-                }
-                if (insn & ARM_CP_RW_BIT) {
-                    /* vfp->arm */
-                    tmp = neon_load_reg(rn, pass);
-                    switch (size) {
-                    case 0:
-                        if (offset)
-                            tcg_gen_shri_i32(tmp, tmp, offset);
-                        if (insn & (1 << 23))
-                            gen_uxtb(tmp);
-                        else
-                            gen_sxtb(tmp);
-                        break;
-                    case 1:
-                        if (insn & (1 << 23)) {
-                            if (offset) {
-                                tcg_gen_shri_i32(tmp, tmp, 16);
-                            } else {
-                                gen_uxth(tmp);
-                            }
-                        } else {
-                            if (offset) {
-                                tcg_gen_sari_i32(tmp, tmp, 16);
-                            } else {
-                                gen_sxth(tmp);
-                            }
-                        }
-                        break;
-                    case 2:
-                        break;
-                    }
-                    store_reg(s, rd, tmp);
-                } else {
-                    /* arm->vfp */
-                    tmp = load_reg(s, rd);
-                    if (insn & (1 << 23)) {
-                        /* VDUP */
-                        int vec_size = pass ? 16 : 8;
-                        tcg_gen_gvec_dup_i32(size, neon_reg_offset(rn, 0),
-                                             vec_size, vec_size, tmp);
-                        tcg_temp_free_i32(tmp);
-                    } else {
-                        /* VMOV */
-                        switch (size) {
-                        case 0:
-                            tmp2 = neon_load_reg(rn, pass);
-                            tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 8);
-                            tcg_temp_free_i32(tmp2);
-                            break;
-                        case 1:
-                            tmp2 = neon_load_reg(rn, pass);
-                            tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 16);
-                            tcg_temp_free_i32(tmp2);
-                            break;
-                        case 2:
-                            break;
-                        }
-                        neon_store_reg(rn, pass, tmp);
-                    }
-                }
+                /* already handled by decodetree */
+                return 1;
             } else { /* !dp */
                 bool is_sysreg;
 
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 28ee664d8c3..8286bdc0729 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -26,3 +26,39 @@
 #  1110 1110 .... .... .... 101. .... ....
 # (but those patterns might also cover some Neon instructions,
 # which do not live in this file.)
+
+# VFP registers have an odd encoding with a four-bit field
+# and a one-bit field which are assembled in different orders
+# depending on whether the register is double or single precision.
+# Each individual instruction function must do the checks for
+# "double register selected but CPU does not have double support"
+# and "double register number has bit 4 set but CPU does not
+# support D16-D31" (which should UNDEF).
+%vm_dp  5:1 0:4
+%vm_sp  0:4 5:1
+%vn_dp  7:1 16:4
+%vn_sp  16:4 7:1
+%vd_dp  22:1 12:4
+%vd_sp  12:4 22:1
+
+%vmov_idx_b     21:1 5:2
+%vmov_idx_h     21:1 6:1
+
+# VMOV scalar to general-purpose register; note that this does
+# include some Neon cases.
+VMOV_to_gp   ---- 1110 u:1 1.        1 .... rt:4 1011 ... 1 0000 \
+             vn=%vn_dp size=0 index=%vmov_idx_b
+VMOV_to_gp   ---- 1110 u:1 0.        1 .... rt:4 1011 ..1 1 0000 \
+             vn=%vn_dp size=1 index=%vmov_idx_h
+VMOV_to_gp   ---- 1110 0   0 index:1 1 .... rt:4 1011 .00 1 0000 \
+             vn=%vn_dp size=2 u=0
+
+VMOV_from_gp ---- 1110 0 1.        0 .... rt:4 1011 ... 1 0000 \
+             vn=%vn_dp size=0 index=%vmov_idx_b
+VMOV_from_gp ---- 1110 0 0.        0 .... rt:4 1011 ..1 1 0000 \
+             vn=%vn_dp size=1 index=%vmov_idx_h
+VMOV_from_gp ---- 1110 0 0 index:1 0 .... rt:4 1011 .00 1 0000 \
+             vn=%vn_dp size=2
+
+VDUP         ---- 1110 1 b:1 q:1 0 .... rt:4 1011 . 0 e:1 1 0000 \
+             vn=%vn_dp
-- 
2.20.1



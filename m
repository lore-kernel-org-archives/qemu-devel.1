Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B022C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208302083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePNrChcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208302083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwdm-00053S-6s
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:57:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTr-0004Bo-W8
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTo-0003f8-AC
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTm-0003DX-DB
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id g135so787401wme.4
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=GNnHv9qCGTSj5R4NNfuX9CQYlGGHlgYiJxCzdJ0Mvyk=;
	b=ePNrChcsnn9Z1C32L6Rf308gqzGhRA6kWv+RwnQGCG0cbEpVp1MN0AsNAYC1M8Of6t
	+r2Ex5gcoYpeG5L9zvWY4x3AaFWDo1dsBWO3rOSZjdRBjV3g3VtiFSW6+avpC6NTZM/u
	FICI/goPaANFntlJky3FyCgWYAxjgdYj58XsMu1zqzSAmSAtmehYNoEeUixZzEPtBTl0
	4eDQNeHQdUeNj/5VHd9aYTF7xtn3w+02rQk9aw6Jp1HsZWZiFdfMe53UmiVzdHMGAayc
	dKrWbiBhVFH14fGXO7cyOYTw4UN7AJcn3uEM0pFKGS9l6hJeU8ZI2a/0JPWdRr/YGboA
	OTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=GNnHv9qCGTSj5R4NNfuX9CQYlGGHlgYiJxCzdJ0Mvyk=;
	b=TKYoUp5mJ67IQkgHKVKsxPH/REqmce0NKVWFNVlfAjujmLU5cmWQFbbqyaIbZmDocw
	NudXXLWDztxGM+NrpfWBpefS1YSKBZWPLYDpcCIjltdfbzVdQx+HxFQryS0BKZwNc/aR
	rFT1go72SFnl6kkIuSH763wUWh9pwwjGtvtpnOP7Ia+LCoLwKpoT/nunzEvjY5lUQmj6
	5ynsIErqUSzwpXyegqUSmkYmbGzZtk0JKA6j1gs6lnF9uFvzHXLUq5uMFfPc+/4imuCq
	UNEFKCjJQAWnOPsRA0inIqmnhJzi4mIawC6tuWyoeqlcvawTqQVeR55ZjKuID6u27+MP
	nGJA==
X-Gm-Message-State: APjAAAV3yi21LZzkI2loRnDCsxk4n4XkG106v0ZKu4ZAv1y5ILETJpkY
	7dmhZtGwohaaeVtEjkoyYDXdOZeCLhyTHw==
X-Google-Smtp-Source: APXvYqzd/sfTg0I/1y21yJ5JOhKOuFIFjFexMKodaFLQB6YjLiaMCC7Feq+LQUxkGgSharhBsgxkIg==
X-Received: by 2002:a1c:e718:: with SMTP id e24mr865093wmh.104.1559843203625; 
	Thu, 06 Jun 2019 10:46:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:56 +0100
Message-Id: <20190606174609.20487-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 29/42] target/arm: Convert VABS to decodetree
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

Convert the VFP VABS instruction to decodetree.

Unlike the 3-op versions, we don't pass fpst to the VFPGen2OpSPFn or
VFPGen2OpDPFn because none of the operations which use this format
and support short vectors will need it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 167 +++++++++++++++++++++++++++++++++
 target/arm/translate.c         |  12 ++-
 target/arm/vfp.decode          |   5 +
 3 files changed, 180 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index a2eeb6cb511..d0282f1f921 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1111,6 +1111,14 @@ typedef void VFPGen3OpSPFn(TCGv_i32 vd,
 typedef void VFPGen3OpDPFn(TCGv_i64 vd,
                            TCGv_i64 vn, TCGv_i64 vm, TCGv_ptr fpst);
 
+/*
+ * Types for callbacks for do_vfp_2op_sp() and do_vfp_2op_dp().
+ * The callback should emit code to write a value to vd (which
+ * should be written to only).
+ */
+typedef void VFPGen2OpSPFn(TCGv_i32 vd, TCGv_i32 vm);
+typedef void VFPGen2OpDPFn(TCGv_i64 vd, TCGv_i64 vm);
+
 /*
  * Perform a 3-operand VFP data processing instruction. fn is the
  * callback to do the actual operation; this function deals with the
@@ -1274,6 +1282,155 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     return true;
 }
 
+static bool do_vfp_2op_sp(DisasContext *s, VFPGen2OpSPFn *fn, int vd, int vm)
+{
+    uint32_t delta_m = 0;
+    uint32_t delta_d = 0;
+    uint32_t bank_mask = 0;
+    int veclen = s->vec_len;
+    TCGv_i32 f0, fd;
+
+    if (!dc_isar_feature(aa32_fpshvec, s) &&
+        (veclen != 0 || s->vec_stride != 0)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (veclen > 0) {
+        bank_mask = 0x18;
+
+        /* Figure out what type of vector operation this is.  */
+        if ((vd & bank_mask) == 0) {
+            /* scalar */
+            veclen = 0;
+        } else {
+            delta_d = s->vec_stride + 1;
+
+            if ((vm & bank_mask) == 0) {
+                /* mixed scalar/vector */
+                delta_m = 0;
+            } else {
+                /* vector */
+                delta_m = delta_d;
+            }
+        }
+    }
+
+    f0 = tcg_temp_new_i32();
+    fd = tcg_temp_new_i32();
+
+    neon_load_reg32(f0, vm);
+
+    for (;;) {
+        fn(fd, f0);
+        neon_store_reg32(fd, vd);
+
+        if (veclen == 0) {
+            break;
+        }
+
+        if (delta_m == 0) {
+            /* single source one-many */
+            while (veclen--) {
+                vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+                neon_store_reg32(fd, vd);
+            }
+            break;
+        }
+
+        /* Set up the operands for the next iteration */
+        veclen--;
+        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+        vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+        neon_load_reg32(f0, vm);
+    }
+
+    tcg_temp_free_i32(f0);
+    tcg_temp_free_i32(fd);
+
+    return true;
+}
+
+static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
+{
+    uint32_t delta_m = 0;
+    uint32_t delta_d = 0;
+    uint32_t bank_mask = 0;
+    int veclen = s->vec_len;
+    TCGv_i64 f0, fd;
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_fp_d32, s) && ((vd | vm) & 0x10)) {
+        return false;
+    }
+
+    if (!dc_isar_feature(aa32_fpshvec, s) &&
+        (veclen != 0 || s->vec_stride != 0)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (veclen > 0) {
+        bank_mask = 0xc;
+
+        /* Figure out what type of vector operation this is.  */
+        if ((vd & bank_mask) == 0) {
+            /* scalar */
+            veclen = 0;
+        } else {
+            delta_d = (s->vec_stride >> 1) + 1;
+
+            if ((vm & bank_mask) == 0) {
+                /* mixed scalar/vector */
+                delta_m = 0;
+            } else {
+                /* vector */
+                delta_m = delta_d;
+            }
+        }
+    }
+
+    f0 = tcg_temp_new_i64();
+    fd = tcg_temp_new_i64();
+
+    neon_load_reg64(f0, vm);
+
+    for (;;) {
+        fn(fd, f0);
+        neon_store_reg64(fd, vd);
+
+        if (veclen == 0) {
+            break;
+        }
+
+        if (delta_m == 0) {
+            /* single source one-many */
+            while (veclen--) {
+                vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+                neon_store_reg64(fd, vd);
+            }
+            break;
+        }
+
+        /* Set up the operands for the next iteration */
+        veclen--;
+        vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask);
+        vm = ((vm + delta_m) & (bank_mask - 1)) | (vm & bank_mask);
+        neon_load_reg64(f0, vm);
+    }
+
+    tcg_temp_free_i64(f0);
+    tcg_temp_free_i64(fd);
+
+    return true;
+}
+
 static void gen_VMLA_sp(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm, TCGv_ptr fpst)
 {
     /* Note that order of inputs to the add matters for NaNs */
@@ -1731,3 +1888,13 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     tcg_temp_free_i64(fd);
     return true;
 }
+
+static bool trans_VABS_sp(DisasContext *s, arg_VABS_sp *a)
+{
+    return do_vfp_2op_sp(s, gen_helper_vfp_abss, a->vd, a->vm);
+}
+
+static bool trans_VABS_dp(DisasContext *s, arg_VABS_dp *a)
+{
+    return do_vfp_2op_dp(s, gen_helper_vfp_absd, a->vd, a->vm);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 38ec026d865..ace9f803ab7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3096,6 +3096,14 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             case 0 ... 14:
                 /* Already handled by decodetree */
                 return 1;
+            case 15:
+                switch (rn) {
+                case 1:
+                    /* Already handled by decodetree */
+                    return 1;
+                default:
+                    break;
+                }
             default:
                 break;
             }
@@ -3104,7 +3112,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
                 case 0x00: /* vmov */
-                case 0x01: /* vabs */
                 case 0x02: /* vneg */
                 case 0x03: /* vsqrt */
                     break;
@@ -3284,9 +3291,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 0: /* cpy */
                         /* no-op */
                         break;
-                    case 1: /* abs */
-                        gen_vfp_abs(dp);
-                        break;
                     case 2: /* neg */
                         gen_vfp_neg(dp);
                         break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 1818d4f71e1..7035861c270 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -156,3 +156,8 @@ VMOV_imm_sp  ---- 1110 1.11 imm4h:4 .... 1010 0000 imm4l:4 \
              vd=%vd_sp
 VMOV_imm_dp  ---- 1110 1.11 imm4h:4 .... 1011 0000 imm4l:4 \
              vd=%vd_dp
+
+VABS_sp      ---- 1110 1.11 0000 .... 1010 11.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VABS_dp      ---- 1110 1.11 0000 .... 1011 11.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1



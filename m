Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21279C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3D521721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsdLSz0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3D521721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39632 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPax-0001CB-64
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdr-0008Qz-Rt
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdW-0004gn-UE
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdW-0004VA-9M
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id s3so9967539wms.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fpGsIWOoUsjHLITABC3kThd/MgC+CdV/FGLa2lIHkA8=;
 b=qsdLSz0u4mT+V1h1NAwSNTlKVSsQF1OGTRacJpxq8jLD9NECCB/FeBziIRMcxVCNqD
 5eniX2Ga0NkIbH8uCJGVq7fXK5iiEvD6bq5f32hQ8WimiIayDBfuYeGGP6PKzUIqKaw2
 iQsAkv6nCl0Bxmkoe8CrlGRuQVZgRza5O5baKDhE7HEQt0O0cYbkopXEzZUIRDBPJtEz
 LnXma1BNu/WcziIHv2AYCWFk9BGOURVfj29EbHLiN2WpeO0wjKwAMok4hbgAw7gukTBB
 vkyPZ+cJzUqmCZP8YwL4VAOFZOTz38Daamavd96xDBdVQgq2Ff/TqDxl6D4DLKXG+fGH
 qFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fpGsIWOoUsjHLITABC3kThd/MgC+CdV/FGLa2lIHkA8=;
 b=WaM7Hwqqw05znW3MsGRbMJPQvNncFZveLTYBsZgeFth2Iob4z1Z7z7IeY9mjYonbqc
 /NtrYsrlNDryQtjWUtSOkc9eILeNXVhqpWv+Ru1yBBEE91TQ9sqA5PkJ8t8sfv4Tvmwx
 oianitBsOytPB1MVpPQkd7DCcRkOnpgAK0TksQbpKkPCI5AQZFjjFmxX1AfSP3YUyEnF
 jLieIveC3nE9fBUg5rehWDPiSzrUnDO78MOBlwsugVPYpEKC1wR34VC+/36P8i5mb17e
 Wh1vY579UtoNbs3K6vQAOYw+vAHpACOEqfISS1Za2FhUwTe9onMcpuu8AzcYD1GcttgW
 hOVw==
X-Gm-Message-State: APjAAAUJkjWoiedUlbtVH83VBEcTNEDZ07yIxN27imwfNwGhemj7TQhJ
 Qz5OpuOEObV3wWLoBmTDVkdW745sTT/lhw==
X-Google-Smtp-Source: APXvYqxKVL4PYOxsjxp5RNuvinHLD5PWa82XzCvUQfxtruOnHKqFL/nQcrcgvLvvgufmeb7Prwpprw==
X-Received: by 2002:a1c:3:: with SMTP id 3mr3729120wma.44.1560428117341;
 Thu, 13 Jun 2019 05:15:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:24 +0100
Message-Id: <20190613121433.5246-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 39/48] target/arm: Convert VFP comparison insns
 to decodetree
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

Convert the VFP comparison instructions to decodetree.

Note that comparison instructions should not honour the VFP
short-vector length and stride information: they are scalar-only
operations.  This applies to all the 2-operand instructions except
for VMOV, VABS, VNEG and VSQRT.  (In the old decoder this is
implemented via the "if (op == 15 && rn > 3) { veclen = 0; }" check.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 75 ++++++++++++++++++++++++++++++++++
 target/arm/translate.c         | 51 +----------------------
 target/arm/vfp.decode          |  5 +++
 3 files changed, 81 insertions(+), 50 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index a7e4ae31985..ebde86210a6 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1938,3 +1938,78 @@ static bool trans_VSQRT_dp(DisasContext *s, arg_VSQRT_dp *a)
 {
     return do_vfp_2op_dp(s, gen_VSQRT_dp, a->vd, a->vm);
 }
+
+static bool trans_VCMP_sp(DisasContext *s, arg_VCMP_sp *a)
+{
+    TCGv_i32 vd, vm;
+
+    /* Vm/M bits must be zero for the Z variant */
+    if (a->z && a->vm != 0) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vd = tcg_temp_new_i32();
+    vm = tcg_temp_new_i32();
+
+    neon_load_reg32(vd, a->vd);
+    if (a->z) {
+        tcg_gen_movi_i32(vm, 0);
+    } else {
+        neon_load_reg32(vm, a->vm);
+    }
+
+    if (a->e) {
+        gen_helper_vfp_cmpes(vd, vm, cpu_env);
+    } else {
+        gen_helper_vfp_cmps(vd, vm, cpu_env);
+    }
+
+    tcg_temp_free_i32(vd);
+    tcg_temp_free_i32(vm);
+
+    return true;
+}
+
+static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
+{
+    TCGv_i64 vd, vm;
+
+    /* Vm/M bits must be zero for the Z variant */
+    if (a->z && a->vm != 0) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_fp_d32, s) && ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    vd = tcg_temp_new_i64();
+    vm = tcg_temp_new_i64();
+
+    neon_load_reg64(vd, a->vd);
+    if (a->z) {
+        tcg_gen_movi_i64(vm, 0);
+    } else {
+        neon_load_reg64(vm, a->vm);
+    }
+
+    if (a->e) {
+        gen_helper_vfp_cmped(vd, vm, cpu_env);
+    } else {
+        gen_helper_vfp_cmpd(vd, vm, cpu_env);
+    }
+
+    tcg_temp_free_i64(vd);
+    tcg_temp_free_i64(vm);
+
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index b26242d3498..af1d01c49b7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1390,30 +1390,6 @@ static inline void gen_vfp_neg(int dp)
         gen_helper_vfp_negs(cpu_F0s, cpu_F0s);
 }
 
-static inline void gen_vfp_cmp(int dp)
-{
-    if (dp)
-        gen_helper_vfp_cmpd(cpu_F0d, cpu_F1d, cpu_env);
-    else
-        gen_helper_vfp_cmps(cpu_F0s, cpu_F1s, cpu_env);
-}
-
-static inline void gen_vfp_cmpe(int dp)
-{
-    if (dp)
-        gen_helper_vfp_cmped(cpu_F0d, cpu_F1d, cpu_env);
-    else
-        gen_helper_vfp_cmpes(cpu_F0s, cpu_F1s, cpu_env);
-}
-
-static inline void gen_vfp_F1_ld0(int dp)
-{
-    if (dp)
-        tcg_gen_movi_i64(cpu_F1d, 0);
-    else
-        tcg_gen_movi_i32(cpu_F1s, 0);
-}
-
 #define VFP_GEN_ITOF(name) \
 static inline void gen_vfp_##name(int dp, int neon) \
 { \
@@ -3091,6 +3067,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             case 15:
                 switch (rn) {
                 case 0 ... 3:
+                case 8 ... 11:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3135,11 +3112,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     rd_is_dp = false;
                     break;
 
-                case 0x08: case 0x0a: /* vcmp, vcmpz */
-                case 0x09: case 0x0b: /* vcmpe, vcmpez */
-                    no_output = true;
-                    break;
-
                 case 0x0c: /* vrintr */
                 case 0x0d: /* vrintz */
                 case 0x0e: /* vrintx */
@@ -3240,14 +3212,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             /* Load the initial operands.  */
             if (op == 15) {
                 switch (rn) {
-                case 0x08: case 0x09: /* Compare */
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_mov_F1_vreg(dp, rm);
-                    break;
-                case 0x0a: case 0x0b: /* Compare with zero */
-                    gen_mov_F0_vreg(dp, rd);
-                    gen_vfp_F1_ld0(dp);
-                    break;
                 case 0x14: /* vcvt fp <-> fixed */
                 case 0x15:
                 case 0x16:
@@ -3357,19 +3321,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                         gen_vfp_msr(tmp);
                         break;
                     }
-                    case 8: /* cmp */
-                        gen_vfp_cmp(dp);
-                        break;
-                    case 9: /* cmpe */
-                        gen_vfp_cmpe(dp);
-                        break;
-                    case 10: /* cmpz */
-                        gen_vfp_cmp(dp);
-                        break;
-                    case 11: /* cmpez */
-                        gen_vfp_F1_ld0(dp);
-                        gen_vfp_cmpe(dp);
-                        break;
                     case 12: /* vrintr */
                     {
                         TCGv_ptr fpst = get_fpstatus_ptr(0);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index b72ab8b8067..9db7aa7021a 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -176,3 +176,8 @@ VSQRT_sp     ---- 1110 1.11 0001 .... 1010 11.0 .... \
              vd=%vd_sp vm=%vm_sp
 VSQRT_dp     ---- 1110 1.11 0001 .... 1011 11.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+VCMP_sp      ---- 1110 1.11 010 z:1 .... 1010 e:1 1.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VCMP_dp      ---- 1110 1.11 010 z:1 .... 1011 e:1 1.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1



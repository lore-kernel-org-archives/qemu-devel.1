Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B634C2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FE62076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyjQjZx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FE62076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqUo-0006Kn-Pm
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8A-0002Aq-RG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:54 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp88-0007YB-R3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:54 -0400
Received: by mail-wr1-x42e.google.com with SMTP id w5so18877940wrp.8
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uc5tKe+n+q9dZpOQQ/cwWK+9f+7sQguxwW/Thvj3qQU=;
 b=gyjQjZx3oTIwsA3Wz+NmnPvUJEBQw9dKKa3Tu8EfVaeWFReFpHOO7uymvAs+iTA7kY
 Ws8J8o8bAPffrSqTG87krH6JnNaapkthxCHGMBhaDFb83+aVVJ6K2Un0Eqf3b0UwPHj/
 Jr2X4g4CLAIW5yx/AYx8cITO5jb4b+sou5Uqxx3R26qbJKy+ILhGOe/8vmqnXGgGsBLR
 dEu1acQUgjbNKpAD88aOUJT+LSrRZ47RmDXzjsnvWKTUDFkeor3GkyfOYsgGgcVT8qAi
 NkW1oAl/ziBYX0MqVkvghv97bP51insgmCOqruHLx5YDYXH82WEb2LVCrfkpZHLfRrRV
 uxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uc5tKe+n+q9dZpOQQ/cwWK+9f+7sQguxwW/Thvj3qQU=;
 b=qEM/aKu/EzaooophxrYuUaqdWsQ/OmtFz9a3O0uYCLHyRtxNv30MKBDEN1X6IK7DI6
 j6l7eHYpRE1Vwk4Q3h9i9L4+jzNrJGofo7p62nACnPX+uYagtyNhZbZqinJAXZCuA9En
 OXXq4ejrg/IHDRIMxzZHDaS3UV3yzBBLgK/+8WHiUtbyhD92tt17IZGVkRbEu3vGtesK
 hdka+9MxzClgtzCackG+AI8nJHZlb2m+oON2dCjPBWO+GNPgqMw1IDGHeh0YEYTdg18v
 9tuFTwQYfHr9UE8CbvGiLVR6tgojQROFINFINnhSbOhQ30eCJ3fBwnK1TLa0CiOJuufQ
 S/Mw==
X-Gm-Message-State: AOAM531aSV/ug8P8S8Wq9sr2jqQ4kMrYKW0dhsYdd0o8PyNAW4EEk47N
 o3YXdP8bvgdX/AI7egBH01tbcFw1dOsjR/mU
X-Google-Smtp-Source: ABdhPJxyAQrW4KKAJ+JjGc8obS69YaWajEwbCtv3eFhPmnZlN7rAmN26ET5hzYk2Xdp9e+41R/2DaQ==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr17188303wrr.201.1600092411005; 
 Mon, 14 Sep 2020 07:06:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/36] target/arm: Convert Neon 3-same-fp size field to MO_* in
 decode
Date: Mon, 14 Sep 2020 15:06:12 +0100
Message-Id: <20200914140641.21369-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the Neon instructions, some instruction formats have a 2-bit size
field which corresponds exactly to QEMU's MO_8/16/32/64.  However the
floating-point insns in the 3-same group have a 1-bit size field
which is "0 for 32-bit float and 1 for 16-bit float".  Currently we
pass these values directly through to trans_ functions, which means
that when reading a particular trans_ function you need to know if
that insn uses a 2-bit size or a 1-bit size.

Move the handling of the 1-bit size to the decodetree file, so that
all these insns consistently pass a size to the trans_ function which
is an MO_8/16/32/64 value.

In this commit we switch over the insns using the 3same_fp and
3same_fp_q0 formats.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200903133209.5141-2-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 15 ++++++++++-----
 target/arm/translate-neon.c.inc | 16 +++++++++++-----
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 1e9e8592917..ea2f0dfcf16 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -45,11 +45,16 @@
 @3same_q0        .... ... . . . size:2 .... .... .... . 0 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp q=0
 
-# For FP insns the high bit of 'size' is used as part of opcode decode
-@3same_fp        .... ... . . . . size:1 .... .... .... . q:1 . . .... \
-                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
-@3same_fp_q0     .... ... . . . . size:1 .... .... .... . 0 . . .... \
-                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp q=0
+# For FP insns the high bit of 'size' is used as part of opcode decode,
+# and the 'size' bit is 0 for 32-bit float and 1 for 16-bit float.
+# This converts this encoding to the same MO_8/16/32/64 values that the
+# integer neon insns use.
+%3same_fp_size   20:1 !function=neon_3same_fp_size
+
+@3same_fp        .... ... . . . . . .... .... .... . q:1 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp size=%3same_fp_size
+@3same_fp_q0     .... ... . . . . . .... .... .... . 0 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp q=0 size=%3same_fp_size
 
 VHADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 0 .... @3same
 VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 2d4926316a4..255c1cf8a2a 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -49,6 +49,12 @@ static inline int rsub_8(DisasContext *s, int x)
     return 8 - x;
 }
 
+static inline int neon_3same_fp_size(DisasContext *s, int x)
+{
+    /* Convert 0==fp32, 1==fp16 into a MO_* value */
+    return MO_32 - x;
+}
+
 /* Include the generated Neon decoder */
 #include "decode-neon-dp.c.inc"
 #include "decode-neon-ls.c.inc"
@@ -1049,7 +1055,7 @@ DO_3SAME_VQDMULH(VQRDMULH, qrdmulh)
     WRAP_FP_GVEC(gen_##INSN##_fp16_3s, FPST_STD_F16, HFUNC)             \
     static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a)     \
     {                                                                   \
-        if (a->size != 0) {                                             \
+        if (a->size == MO_16) {                                         \
             if (!dc_isar_feature(aa32_fp16_arith, s)) {                 \
                 return false;                                           \
             }                                                           \
@@ -1088,7 +1094,7 @@ static bool trans_VMAXNM_fp_3s(DisasContext *s, arg_3same *a)
         return false;
     }
 
-    if (a->size != 0) {
+    if (a->size == MO_16) {
         if (!dc_isar_feature(aa32_fp16_arith, s)) {
             return false;
         }
@@ -1103,7 +1109,7 @@ static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
         return false;
     }
 
-    if (a->size != 0) {
+    if (a->size == MO_16) {
         if (!dc_isar_feature(aa32_fp16_arith, s)) {
             return false;
         }
@@ -1135,7 +1141,7 @@ static bool do_3same_fp_pair(DisasContext *s, arg_3same *a,
     assert(a->q == 0); /* enforced by decode patterns */
 
 
-    fpstatus = fpstatus_ptr(a->size != 0 ? FPST_STD_F16 : FPST_STD);
+    fpstatus = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
@@ -1152,7 +1158,7 @@ static bool do_3same_fp_pair(DisasContext *s, arg_3same *a,
 #define DO_3S_FP_PAIR(INSN,FUNC)                                    \
     static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
     {                                                               \
-        if (a->size != 0) {                                         \
+        if (a->size == MO_16) {                                     \
             if (!dc_isar_feature(aa32_fp16_arith, s)) {             \
                 return false;                                       \
             }                                                       \
-- 
2.20.1



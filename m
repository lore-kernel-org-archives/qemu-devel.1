Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB99C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C07E21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LqfMBsLS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C07E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCZm-0002sA-Ps
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58982)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzh-0005iT-Gi
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBze-0003Q0-Bo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49233 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBzc-0003Ea-33; Tue, 02 Jul 2019 02:10:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMm4Hz1z9sQt; Tue,  2 Jul 2019 16:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047748;
 bh=3BpbH90W3luMeP+IvsOTmWCX6bwXDkEpvBUYrisI9OY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LqfMBsLSk+ZhDz1oeToKWjAcnX+DFsR8ydyac7Fsxfrjw5n1FP2deGfDIgKSxCXzP
 mZh6ZKoCsiXfZcf/E3FYXH2oaDUXqOuuGTik56srCOWg+Kv3ZEf34mVvcaGTWvjqZ5
 iwPbL3tnQjbw3aV3HgGcjMMPYkj0FPqXHw/BLYoU=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:42 +1000
Message-Id: <20190702060857.3926-35-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 34/49] target/ppc: introduce
 GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Rather than perform the VSR register decoding within the helper itself,
introduce a new GEN_VSX_HELPER_X2_AB macro which performs the decode base=
d
upon xA and xB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-9-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 15 ++++++---------
 target/ppc/helper.h                 | 12 ++++++------
 target/ppc/translate/vsx-impl.inc.c | 30 +++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 44dff1b459..902d63b139 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2179,10 +2179,9 @@ VSX_RSQRTE(xvrsqrtesp, 4, float32, VsrW(i), 0, 0)
  *   nbits - number of fraction bits
  */
 #define VSX_TDIV(op, nels, tp, fld, emin, emax, nbits)                  =
\
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
\
+void helper_##op(CPUPPCState *env, uint32_t opcode,                     =
\
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          =
\
 {                                                                       =
\
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
  \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
  \
     int i;                                                              =
\
     int fe_flag =3D 0;                                                  =
  \
     int fg_flag =3D 0;                                                  =
  \
@@ -2431,10 +2430,9 @@ VSX_SCALAR_CMP_DP(xscmpgedp, le, 1, 1)
 VSX_SCALAR_CMP_DP(xscmpgtdp, lt, 1, 1)
 VSX_SCALAR_CMP_DP(xscmpnedp, eq, 0, 0)
=20
-void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode)
+void helper_xscmpexpdp(CPUPPCState *env, uint32_t opcode,
+                       ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];
     int64_t exp_a, exp_b;
     uint32_t cc;
=20
@@ -2492,10 +2490,9 @@ void helper_xscmpexpqp(CPUPPCState *env, uint32_t =
opcode)
 }
=20
 #define VSX_SCALAR_CMP(op, ordered)                                     =
 \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
 \
+void helper_##op(CPUPPCState *env, uint32_t opcode,                     =
 \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          =
 \
 {                                                                       =
 \
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
   \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
   \
     uint32_t cc =3D 0;                                                  =
   \
     bool vxsnan_flag =3D false, vxvc_flag =3D false;                    =
     \
                                                                         =
 \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f56476ec41..0ab1ef2aee 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -375,7 +375,7 @@ DEF_HELPER_2(xsdivqp, void, env, i32)
 DEF_HELPER_3(xsredp, void, env, vsr, vsr)
 DEF_HELPER_3(xssqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xsrsqrtedp, void, env, vsr, vsr)
-DEF_HELPER_2(xstdivdp, void, env, i32)
+DEF_HELPER_4(xstdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xstsqrtdp, void, env, i32)
 DEF_HELPER_4(xsmaddadp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmaddmdp, void, env, vsr, vsr, vsr)
@@ -389,10 +389,10 @@ DEF_HELPER_4(xscmpeqdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpgtdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpgedp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpnedp, void, env, vsr, vsr, vsr)
-DEF_HELPER_2(xscmpexpdp, void, env, i32)
+DEF_HELPER_4(xscmpexpdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscmpexpqp, void, env, i32)
-DEF_HELPER_2(xscmpodp, void, env, i32)
-DEF_HELPER_2(xscmpudp, void, env, i32)
+DEF_HELPER_4(xscmpodp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscmpudp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xscmpoqp, void, env, i32)
 DEF_HELPER_2(xscmpuqp, void, env, i32)
 DEF_HELPER_4(xsmaxdp, void, env, vsr, vsr, vsr)
@@ -460,7 +460,7 @@ DEF_HELPER_4(xvdivdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvredp, void, env, vsr, vsr)
 DEF_HELPER_3(xvsqrtdp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtedp, void, env, vsr, vsr)
-DEF_HELPER_2(xvtdivdp, void, env, i32)
+DEF_HELPER_4(xvtdivdp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xvtsqrtdp, void, env, i32)
 DEF_HELPER_4(xvmaddadp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaddmdp, void, env, vsr, vsr, vsr)
@@ -498,7 +498,7 @@ DEF_HELPER_4(xvdivsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_3(xvresp, void, env, vsr, vsr)
 DEF_HELPER_3(xvsqrtsp, void, env, vsr, vsr)
 DEF_HELPER_3(xvrsqrtesp, void, env, vsr, vsr)
-DEF_HELPER_2(xvtdivsp, void, env, i32)
+DEF_HELPER_4(xvtdivsp, void, env, i32, vsr, vsr)
 DEF_HELPER_2(xvtsqrtsp, void, env, i32)
 DEF_HELPER_4(xvmaddasp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xvmaddmsp, void, env, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 36fb740f6a..9b4603ac33 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1061,6 +1061,24 @@ static void gen_##name(DisasContext *ctx)         =
                            \
     tcg_temp_free_ptr(xb);                                              =
      \
 }
=20
+#define GEN_VSX_HELPER_X2_AB(name, op1, op2, inval, type)               =
      \
+static void gen_##name(DisasContext *ctx)                               =
      \
+{                                                                       =
      \
+    TCGv_i32 opc;                                                       =
      \
+    TCGv_ptr xa, xb;                                                    =
      \
+    if (unlikely(!ctx->vsx_enabled)) {                                  =
      \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                          =
      \
+        return;                                                         =
      \
+    }                                                                   =
      \
+    opc =3D tcg_const_i32(ctx->opcode);                                 =
        \
+    xa =3D gen_vsr_ptr(xA(ctx->opcode));                                =
        \
+    xb =3D gen_vsr_ptr(xB(ctx->opcode));                                =
        \
+    gen_helper_##name(cpu_env, opc, xa, xb);                            =
      \
+    tcg_temp_free_i32(opc);                                             =
      \
+    tcg_temp_free_ptr(xa);                                              =
      \
+    tcg_temp_free_ptr(xb);                                              =
      \
+}
+
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
 static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
@@ -1089,7 +1107,7 @@ GEN_VSX_HELPER_2(xsdivqp, 0x04, 0x11, 0, PPC2_ISA30=
0)
 GEN_VSX_HELPER_X2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
@@ -1103,10 +1121,10 @@ GEN_VSX_HELPER_X3(xscmpeqdp, 0x0C, 0x00, 0, PPC2_=
ISA300)
 GEN_VSX_HELPER_X3(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X2_AB(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
@@ -1174,7 +1192,7 @@ GEN_VSX_HELPER_X3(xvdivdp, 0x00, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
@@ -1208,7 +1226,7 @@ GEN_VSX_HELPER_X3(xvdivsp, 0x00, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X2_AB(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
--=20
2.21.0



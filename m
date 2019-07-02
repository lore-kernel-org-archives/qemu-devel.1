Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081D5C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71CC205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="i/iiaTYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71CC205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCVi-0000GY-0p
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58735)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzE-0005J4-UB
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzD-0003DX-7s
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:52 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50487 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBzC-0003CN-IX; Tue, 02 Jul 2019 02:09:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMl4nD0z9sR7; Tue,  2 Jul 2019 16:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047747;
 bh=tSoLUFvH2LPGKI+wyry7XeieVc2l5AM3MEHgJddFrXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i/iiaTYwPIiQapn6o9pXCagGuGckhz/5tC90r0tbunilCOLcllk4Wlz9I02UBEdeA
 Cgdc/8BE90/s3EIocCCZMiDQnZO0DrCqIysi6RWjDOQa6aeeJio38MvZFznQ+MEaF0
 wheVELl3UWDCTubZgcw4XPXOfYCqf/4KVsJriakE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:46 +1000
Message-Id: <20190702060857.3926-39-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 38/49] target/ppc: introduce
 GEN_VSX_HELPER_R2_AB macro to fpu_helper.c
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
introduce a new GEN_VSX_HELPER_R2_AB macro which performs the decode base=
d
upon rA and rB at translation time.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-13-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             | 10 ++++------
 target/ppc/helper.h                 |  6 +++---
 target/ppc/translate/vsx-impl.inc.c | 24 +++++++++++++++++++++---
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index cb593517ae..f0a897cb9a 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -2452,10 +2452,9 @@ void helper_xscmpexpdp(CPUPPCState *env, uint32_t =
opcode,
     do_float_check_status(env, GETPC());
 }
=20
-void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode)
+void helper_xscmpexpqp(CPUPPCState *env, uint32_t opcode,
+                       ppc_vsr_t *xa, ppc_vsr_t *xb)
 {
-    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];
-    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];
     int64_t exp_a, exp_b;
     uint32_t cc;
=20
@@ -2531,10 +2530,9 @@ VSX_SCALAR_CMP(xscmpodp, 1)
 VSX_SCALAR_CMP(xscmpudp, 0)
=20
 #define VSX_SCALAR_CMPQ(op, ordered)                                    =
\
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
\
+void helper_##op(CPUPPCState *env, uint32_t opcode,                     =
\
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          =
\
 {                                                                       =
\
-    ppc_vsr_t *xa =3D &env->vsr[rA(opcode) + 32];                       =
  \
-    ppc_vsr_t *xb =3D &env->vsr[rB(opcode) + 32];                       =
  \
     uint32_t cc =3D 0;                                                  =
  \
     bool vxsnan_flag =3D false, vxvc_flag =3D false;                    =
    \
                                                                         =
\
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 2e0646f5eb..a5e12a3933 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -390,11 +390,11 @@ DEF_HELPER_4(xscmpgtdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpgedp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpnedp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xscmpexpdp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xscmpexpqp, void, env, i32)
+DEF_HELPER_4(xscmpexpqp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscmpodp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xscmpudp, void, env, i32, vsr, vsr)
-DEF_HELPER_2(xscmpoqp, void, env, i32)
-DEF_HELPER_2(xscmpuqp, void, env, i32)
+DEF_HELPER_4(xscmpoqp, void, env, i32, vsr, vsr)
+DEF_HELPER_4(xscmpuqp, void, env, i32, vsr, vsr)
 DEF_HELPER_4(xsmaxdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xsmindp, void, env, vsr, vsr, vsr)
 DEF_HELPER_5(xsmaxcdp, void, env, i32, vsr, vsr, vsr)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 05db509a0c..5cf053e7f2 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1133,6 +1133,24 @@ static void gen_##name(DisasContext *ctx)         =
                            \
     tcg_temp_free_ptr(xb);                                              =
      \
 }
=20
+#define GEN_VSX_HELPER_R2_AB(name, op1, op2, inval, type)               =
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
+    xa =3D gen_vsr_ptr(rA(ctx->opcode) + 32);                           =
        \
+    xb =3D gen_vsr_ptr(rB(ctx->opcode) + 32);                           =
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
@@ -1176,11 +1194,11 @@ GEN_VSX_HELPER_X3(xscmpgtdp, 0x0C, 0x01, 0, PPC2_=
ISA300)
 GEN_VSX_HELPER_X3(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X3(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2_AB(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
+GEN_VSX_HELPER_R2_AB(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
 GEN_VSX_HELPER_X2_AB(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_X2_AB(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
+GEN_VSX_HELPER_R2_AB(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_R2_AB(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
 GEN_VSX_HELPER_X3(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
 GEN_VSX_HELPER_R3(xsmaxcdp, 0x00, 0x10, 0, PPC2_ISA300)
--=20
2.21.0



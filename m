Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6370CC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D24420881
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oTZtpXux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D24420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCUW-0007O6-7y
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58991)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzi-0005kF-Fe
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBze-0003Pq-Aq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:22 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:42395 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBza-0003Dz-4m; Tue, 02 Jul 2019 02:10:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMm335dz9sR5; Tue,  2 Jul 2019 16:09:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047748;
 bh=wwz/Oj8Oqxl4qc3VzT5DUcYIjpbtyN+sQEa+O/DZkaM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oTZtpXuxT+wEZU+C81OQ5TGDNskScHkUdMT6iKOi23UZvBTIsA8eOQDET9Q2qVlwI
 wpIs04PxgPf7knwbHLZ5KG2HZpUQ5ynappbXlYZ/wsu5IdMPw3U2ZDAB5k4OTcp4Dw
 1tovfPVqgD5QATyJ6vvVT2z34aSbnClNottnYKpY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:39 +1000
Message-Id: <20190702060857.3926-32-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 31/49] target/ppc: introduce GEN_VSX_HELPER_X3
 macro to fpu_helper.c
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
introduce a new GEN_VSX_HELPER_X3 macro which performs the decode based
upon xT, xA and xB at translation time.

With the previous changes to the VSX_CMP generator and helper macros the
opcode parameter is no longer required in the common case and can be
removed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190616123751.781-6-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/fpu_helper.c             |  42 +++------
 target/ppc/helper.h                 | 120 ++++++++++++------------
 target/ppc/translate/vsx-impl.inc.c | 137 ++++++++++++++++------------
 3 files changed, 151 insertions(+), 148 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index b1ce954354..012dfdac3e 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1801,11 +1801,9 @@ uint32_t helper_efdcmpeq(CPUPPCState *env, uint64_=
t op1, uint64_t op2)
  *   sfprf - set FPRF
  */
 #define VSX_ADD_SUB(name, op, nels, tp, fld, sfprf, r2sp)               =
     \
-void helper_##name(CPUPPCState *env, uint32_t opcode)                   =
     \
+void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,                     =
     \
+                   ppc_vsr_t *xa, ppc_vsr_t *xb)                        =
     \
 {                                                                       =
     \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
       \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
     ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
@@ -1884,11 +1882,9 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opc=
ode)
  *   sfprf - set FPRF
  */
 #define VSX_MUL(op, nels, tp, fld, sfprf, r2sp)                         =
     \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
     \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                       =
     \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          =
     \
 {                                                                       =
     \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
       \
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
       \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
       \
     ppc_vsr_t t =3D *xt;                                                =
       \
     int i;                                                              =
     \
                                                                         =
     \
@@ -1962,11 +1958,9 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opc=
ode)
  *   sfprf - set FPRF
  */
 #define VSX_DIV(op, nels, tp, fld, sfprf, r2sp)                         =
      \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
      \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                       =
      \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          =
      \
 {                                                                       =
      \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
        \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
     ppc_vsr_t t =3D *xt;                                                =
        \
     int i;                                                              =
      \
                                                                         =
      \
@@ -2304,11 +2298,9 @@ VSX_TSQRT(xvtsqrtsp, 4, float32, VsrW(i), -126, 23=
)
  *   sfprf - set FPRF
  */
 #define VSX_MADD(op, nels, tp, fld, maddflgs, afrm, sfprf, r2sp)        =
      \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
      \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                       =
      \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          =
      \
 {                                                                       =
      \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
        \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
     ppc_vsr_t t =3D *xt, *b, *c;                                        =
        \
     int i;                                                              =
      \
                                                                         =
      \
@@ -2402,11 +2394,9 @@ VSX_MADD(xvnmsubmsp, 4, float32, VsrW(i), NMSUB_FL=
GS, 0, 0, 0)
  *   svxvc - set VXVC bit
  */
 #define VSX_SCALAR_CMP_DP(op, cmp, exp, svxvc)                          =
      \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                     =
      \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                       =
      \
+                 ppc_vsr_t *xa, ppc_vsr_t *xb)                          =
      \
 {                                                                       =
      \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
        \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
     ppc_vsr_t t =3D *xt;                                                =
        \
     bool vxsnan_flag =3D false, vxvc_flag =3D false, vex_flag =3D false;=
            \
                                                                         =
      \
@@ -2614,11 +2604,9 @@ VSX_SCALAR_CMPQ(xscmpuqp, 0)
  *   fld   - vsr_t field (VsrD(*) or VsrW(*))
  */
 #define VSX_MAX_MIN(name, op, nels, tp, fld)                            =
      \
-void helper_##name(CPUPPCState *env, uint32_t opcode)                   =
      \
+void helper_##name(CPUPPCState *env, ppc_vsr_t *xt,                     =
      \
+                   ppc_vsr_t *xa, ppc_vsr_t *xb)                        =
      \
 {                                                                       =
      \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
        \
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
        \
-    ppc_vsr_t *xb =3D &env->vsr[xB(opcode)];                            =
        \
     ppc_vsr_t t =3D *xt;                                                =
        \
     int i;                                                              =
      \
                                                                         =
      \
@@ -3194,11 +3182,9 @@ uint64_t helper_xsrsp(CPUPPCState *env, uint64_t x=
b)
 }
=20
 #define VSX_XXPERM(op, indexed)                                       \
-void helper_##op(CPUPPCState *env, uint32_t opcode)                   \
+void helper_##op(CPUPPCState *env, ppc_vsr_t *xt,                     \
+                 ppc_vsr_t *xa, ppc_vsr_t *pcv)                       \
 {                                                                     \
-    ppc_vsr_t *xt =3D &env->vsr[xT(opcode)];                            =
\
-    ppc_vsr_t *xa =3D &env->vsr[xA(opcode)];                            =
\
-    ppc_vsr_t *pcv =3D &env->vsr[xB(opcode)];                           =
\
     ppc_vsr_t t =3D *xt;                                                =
\
     int i, idx;                                                       \
                                                                       \
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 8666415169..f6a97cedc6 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -365,38 +365,38 @@ DEF_HELPER_4(bcdsr, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdtrunc, i32, avr, avr, avr, i32)
 DEF_HELPER_4(bcdutrunc, i32, avr, avr, avr, i32)
=20
-DEF_HELPER_2(xsadddp, void, env, i32)
+DEF_HELPER_4(xsadddp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xsaddqp, void, env, i32)
-DEF_HELPER_2(xssubdp, void, env, i32)
-DEF_HELPER_2(xsmuldp, void, env, i32)
+DEF_HELPER_4(xssubdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsmuldp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xsmulqp, void, env, i32)
-DEF_HELPER_2(xsdivdp, void, env, i32)
+DEF_HELPER_4(xsdivdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xsdivqp, void, env, i32)
 DEF_HELPER_2(xsredp, void, env, i32)
 DEF_HELPER_2(xssqrtdp, void, env, i32)
 DEF_HELPER_2(xsrsqrtedp, void, env, i32)
 DEF_HELPER_2(xstdivdp, void, env, i32)
 DEF_HELPER_2(xstsqrtdp, void, env, i32)
-DEF_HELPER_2(xsmaddadp, void, env, i32)
-DEF_HELPER_2(xsmaddmdp, void, env, i32)
-DEF_HELPER_2(xsmsubadp, void, env, i32)
-DEF_HELPER_2(xsmsubmdp, void, env, i32)
-DEF_HELPER_2(xsnmaddadp, void, env, i32)
-DEF_HELPER_2(xsnmaddmdp, void, env, i32)
-DEF_HELPER_2(xsnmsubadp, void, env, i32)
-DEF_HELPER_2(xsnmsubmdp, void, env, i32)
-DEF_HELPER_2(xscmpeqdp, void, env, i32)
-DEF_HELPER_2(xscmpgtdp, void, env, i32)
-DEF_HELPER_2(xscmpgedp, void, env, i32)
-DEF_HELPER_2(xscmpnedp, void, env, i32)
+DEF_HELPER_4(xsmaddadp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsmaddmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsmsubadp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsmsubmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsnmaddadp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsnmaddmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsnmsubadp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsnmsubmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xscmpeqdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xscmpgtdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xscmpgedp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xscmpnedp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xscmpexpdp, void, env, i32)
 DEF_HELPER_2(xscmpexpqp, void, env, i32)
 DEF_HELPER_2(xscmpodp, void, env, i32)
 DEF_HELPER_2(xscmpudp, void, env, i32)
 DEF_HELPER_2(xscmpoqp, void, env, i32)
 DEF_HELPER_2(xscmpuqp, void, env, i32)
-DEF_HELPER_2(xsmaxdp, void, env, i32)
-DEF_HELPER_2(xsmindp, void, env, i32)
+DEF_HELPER_4(xsmaxdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsmindp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xsmaxcdp, void, env, i32)
 DEF_HELPER_2(xsmincdp, void, env, i32)
 DEF_HELPER_2(xsmaxjdp, void, env, i32)
@@ -436,42 +436,42 @@ DEF_HELPER_2(xsrqpxp, void, env, i32)
 DEF_HELPER_2(xssqrtqp, void, env, i32)
 DEF_HELPER_2(xssubqp, void, env, i32)
=20
-DEF_HELPER_2(xsaddsp, void, env, i32)
-DEF_HELPER_2(xssubsp, void, env, i32)
-DEF_HELPER_2(xsmulsp, void, env, i32)
-DEF_HELPER_2(xsdivsp, void, env, i32)
+DEF_HELPER_4(xsaddsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xssubsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsmulsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsdivsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xsresp, void, env, i32)
 DEF_HELPER_2(xsrsp, i64, env, i64)
 DEF_HELPER_2(xssqrtsp, void, env, i32)
 DEF_HELPER_2(xsrsqrtesp, void, env, i32)
-DEF_HELPER_2(xsmaddasp, void, env, i32)
-DEF_HELPER_2(xsmaddmsp, void, env, i32)
-DEF_HELPER_2(xsmsubasp, void, env, i32)
-DEF_HELPER_2(xsmsubmsp, void, env, i32)
-DEF_HELPER_2(xsnmaddasp, void, env, i32)
-DEF_HELPER_2(xsnmaddmsp, void, env, i32)
-DEF_HELPER_2(xsnmsubasp, void, env, i32)
-DEF_HELPER_2(xsnmsubmsp, void, env, i32)
+DEF_HELPER_4(xsmaddasp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsmaddmsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsmsubasp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsmsubmsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsnmaddasp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsnmaddmsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsnmsubasp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xsnmsubmsp, void, env, vsr, vsr, vsr)
=20
-DEF_HELPER_2(xvadddp, void, env, i32)
-DEF_HELPER_2(xvsubdp, void, env, i32)
-DEF_HELPER_2(xvmuldp, void, env, i32)
-DEF_HELPER_2(xvdivdp, void, env, i32)
+DEF_HELPER_4(xvadddp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvsubdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmuldp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvdivdp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xvredp, void, env, i32)
 DEF_HELPER_2(xvsqrtdp, void, env, i32)
 DEF_HELPER_2(xvrsqrtedp, void, env, i32)
 DEF_HELPER_2(xvtdivdp, void, env, i32)
 DEF_HELPER_2(xvtsqrtdp, void, env, i32)
-DEF_HELPER_2(xvmaddadp, void, env, i32)
-DEF_HELPER_2(xvmaddmdp, void, env, i32)
-DEF_HELPER_2(xvmsubadp, void, env, i32)
-DEF_HELPER_2(xvmsubmdp, void, env, i32)
-DEF_HELPER_2(xvnmaddadp, void, env, i32)
-DEF_HELPER_2(xvnmaddmdp, void, env, i32)
-DEF_HELPER_2(xvnmsubadp, void, env, i32)
-DEF_HELPER_2(xvnmsubmdp, void, env, i32)
-DEF_HELPER_2(xvmaxdp, void, env, i32)
-DEF_HELPER_2(xvmindp, void, env, i32)
+DEF_HELPER_4(xvmaddadp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmaddmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmsubadp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmsubmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvnmaddadp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvnmaddmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvnmsubadp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvnmsubmdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmaxdp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmindp, void, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpeqdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgedp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgtdp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
@@ -491,25 +491,25 @@ DEF_HELPER_2(xvrdpim, void, env, i32)
 DEF_HELPER_2(xvrdpip, void, env, i32)
 DEF_HELPER_2(xvrdpiz, void, env, i32)
=20
-DEF_HELPER_2(xvaddsp, void, env, i32)
-DEF_HELPER_2(xvsubsp, void, env, i32)
-DEF_HELPER_2(xvmulsp, void, env, i32)
-DEF_HELPER_2(xvdivsp, void, env, i32)
+DEF_HELPER_4(xvaddsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvsubsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmulsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvdivsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_2(xvresp, void, env, i32)
 DEF_HELPER_2(xvsqrtsp, void, env, i32)
 DEF_HELPER_2(xvrsqrtesp, void, env, i32)
 DEF_HELPER_2(xvtdivsp, void, env, i32)
 DEF_HELPER_2(xvtsqrtsp, void, env, i32)
-DEF_HELPER_2(xvmaddasp, void, env, i32)
-DEF_HELPER_2(xvmaddmsp, void, env, i32)
-DEF_HELPER_2(xvmsubasp, void, env, i32)
-DEF_HELPER_2(xvmsubmsp, void, env, i32)
-DEF_HELPER_2(xvnmaddasp, void, env, i32)
-DEF_HELPER_2(xvnmaddmsp, void, env, i32)
-DEF_HELPER_2(xvnmsubasp, void, env, i32)
-DEF_HELPER_2(xvnmsubmsp, void, env, i32)
-DEF_HELPER_2(xvmaxsp, void, env, i32)
-DEF_HELPER_2(xvminsp, void, env, i32)
+DEF_HELPER_4(xvmaddasp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmaddmsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmsubasp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmsubmsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvnmaddasp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvnmaddmsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvnmsubasp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvnmsubmsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvmaxsp, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xvminsp, void, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpeqsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgesp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
 DEF_HELPER_FLAGS_4(xvcmpgtsp, TCG_CALL_NO_RWG, i32, env, vsr, vsr, vsr)
@@ -532,8 +532,8 @@ DEF_HELPER_2(xvrspic, void, env, i32)
 DEF_HELPER_2(xvrspim, void, env, i32)
 DEF_HELPER_2(xvrspip, void, env, i32)
 DEF_HELPER_2(xvrspiz, void, env, i32)
-DEF_HELPER_2(xxperm, void, env, i32)
-DEF_HELPER_2(xxpermr, void, env, i32)
+DEF_HELPER_4(xxperm, void, env, vsr, vsr, vsr)
+DEF_HELPER_4(xxpermr, void, env, vsr, vsr, vsr)
 DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
 DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
 DEF_HELPER_2(xvxsigsp, void, env, i32)
diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 900ba07d40..b24be00ccf 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -1012,6 +1012,23 @@ static void gen_##name(DisasContext *ctx)         =
                            \
     tcg_temp_free_i32(opc);                                             =
      \
 }
=20
+#define GEN_VSX_HELPER_X3(name, op1, op2, inval, type)                  =
      \
+static void gen_##name(DisasContext *ctx)                               =
      \
+{                                                                       =
      \
+    TCGv_ptr xt, xa, xb;                                                =
      \
+    if (unlikely(!ctx->vsx_enabled)) {                                  =
      \
+        gen_exception(ctx, POWERPC_EXCP_VSXU);                          =
      \
+        return;                                                         =
      \
+    }                                                                   =
      \
+    xt =3D gen_vsr_ptr(xT(ctx->opcode));                                =
        \
+    xa =3D gen_vsr_ptr(xA(ctx->opcode));                                =
        \
+    xb =3D gen_vsr_ptr(xB(ctx->opcode));                                =
        \
+    gen_helper_##name(cpu_env, xt, xa, xb);                             =
      \
+    tcg_temp_free_ptr(xt);                                              =
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
@@ -1030,38 +1047,38 @@ static void gen_##name(DisasContext *ctx)        =
             \
     tcg_temp_free_i64(t1);                                    \
 }
=20
-GEN_VSX_HELPER_2(xsadddp, 0x00, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsadddp, 0x00, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsaddqp, 0x04, 0x00, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xssubdp, 0x00, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xssubdp, 0x00, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmuldp, 0x00, 0x06, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmulqp, 0x04, 0x01, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsdivdp, 0x00, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsdivqp, 0x04, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsredp, 0x14, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xssqrtdp, 0x16, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsrsqrtedp, 0x14, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xstdivdp, 0x14, 0x07, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xstsqrtdp, 0x14, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmsubmdp, 0x04, 0x07, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsnmaddadp, 0x04, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsnmaddmdp, 0x04, 0x15, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsnmsubadp, 0x04, 0x16, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsnmsubmdp, 0x04, 0x17, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xscmpeqdp, 0x0C, 0x00, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xsmaddadp, 0x04, 0x04, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmaddmdp, 0x04, 0x05, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmsubadp, 0x04, 0x06, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmsubmdp, 0x04, 0x07, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsnmaddadp, 0x04, 0x14, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsnmaddmdp, 0x04, 0x15, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsnmsubadp, 0x04, 0x16, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsnmsubmdp, 0x04, 0x17, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xscmpeqdp, 0x0C, 0x00, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xscmpgtdp, 0x0C, 0x01, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xscmpgedp, 0x0C, 0x02, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xscmpnedp, 0x0C, 0x03, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpexpdp, 0x0C, 0x07, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpexpqp, 0x04, 0x05, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xscmpodp, 0x0C, 0x05, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpudp, 0x0C, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpoqp, 0x04, 0x04, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xscmpuqp, 0x04, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmaxdp, 0x00, 0x14, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xsmindp, 0x00, 0x15, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xsmaxcdp, 0x00, 0x10, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsmincdp, 0x00, 0x11, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xsmaxjdp, 0x00, 0x12, 0, PPC2_ISA300)
@@ -1098,46 +1115,46 @@ GEN_VSX_HELPER_2(xsrqpxp, 0x05, 0x01, 0, PPC2_ISA=
300)
 GEN_VSX_HELPER_2(xssqrtqp, 0x04, 0x19, 0x1B, PPC2_ISA300)
 GEN_VSX_HELPER_2(xssubqp, 0x04, 0x10, 0, PPC2_ISA300)
=20
-GEN_VSX_HELPER_2(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmulsp, 0x00, 0x02, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsdivsp, 0x00, 0x03, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsaddsp, 0x00, 0x00, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xssubsp, 0x00, 0x01, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmulsp, 0x00, 0x02, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsdivsp, 0x00, 0x03, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsresp, 0x14, 0x01, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xssqrtsp, 0x16, 0x00, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xsrsqrtesp, 0x14, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmaddasp, 0x04, 0x00, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmaddmsp, 0x04, 0x01, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmsubasp, 0x04, 0x02, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsmsubmsp, 0x04, 0x03, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsnmaddasp, 0x04, 0x10, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsnmaddmsp, 0x04, 0x11, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
-GEN_VSX_HELPER_2(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmaddasp, 0x04, 0x00, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmaddmsp, 0x04, 0x01, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmsubasp, 0x04, 0x02, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsmsubmsp, 0x04, 0x03, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsnmaddasp, 0x04, 0x10, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsnmaddmsp, 0x04, 0x11, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsnmsubasp, 0x04, 0x12, 0, PPC2_VSX207)
+GEN_VSX_HELPER_X3(xsnmsubmsp, 0x04, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvsxdsp, 0x10, 0x13, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xscvuxdsp, 0x10, 0x12, 0, PPC2_VSX207)
 GEN_VSX_HELPER_2(xststdcsp, 0x14, 0x12, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcdp, 0x14, 0x16, 0, PPC2_ISA300)
 GEN_VSX_HELPER_2(xststdcqp, 0x04, 0x16, 0, PPC2_ISA300)
=20
-GEN_VSX_HELPER_2(xvadddp, 0x00, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvsubdp, 0x00, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmuldp, 0x00, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvdivdp, 0x00, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvadddp, 0x00, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvsubdp, 0x00, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmuldp, 0x00, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvdivdp, 0x00, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvredp, 0x14, 0x0D, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvsqrtdp, 0x16, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrsqrtedp, 0x14, 0x0C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtdivdp, 0x14, 0x0F, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtdp, 0x14, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmsubmdp, 0x04, 0x0F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmaddadp, 0x04, 0x1C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmaddmdp, 0x04, 0x1D, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmsubadp, 0x04, 0x1E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaddadp, 0x04, 0x0C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaddmdp, 0x04, 0x0D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmsubadp, 0x04, 0x0E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmsubmdp, 0x04, 0x0F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmaddadp, 0x04, 0x1C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmaddmdp, 0x04, 0x1D, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmsubadp, 0x04, 0x1E, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmsubmdp, 0x04, 0x1F, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaxdp, 0x00, 0x1C, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmindp, 0x00, 0x1D, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvdpsp, 0x12, 0x18, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvdpsxds, 0x10, 0x1D, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvdpsxws, 0x10, 0x0D, 0, PPC2_VSX)
@@ -1153,25 +1170,25 @@ GEN_VSX_HELPER_2(xvrdpim, 0x12, 0x0F, 0, PPC2_VSX=
)
 GEN_VSX_HELPER_2(xvrdpip, 0x12, 0x0E, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrdpiz, 0x12, 0x0D, 0, PPC2_VSX)
=20
-GEN_VSX_HELPER_2(xvaddsp, 0x00, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvsubsp, 0x00, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmulsp, 0x00, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvdivsp, 0x00, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvaddsp, 0x00, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvsubsp, 0x00, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmulsp, 0x00, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvdivsp, 0x00, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvresp, 0x14, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvsqrtsp, 0x16, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrsqrtesp, 0x14, 0x08, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtdivsp, 0x14, 0x0B, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtsqrtsp, 0x14, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmsubmsp, 0x04, 0x0B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmaddasp, 0x04, 0x18, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmaddmsp, 0x04, 0x19, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmsubasp, 0x04, 0x1A, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaddasp, 0x04, 0x08, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaddmsp, 0x04, 0x09, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmsubasp, 0x04, 0x0A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmsubmsp, 0x04, 0x0B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmaddasp, 0x04, 0x18, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmaddmsp, 0x04, 0x19, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmsubasp, 0x04, 0x1A, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvnmsubmsp, 0x04, 0x1B, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvmaxsp, 0x00, 0x18, 0, PPC2_VSX)
+GEN_VSX_HELPER_X3(xvminsp, 0x00, 0x19, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvspdp, 0x12, 0x1C, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvcvhpsp, 0x16, 0x1D, 0x18, PPC2_ISA300)
 GEN_VSX_HELPER_2(xvcvsphp, 0x16, 0x1D, 0x19, PPC2_ISA300)
@@ -1190,8 +1207,8 @@ GEN_VSX_HELPER_2(xvrspip, 0x12, 0x0A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvrspiz, 0x12, 0x09, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtstdcsp, 0x14, 0x1A, 0, PPC2_VSX)
 GEN_VSX_HELPER_2(xvtstdcdp, 0x14, 0x1E, 0, PPC2_VSX)
-GEN_VSX_HELPER_2(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
-GEN_VSX_HELPER_2(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xxperm, 0x08, 0x03, 0, PPC2_ISA300)
+GEN_VSX_HELPER_X3(xxpermr, 0x08, 0x07, 0, PPC2_ISA300)
=20
 static void gen_xxbrd(DisasContext *ctx)
 {
--=20
2.21.0



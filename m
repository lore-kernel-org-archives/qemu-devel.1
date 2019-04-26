Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72886C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F80820675
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pvYzw0u/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F80820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuGr-0005q3-7J
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:23:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0d-0005aR-LK
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0b-0004ZK-P9
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:55 -0400
Received: from ozlabs.org ([203.11.71.1]:53953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0b-0004VB-2b; Fri, 26 Apr 2019 02:06:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tp4vWcz9sNl; Fri, 26 Apr 2019 16:06:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258798;
	bh=W9sQhKyJrQXMj/mZuUVkZXbL5uKfz7ioG1dbmzOxLGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvYzw0u/sfJ2xd93yE8Rkc1qivvg+e47X6/ccxrFq7SJZ3IIzJsdaj0Qd3+NTB50L
	0oXobs8vZfbr4t4mI62A7gnsCQ5ELTBeK/SuhS6AgjZMoeJesG5sjH5BwCMM4KSpn9
	Fty8AKGc5gh+lQVfiQZpE2XyTkiwp5X1Tg11zn4A=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:17 +1000
Message-Id: <20190426060627.18153-27-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 26/36] target/ppc: Style fixes for
 translate/vmx-impl.inc.c
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
Cc: gkurz@kaod.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060617.azk_hIxKvukR3qcZiPt4GTnS2Eciwf5fks0e-nNC0fo@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate/vmx-impl.inc.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index eb10c533ca..bd3ff40e68 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -15,7 +15,7 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
 }
=20
 #define GEN_VR_LDX(name, opc2, opc3)                                    =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 avr;                                                       =
      \
@@ -28,8 +28,10 @@ static void glue(gen_, name)(DisasContext *ctx)
     EA =3D tcg_temp_new();                                              =
        \
     gen_addr_reg_index(ctx, EA);                                        =
      \
     tcg_gen_andi_tl(EA, EA, ~0xf);                                      =
      \
-    /* We only need to swap high and low halves. gen_qemu_ld64_i64 does =
      \
-       necessary 64-bit byteswap already. */                            =
      \
+    /*                                                                  =
      \
+     * We only need to swap high and low halves. gen_qemu_ld64_i64      =
      \
+     * does necessary 64-bit byteswap already.                          =
      \
+     */                                                                 =
      \
     if (ctx->le_mode) {                                                 =
      \
         gen_qemu_ld64_i64(ctx, avr, EA);                                =
      \
         set_avr64(rD(ctx->opcode), avr, false);                         =
      \
@@ -61,8 +63,10 @@ static void gen_st##name(DisasContext *ctx)           =
                        \
     EA =3D tcg_temp_new();                                              =
        \
     gen_addr_reg_index(ctx, EA);                                        =
      \
     tcg_gen_andi_tl(EA, EA, ~0xf);                                      =
      \
-    /* We only need to swap high and low halves. gen_qemu_st64_i64 does =
      \
-       necessary 64-bit byteswap already. */                            =
      \
+    /*                                                                  =
      \
+     * We only need to swap high and low halves. gen_qemu_st64_i64      =
      \
+     * does necessary 64-bit byteswap already.                          =
      \
+     */                                                                 =
      \
     if (ctx->le_mode) {                                                 =
      \
         get_avr64(avr, rD(ctx->opcode), false);                         =
      \
         gen_qemu_st64_i64(ctx, avr, EA);                                =
      \
@@ -296,7 +300,7 @@ GEN_VXFORM_V(vnand, MO_64, tcg_gen_gvec_nand, 2, 22);
 GEN_VXFORM_V(vorc, MO_64, tcg_gen_gvec_orc, 2, 21);
=20
 #define GEN_VXFORM(name, opc2, opc3)                                    =
\
-static void glue(gen_, name)(DisasContext *ctx)                         =
        \
+static void glue(gen_, name)(DisasContext *ctx)                         =
\
 {                                                                       =
\
     TCGv_ptr ra, rb, rd;                                                =
\
     if (unlikely(!ctx->altivec_enabled)) {                              =
\
@@ -306,7 +310,7 @@ static void glue(gen_, name)(DisasContext *ctx)
     ra =3D gen_avr_ptr(rA(ctx->opcode));                                =
  \
     rb =3D gen_avr_ptr(rB(ctx->opcode));                                =
  \
     rd =3D gen_avr_ptr(rD(ctx->opcode));                                =
  \
-    gen_helper_##name (rd, ra, rb);                                     =
\
+    gen_helper_##name(rd, ra, rb);                                      =
\
     tcg_temp_free_ptr(ra);                                              =
\
     tcg_temp_free_ptr(rb);                                              =
\
     tcg_temp_free_ptr(rd);                                              =
\
@@ -758,7 +762,7 @@ GEN_VXFORM_DUPI(vspltish, tcg_gen_gvec_dup16i, 6, 13)=
;
 GEN_VXFORM_DUPI(vspltisw, tcg_gen_gvec_dup32i, 6, 14);
=20
 #define GEN_VXFORM_NOA(name, opc2, opc3)                                =
\
-static void glue(gen_, name)(DisasContext *ctx)                         =
        \
+static void glue(gen_, name)(DisasContext *ctx)                         =
\
     {                                                                   =
\
         TCGv_ptr rb, rd;                                                =
\
         if (unlikely(!ctx->altivec_enabled)) {                          =
\
@@ -767,9 +771,9 @@ static void glue(gen_, name)(DisasContext *ctx)
         }                                                               =
\
         rb =3D gen_avr_ptr(rB(ctx->opcode));                            =
  \
         rd =3D gen_avr_ptr(rD(ctx->opcode));                            =
  \
-        gen_helper_##name (rd, rb);                                     =
\
+        gen_helper_##name(rd, rb);                                      =
\
         tcg_temp_free_ptr(rb);                                          =
\
-        tcg_temp_free_ptr(rd);                                         \
+        tcg_temp_free_ptr(rd);                                          =
\
     }
=20
 #define GEN_VXFORM_NOA_ENV(name, opc2, opc3)                            =
\
@@ -943,7 +947,7 @@ static void gen_vsldoi(DisasContext *ctx)
     rb =3D gen_avr_ptr(rB(ctx->opcode));
     rd =3D gen_avr_ptr(rD(ctx->opcode));
     sh =3D tcg_const_i32(VSH(ctx->opcode));
-    gen_helper_vsldoi (rd, ra, rb, sh);
+    gen_helper_vsldoi(rd, ra, rb, sh);
     tcg_temp_free_ptr(ra);
     tcg_temp_free_ptr(rb);
     tcg_temp_free_ptr(rd);
--=20
2.20.1



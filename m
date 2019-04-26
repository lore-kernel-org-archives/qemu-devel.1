Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030CDC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9372206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Fw9yEwTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9372206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuXC-0004Ym-NW
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:40:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1J-0006QO-8w
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1I-0005bx-87
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:37 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60563 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu1H-00050u-Ii; Fri, 26 Apr 2019 02:07:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tq3TK9z9sNq; Fri, 26 Apr 2019 16:06:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258799;
	bh=G3nunOIA/V2+aFWTwHvGJIidNGFYxp04mZ7Q+2kZLJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fw9yEwTHaLiN5Z7yFNiYKo7EvmWU4onkIVBxcR/iBHeUKDo7vKwUna2vg5BK9ezX6
	nWciczeXlpqaZLocHDI+PST5kXdlJOXjtqrnqTmSJoE21c7AYUiAeaxLd5mAbHQ9JZ
	fn5rOH2wikiCF4GLOMO7sABVhjTrUNOZ5uXgJwRw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:16 +1000
Message-Id: <20190426060627.18153-26-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 25/36] target/ppc: Style fixes for
 translate/vsx-impl.inc.c
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
Message-ID: <20190426060616.UpqLsRFP8xe2iC-agYo3N0HGZsML0DVkQ1nRxZzNBq8@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate/vsx-impl.inc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
index 489b2436e4..11d9b75d01 100644
--- a/target/ppc/translate/vsx-impl.inc.c
+++ b/target/ppc/translate/vsx-impl.inc.c
@@ -751,7 +751,7 @@ static void gen_xxpermdi(DisasContext *ctx)
 #define SGN_MASK_SP 0x8000000080000000ull
=20
 #define VSX_SCALAR_MOVE(name, op, sgn_mask)                       \
-static void glue(gen_, name)(DisasContext * ctx)                  \
+static void glue(gen_, name)(DisasContext *ctx)                   \
     {                                                             \
         TCGv_i64 xb, sgm;                                         \
         if (unlikely(!ctx->vsx_enabled)) {                        \
@@ -848,7 +848,7 @@ VSX_SCALAR_MOVE_QP(xsnegqp, OP_NEG, SGN_MASK_DP)
 VSX_SCALAR_MOVE_QP(xscpsgnqp, OP_CPSGN, SGN_MASK_DP)
=20
 #define VSX_VECTOR_MOVE(name, op, sgn_mask)                      \
-static void glue(gen_, name)(DisasContext * ctx)                 \
+static void glue(gen_, name)(DisasContext *ctx)                  \
     {                                                            \
         TCGv_i64 xbh, xbl, sgm;                                  \
         if (unlikely(!ctx->vsx_enabled)) {                       \
@@ -910,7 +910,7 @@ VSX_VECTOR_MOVE(xvnegsp, OP_NEG, SGN_MASK_SP)
 VSX_VECTOR_MOVE(xvcpsgnsp, OP_CPSGN, SGN_MASK_SP)
=20
 #define GEN_VSX_HELPER_2(name, op1, op2, inval, type)                   =
      \
-static void gen_##name(DisasContext * ctx)                              =
      \
+static void gen_##name(DisasContext *ctx)                               =
      \
 {                                                                       =
      \
     TCGv_i32 opc;                                                       =
      \
     if (unlikely(!ctx->vsx_enabled)) {                                  =
      \
@@ -923,7 +923,7 @@ static void gen_##name(DisasContext * ctx)           =
                         \
 }
=20
 #define GEN_VSX_HELPER_XT_XB_ENV(name, op1, op2, inval, type) \
-static void gen_##name(DisasContext * ctx)                    \
+static void gen_##name(DisasContext *ctx)                     \
 {                                                             \
     TCGv_i64 t0;                                              \
     TCGv_i64 t1;                                              \
@@ -1230,7 +1230,7 @@ static void gen_xxbrw(DisasContext *ctx)
 }
=20
 #define VSX_LOGICAL(name, vece, tcg_op)                              \
-static void glue(gen_, name)(DisasContext * ctx)                     \
+static void glue(gen_, name)(DisasContext *ctx)                      \
     {                                                                \
         if (unlikely(!ctx->vsx_enabled)) {                           \
             gen_exception(ctx, POWERPC_EXCP_VSXU);                   \
@@ -1251,7 +1251,7 @@ VSX_LOGICAL(xxlnand, MO_64, tcg_gen_gvec_nand)
 VSX_LOGICAL(xxlorc, MO_64, tcg_gen_gvec_orc)
=20
 #define VSX_XXMRG(name, high)                               \
-static void glue(gen_, name)(DisasContext * ctx)            \
+static void glue(gen_, name)(DisasContext *ctx)             \
     {                                                       \
         TCGv_i64 a0, a1, b0, b1, tmp;                       \
         if (unlikely(!ctx->vsx_enabled)) {                  \
@@ -1444,7 +1444,8 @@ static void gen_##name(DisasContext *ctx)          =
             \
     xb =3D tcg_const_tl(xB(ctx->opcode));                         \
     t0 =3D tcg_temp_new_i32();                                    \
     t1 =3D tcg_temp_new_i64();                                    \
-    /* uimm > 15 out of bound and for                           \
+    /*                                                          \
+     * uimm > 15 out of bound and for                           \
      * uimm > 12 handle as per hardware in helper               \
      */                                                         \
     if (uimm > 15) {                                            \
--=20
2.20.1



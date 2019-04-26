Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408FBC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B95206BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pxlrspVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B95206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuR7-0007vP-8H
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:34:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu12-00065V-25
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu10-00059e-47
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:19 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51167 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0y-0004aJ-6x; Fri, 26 Apr 2019 02:07:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tq2Tttz9sNx; Fri, 26 Apr 2019 16:06:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258799;
	bh=MgDowlJQQEQCvGIHI/vGXoXDkAhhSrhzg1uosH+m9Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxlrspVh+OezBSNSRotrrpMyhQrY8CuKSJJCC4Jibp3VmXSqCah+qHgG9tWU3dLqT
	7WuoPQi3tudjlKOlVYy4r9Eqh94/U2SIV3OrgMUSL7srev0WzlcQjuG6/V6h+jV96o
	zMB6FATHfcQ77Soivl+46fcy5KLhHVlV1AfExzV8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:15 +1000
Message-Id: <20190426060627.18153-25-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 24/36] target/ppc: Style fixes for
 translate/fp-impl.inc.c
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
Message-ID: <20190426060615.AthsSRt_tcNzAQffMnR_qoWeLNu6OtELG_wgypQfNtA@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate/fp-impl.inc.c | 52 ++++++++++++++++++------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp=
-impl.inc.c
index 0f21a4e477..9dcff947c0 100644
--- a/target/ppc/translate/fp-impl.inc.c
+++ b/target/ppc/translate/fp-impl.inc.c
@@ -585,11 +585,13 @@ static void gen_mcrfs(DisasContext *ctx)
     shift =3D 4 * nibble;
     tcg_gen_shri_tl(tmp, cpu_fpscr, shift);
     tcg_gen_trunc_tl_i32(cpu_crf[crfD(ctx->opcode)], tmp);
-    tcg_gen_andi_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcod=
e)], 0xf);
+    tcg_gen_andi_i32(cpu_crf[crfD(ctx->opcode)], cpu_crf[crfD(ctx->opcod=
e)],
+                     0xf);
     tcg_temp_free(tmp);
     tcg_gen_extu_tl_i64(tnew_fpscr, cpu_fpscr);
     /* Only the exception bits (including FX) should be cleared if read =
*/
-    tcg_gen_andi_i64(tnew_fpscr, tnew_fpscr, ~((0xF << shift) & FP_EX_CL=
EAR_BITS));
+    tcg_gen_andi_i64(tnew_fpscr, tnew_fpscr,
+                     ~((0xF << shift) & FP_EX_CLEAR_BITS));
     /* FEX and VX need to be updated, so don't set fpscr directly */
     tmask =3D tcg_const_i32(1 << nibble);
     gen_helper_store_fpscr(cpu_env, tnew_fpscr, tmask);
@@ -735,7 +737,7 @@ static void gen_mtfsfi(DisasContext *ctx)
=20
 /***                         Floating-point load                        =
   ***/
 #define GEN_LDF(name, ldop, opc, type)                                  =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -754,7 +756,7 @@ static void glue(gen_, name)(DisasContext *ctx)
 }
=20
 #define GEN_LDUF(name, ldop, opc, type)                                 =
      \
-static void glue(gen_, name##u)(DisasContext *ctx)                      =
              \
+static void glue(gen_, name##u)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -778,7 +780,7 @@ static void glue(gen_, name##u)(DisasContext *ctx)
 }
=20
 #define GEN_LDUXF(name, ldop, opc, type)                                =
      \
-static void glue(gen_, name##ux)(DisasContext *ctx)                     =
              \
+static void glue(gen_, name##ux)(DisasContext *ctx)                     =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -802,7 +804,7 @@ static void glue(gen_, name##ux)(DisasContext *ctx)
 }
=20
 #define GEN_LDXF(name, ldop, opc2, opc3, type)                          =
      \
-static void glue(gen_, name##x)(DisasContext *ctx)                      =
              \
+static void glue(gen_, name##x)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -872,8 +874,10 @@ static void gen_lfdp(DisasContext *ctx)
     EA =3D tcg_temp_new();
     gen_addr_imm_index(ctx, EA, 0);
     t0 =3D tcg_temp_new_i64();
-    /* We only need to swap high and low halves. gen_qemu_ld64_i64 does
-       necessary 64-bit byteswap already. */
+    /*
+     * We only need to swap high and low halves. gen_qemu_ld64_i64
+     * does necessary 64-bit byteswap already.
+     */
     if (unlikely(ctx->le_mode)) {
         gen_qemu_ld64_i64(ctx, t0, EA);
         set_fpr(rD(ctx->opcode) + 1, t0);
@@ -904,8 +908,10 @@ static void gen_lfdpx(DisasContext *ctx)
     EA =3D tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
     t0 =3D tcg_temp_new_i64();
-    /* We only need to swap high and low halves. gen_qemu_ld64_i64 does
-       necessary 64-bit byteswap already. */
+    /*
+     * We only need to swap high and low halves. gen_qemu_ld64_i64
+     * does necessary 64-bit byteswap already.
+     */
     if (unlikely(ctx->le_mode)) {
         gen_qemu_ld64_i64(ctx, t0, EA);
         set_fpr(rD(ctx->opcode) + 1, t0);
@@ -966,7 +972,7 @@ static void gen_lfiwzx(DisasContext *ctx)
 }
 /***                         Floating-point store                       =
   ***/
 #define GEN_STF(name, stop, opc, type)                                  =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -985,7 +991,7 @@ static void glue(gen_, name)(DisasContext *ctx)
 }
=20
 #define GEN_STUF(name, stop, opc, type)                                 =
      \
-static void glue(gen_, name##u)(DisasContext *ctx)                      =
              \
+static void glue(gen_, name##u)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -1009,7 +1015,7 @@ static void glue(gen_, name##u)(DisasContext *ctx)
 }
=20
 #define GEN_STUXF(name, stop, opc, type)                                =
      \
-static void glue(gen_, name##ux)(DisasContext *ctx)                     =
              \
+static void glue(gen_, name##ux)(DisasContext *ctx)                     =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -1033,7 +1039,7 @@ static void glue(gen_, name##ux)(DisasContext *ctx)
 }
=20
 #define GEN_STXF(name, stop, opc2, opc3, type)                          =
      \
-static void glue(gen_, name##x)(DisasContext *ctx)                      =
              \
+static void glue(gen_, name##x)(DisasContext *ctx)                      =
      \
 {                                                                       =
      \
     TCGv EA;                                                            =
      \
     TCGv_i64 t0;                                                        =
      \
@@ -1103,8 +1109,10 @@ static void gen_stfdp(DisasContext *ctx)
     EA =3D tcg_temp_new();
     t0 =3D tcg_temp_new_i64();
     gen_addr_imm_index(ctx, EA, 0);
-    /* We only need to swap high and low halves. gen_qemu_st64_i64 does
-       necessary 64-bit byteswap already. */
+    /*
+     * We only need to swap high and low halves. gen_qemu_st64_i64
+     * does necessary 64-bit byteswap already.
+     */
     if (unlikely(ctx->le_mode)) {
         get_fpr(t0, rD(ctx->opcode) + 1);
         gen_qemu_st64_i64(ctx, t0, EA);
@@ -1135,8 +1143,10 @@ static void gen_stfdpx(DisasContext *ctx)
     EA =3D tcg_temp_new();
     t0 =3D tcg_temp_new_i64();
     gen_addr_reg_index(ctx, EA);
-    /* We only need to swap high and low halves. gen_qemu_st64_i64 does
-       necessary 64-bit byteswap already. */
+    /*
+     * We only need to swap high and low halves. gen_qemu_st64_i64
+     * does necessary 64-bit byteswap already.
+     */
     if (unlikely(ctx->le_mode)) {
         get_fpr(t0, rD(ctx->opcode) + 1);
         gen_qemu_st64_i64(ctx, t0, EA);
@@ -1204,8 +1214,9 @@ static void gen_lfqu(DisasContext *ctx)
     gen_addr_add(ctx, t1, t0, 8);
     gen_qemu_ld64_i64(ctx, t2, t1);
     set_fpr((rd + 1) % 32, t2);
-    if (ra !=3D 0)
+    if (ra !=3D 0) {
         tcg_gen_mov_tl(cpu_gpr[ra], t0);
+    }
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free_i64(t2);
@@ -1229,8 +1240,9 @@ static void gen_lfqux(DisasContext *ctx)
     gen_qemu_ld64_i64(ctx, t2, t1);
     set_fpr((rd + 1) % 32, t2);
     tcg_temp_free(t1);
-    if (ra !=3D 0)
+    if (ra !=3D 0) {
         tcg_gen_mov_tl(cpu_gpr[ra], t0);
+    }
     tcg_temp_free(t0);
     tcg_temp_free_i64(t2);
 }
--=20
2.20.1



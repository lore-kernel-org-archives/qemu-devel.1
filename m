Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1DDC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC38020675
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hFPWVisH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC38020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuH5-00061o-4T
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:23:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu10-00063D-2D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0y-00056m-7P
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:18 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60491 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0w-0004Vk-4d; Fri, 26 Apr 2019 02:07:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tp5vfKz9sNs; Fri, 26 Apr 2019 16:06:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258798;
	bh=7nqWASjgaSD9sIm7A3aZFRTFfvHArAZgUMaAEXJMIjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFPWVisHQCsMkMa85EgVCsiTNPOX87Y4U/E3bzom46bN+Qxb4+u8BAzun3L7uoWaV
	GqjJY2U6smVnsRniu75u5jj1CwDC3+h/39Z91GkjLwhxNx8dvH+GjGAz1Bo1azS2jw
	/I0AVNyQKRFWqSqWNKRwQCbf6pmAsy4mVFebTkdI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:18 +1000
Message-Id: <20190426060627.18153-28-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 27/36] target/ppc: Style fixes for
 translate/spe-impl.inc.c
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
Message-ID: <20190426060618.N0uyEBZQ8xbpnVgVeIhSJWTLxv99GWKenVsIBf8NHRs@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate/spe-impl.inc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/s=
pe-impl.inc.c
index 8c1c16c63e..7ab0a29b5f 100644
--- a/target/ppc/translate/spe-impl.inc.c
+++ b/target/ppc/translate/spe-impl.inc.c
@@ -18,7 +18,8 @@ static inline void gen_evmra(DisasContext *ctx)
     TCGv_i64 tmp =3D tcg_temp_new_i64();
=20
     /* tmp :=3D rA_lo + rA_hi << 32 */
-    tcg_gen_concat_tl_i64(tmp, cpu_gpr[rA(ctx->opcode)], cpu_gprh[rA(ctx=
->opcode)]);
+    tcg_gen_concat_tl_i64(tmp, cpu_gpr[rA(ctx->opcode)],
+                          cpu_gprh[rA(ctx->opcode)]);
=20
     /* spe_acc :=3D tmp */
     tcg_gen_st_i64(tmp, cpu_env, offsetof(CPUPPCState, spe_acc));
@@ -780,7 +781,7 @@ static inline void gen_op_evstwwo(DisasContext *ctx, =
TCGv addr)
 }
=20
 #define GEN_SPEOP_LDST(name, opc2, sh)                                  =
      \
-static void glue(gen_, name)(DisasContext *ctx)                         =
              \
+static void glue(gen_, name)(DisasContext *ctx)                         =
      \
 {                                                                       =
      \
     TCGv t0;                                                            =
      \
     if (unlikely(!ctx->spe_enabled)) {                                  =
      \
@@ -1089,7 +1090,8 @@ static inline void gen_efsabs(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_SPEU);
         return;
     }
-    tcg_gen_andi_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], =
(target_long)~0x80000000LL);
+    tcg_gen_andi_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
+                    (target_long)~0x80000000LL);
 }
 static inline void gen_efsnabs(DisasContext *ctx)
 {
@@ -1097,7 +1099,8 @@ static inline void gen_efsnabs(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_SPEU);
         return;
     }
-    tcg_gen_ori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], 0=
x80000000);
+    tcg_gen_ori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
+                   0x80000000);
 }
 static inline void gen_efsneg(DisasContext *ctx)
 {
@@ -1105,7 +1108,8 @@ static inline void gen_efsneg(DisasContext *ctx)
         gen_exception(ctx, POWERPC_EXCP_SPEU);
         return;
     }
-    tcg_gen_xori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)], =
0x80000000);
+    tcg_gen_xori_tl(cpu_gpr[rD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
+                    0x80000000);
 }
=20
 /* Conversion */
--=20
2.20.1



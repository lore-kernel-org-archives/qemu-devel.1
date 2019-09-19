Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36BEC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB5621848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pg+l19Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB5621848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqKV-0004Fq-QP
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 02:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iAqGy-0000Rq-Lf
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iAqGw-0000lr-Rg
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:50:36 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47497 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iAqGv-0000ij-Pl; Thu, 19 Sep 2019 02:50:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46YnXz4b33z9sP6; Thu, 19 Sep 2019 16:50:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568875827;
 bh=xbfGkM3gkdlM8wDdWtaazH7GqADRuJVvYEA6g9qX528=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pg+l19NaOWlRkqtzsYhoHCyXofIuAz+rjF2e2oD6z63tA28kcXhjYA+q2UVN/K9yp
 wltTu+gdTrmfwygTeVXn4qlEj6qBPq1zvEoSdso0qNqEDtz8a90FOCK6QdUqZnZQZv
 kybSqPoyiwiVTL1LZNf/ADKI/9L63vuvS/ffYOag=
Date: Thu, 19 Sep 2019 16:29:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Paul A. Clarke" <pc@us.ibm.com>
Message-ID: <20190919062917.GD22790@umbus.fritz.box>
References: <1568817082-1384-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline
In-Reply-To: <1568817082-1384-1-git-send-email-pc@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH v3 2/2] ppc: Add support for 'mffsce'
 instruction
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 09:31:22AM -0500, Paul A. Clarke wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>=20
> ISA 3.0B added a set of Floating-Point Status and Control Register (FPSCR)
> instructions: mffsce, mffscdrn, mffscdrni, mffscrn, mffscrni, mffsl.
> This patch adds support for 'mffsce' instruction.
>=20
> 'mffsce' is identical to 'mffs', except that it also clears the exception
> enable bits in the FPSCR.
>=20
> On CPUs without support for 'mffsce' (below ISA 3.0), the
> instruction will execute identically to 'mffs'.
>=20
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied to ppc-for-4.2, thanks.

> ---
> v3: no changes.
> v2: no changes.
>=20
>  target/ppc/translate/fp-impl.inc.c | 30 ++++++++++++++++++++++++++++++
>  target/ppc/translate/fp-ops.inc.c  |  2 ++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp=
-impl.inc.c
> index 75f9523..d8e27bf 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -639,6 +639,36 @@ static void gen_mffsl(DisasContext *ctx)
>      tcg_temp_free_i64(t0);
>  }
> =20
> +/* mffsce */
> +static void gen_mffsce(DisasContext *ctx)
> +{
> +    TCGv_i64 t0;
> +    TCGv_i32 mask;
> +
> +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300))) {
> +        return gen_mffs(ctx);
> +    }
> +
> +    if (unlikely(!ctx->fpu_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_FPU);
> +        return;
> +    }
> +
> +    t0 =3D tcg_temp_new_i64();
> +
> +    gen_reset_fpstatus();
> +    tcg_gen_extu_tl_i64(t0, cpu_fpscr);
> +    set_fpr(rD(ctx->opcode), t0);
> +
> +    /* Clear exception enable bits in the FPSCR.  */
> +    tcg_gen_andi_i64(t0, t0, ~FP_ENABLES);
> +    mask =3D tcg_const_i32(0x0003);
> +    gen_helper_store_fpscr(cpu_env, t0, mask);
> +
> +    tcg_temp_free_i32(mask);
> +    tcg_temp_free_i64(t0);
> +}
> +
>  static void gen_helper_mffscrn(DisasContext *ctx, TCGv_i64 t1)
>  {
>      TCGv_i64 t0 =3D tcg_temp_new_i64();
> diff --git a/target/ppc/translate/fp-ops.inc.c b/target/ppc/translate/fp-=
ops.inc.c
> index f2bcf0e..88fab65 100644
> --- a/target/ppc/translate/fp-ops.inc.c
> +++ b/target/ppc/translate/fp-ops.inc.c
> @@ -105,6 +105,8 @@ GEN_HANDLER_E(fmrgew, 0x3F, 0x06, 0x1E, 0x00000001, P=
PC_NONE, PPC2_VSX207),
>  GEN_HANDLER_E(fmrgow, 0x3F, 0x06, 0x1A, 0x00000001, PPC_NONE, PPC2_VSX20=
7),
>  GEN_HANDLER(mcrfs, 0x3F, 0x00, 0x02, 0x0063F801, PPC_FLOAT),
>  GEN_HANDLER_E_2(mffs, 0x3F, 0x07, 0x12, 0x00, 0x00000000, PPC_FLOAT, PPC=
_NONE),
> +GEN_HANDLER_E_2(mffsce, 0x3F, 0x07, 0x12, 0x01, 0x00000000, PPC_FLOAT,
> +    PPC2_ISA300),
>  GEN_HANDLER_E_2(mffsl, 0x3F, 0x07, 0x12, 0x18, 0x00000000, PPC_FLOAT,
>      PPC2_ISA300),
>  GEN_HANDLER_E_2(mffscrn, 0x3F, 0x07, 0x12, 0x16, 0x00000000, PPC_FLOAT,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2DID0ACgkQbDjKyiDZ
s5J33BAApS+htTS0V7IiZOmIRt/DZnTVI2dBMkCojf3iqa1c5bD+0d841xpniEYp
9dv6hqHTAzDskra28Jm9+B5vafgvn0tLamMoNQg8x4w1A41FwagC8LfzFqtJD7Dd
bFc3woGe4PDKspeYF2qCOhTMYfFFN4QV/bfKB4GIcS/uvyFnvHUdpmbEVsTtuyqR
TN0v+DkS6AMpBsDhfFeb5BrHXTx5RJ0iZKgEkHnehEE075osWXHLUdupzRCU3Ic1
l9FKxh7lYYpCE3SwHqnLhgT6+SO9fBUtDm7WEZjYA8ctLMnB99JVeq3ziCJTqvHg
TKVnf8ZzvrrG5rPJZA5e2D8qVYLy/3BLr2jRjjNPoNwDVkgFoH6X3KUU+lsUeizm
eYSe2TdNkPlVwib0eFRYNQN0b22meVizAuBcWcmCOFawk1c8NDDzwk71k6bQbrRJ
AtZbqid59suhZ7QyCiHwvurSxRSSN7514wFCOjklDrwCbyBqotebPftkjt7DCMVb
Grqzvw/YQO/5DcwgysorX/joijCxfFc3/lbMuR5G97tjBTdd3yDNjmwQKRK5CQqT
/cSHn55lKfeAYb0GsDJ+eqaHhuRC/rN3k6GCYyQU92g4P3sDssjX5KDGnN6ESpqk
UZ/KCJ2qYs4b+jyYFB126TzX1EWOoBH5nv91x6vxfJOzxsH4rlI=
=tYZw
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--


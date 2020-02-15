Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502EBC3F68F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 04:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160C320718
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 04:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="a8CBr+ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160C320718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2pCh-0007Kw-7d
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 23:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2pC2-0006IB-I1
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 23:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2pC1-0007n6-0K
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 23:36:38 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59685 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j2pC0-0007ew-3B; Fri, 14 Feb 2020 23:36:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48KHWd0MN1z9sRJ; Sat, 15 Feb 2020 15:36:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581741389;
 bh=iAlcM+L8JKoI0x2+hNvVdSxxP898sb+Akh+pGsuFj6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a8CBr+ES5HxQVCJsUBY7I/oFBuEJ7DaJ9Jg6eCOa7Uy++QAXEzHmgiOqWcjMG6TVH
 ML8MBdmjHi2UTOU2+1EsyP5GrdEsoyYxx4UuVrhbCri9bnmh2j0BRWEvIRnh8h17xV
 ajLWWczk+GJdkTz767ykKhV29CZh9daDBYfJyr88=
Date: Sat, 15 Feb 2020 15:13:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v2] target/ppc: Fix typo in comments
Message-ID: <20200215041314.GA2156@umbus.fritz.box>
References: <20200214155748.0896B745953@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200214155748.0896B745953@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 12:57:34AM +0100, BALATON Zoltan wrote:
> "Deferred" was misspelled as "differed" in some comments, correct this
> typo,
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

I've replaced the earlier version in my tree.

> ---
> v2: Found one more where even the typo was misspelled
>=20
> target/ppc/fpu_helper.c            | 4 ++--
>  target/ppc/translate/fp-impl.inc.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index dc383242f7..ae43b08eb5 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -293,7 +293,7 @@ static void float_invalid_op_vxvc(CPUPPCState *env, b=
ool set_fpcc,
>          env->error_code =3D POWERPC_EXCP_FP | POWERPC_EXCP_FP_VXVC;
>          /* Update the floating-point enabled exception summary */
>          env->fpscr |=3D FP_FEX;
> -        /* Exception is differed */
> +        /* Exception is deferred */
>      }
>  }
> =20
> @@ -644,7 +644,7 @@ static void do_float_check_status(CPUPPCState *env, u=
intptr_t raddr)
> =20
>      if (cs->exception_index =3D=3D POWERPC_EXCP_PROGRAM &&
>          (env->error_code & POWERPC_EXCP_FP)) {
> -        /* Differred floating-point exception after target FPR update */
> +        /* Deferred floating-point exception after target FPR update */
>          if (fp_exceptions_enabled(env)) {
>              raise_exception_err_ra(env, cs->exception_index,
>                                     env->error_code, raddr);
> diff --git a/target/ppc/translate/fp-impl.inc.c b/target/ppc/translate/fp=
-impl.inc.c
> index d8e27bf4d5..9f7868ee28 100644
> --- a/target/ppc/translate/fp-impl.inc.c
> +++ b/target/ppc/translate/fp-impl.inc.c
> @@ -781,7 +781,7 @@ static void gen_mtfsb1(DisasContext *ctx)
>          tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
>          tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
>      }
> -    /* We can raise a differed exception */
> +    /* We can raise a deferred exception */
>      gen_helper_float_check_status(cpu_env);
>  }
> =20
> @@ -817,7 +817,7 @@ static void gen_mtfsf(DisasContext *ctx)
>          tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
>          tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
>      }
> -    /* We can raise a differed exception */
> +    /* We can raise a deferred exception */
>      gen_helper_float_check_status(cpu_env);
>      tcg_temp_free_i64(t1);
>  }
> @@ -850,7 +850,7 @@ static void gen_mtfsfi(DisasContext *ctx)
>          tcg_gen_trunc_tl_i32(cpu_crf[1], cpu_fpscr);
>          tcg_gen_shri_i32(cpu_crf[1], cpu_crf[1], FPSCR_OX);
>      }
> -    /* We can raise a differed exception */
> +    /* We can raise a deferred exception */
>      gen_helper_float_check_status(cpu_env);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5Hb9gACgkQbDjKyiDZ
s5LYBg//UcuNfbf53RAkexJdR+zbp815rn0v45N0Ajf6R4sGKrRUy7IF/QmAZ2Vr
huHYefwPhb5+tNft9pJNTvIYY5R2PZscGJ1b+jAxbb+mCykCloAlB7Chpw7I2Ofe
7bWp7+6fXdG1Tq2JMoUnPK9sdMOkJa2TzK2DrKNtafISohcKrzvqPLSXL0JspFVq
2ew+3+82d8poZDhwzH8awsF9R/lCDvu+EWMzLG12jEoN9s/Q6tvquqmKMZQoCeMW
mrFb1vgSg5Xs+rh3CjXRGYmd3yjp1M15BNVa7y/Lm8vXYtoexuXrq/UBuxdHpWJ2
kPZgwa/seKu/ofR2Pfr8QIlB5eJWLrPT948QG80SgAGIoQgLvvSw5GId3ph2dXij
JXi/11oNSvY+Az05PbdObKbubwK7y0C4JFMdU8tMM4F3SdvpnwDXFXg53KopdaAE
N2F/JQ0m0v8JQ5AR+fMs2o4dvn/Y11aYMVEU2vsbNZO0y+Afk6pLmY3XCk4qrcZ+
3uNyCheIsjSOYUHenXMWQ7NTc6fPXSVI/ziAajt2bMwb5u64lT+vK2Ytra/3Fv0B
R6ZO6YwQxUvcNgag1PgcMnphD1JmXjZT+ImJNhkHEi4W3TgitwDItxZCFfSoWAEY
KKs3i29IgzVvUPPZfbd9Xjp4FCi06FFJ4RH4OZK7CVSg/bteH0s=
=AroX
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--


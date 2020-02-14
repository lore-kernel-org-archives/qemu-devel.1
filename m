Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B437C352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558892082F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 00:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="opTl+bTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558892082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2P0T-0000j6-I5
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 19:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2Ozs-0000CS-9p
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2Ozq-00086k-Da
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 19:38:19 -0500
Received: from ozlabs.org ([203.11.71.1]:58495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j2Ozp-00082l-4I; Thu, 13 Feb 2020 19:38:18 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48JZH84Q4Mz9sRQ; Fri, 14 Feb 2020 11:38:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581640692;
 bh=kI6wB6nLJa7eJxKlfnD/onqNcUOwyyqXmoPvcV8+QyA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=opTl+bTqpw05z8NXQoXLorjq+yrk0xm4/JsO1z8xsnML4RSIPqUa67bvc0mYQyDGy
 r36o+nIMtFgzTwd7SndgpAtyFyCNin003Fmrs/WyuNoBmxz7m175aI7pz+mmS9+JIw
 mELYo9vP9H9n29stqtQf/8H6A9AoDTeXZ82TmKQI=
Date: Fri, 14 Feb 2020 11:37:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] target/ppc: Fix typo in comments
Message-ID: <20200214003740.GJ124369@umbus.fritz.box>
References: <20200214000143.6D67F747DCF@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
Content-Disposition: inline
In-Reply-To: <20200214000143.6D67F747DCF@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 12:57:34AM +0100, BALATON Zoltan wrote:
> "Deferred" was misspelled as "differed" in some comments, correct this
> typo,
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-5.0, thanks.

> ---
>  target/ppc/fpu_helper.c            | 2 +-
>  target/ppc/translate/fp-impl.inc.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index dc383242f7..5182764df3 100644
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

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5F688ACgkQbDjKyiDZ
s5JMJxAA4VtPVgBmy8q1eJDNj1PWpPv9g0fPrZvK/HzwWnCOqH9No6ZMGy9FrO3l
ETIRRz2oIFdhbjSKGft6X9HGHyYmDbPBiuLQ6aPEzn9P7sE0vnP4MyPt4povaAQY
+vzApV135ZZHWx9oYvM7ZkYtFGoshbiPEKaRRqUIuFW/WKyB5U/PI5cFu+7sBys/
LEDa5wkjqzo4CLZ4rc5042E+40PagKHrINLdZijiIUr7PbDAgSxxQLB/S5nYVyTz
0AIcXlogMrY7/VdYOqcNq8AT4eqYarwk0y6ySKTq5hbPQ9vv4cuXuJAtStLArjJW
l3CEu2bbQT/uZTHb3XHJwuc/sXtv4B4Gjbbpy/hUG9r7RQxzWF95ym3NYlMQW4nm
A8CtKZyi+md/osLNwjYOUmFT8HbWSDZyE1DYyO7uV4r63CJWW4bcwN6sivT4QLWd
2ZA5y4pbZ8Rs1sWymvlPeE971YN621GzF2R+ot29RZ7bK/e4FMY7KuykSA2VxyFM
8e4ubz92D2lzSdnSBSnwzZe1+1uLz2Tfmkih3RTAMUcZUrs7PdCvzZSCtghpFLsL
NfYrdZ2sXIVm61Jk8OSxXELBdaVrDGglTQSkAbzaaD0xE2utfrNLQVSR/7K9SIQ2
H0EyRYmuiZr9W3KJmJHPjEc+AnxDSq22tDGHgt/P2QAdOJIs1As=
=Be9X
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--


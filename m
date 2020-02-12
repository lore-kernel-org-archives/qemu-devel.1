Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3686C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB682073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 06:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NR6p7Q8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB682073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1lA5-0000N8-SO
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 01:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j1l9M-0008Fm-Tw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j1l9L-0002P1-9G
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 01:05:28 -0500
Received: from ozlabs.org ([203.11.71.1]:57615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j1l9J-0002N7-Gi; Wed, 12 Feb 2020 01:05:27 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48HTdY0JYrz9sRJ; Wed, 12 Feb 2020 17:05:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581487521;
 bh=WvyJblUwCkZO6O8e6DNC1xLK1EeGD0Wv62YEl9vqe/U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NR6p7Q8gSGyzwk23Pn/kSwEA+fY0jLI2bkFLc3qiS9DTO9meN3Yo4FcggJa2vIqQ4
 HvO2S4irCipC2M7m+AarbvvgQMeGYVyrBSOQsTmpbPnBcPApkhJ066429QLEerl4AU
 AoOycV8uWFR3qP0vPXiqIn3fmiulWJKP1kgwPZC8=
Date: Wed, 12 Feb 2020 16:43:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v6 1/6] ppc: Start CPU in the default mode which is
 big-endian 32bit
Message-ID: <20200212054304.GY22584@umbus.fritz.box>
References: <20200203032943.121178-1-aik@ozlabs.ru>
 <20200203032943.121178-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ggC1wwkyYWqEab//"
Content-Disposition: inline
In-Reply-To: <20200203032943.121178-2-aik@ozlabs.ru>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ggC1wwkyYWqEab//
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 02:29:38PM +1100, Alexey Kardashevskiy wrote:
> At the moment we enforce 64bit mode on a CPU when reset. This does not
> make difference as SLOF or Linux set the desired mode straight away.
> However if we ever boot something other than these two,
> this might not work as, for example, GRUB expects the default MSR state
> and does not work properly.
>=20
> This removes setting MSR_SF from the PPC CPU reset.

Hrm.  This is in the core cpu model so it doesn't just affect pseries,
but powernv (and theoretically others) as well.  Generally the cpu
model should have the bare metal behaviour, and we can override it in
the pseries machine if necessary.

So for a bare metal POWER system, what mode do we start in?  I'm
guessing it probably doesn't matter in practice, since the skiboot
firmware also probably does a mode set on entry, but it'd be nice to
get this right in theory.

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  target/ppc/translate_init.inc.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 53995f62eab2..f6a676cf55e8 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10710,12 +10710,6 @@ static void ppc_cpu_reset(CPUState *s)
>  #endif
>  #endif
> =20
> -#if defined(TARGET_PPC64)
> -    if (env->mmu_model & POWERPC_MMU_64) {
> -        msr |=3D (1ULL << MSR_SF);
> -    }
> -#endif
> -
>      hreg_store_msr(env, msr, 1);
> =20
>  #if !defined(CONFIG_USER_ONLY)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ggC1wwkyYWqEab//
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5DkGgACgkQbDjKyiDZ
s5Lf0BAAx46Y/NIBsgjPmbQOrP3EetzV92nps0D19Fv29IJZzcWuoKud9UN60c4V
aZn6L5USms2gemQtus2b9f1LBY70MdKyxHL8Qeq6khQizUEahC717D0yyJbU21dq
QTu0zeCO7l+pPCbfmIF89TdWKwTwJJABMe03OIh6k5b0isDwUj7FO3GBcuAPv+7A
XyMzGwo6Fr8GND2qdciy0hHLruvLXZbXCr5VV1dWuRYKOtmRYxT6OkNNgzlZFZmC
FRZajfKpr/5/qIgmyqkA/92QgdvX//J1VvXPFFnGdUIL2+218sMQOfwHNfnulS8A
ql5stgWIqC9JEYGzLIkFCyMMQiIxipHZikVXdny418r/NyGx8OJwKNdS0VFoUgAc
6li6vnXWueuv2eAspvzQiwtikZlsWUdtEtPmUlxRJkgThCepFHKBwgBtM50qsR3U
nXAEkKe9PToUs1FPBP0JkjGPLlJ++39Y5Wh8daeP9kjbDp1GaNsFeQZgbibHyXJz
7mhuB3YQNDjhgx/I+OKJYEqTP2CmpCawdGER0cMqq/ozSH2oz5YmsK8eHcuLDqeH
W6MQpo72n58QHeI6UUvcJtovOH0zNC7J944Kf4IyFVHlZTcRWxzcpeJdNdKaMhz7
eIiCL5oxyo/5qhSMOluRnlTr5THytzzzAMj7Q8hF2y06dfTRiFg=
=KmKI
-----END PGP SIGNATURE-----

--ggC1wwkyYWqEab//--


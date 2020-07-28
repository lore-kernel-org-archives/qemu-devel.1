Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB838C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 03:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7468B20759
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 03:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hA4xpDc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7468B20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Glf-0005J8-OI
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 23:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k0Gjb-0003z4-9z; Mon, 27 Jul 2020 23:57:02 -0400
Received: from ozlabs.org ([203.11.71.1]:37655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k0GjY-0000Dv-3H; Mon, 27 Jul 2020 23:56:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BG2t340T4z9sTj; Tue, 28 Jul 2020 13:56:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1595908603;
 bh=b6lu/0ypHEVBmluZT8612BLl5QBgm+3oW25w7SQcjMk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hA4xpDc0ge8kE/A1uOWvvD47J0fZjghSKSw4PrNPwrHQe7hxwfOvI7nFCTVYGvHjb
 q4BZFTPI3zXOkd//ZM+LHFa9+++2WkU978B7LD0QjTzjq+7rbMp4EoyHIVEuBNVIMj
 zOmclJ4uLZ1gs+bebasA7fC2V4B5KsU21b6u/YWs=
Date: Tue, 28 Jul 2020 13:53:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matthieu Bucchianeri <matthieu.bucchianeri@leostella.com>
Subject: Re: [PATCH] target/ppc: Fix TCG leak with the evmwsmiaa instruction
Message-ID: <20200728035306.GH84173@umbus.fritz.box>
References: <20200727172114.31415-1-matthieu.bucchianeri@leostella.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <20200727172114.31415-1-matthieu.bucchianeri@leostella.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:56:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 10:21:14AM -0700, Matthieu Bucchianeri wrote:
> Fix double-call to tcg_temp_new_i64(), where a temp is allocated both at
> declaration time and further down the implementation of gen_evmwsmiaa().
>=20
> Note that gen_evmwsmia() and gen_evmwsmiaa() are still not implemented
> correctly, as they invoke gen_evmwsmi() which may return early, but the
> return is not propagated. This will be fixed in my patch for bug #1888918.
>=20
> Signed-off-by: Matthieu Bucchianeri
> <matthieu.bucchianeri@leostella.com>

Applied to ppc-for-5.1.  Note that since this isn't a regression, it's
not entirely clear it's a good candidate for 5.1 this late in the
freeze.  There's a possibility it will get punted to 5.2, therefore,
but for now I'm staging it for 5.1.

> ---
>  target/ppc/translate/spe-impl.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/s=
pe-impl.inc.c
> index 36b4d5654d..42a0d1cffb 100644
> --- a/target/ppc/translate/spe-impl.inc.c
> +++ b/target/ppc/translate/spe-impl.inc.c
> @@ -528,14 +528,14 @@ static inline void gen_evmwsmia(DisasContext *ctx)
>=20
>      tcg_temp_free_i64(tmp);
>  }
>=20
>  static inline void gen_evmwsmiaa(DisasContext *ctx)
>  {
> -    TCGv_i64 acc =3D tcg_temp_new_i64();
> -    TCGv_i64 tmp =3D tcg_temp_new_i64();
> +    TCGv_i64 acc;
> +    TCGv_i64 tmp;
>=20
>      gen_evmwsmi(ctx);           /* rD :=3D rA * rB */
>=20
>      acc =3D tcg_temp_new_i64();
>      tmp =3D tcg_temp_new_i64();
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8foR8ACgkQbDjKyiDZ
s5KzNw/8Cb9B5+eP5Atb74hpaWBmW79ZKk0k39rNRMnlDYzxjx+BB/UzPQeXc5Ny
2PdPyoxskkOXgQ5eHLj0Ht7/O1/7/HcLXBqV793PSedsRtAAm7m21BK5pu3WulpI
FJFTdHsocFzj5MNF6LzrDg+8QNnJwxDsCiyVX6GHYMHYFu0RHmXGfy5pj1/6kquz
pjX+w37K3r/hQIYAC6eCUMJB+7k61m3E3qw00TuadCfRhcCWHAMRAVyqUy5zca/H
3FBzRCGncFDHUvBlfLOS/BMt9buBHjWk94g21K6WJnzkQ6Ozokf2bEFotzUZzB4M
eHPZJ1pSg41c6kIPlgehV78+5x7UnfxNkPFLuvR1sbOLi7vYLHGBCdccIHCytilO
8kiMa6XiNpXlFJi9XY7el5qLI7Jv4TUTa1HFz8laF6ot6f1mPFaSXPNI9W+I+FHQ
4z2JPoi1/xTKV+nPPSTPvSBLbhNYQuFBj/jAd0jXsdeFqVWZoOF0/YPhnGg8Mzdd
HyyRHAMSQUwrQkYQwAXY+Iqgv0oXKV3BM5n8YIivnRAdEbCCQUWjgIgFPsh1Bg3F
54aRDvEs/AnckX9xi5CNbmu6aA2c9LchVZeKIsmFL90anGm3MY3/FRqq4lP8WgiG
Vn/4fb2ICk2blkTSXQ1VpCX+bKd4QZSSb9CItaTBNlLIDT335EY=
=FfQA
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--


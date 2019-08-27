Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE2AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEEF2186A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BnQnXq/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEEF2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2SzX-0004E4-Ks
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2SyD-00037R-DK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2SyB-0003qF-Px
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:20:37 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59517 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2SyB-0003pK-2a; Tue, 27 Aug 2019 00:20:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46HbJY2L4yz9sDB; Tue, 27 Aug 2019 14:20:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566879629;
 bh=SUGGDKg6EXvOhHn+O0d/xw6obG3Q4nOgrKhf2B8rHyE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BnQnXq/9umy0W47f2EKcmpf23ppSRFZNx4EtIfrOkk2CVk92nSA4HBL9iAQF2GXse
 2GKU3c6PxkykoGIzf/MHkYnvmBIDCsldTz4c43Vb9MSnNrvAIQui9WtK3sfeCJkp9C
 aMPDwEcDv9l75mogaK3UbZ4GCRG1v91uJS6+rRrg=
Date: Tue, 27 Aug 2019 13:41:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190827034138.GF28081@umbus.fritz.box>
References: <20190827020013.27154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline
In-Reply-To: <20190827020013.27154-1-richard.henderson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Set
 float_tininess_before_rounding at cpu reset
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, pc@us.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2019 at 07:00:13PM -0700, Richard Henderson wrote:
> As defined in Power 3.0 section 4.4.4 "Underflow Exception",
> a tiny result is detected before rounding.
>=20
> Fixes: https://bugs.launchpad.net/qemu/+bug/1841491
> Reported-by: Paul Clarke <pc@us.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Applied to ppc-for-4.2, thanks.

> ---
>  target/ppc/translate_init.inc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 4a21ed7289..023138c2f9 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -10461,6 +10461,10 @@ static void ppc_cpu_reset(CPUState *s)
>      s->exception_index =3D POWERPC_EXCP_NONE;
>      env->error_code =3D 0;
> =20
> +    /* tininess for underflow is detected before rounding */
> +    set_float_detect_tininess(float_tininess_before_rounding,
> +                              &env->fp_status);
> +
>      for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
>          ppc_spr_t *spr =3D &env->spr_cb[i];
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1kpnAACgkQbDjKyiDZ
s5JvUw//dYjufLDP2ATZxQqw1VMsKz71UiCkaXCwSE3ioyfcKJwy3XWz9pXFPkUF
hmmozOp3rfYqLkfJrowKUFUVHi3ICWZZGX2YHZ8HRsKK5aiuVkiTlLHULTB1adMu
iSOl2knSa5JeaXx6BTFakgT6N1xupNHgBwbcpDu8CJW4kFXNWYQftsUa70VgUvBA
EYdHaAtTQS/wzTvXj9GC1/+HDERg3OmtPX5qRSfXB17SKYtfLwsrwvXEg932qSEf
Rrt1/gR46Jr5x7p+N7motxBgM9huLe1Vxu4T/akySCVApC0gt67MALE2iXNFhdAV
76GbBtpIt1HyALbSnjxBELt4HSdnqrGSaTNb8LjCx0OGW+4ImYyHFIbIOgXhIxYP
dbBi2xL/clsTJuepU960IPFN5JWiQ5mr+mYqBeA+vVqBzFweUz2XNrZ6W8VS0Bck
TU7cNpdKLMyNTtf7GNcUKNnL342r1MA91SgDzPWvjvggaBmv8hXolLbyzdIV2zaV
T++Tkdbjw22CnrgasQuA+0mEHQux0LOA7NS/GwDa+xFDos3Inmni930Ye6BRDQ09
awjM07cppssgAtHeHEiBmOtuaLg+1QUt6W5VO/Ixs5e8Q/kwAQiW2ZyiPt+RuYsc
xhsJoOx9a9Pr9fWRdvqddIM4spZfCxCBaNQfgoy5aLQgMdC0nKc=
=7fx4
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--


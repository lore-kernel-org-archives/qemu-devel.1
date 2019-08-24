Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A08C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4C020870
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oDwqk41b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4C020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Sv6-0003VD-Gc
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 06:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i1Sqa-0000xR-Cb
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i1SqZ-0000S2-1Z
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:00:36 -0400
Received: from ozlabs.org ([203.11.71.1]:43381)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i1SqV-0000FB-8M; Sat, 24 Aug 2019 06:00:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Fv060TRwz9s7T; Sat, 24 Aug 2019 20:00:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566640822;
 bh=B2scDrCEmsrvlvxvsFT460N/Jf/uBFVfHmkko8SiUUg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oDwqk41btXVlNhqwUMMwuwmggeYN71pMPu0saPQfHAVlP8pubtRc0s7a35Vd9+CAg
 cYwEdmeyzDJ3r8CCwI5h9SDIyIFWS4mhbPGczlbQFY4a2gbcxHG94rh6ZtXGG4liVb
 93/nGR8eORGLhP/Q4+Ps6JsglYUorhDqeWIi3u0w=
Date: Sat, 24 Aug 2019 19:27:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tony Nguyen <tony.nguyen@bt.com>
Message-ID: <20190824092710.GH3027@umbus.fritz.box>
References: <cover.1566467963.git.tony.nguyen@bt.com>
 <90bd564769dbabaa7cf70b08e77170d54fa4b625.1566467963.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Content-Disposition: inline
In-Reply-To: <90bd564769dbabaa7cf70b08e77170d54fa4b625.1566467963.git.tony.nguyen@bt.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [RFC PATCH 07/17] hw/i2c: Declare device little or
 big endian
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
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2019 at 04:56:28AM +1000, Tony Nguyen wrote:
> For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
> targets from the set of target/hw/*/device.o.
>=20
> If the set of targets are all little or all big endian, re-declare
> the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
> respectively.
>=20
> This *naive* deduction may result in genuinely native endian devices
> being incorrectly declared as little or big endian, but should not
> introduce regressions for current targets.
>=20
> These devices should be re-declared as DEVICE_NATIVE_ENDIAN if 1) it
> has a new target with an opposite endian or 2) someone informed knows
> better =3D)
>=20
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  hw/i2c/imx_i2c.c       | 2 +-
>  hw/i2c/mpc_i2c.c       | 2 +-
>  hw/i2c/versatile_i2c.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

ppc part (mpc_i2c.c)
Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
> index 30b9aea247..cc2689d967 100644
> --- a/hw/i2c/imx_i2c.c
> +++ b/hw/i2c/imx_i2c.c
> @@ -278,7 +278,7 @@ static const MemoryRegionOps imx_i2c_ops =3D {
>      .write =3D imx_i2c_write,
>      .valid.min_access_size =3D 1,
>      .valid.max_access_size =3D 2,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
>  static const VMStateDescription imx_i2c_vmstate =3D {
> diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
> index 0aa1be3ce7..b71b5ff7d5 100644
> --- a/hw/i2c/mpc_i2c.c
> +++ b/hw/i2c/mpc_i2c.c
> @@ -306,7 +306,7 @@ static const MemoryRegionOps i2c_ops =3D {
>      .read =3D  mpc_i2c_read,
>      .write =3D  mpc_i2c_write,
>      .valid.max_access_size =3D 1,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
>  static const VMStateDescription mpc_i2c_vmstate =3D {
> diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
> index 1ac2a6f59a..c92d3b115c 100644
> --- a/hw/i2c/versatile_i2c.c
> +++ b/hw/i2c/versatile_i2c.c
> @@ -77,7 +77,7 @@ static void versatile_i2c_write(void *opaque, hwaddr of=
fset,
>  static const MemoryRegionOps versatile_i2c_ops =3D {
>      .read =3D versatile_i2c_read,
>      .write =3D versatile_i2c_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
> =20
>  static void versatile_i2c_init(Object *obj)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1hAuwACgkQbDjKyiDZ
s5IQhBAAqxrcGxIkMSJFCefVB/bVhpoflWpH1USQmsPShUrd4YR+H6KoFaAWFC7S
Oz6t6dUXSmSdJ+pOUClx7lGjvRcFSuyEpT7VB26jRpgJ0eZ/PXhMr/mXU9Y/U4ea
LcbtbHmWHCoZCu+EdfRU3BH6IEUhJGYUr5EA7Tmzn9AUCIGU//NWZOujOW4vL0Pd
Y5D4yvWrmEFuhnmw48gjnIp1dla0hbnti63fXgSUo7M5DFmwVsHm7igEqDJQkWSc
8cOtVn6iJ0BcIpQe4ESItDyOcCAPrqbdryucGzOUtqr78ESk9fBGcX/mHnc90qPc
XqQ9Np2cw0XFzR6yRVR9GPZpvjrzqWyzBrwpdmf6S1aYgbYMqa59INTLK54qcjst
6mtLCwxbd2GZE2T8VNIxEhmb4QYsF8NQDpfSkbKHGr4Eg+WQ3g6i7LNwMIyFh3Ua
qGVAX2jnhTJOsnmgPC2BE6juByVa+JN9Txoer3uts8A3Z8EvCa0oUMPqpGifjajd
bkamwn4Y3tPsuPOVVZSk6GMz6kNrASf25I9JYrhSH39aCv7Kshx3qC4KMv8pXRAa
VsE96a5rddzgzQ1MAXO4kRQDR+l7secm7XzKCQbclv1YsjvYFdRbAD61/hRGSwht
cCZhu3dPQG329ZkOFaJVvkEn42AvsQaPbHLaDHdt29FcUf4nuz8=
=jkcV
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--


Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B88AC2D0DE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A5A215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LMfLQe4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A5A215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imq9z-00047W-5V
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 21:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6k-0008MN-9i
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6i-0005Sq-RS
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:05 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39307 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1imq6i-0005R6-Fm; Wed, 01 Jan 2020 21:21:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pBbb3lNrz9sPK; Thu,  2 Jan 2020 13:20:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577931659;
 bh=zzCsEZFC21PJNnTZTKM+zrONrqVJimGayr78SWVC6Bc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LMfLQe4+PAlWPCfbb7VcZaf0SmXA+chVOhV6GD5eSuK+DekwPiFXbx3vb6/aTA7Pp
 oOF9BRfyqnKtoIqeFTjdcfNMLgcbptWUe8spPJsDBFdqtGUFYxsmL5+mprBLL6mRNx
 su26XWRJUP0NOo3mt0tHLpW3pVdtjTn+tjGk5C98=
Date: Thu, 2 Jan 2020 13:03:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 07/14] hw/ppc/Kconfig: Let the Sam460ex board use the
 PowerPC 405 devices
Message-ID: <20200102020340.GD2098@umbus>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-8-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <20191231183216.6781-8-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2019 at 07:32:09PM +0100, Philippe Mathieu-Daud=E9 wrote:
> When configured with --without-default-devices, the build fails:
>=20
>     LINK    ppc-softmmu/qemu-system-ppc
>   /usr/bin/ld: hw/ppc/sam460ex.o: in function `sam460ex_init':
>   hw/ppc/sam460ex.c:313: undefined reference to `ppc4xx_plb_init'
>   /usr/bin/ld: hw/ppc/sam460ex.c:353: undefined reference to `ppc405_ebc_=
init'
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [Makefile:206: qemu-system-ppc] Error 1
>=20
> Fix by selecting the PPC405 config.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 0cd8d4053e..004b7d5ad5 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -50,6 +50,7 @@ config PPC4XX
> =20
>  config SAM460EX
>      bool
> +    select PPC405
>      select PFLASH_CFI01
>      select IDE_SII3112
>      select M41T80

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4NT3wACgkQbDjKyiDZ
s5KY7w//SVKQ4v5x4L4eF0eJEkXtTVSGVIiQWtn1oVHu3qhTWc1UOnk9XjIagtqJ
n4/p8z3KcnsugxU/TvfFHlRNfbnA7WJUdg/t2JGQPTDmvPLP2cumMAMHnd4LzduC
D1BPnpZsT5bq4L0YDhpjaw9IQ86m+RIUoty+GMVB7O4Fg8eqc85Iy8/Ch6JpYZP2
smuKvZjXtJ3v3luIrnkqmvE22KTG2+jmg4wynIcKF6XqkLIdY2X+BsSRX/y1e3nz
17HnAlzrFiMKtAq6K/ucLpQXEOepY1GWEj6QXZuDgixRLMc4iOptKeirhf7NtrUj
R2q2i4MIAvjer6R9AOzBcjVqrqaJG+ubnN/5e8QacQsqVJzWvtgB+Dkp2yl05uHm
yZ0usEoV2qtWf7ilw45lLdWE9A5ZuBCD7dY1jAFqO6PLY9Ri2nnAsK80XzPjRtRc
Xz57StVbO0356ABDjrkWzhj/ZlWNkY0AQ1IjdOVvfVhUvQ/BS/mppZO1coVdwVNZ
qaSZt8WkhVV/krWX840kq4fJG98sVpO6U2MIT2oNRyvz1CIP0te4svgcimkPtgus
SdlenbW30kvGbaoVsdVCSbSnI986HTzXvsibgVceznnEyBeQ4qdP1Yvg3sMIlJeY
qkOAgBsBMHf9N5Ux5+k+CJSpfJgM1hGHPH8TkqlNq0pPz2NUez0=
=918o
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--


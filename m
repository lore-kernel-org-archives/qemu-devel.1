Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC45DC2D0DE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D1E215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ChQU4YXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D1E215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imq8F-0001R0-Hm
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 21:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6k-0008MQ-At
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6i-0005T2-Ry
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:05 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:50207)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1imq6i-0005R4-2v; Wed, 01 Jan 2020 21:21:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pBbc0Bkwz9sR8; Thu,  2 Jan 2020 13:20:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577931660;
 bh=hIIWn1SmokkbLLZNg975rs8sgN4QUTmhkbF6Bm9+qVY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ChQU4YXcz2CFIiaiVzALaiGErkY0fs4NMeBNjjLfvETQkYZqTyS05UIugXLdQSPqR
 zvvx0Va+WfMWhwtv9uHfuxwWpbZP2ZHmPbeP31yPPOh+sPrNZDbAdcCjBUT0xc1yde
 jEz1ti83EH1lApZaiipAtMEuZqzyrGIyD/yjHw70=
Date: Thu, 2 Jan 2020 13:04:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 08/14] hw/ppc/Kconfig: Let the Xilinx Virtex5 ML507 use
 the PPC-440 devices
Message-ID: <20200102020428.GE2098@umbus>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-9-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <20191231183216.6781-9-philmd@redhat.com>
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


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2019 at 07:32:10PM +0100, Philippe Mathieu-Daud=E9 wrote:
> When configured with --without-default-devices, the build fails:
>=20
>     LINK    ppc-softmmu/qemu-system-ppc
>   /usr/bin/ld: hw/ppc/virtex_ml507.o: in function `ppc440_init_xilinx':
>   hw/ppc/virtex_ml507.c:112: undefined reference to `ppcuic_init'
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [Makefile:206: qemu-system-ppc] Error 1
>   make: *** [Makefile:483: ppc-softmmu/all] Error 2
>=20
> Fix by selecting the PPC4XX config.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 004b7d5ad5..d8482a5e99 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -110,6 +110,7 @@ config E500
> =20
>  config VIRTEX
>      bool
> +    select PPC4XX
>      select PFLASH_CFI01
>      select SERIAL
>      select XILINX

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4NT6sACgkQbDjKyiDZ
s5Li/hAAxxLlQvl1ySONsVvlskMByoYb9tvaj8TSpViFYdvMeczB4Ue97iRM/4hV
WIBSzsncV/7nIyho9k25avz7ZfRIYz7Q5Um8Ano1Kiotv6kHOwFatpQr44+Foapy
cj+tFyVuXXypo9ao2mEmfLv2+UGpVb3fz+NudGOeNUTTE6clUN5XevK/oCgpseMH
QmxwlVvIacdl1Mgqs5q00g/+aFYS8n9dtDB/5WMDjyQX96JrZFcz7bAfuVPQHuv/
PHtD4z6OKAA6xVlaLRzTeevhXC1RblmMTjQWOfu3Y7vj+t3Qwc0MubA4Jp7sH1sF
5Ccuz64udFJ0qYpUW/MY7G6REahC5MJXitcsyH8343BFzB4IeK/m0l9LMu0E9NRR
r8KqUCL1qXzuCr/8qVS5gGbGHROEjgygDCEJrAF2R6b4U0sWvMjKyE76P/WL6uUM
h8ApuVQz1vM0r3DrY5P5l07+Mf1WbKrNFwpQdyaVm8GGI9LVlmxYwvwGf8dbKkiM
sYJL572WnWQxXvii8DHCsT3GMZP1miQKk7AseIOAncNNlQKeyvbIC/2qe5CHdF0j
gU+lXN/MNqCpNUFWTHmmG/HKkb0zAP/DOHD3NnCN76DBysGVKfGNKMbOz7cUDxGT
O5NeQcTR5g9jUFQ9OdpKMb8nsr2h8kXNMf6ZjmcnK2mMnnd9gTU=
=zzqV
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--


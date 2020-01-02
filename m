Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFAAC2D0DE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC23215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MxRp/N0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC23215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imq81-0001OY-Nv
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 21:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6k-0008MP-Ab
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6i-0005T7-SZ
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:05 -0500
Received: from ozlabs.org ([203.11.71.1]:53893)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1imq6h-0005Qz-Tl; Wed, 01 Jan 2020 21:21:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pBbb0GvXz9sPW; Thu,  2 Jan 2020 13:20:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577931659;
 bh=0vwoa7fPYG43fPT648dq7hg98MiNPTwh8x1FiZdydDM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MxRp/N0QmaVA4Da5EnKdBxhqyecn45rZCDh4tIkpj5y/VHnEJaQ+YQPTTXT253sdU
 r2jPEIJ/S/qs6EufsmhRWB3um3hE4cs07iAuCjGz44mabk6Xu8ROYlPtaJqhAS7X6u
 K1NMoTY4mpMAWqXvBsGIMekUjonhoH+7OwsNC8aM=
Date: Thu, 2 Jan 2020 13:03:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 06/14] hw/ppc/Kconfig: Restrict the MPC I2C controller to
 e500-based platforms
Message-ID: <20200102020303.GC2098@umbus>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-7-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20191231183216.6781-7-philmd@redhat.com>
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


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2019 at 07:32:08PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Only the PowerPC e500-based platforms use the MPC I2C controller.
> Do not build it for the other machines.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  default-configs/ppc-softmmu.mak | 1 -
>  hw/ppc/Kconfig                  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index bf86128a0c..61b78b844d 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -1,7 +1,6 @@
>  # Default configuration for ppc-softmmu
> =20
>  # For embedded PPCs:
> -CONFIG_MPC_I2C=3Dy
>  CONFIG_DS1338=3Dy
>  CONFIG_E500=3Dy
>  CONFIG_PPC405=3Dy
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index f927ec9c74..0cd8d4053e 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -105,6 +105,7 @@ config E500
>      select PLATFORM_BUS
>      select PPCE500_PCI
>      select SERIAL
> +    select MPC_I2C
> =20
>  config VIRTEX
>      bool

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4NT1QACgkQbDjKyiDZ
s5IQLRAA4n3fsNvpeW0COz2th17NtKiRyu0b0Zp5PngR1zTQQ1mlVKKihkb1QMnu
k+nQ4DuGHhQcfqWA97EjwzuY/sS0uxbh8cyDtTgPRWEpgja8NtC/xQKwyvF3kimh
VQTWpSS2bdPJT6n7Y/gvf9g0M2rvwcDCZxIPOEk8Fcfj3Ewn739vz2zqWxtwohUD
f14KvXwfinEUiq3f+J0ANTIQ6kTItvudPeWLOUO37gVBTibCmgcaF1tA27fbeKaF
bQj30RvYoSYxYzVWj7SJn3c5n3Uw2Hw/t8imJPgaHA4UJZ8QMNG0FKZjegMZqXtA
KqtOLfQ+vjU9rDxfpicFa2ULZWzPwV+Cb17lzxuO7et+m6Rw9agoEQQ4+DdQc3Av
O/vU9WOmfKzt2gziMieXY+fMwYR7rNOI/gSACEoWg3kfbDohqS3AyPHY2AC/aDqz
+UtR+ZOdcAKD9Dpa1mzX2Dfz0iPTA7QifNFcTrFXVeiSKEOt6Bb2sf6NR5d5vAKz
+AfB5PjNTuMTrphltTR/3BG3SN5DZX8rK6espi+tiH6ieon2aet4gbesx9H8JqTw
+X5pY/tvjlcmPcpJwn+CxePya4gBsIdXjJDCuuFaREJluaJMkVnMWRAnMm0zMIpS
jMvLpT18Pcv855tVCwy4wCjSoNkVui8C25ZLcGVj9KqQ2p8MVMI=
=wxqr
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--


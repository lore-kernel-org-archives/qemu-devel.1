Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92619C2D0DE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525E1215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="K7nzymxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525E1215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imq9w-00044R-4c
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 21:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6m-0008Mt-CU
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6l-0005UP-3G
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:08 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39663 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1imq6k-0005TI-OL; Wed, 01 Jan 2020 21:21:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pBbc3lvsz9sSP; Thu,  2 Jan 2020 13:21:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577931660;
 bh=qjhx2lC1m2sIPnJf8DjvA8VKRmh4JMECOQnp38tlKTM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K7nzymxlX32iGMlftA8mTlSp2l9rTeAzRWQ7Kr0ZQKlyEEgkcnS9C6CxDM6hdLgww
 FVhAM8FMh2se+V/Y3Xaeqq7c5qPx9BiA/ArO5Og8LyK76Cd1n5viAgm3WcvnlxLzNj
 JTlJ0qTSNSjlfdJCFdRtKxqDAVPTr6LShrafgVrs=
Date: Thu, 2 Jan 2020 13:07:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 13/14] hw/nvram/Kconfig: Restrict CHRP NVRAM to machines
 using OpenBIOS or SLOF
Message-ID: <20200102020748.GI2098@umbus>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-14-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Content-Disposition: inline
In-Reply-To: <20191231183216.6781-14-philmd@redhat.com>
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


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2019 at 07:32:15PM +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Only the OpenBIOS and SLOF firmwares use the CHRP NVRAM layout.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/nvram/Kconfig       | 4 ++++
>  hw/nvram/Makefile.objs | 2 +-
>  hw/ppc/Kconfig         | 1 +
>  hw/sparc/Kconfig       | 1 +
>  hw/sparc64/Kconfig     | 1 +
>  5 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
> index e082a5610c..0d2ba531ac 100644
> --- a/hw/nvram/Kconfig
> +++ b/hw/nvram/Kconfig
> @@ -7,7 +7,11 @@ config AT24C
> =20
>  config MAC_NVRAM
>      bool
> +    select CHRP_NVRAM
> =20
>  # NMC93XX uses the NS =CE=BCWire interface (similar to SPI but less conf=
igurable)
>  config NMC93XX_EEPROM
>      bool
> +
> +config CHRP_NVRAM
> +    bool
> diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
> index a4bdfbf187..090df63fcd 100644
> --- a/hw/nvram/Makefile.objs
> +++ b/hw/nvram/Makefile.objs
> @@ -2,7 +2,7 @@ common-obj-$(CONFIG_DS1225Y) +=3D ds1225y.o
>  common-obj-$(CONFIG_NMC93XX_EEPROM) +=3D eeprom93xx.o
>  common-obj-$(CONFIG_AT24C) +=3D eeprom_at24c.o
>  common-obj-y +=3D fw_cfg.o
> -common-obj-y +=3D chrp_nvram.o
> +common-obj-$(CONFIG_CHRP_NVRAM) +=3D chrp_nvram.o
>  common-obj-$(CONFIG_MAC_NVRAM) +=3D mac_nvram.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_nvram.o
>  obj-$(CONFIG_NRF51_SOC) +=3D nrf51_nvm.o
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 8e62d8f470..e27efe9a24 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -11,6 +11,7 @@ config PSERIES
>      select XIVE_SPAPR
>      select MSI_NONBROKEN
>      select FDT_PPC
> +    select CHRP_NVRAM
> =20
>  config SPAPR_RNG
>      bool
> diff --git a/hw/sparc/Kconfig b/hw/sparc/Kconfig
> index 2a83a8010e..22aff2f5b7 100644
> --- a/hw/sparc/Kconfig
> +++ b/hw/sparc/Kconfig
> @@ -12,6 +12,7 @@ config SUN4M
>      select LANCE
>      select M48T59
>      select STP2000
> +    select CHRP_NVRAM
> =20
>  config LEON3
>      bool
> diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
> index f9f8b0f73a..980a201bb7 100644
> --- a/hw/sparc64/Kconfig
> +++ b/hw/sparc64/Kconfig
> @@ -12,6 +12,7 @@ config SUN4U
>      select IDE_CMD646
>      select PCKBD
>      select SIMBA
> +    select CHRP_NVRAM
> =20
>  config NIAGARA
>      bool

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4NUHQACgkQbDjKyiDZ
s5IHMhAAkhljr5f8Zcot19wEckEE3hgY+w6Disn3Gl3kE0DGpm70cc/74aHa6y4i
ihX4xvwcF7/UESoEi+9RG+6oJpnwlJ5HanE2fU3QgL9vG1oZx6t1KqT30EIgGCdI
nSa9PwJFc5yKulG09FaIkmEjS4JT2nYsh/zfHoJBwYdRITdwpIiLwGSKIOS1duJg
VFRIbJ3o4rCT0/5cTak2U7cEoz18QcPmd9OZ8W1WlK+qDfMzEIExbwqTfcUfv3r4
m5LZ3b2GEnTLhaFC8PhfpCQukUKVbi2vHLUajNqf7YevXHChHwdS+jxSjvgTZT+C
mZYHflxW42Y4WzhuZIa+o+xQX1/FzLEahWAtObN1ElXqE8Aekd8qeciTkg1JgwK6
UbQxCKwf+nmp5QV4XzJSAr/nNXpoooPkccwjaIknJThDqYHrucFsM+UozU6+K3hV
zrkFFYQzYP1l8lhE65AtwfG/3Q9i51HIq513u3EuLhIfdiv7XxRSfMhCyxESu4XT
cgZqoGDYcqjan4hG2IyEFMRHbqQK3rhfS6H0l1otPRCAQY2ULxtqWasitHY9OVP6
PMV+C9b8y6wg6eMyMXLZmlZqMp1A7DgEAGHsURJpKd9blm4unQEOYdClPG03G6m1
4zfh9jiOeAVgxuWluMc8dTwI6Cz7043+XPWJCBlz3SrGXawecgY=
=g0n1
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--


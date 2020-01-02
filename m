Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C07C32764
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA7E20866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KFMJ+q8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA7E20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imqBc-0006Yp-38
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 21:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6m-0008Ms-CJ
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6l-0005UX-49
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:08 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37477 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1imq6k-0005TK-PF; Wed, 01 Jan 2020 21:21:07 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pBbc4b99z9sSL; Thu,  2 Jan 2020 13:21:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577931660;
 bh=1LFoTe3s6flHTJfC8lWxcgYuGo3tkFZLZsuVyfSGx4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KFMJ+q8qKjjxq4D7aRKIZXmyyI0SClmCjqTMtahTW9LCKR5RLlpPYPLUq/gTAFi86
 99XGhgBmHFk794lbihaqxKhRspN9cqz0QTqGw7QEb1KIKQGCGTP83uGdbnwEhN23lz
 Kck7Hgv4ud7eER39eUWVBv395PvTs54O3LroO2kg=
Date: Thu, 2 Jan 2020 13:06:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 11/14] hw/ppc/Kconfig: Only select FDT helper for
 machines using it
Message-ID: <20200102020616.GH2098@umbus>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-12-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline
In-Reply-To: <20191231183216.6781-12-philmd@redhat.com>
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


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2019 at 07:32:13PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Not all machines use the ppc_create_page_sizes_prop() helper.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Can Kconfig can restrict to TARGET_PPC64?
> ---
>  hw/ppc/Kconfig       | 10 ++++++++++
>  hw/ppc/Makefile.objs |  3 ++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index e4ca920507..8e62d8f470 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -10,6 +10,7 @@ config PSERIES
>      select XICS_SPAPR
>      select XIVE_SPAPR
>      select MSI_NONBROKEN
> +    select FDT_PPC
> =20
>  config SPAPR_RNG
>      bool
> @@ -26,6 +27,7 @@ config POWERNV
>      select MC146818RTC
>      select XICS
>      select XIVE
> +    select FDT_PPC
> =20
>  config PPC405
>      bool
> @@ -42,6 +44,7 @@ config PPC440
>      select PCI_EXPRESS
>      select PPC4XX
>      select SERIAL
> +    select FDT_PPC
> =20
>  config PPC4XX
>      bool
> @@ -60,6 +63,7 @@ config SAM460EX
>      select SMBUS_EEPROM
>      select USB_EHCI_SYSBUS
>      select USB_OHCI
> +    select FDT_PPC
> =20
>  config PREP
>      bool
> @@ -110,6 +114,7 @@ config E500
>      select PPCE500_PCI
>      select SERIAL
>      select MPC_I2C
> +    select FDT_PPC
> =20
>  config VIRTEX
>      bool
> @@ -118,6 +123,7 @@ config VIRTEX
>      select SERIAL
>      select XILINX
>      select XILINX_ETHLITE
> +    select FDT_PPC
> =20
>  config XIVE
>      bool
> @@ -134,5 +140,9 @@ config XIVE_KVM
>      default y
>      depends on XIVE_SPAPR && KVM
> =20
> +# Only used by 64-bit targets
>  config FW_CFG_PPC
>      bool
> +
> +config FDT_PPC
> +    bool
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 5c46c68e44..a4bac57be6 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -1,5 +1,6 @@
>  # shared objects
> -obj-y +=3D ppc.o ppc_booke.o fdt.o
> +obj-y +=3D ppc.o ppc_booke.o
> +obj-$(CONFIG_FDT_PPC) +=3D fdt.o
>  obj-$(CONFIG_FW_CFG_PPC) +=3D fw_cfg.o
>  # IBM pSeries (sPAPR)
>  obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
=2Eo

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4NUBgACgkQbDjKyiDZ
s5JOKA/8D6gW4zVYQleoNiAiu0pbOjrwhJaWalbepOfbdf5mzdU7tEmYAs678RAc
4XcOSRcA6AIE8z4oZaiOoJykl7Zg7hcLx171xnku1d/9G4x94KkX8lSHVL9ZYDh8
iKvMaaAoG4rnQ0NRmcG6I4gBf+K0rMZ3A9jX3/k0hSV1wBqxGSqMWtGLm8j5ecry
1htK/WiNwRQca9/pgkn6ydH0oKAlvgBXIATtNssxfRb/PI44zpvMQlyHV1x8BaqS
67wT8Kx429/PhLX3kZRk1LhxhWoIbrAzaYoTYL/IsHLMxqv+NMtDKg4rJHLS2M5n
jr2wFhDnKgq0ceT5vtRNz3dI+vLxVqj/xfy98fKmpa9gBYVEMEpWH8oTs8hAICS7
R1WCX7rneDyXMAkuFQN4x5tEU4O+XL5pmYE1LQiSQQZS24+qjLPGocnCfXTWAALQ
+DBd/tieVp1ccmLIGnIulH5eig/EgstrPHiiFsLH0CZQEp1nIMhr+FRM2/FaW7pz
Dt++rDOkT3zRSq7oAGofppTpQmZGi9aUE2CMg4Q10hKbJuPyhqJFXYThBLennWE1
q08kN0VUZIaQYRuPNEd+2VHNtR9HFnHlX2ix5a+Tmc++vDg4luSLRbjPVee+HJv9
jZwx9NglrYGThC5q2hjdp31nahn//HfCqd1A+sl31t1whrZnS+Q=
=q4R9
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--


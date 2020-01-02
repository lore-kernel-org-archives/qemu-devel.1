Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B86C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC8521655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 02:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lSRNnjp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC8521655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imq9w-00044V-Ar
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 21:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6k-0008MO-80
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1imq6i-0005Sj-PZ
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 21:21:05 -0500
Received: from ozlabs.org ([203.11.71.1]:56725)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1imq6i-0005R7-AV; Wed, 01 Jan 2020 21:21:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pBbc1Bxlz9sRG; Thu,  2 Jan 2020 13:21:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577931660;
 bh=6NrZCEiI06S9033LlWqxZYWlYwi5hDEfONFR9YFnEG4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lSRNnjp2vpdI2tAkgrdBObv1O1tvXf7q48Y2VDKeLwYqWd/3PTAn78MqFdKlnJaSB
 kglNHDAaKdtGyquQJPK0KcqurGhWlCHEQFuCESNtlEWMy4EdBEp9YJZn/AtTZLoBlC
 yvW7CE1z8YcYumfwdU0v4JtLbfjX46lMsorPHgBE=
Date: Thu, 2 Jan 2020 13:05:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 10/14] hw/ppc/Kconfig: Only select fw_cfg with machines
 using OpenBIOS
Message-ID: <20200102020544.GG2098@umbus>
References: <20191231183216.6781-1-philmd@redhat.com>
 <20191231183216.6781-11-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <20191231183216.6781-11-philmd@redhat.com>
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
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2019 at 07:32:12PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The fw_cfg helpers are only used by machines using OpenBIOS.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: "Herv=E9 Poussineau" <hpoussin@reactos.org>
> ---
>  hw/ppc/Kconfig       | 6 ++++++
>  hw/ppc/Makefile.objs | 3 ++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index d8482a5e99..e4ca920507 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -72,6 +72,7 @@ config PREP
>      select M48T59
>      select PC87312
>      select RS6000_MC
> +    select FW_CFG_PPC
> =20
>  config RS6000_MC
>      bool
> @@ -85,6 +86,7 @@ config MAC_OLDWORLD
>      select GRACKLE_PCI
>      select HEATHROW_PIC
>      select MACIO
> +    select FW_CFG_PPC
> =20
>  config MAC_NEWWORLD
>      bool
> @@ -96,6 +98,7 @@ config MAC_NEWWORLD
>      select MACIO_GPIO
>      select MAC_PMU
>      select UNIN_PCI
> +    select FW_CFG_PPC
> =20
>  config E500
>      bool
> @@ -130,3 +133,6 @@ config XIVE_KVM
>      bool
>      default y
>      depends on XIVE_SPAPR && KVM
> +
> +config FW_CFG_PPC
> +    bool
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 79adf06aa3..5c46c68e44 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -1,5 +1,6 @@
>  # shared objects
> -obj-y +=3D ppc.o ppc_booke.o fdt.o fw_cfg.o
> +obj-y +=3D ppc.o ppc_booke.o fdt.o
> +obj-$(CONFIG_FW_CFG_PPC) +=3D fw_cfg.o
>  # IBM pSeries (sPAPR)
>  obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
=2Eo
>  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4NT/gACgkQbDjKyiDZ
s5LVlQ//cQikYx+f+vanSJYjAmi9dPy2I40J+/g16ddrs0IsYhHqt3fEakrNNs4+
hrvEX+m7GCJcvLpJlhwiT6nTtk42kdhbmwCBvN9KRu8AyYJaFDMn9EXsYEkPWmg3
nXKZ9A6smp6foeQ77ZyV4WVHq60TclFO6/XyivqdqawCPgjD8nxOSZCqvqHwqQzZ
Sgeief6N3BV5ZENKp0ROqUbuDGP4uScSTTG8WnYsJEx9uF6Quj2q3T+C2IFlYCRz
W+axA1sxUiiT9HcoHFwbUqV6SO7tNgNiXpCjXZLVTr54dkcHgYjtSzZTuuo2lj/v
hzGnTHfMbS9eG1o22EhN4A9Pw6KY4DiOzjMOuoDkjDrl2/oKCkE24Aoa1PrhLhXS
pUzQSc8q3JPhfS/nqAQVPc6MdMlgchjE9NDuereG4FcqdnRFV2B3ilfd2Dx0Zt0y
X9LtUjIbpJB114tTaNXXtVTGdZ+//p3hItUvr8h86mKvym0TFxgjhy8m9SavSeqQ
3pzROgjUcmNOspdGH2nbTBP2cD6ob+zT2YtecsMVezT/0YoIK6hRAZKeZEuRW3uu
7uy2abD/WaOneTIdCKXdcsDVZlIRVjE1KmCY6HVhCms8SRwXaT+z+FSO064vvJn8
haRng/nsFvg5P0icrM8cTN66noqG+JrujXuKSyM8gze9RiYdYOQ=
=YrJN
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--


Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DE1C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7383A2075A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 00:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DnWhl9bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7383A2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iochx-00062F-6W
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 19:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iocfT-0003fw-14
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iocfR-0001ZU-Eg
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 19:24:18 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:41699)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iocfQ-0001Tg-IS; Mon, 06 Jan 2020 19:24:17 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47sCmX5JSrz9sRG; Tue,  7 Jan 2020 11:24:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578356652;
 bh=4H3WERXV2xwlHNTpF+FzNPub2SblSkIuPpkE+dPFxuQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DnWhl9bIgXhgfW+O10kB8AHy9zfRTU6NP1hMymtZWiWUOD65TRPLzjO4oLjHnDl8K
 ZFrBDWjMPSB8+Z/f89uCeJEtM/fgYR3v7bWwgIZXTQ86SsLif9fvq7/nly6euBp9hm
 lb4lQeHTLMkF0+70Zti+1ve9SwbyroTeXsipegcw=
Date: Tue, 7 Jan 2020 11:16:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 10/12] pnv/xive: Deduce the PnvXive pointer from
 XiveTCTX::xptr
Message-ID: <20200107001631.GF2098@umbus>
References: <20200106145645.4539-1-clg@kaod.org>
 <20200106145645.4539-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5MRs3DbAxHy5wbhc"
Content-Disposition: inline
In-Reply-To: <20200106145645.4539-11-clg@kaod.org>
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5MRs3DbAxHy5wbhc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 03:56:43PM +0100, C=E9dric Le Goater wrote:
> From: Greg Kurz <groug@kaod.org>
>=20
> And use it instead of reaching out to the machine. This allows to get
> rid of pnv_get_chip().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

6..10 applied to ppc-for-5.0.

> ---
>  include/hw/ppc/pnv.h |  2 --
>  hw/intc/pnv_xive.c   |  8 ++------
>  hw/ppc/pnv.c         | 14 --------------
>  3 files changed, 2 insertions(+), 22 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 2504d8cd4f6b..d65dd32036c8 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -219,8 +219,6 @@ struct PnvMachineState {
>      PnvPnor      *pnor;
>  };
> =20
> -PnvChip *pnv_get_chip(uint32_t chip_id);
> -
>  #define PNV_FDT_ADDR          0x01000000
>  #define PNV_TIMEBASE_FREQ     512000000ULL
> =20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 6412cf222eae..715fca61ae22 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -472,12 +472,8 @@ static uint8_t pnv_xive_get_block_id(XiveRouter *xrt=
r)
>  static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
>  {
>      int pir =3D ppc_cpu_pir(cpu);
> -    PnvChip *chip;
> -    PnvXive *xive;
> -
> -    chip =3D pnv_get_chip(PNV9_PIR2CHIP(pir));
> -    assert(chip);
> -    xive =3D &PNV9_CHIP(chip)->xive;
> +    XivePresenter *xptr =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc)->xptr;
> +    PnvXive *xive =3D PNV_XIVE(xptr);
> =20
>      if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
>          xive_error(xive, "IC: CPU %x is not enabled", pir);
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index de44c7ddb304..924b8dc592fe 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1705,20 +1705,6 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t =
format,
>      return total_count;
>  }
> =20
> -PnvChip *pnv_get_chip(uint32_t chip_id)
> -{
> -    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
> -    int i;
> -
> -    for (i =3D 0; i < pnv->num_chips; i++) {
> -        PnvChip *chip =3D pnv->chips[i];
> -        if (chip->chip_id =3D=3D chip_id) {
> -            return chip;
> -        }
> -    }
> -    return NULL;
> -}
> -
>  static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5MRs3DbAxHy5wbhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4Tzd8ACgkQbDjKyiDZ
s5JvKw/+NGf14M3NnLXHdByVlfMC3jrbQu4XdF1CLpdcyGTrrQsqaYAl6c8l5WcP
7wAD+d98k25DXfKTNwvAG3IlPApjSFcjCUc2PGiroyYlwlYRGiDlFD5lc1C/JEJw
TBro/ADz18Jg1+g/DBaoDU0JCPO1opeJq8cqT7fjfocSDHw+1BdOdmPwnrg7msXY
ShxwP/0J5c0Yu+Zthe0gA0Myjg1KlVL+jg70JBcJxpoE52uLMDe+Fqmq+jKqsgRX
E9fWHAyyT1tVWefh/1nTGnpk4ImlTyqTCv5gybOTMV4D9L34noVoO2CwBWEjqcrD
qrdUD6nxlAqcpSUUsj5LSYJW8yfJWqgO6L+/y7DSJ6LCMCPs9wnjGlds1PBdeAGU
qayFYHXq0zx8gEBkiV8wA70BgQjzwS/OPmjXEnNbi0E48KZ19MKO53+3qHlNdV2n
ws01ipMF8SrG9f8Tk2ljNMUJNexswyjUyvTQNSMUjl0wJ3bPLvvtnxL1o0N/ODlR
3v1B6inffUB1AJ3JNqVmDz1by+ci7fKuynkrsy1X/9NsVv6Vh5cUwDIG/D8XI5/5
dCoO/fnxqS9S0vccSs9cks5T2RSDrp4aJ0oG3BjbBj+SqkJVIzM86yWLXeQMxRZA
0HKcGMUmAbnVSMXMZf+kXCrcvw9+fKu8xU+s7nPZDsHk99sgBPc=
=6jpR
-----END PGP SIGNATURE-----

--5MRs3DbAxHy5wbhc--


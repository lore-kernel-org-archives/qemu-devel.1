Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EDBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6D120665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CNGsFmxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6D120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZq1g-0006zZ-EO
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 00:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpzc-0005Qp-2i
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpza-0000K5-O7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:35:59 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:53615 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZpzZ-0000DA-Nc; Wed, 27 Nov 2019 00:35:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47N8d21tNyz9sSm; Wed, 27 Nov 2019 16:35:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574832950;
 bh=oXVSCrqoB8jcK2yOutkT84n97iU8mQKg6flxXe/vrSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CNGsFmxpXPWDZWRw79UcD5eEzilplVe/OZIPdndhUNSMxGoYB9gugYl8xxC3Izr8C
 KbWvI+vAm1MyFxX4m+zc2DSu321FEqvvE02An/LUPDPwEj0GHFbZaUgsWMjzrRtd5K
 3XXfJMbmYJSX7JZZ4Bur2IAkz1ECiV1EEtaEndVU=
Date: Wed, 27 Nov 2019 16:01:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 06/20] ppc/pnv: Introduce a pnv_xive_is_cpu_enabled()
 helper
Message-ID: <20191127050123.GO5582@umbus.fritz.box>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3qFz8M2h77c7FGn9"
Content-Disposition: inline
In-Reply-To: <20191125065820.927-7-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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


--3qFz8M2h77c7FGn9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 07:58:06AM +0100, C=E9dric Le Goater wrote:
> and use this helper to exclude CPUs which are not enabled in the XIVE
> controller.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied 5..6 to ppc-for-5.0.

> ---
>  include/hw/ppc/pnv.h |  5 +++++
>  hw/intc/pnv_xive.c   | 19 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 03cb429f2131..12b0169a4010 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -99,6 +99,11 @@ typedef struct Pnv9Chip {
>      PnvQuad      *quads;
>  } Pnv9Chip;
> =20
> +/*
> + * A SMT8 fused core is a pair of SMT4 cores.
> + */
> +#define PNV9_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
> +
>  typedef struct PnvChipClass {
>      /*< private >*/
>      SysBusDeviceClass parent_class;
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 9798bd9e729f..ec8349ee4a1f 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -372,6 +372,21 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>  }
> =20
> +/*
> + * One bit per thread id. The first register PC_THREAD_EN_REG0 covers
> + * the first cores 0-15 (normal) of the chip or 0-7 (fused). The
> + * second register covers cores 16-23 (normal) or 8-11 (fused).
> + */
> +static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
> +{
> +    int pir =3D ppc_cpu_pir(cpu);
> +    uint32_t fc =3D PNV9_PIR2FUSEDCORE(pir);
> +    uint64_t reg =3D fc < 8 ? PC_THREAD_EN_REG0 : PC_THREAD_EN_REG1;
> +    uint32_t bit =3D pir & 0x3f;
> +
> +    return xive->regs[reg >> 3] & PPC_BIT(bit);
> +}
> +
>  static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>                                uint8_t nvt_blk, uint32_t nvt_idx,
>                                bool cam_ignore, uint8_t priority,
> @@ -391,6 +406,10 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, u=
int8_t format,
>              XiveTCTX *tctx;
>              int ring;
> =20
> +            if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
> +                continue;
> +            }
> +
>              tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> =20
>              /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3qFz8M2h77c7FGn9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3eAyMACgkQbDjKyiDZ
s5KeIQ/8Cg0d0a96QnSzNQKrBZp05NxqQafUhFPFP+jeC1NvVZyxplP4xwjXSYyt
SRWPnvCVB/pCXEGNhcQ5oHUsX/CRq+GJNV/jM+cz++8NCqhKkfjMLxaLmsbiIfJc
bPRc1wuenUWQmDhuhLRnRmr06EUDrVWWgwZ05qOn4PGXAnkfFnw+BowtCLC+auvN
EqViAJ6BMyRcp7FJIcFOZWLYi3bNoWDGzbmcouXCSFl6VdzbIRCJfgsH7TFRUTDB
Jvjb7aa5xo+t5r3BVBZHWAL4YWdZXt2cCme4AvHBBgPUfnyHV+lZ+qgL5hWmDA5G
eCs5Y6PZ2AX6K/Emg2zBVl7WRbGlwYJXU+uYdKiedbghWM6YZw2L28rSVeaiY86p
M5m8FsVeAVViL7cEy2ciG5suo9qoM0a6/7XpP543UVlsvuqsoQwZBjDODw7k24pc
BdKP/qYzzgoMcWfquc4fnBXIutIOI0KEdQS4Py51vIlCyd/9H9j3rEOmKHThScAp
UgadRBD7gcVUZs7PfMIPmr/UDRCpvmXs8yzoX/nv+rHHfc/HQP3xLbkTq17mnvj0
ccaEknSczMmvcz2rF0G4WEQAe8XxQoHw/Fvi/k3OU76YiPdhDYFsjGLx7Y5vNyVH
8n3piFzsteS27WMliNBfLY7SrLb46qIOd1nh49zfuyPTd2gSb4k=
=F8DP
-----END PGP SIGNATURE-----

--3qFz8M2h77c7FGn9--


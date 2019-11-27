Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B28C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFB02071E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 05:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KGz8VQBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFB02071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZq4e-0001H5-2B
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 00:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpzc-0005Qq-4a
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:36:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iZpza-0000Jj-Lw
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 00:36:00 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:58655)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iZpzZ-0000DE-Vn; Wed, 27 Nov 2019 00:35:58 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47N8d245HDz9sSt; Wed, 27 Nov 2019 16:35:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574832950;
 bh=8DQJeLg6ECelwJpxkrR0QOzqkQdL78XZ7vng2tyMAkY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KGz8VQBypkaMfn2NrSD1Tgwi+LxMSETXEBE4zym+2BYuu/MrsfJ36j1AoxYd+Iz0Q
 +pMHBlPFUkRIBfhYbuAB1GmRtesz8OdT91I5UiHcCDK3tS/ePIR8WUqz+OxklAxI7Y
 h1aQ5mVK2uRY8ALRvKlmplA4KGRs7U2bCMEeqX2A=
Date: Wed, 27 Nov 2019 16:23:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 13/20] ppc/pnv: Clarify how the TIMA is accessed on a
 multichip system
Message-ID: <20191127052353.GR5582@umbus.fritz.box>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Vydr8UAy5z+pPMm1"
Content-Disposition: inline
In-Reply-To: <20191125065820.927-14-clg@kaod.org>
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


--Vydr8UAy5z+pPMm1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 07:58:13AM +0100, C=E9dric Le Goater wrote:
> The TIMA region gives access to the thread interrupt context registers
> of a CPU. It is mapped at the same address on all chips and can be
> accessed by any CPU of the system. To identify the chip from which the
> access is being done, the PowerBUS uses a 'chip' field in the
> load/store messages. QEMU does not model these messages, instead, we
> extract the chip id from the CPU PIR and do a lookup at the machine
> level to fetch the targeted interrupt controller.
>=20
> Introduce pnv_get_chip() and pnv_xive_tm_get_xive() helpers to clarify
> this process in pnv_xive_get_tctx(). The latter will be removed in the
> subsequent patches but the same principle will be kept.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/pnv.h |  3 +++
>  hw/intc/pnv_xive.c   | 40 +++++++++++++++++++++++-----------------
>  hw/ppc/pnv.c         | 14 ++++++++++++++
>  3 files changed, 40 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index a58cfea3f2fd..3a7bc3c57e0d 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -103,6 +103,7 @@ typedef struct Pnv9Chip {
>   * A SMT8 fused core is a pair of SMT4 cores.
>   */
>  #define PNV9_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
> +#define PNV9_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
> =20
>  typedef struct PnvChipClass {
>      /*< private >*/
> @@ -197,6 +198,8 @@ static inline bool pnv_is_power9(PnvMachineState *pnv)
>      return pnv_chip_is_power9(pnv->chips[0]);
>  }
> =20
> +PnvChip *pnv_get_chip(uint32_t chip_id);
> +
>  #define PNV_FDT_ADDR          0x01000000
>  #define PNV_TIMEBASE_FREQ     512000000ULL
> =20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 95e9de312cd9..db9d9c11a8f4 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -439,31 +439,37 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, =
uint8_t format,
>      return count;
>  }
> =20
> +/*
> + * The TIMA MMIO space is shared among the chips and to identify the
> + * chip from which the access is being done, we extract the chip id
> + * from the PIR.
> + */
> +static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
> +{
> +    int pir =3D ppc_cpu_pir(cpu);
> +    PnvChip *chip;
> +    PnvXive *xive;
> +
> +    chip =3D pnv_get_chip(PNV9_PIR2CHIP(pir));
> +    assert(chip);
> +    xive =3D &PNV9_CHIP(chip)->xive;
> +
> +    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
> +        xive_error(xive, "IC: CPU %x is not enabled", pir);
> +    }
> +    return xive;
> +}
> +
>  static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> -    PnvXive *xive =3D NULL;
> -    CPUPPCState *env =3D &cpu->env;
> -    int pir =3D env->spr_cb[SPR_PIR].default_value;
> +    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
> =20
> -    /*
> -     * Perform an extra check on the HW thread enablement.
> -     *
> -     * The TIMA is shared among the chips and to identify the chip
> -     * from which the access is being done, we extract the chip id
> -     * from the PIR.
> -     */
> -    xive =3D pnv_xive_get_ic((pir >> 8) & 0xf);
>      if (!xive) {
>          return NULL;
>      }
> =20
> -    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {

I'm not seeing any code which will replace this check on the thread
enabled register.  Is that really what you intend?

> -        xive_error(PNV_XIVE(xrtr), "IC: CPU %x is not enabled", pir);
> -    }
> -
> -    return tctx;
> +    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>  }
> =20
>  /*
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 5b8b07f6aedc..fa656858b24a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1472,6 +1472,20 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t =
format,
>      return total_count;
>  }
> =20
> +PnvChip *pnv_get_chip(uint32_t chip_id)
> +{
> +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
> +    int i;
> +
> +    for (i =3D 0; i < pnv->num_chips; i++) {
> +        PnvChip *chip =3D pnv->chips[i];
> +        if (chip->chip_id =3D=3D chip_id) {
> +            return chip;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Vydr8UAy5z+pPMm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3eCGQACgkQbDjKyiDZ
s5LKRQ/+OojhBRJ0raRhbdp0wcsQ2HqHMB3Qbd+0Oj0prwmG+yWcT++AssPO51bj
M/kmVsd2cj6+dR8dgxmubBFfnsGWUrXA86b0a0vJijFrdIziV5HiIVtc4IFzoF+u
g3SBxEVaCAV5jV918pGwo/RVQ+DHHkGk7zK4/Y4VhJKQS4c/x2pKy1OO7EFD7f5h
fY/tLdtOdTY2IdRMP5jMek33l0Qt/ePKBLo5aghd3i0zLfqEyFoGXhZyPa8Hrub8
GOAMMKyMFjhY7SWEbumpoLPWWLwQaQYub50qTr+AdBlNGoEBdAWCa09/o3i1zDw8
TTLs06P7STyOPNI06l28+w7mv7vUwcNWxaDjwrBWajvgGUeT6OeCjs4vd4OypTbf
Q91JgWxyy2BAzc9TRypT/35FQ8UCaCv44d/aIaZeftUERx+dv/jBmpZE61uZm7Ba
ZMdInWQ3XnMDTY+CKoCCxOeQiWwFNWyMeYbStlofRE3BnccFhFl6dYksYYCY/xOX
4Yoz4o78Qt0dttTsiMR6Do8Ynyk0XLT4gR38jilyN/1ooEaLhsqOBN/bZM6xV/8v
Qut95vB8relxg3W5/6hWwnKe+Jz9YiXLHn03HU4OGSXe4/oe9prKLbUyQIBucwou
eAK67v+2JQviKOlAQIuRt+tyhDZwNTtp2crc/lN/MROLO7PkEcc=
=ak6H
-----END PGP SIGNATURE-----

--Vydr8UAy5z+pPMm1--


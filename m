Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C368C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76082089F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Qm3d7aSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76082089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhpGx-0008Au-6S
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 01:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37425)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAi-0000eQ-KA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hhpAg-0005rR-GJ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 01:48:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59343 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hhpAf-0005p6-P9; Mon, 01 Jul 2019 01:48:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45cbxs6Xh4z9sPM; Mon,  1 Jul 2019 15:48:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1561960081;
 bh=La5wpYeVWWyWA1k4a/X+TG3/LKFrYVWAJfzBvUudCpI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qm3d7aSe69fg8gPDzySRNMPla341qMaeVrbkEuU3Kb8zknWa07ytEA/41G/c18rpv
 mWoOo73Y1lKwoHYEywcz1k/XiONJvD5L5tMv2C7ejN/HQ4xG7g+vIpcuUnhU0/bTTZ
 cC9kbxdSePQCtL9sxsR1rM/p/mu0Z85/kAcJER9s=
Date: Mon, 1 Jul 2019 15:32:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190701053204.GO2138@umbus.fritz.box>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190630204601.30574-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Sr6hGnsCY8KeifOY"
Content-Disposition: inline
In-Reply-To: <20190630204601.30574-4-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 03/10] ppc/pnv: Rework cache watch model of
 PnvXIVE
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Sr6hGnsCY8KeifOY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2019 at 10:45:54PM +0200, C=E9dric Le Goater wrote:
> When the software modifies the XIVE internal structures, ESB, EAS,
> END, NVT, it also must update the caches of the different XIVE
> sub-engines. HW offers a set of common interface for such purpose.
>=20
> The CWATCH_SPEC register defines the block/index of the target and a
> set of flags to perform a full update and to watch for update
> conflicts.
>=20
> The cache watch CWATCH_DATAX registers are then loaded with the target
> data with a first read on CWATCH_DATA0. Writing back is done in the
> opposit order, CWATCH_DATA0 triggering the update.
>=20
> The SCRUB_TRIG registers are used to flush the cache in RAM, and to
> possibly invalidate it. Cache disablement is also an option but as we
> do not model the cache, these registers are no-ops
>=20
> Today, the modeling of these registers is incorrect but it did not
> impact the set up of a baremetal system. However, running KVM requires
> a rework.
>=20
> Fixes: 2dfa91a2aa5a ("ppc/pnv: add a XIVE interrupt controller model for =
POWER9")
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Pushing it for what counts as a bugfix this close to freeze, but I'll
take it.  Applied to ppc-for-4.1.

> ---
>  hw/intc/pnv_xive.c | 142 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 106 insertions(+), 36 deletions(-)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 9ab77feee9d8..4dc92ef1e372 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -169,7 +169,7 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *x=
ive, uint32_t type,
>      vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
> =20
>      if (!(vsd & VSD_ADDRESS_MASK)) {
> -        xive_error(xive, "VST: invalid %s entry %x !?", info->name, 0);
> +        xive_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
>          return 0;
>      }
> =20
> @@ -190,7 +190,7 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *x=
ive, uint32_t type,
>          vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
> =20
>          if (!(vsd & VSD_ADDRESS_MASK)) {
> -            xive_error(xive, "VST: invalid %s entry %x !?", info->name, =
0);
> +            xive_error(xive, "VST: invalid %s entry %x !?", info->name, =
idx);
>              return 0;
>          }
> =20
> @@ -294,8 +294,12 @@ static int pnv_xive_write_end(XiveRouter *xrtr, uint=
8_t blk, uint32_t idx,
>                                word_number);
>  }
> =20
> -static int pnv_xive_end_update(PnvXive *xive, uint8_t blk, uint32_t idx)
> +static int pnv_xive_end_update(PnvXive *xive)
>  {
> +    uint8_t  blk =3D GETFIELD(VC_EQC_CWATCH_BLOCKID,
> +                           xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
> +    uint32_t idx =3D GETFIELD(VC_EQC_CWATCH_OFFSET,
> +                           xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
>      int i;
>      uint64_t eqc_watch[4];
> =20
> @@ -307,6 +311,24 @@ static int pnv_xive_end_update(PnvXive *xive, uint8_=
t blk, uint32_t idx)
>                                XIVE_VST_WORD_ALL);
>  }
> =20
> +static void pnv_xive_end_cache_load(PnvXive *xive)
> +{
> +    uint8_t  blk =3D GETFIELD(VC_EQC_CWATCH_BLOCKID,
> +                           xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
> +    uint32_t idx =3D GETFIELD(VC_EQC_CWATCH_OFFSET,
> +                           xive->regs[(VC_EQC_CWATCH_SPEC >> 3)]);
> +    uint64_t eqc_watch[4] =3D { 0 };
> +    int i;
> +
> +    if (pnv_xive_vst_read(xive, VST_TSEL_EQDT, blk, idx, eqc_watch)) {
> +        xive_error(xive, "VST: no END entry %x/%x !?", blk, idx);
> +    }
> +
> +    for (i =3D 0; i < ARRAY_SIZE(eqc_watch); i++) {
> +        xive->regs[(VC_EQC_CWATCH_DAT0 >> 3) + i] =3D be64_to_cpu(eqc_wa=
tch[i]);
> +    }
> +}
> +
>  static int pnv_xive_get_nvt(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
>                              XiveNVT *nvt)
>  {
> @@ -320,8 +342,12 @@ static int pnv_xive_write_nvt(XiveRouter *xrtr, uint=
8_t blk, uint32_t idx,
>                                word_number);
>  }
> =20
> -static int pnv_xive_nvt_update(PnvXive *xive, uint8_t blk, uint32_t idx)
> +static int pnv_xive_nvt_update(PnvXive *xive)
>  {
> +    uint8_t  blk =3D GETFIELD(PC_VPC_CWATCH_BLOCKID,
> +                           xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
> +    uint32_t idx =3D GETFIELD(PC_VPC_CWATCH_OFFSET,
> +                           xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
>      int i;
>      uint64_t vpc_watch[8];
> =20
> @@ -333,6 +359,24 @@ static int pnv_xive_nvt_update(PnvXive *xive, uint8_=
t blk, uint32_t idx)
>                                XIVE_VST_WORD_ALL);
>  }
> =20
> +static void pnv_xive_nvt_cache_load(PnvXive *xive)
> +{
> +    uint8_t  blk =3D GETFIELD(PC_VPC_CWATCH_BLOCKID,
> +                           xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
> +    uint32_t idx =3D GETFIELD(PC_VPC_CWATCH_OFFSET,
> +                           xive->regs[(PC_VPC_CWATCH_SPEC >> 3)]);
> +    uint64_t vpc_watch[8] =3D { 0 };
> +    int i;
> +
> +    if (pnv_xive_vst_read(xive, VST_TSEL_VPDT, blk, idx, vpc_watch)) {
> +        xive_error(xive, "VST: no NVT entry %x/%x !?", blk, idx);
> +    }
> +
> +    for (i =3D 0; i < ARRAY_SIZE(vpc_watch); i++) {
> +        xive->regs[(PC_VPC_CWATCH_DAT0 >> 3) + i] =3D be64_to_cpu(vpc_wa=
tch[i]);
> +    }
> +}
> +
>  static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
>                              XiveEAS *eas)
>  {
> @@ -346,12 +390,6 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>  }
> =20
> -static int pnv_xive_eas_update(PnvXive *xive, uint8_t blk, uint32_t idx)
> -{
> -    /* All done. */
> -    return 0;
> -}
> -
>  static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> @@ -950,28 +988,43 @@ static void pnv_xive_ic_reg_write(void *opaque, hwa=
ddr offset,
>       * XIVE PC & VC cache updates for EAS, NVT and END
>       */
>      case VC_IVC_SCRUB_MASK:
> -        break;
>      case VC_IVC_SCRUB_TRIG:
> -        pnv_xive_eas_update(xive, GETFIELD(PC_SCRUB_BLOCK_ID, val),
> -                            GETFIELD(VC_SCRUB_OFFSET, val));
>          break;
> =20
> -    case VC_EQC_SCRUB_MASK:
>      case VC_EQC_CWATCH_SPEC:
> -    case VC_EQC_CWATCH_DAT0 ... VC_EQC_CWATCH_DAT3:
> +        val &=3D ~VC_EQC_CWATCH_CONFLICT; /* HW resets this bit */
> +        break;
> +    case VC_EQC_CWATCH_DAT1 ... VC_EQC_CWATCH_DAT3:
>          break;
> +    case VC_EQC_CWATCH_DAT0:
> +        /* writing to DATA0 triggers the cache write */
> +        xive->regs[reg] =3D val;
> +        pnv_xive_end_update(xive);
> +        break;
> +    case VC_EQC_SCRUB_MASK:
>      case VC_EQC_SCRUB_TRIG:
> -        pnv_xive_end_update(xive, GETFIELD(VC_SCRUB_BLOCK_ID, val),
> -                            GETFIELD(VC_SCRUB_OFFSET, val));
> +        /*
> +         * The scrubbing registers flush the cache in RAM and can also
> +         * invalidate.
> +         */
>          break;
> =20
> -    case PC_VPC_SCRUB_MASK:
>      case PC_VPC_CWATCH_SPEC:
> -    case PC_VPC_CWATCH_DAT0 ... PC_VPC_CWATCH_DAT7:
> +        val &=3D ~PC_VPC_CWATCH_CONFLICT; /* HW resets this bit */
> +        break;
> +    case PC_VPC_CWATCH_DAT1 ... PC_VPC_CWATCH_DAT7:
>          break;
> +    case PC_VPC_CWATCH_DAT0:
> +        /* writing to DATA0 triggers the cache write */
> +        xive->regs[reg] =3D val;
> +        pnv_xive_nvt_update(xive);
> +        break;
> +    case PC_VPC_SCRUB_MASK:
>      case PC_VPC_SCRUB_TRIG:
> -        pnv_xive_nvt_update(xive, GETFIELD(PC_SCRUB_BLOCK_ID, val),
> -                           GETFIELD(PC_SCRUB_OFFSET, val));
> +        /*
> +         * The scrubbing registers flush the cache in RAM and can also
> +         * invalidate.
> +         */
>          break;
> =20
> =20
> @@ -1022,15 +1075,6 @@ static uint64_t pnv_xive_ic_reg_read(void *opaque,=
 hwaddr offset, unsigned size)
>      case PC_GLOBAL_CONFIG:
> =20
>      case PC_VPC_SCRUB_MASK:
> -    case PC_VPC_CWATCH_SPEC:
> -    case PC_VPC_CWATCH_DAT0:
> -    case PC_VPC_CWATCH_DAT1:
> -    case PC_VPC_CWATCH_DAT2:
> -    case PC_VPC_CWATCH_DAT3:
> -    case PC_VPC_CWATCH_DAT4:
> -    case PC_VPC_CWATCH_DAT5:
> -    case PC_VPC_CWATCH_DAT6:
> -    case PC_VPC_CWATCH_DAT7:
> =20
>      case VC_GLOBAL_CONFIG:
>      case VC_AIB_TX_ORDER_TAG2:
> @@ -1043,12 +1087,6 @@ static uint64_t pnv_xive_ic_reg_read(void *opaque,=
 hwaddr offset, unsigned size)
>      case VC_IRQ_CONFIG_IPI_CASC:
> =20
>      case VC_EQC_SCRUB_MASK:
> -    case VC_EQC_CWATCH_DAT0:
> -    case VC_EQC_CWATCH_DAT1:
> -    case VC_EQC_CWATCH_DAT2:
> -    case VC_EQC_CWATCH_DAT3:
> -
> -    case VC_EQC_CWATCH_SPEC:
>      case VC_IVC_SCRUB_MASK:
>      case VC_SBC_CONFIG:
>      case VC_AT_MACRO_KILL_MASK:
> @@ -1080,6 +1118,38 @@ static uint64_t pnv_xive_ic_reg_read(void *opaque,=
 hwaddr offset, unsigned size)
>      /*
>       * XIVE PC & VC cache updates for EAS, NVT and END
>       */
> +    case VC_EQC_CWATCH_SPEC:
> +        xive->regs[reg] =3D ~(VC_EQC_CWATCH_FULL | VC_EQC_CWATCH_CONFLIC=
T);
> +        val =3D xive->regs[reg];
> +        break;
> +    case VC_EQC_CWATCH_DAT0:
> +        /*
> +         * Load DATA registers from cache with data requested by the
> +         * SPEC register
> +         */
> +        pnv_xive_end_cache_load(xive);
> +        val =3D xive->regs[reg];
> +        break;
> +    case VC_EQC_CWATCH_DAT1 ... VC_EQC_CWATCH_DAT3:
> +        val =3D xive->regs[reg];
> +        break;
> +
> +    case PC_VPC_CWATCH_SPEC:
> +        xive->regs[reg] =3D ~(PC_VPC_CWATCH_FULL | PC_VPC_CWATCH_CONFLIC=
T);
> +        val =3D xive->regs[reg];
> +        break;
> +    case PC_VPC_CWATCH_DAT0:
> +        /*
> +         * Load DATA registers from cache with data requested by the
> +         * SPEC register
> +         */
> +        pnv_xive_nvt_cache_load(xive);
> +        val =3D xive->regs[reg];
> +        break;
> +    case PC_VPC_CWATCH_DAT1 ... PC_VPC_CWATCH_DAT7:
> +        val =3D xive->regs[reg];
> +        break;
> +
>      case PC_VPC_SCRUB_TRIG:
>      case VC_IVC_SCRUB_TRIG:
>      case VC_EQC_SCRUB_TRIG:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sr6hGnsCY8KeifOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ZmtQACgkQbDjKyiDZ
s5JeBg//bINgwMCJ8lT8p5pJD/6aRGC8/FCXie/765SXo0h/KCvdMd6wntBVvDv6
Xcg/JI00THfHyXEqx7el6eDT+EYcaBwqV4D7z4C5r1/J9u8AByliRqUe3/RBr3L8
8IWlua/rAWi6bj4fMX5Ww48QnpBg96DU28AlxfF2lZIZ2xcrEZMCscdji3qfk0yq
Hx0Dy2M+Z5UEZffkVb38WKUsj2jp1u3+q+tqA4tuh3+zG5a97dUjLZDLXEyuoDCO
P2V6uRxPoFRWbV0bL3e9HwbPHEGyHQCbrpPXLZBtkAUSk83dWvcANH/BYKIAqTMs
H5Y8crVqOw7M2vabfy1uI3diJnrdggyymJkLONTB3qg4H5BHOmBizhOPYl3BlK+X
HBhG/IgXrc1P0kKvq9Th0Th+EEt+lFHlG5eI3/4nTfyAYClRZBTpCqXbNZaXtK8m
I8ZXjYHRZFZdBU5MaRov+HIM5M06x5tA7BG1y5cvI/ilFLk7YnHzpAKGLg5Wuz0e
cWyY77Mz+uCj6arU51NdNpNnfieOn2WwbHTK4t0VGNCNfJGvR3H+M5pcwZxNucNB
GRwF6O/fr2gzlkzK49qE5KJPJczHWHYeF4RnGoIEh6hbq45OfS+f7sijXqrBcmhV
NsB1/J0cXL+t23w1N1lqZuVmAVn6h9G+9vX3yERqNCX3qo38R3c=
=yBzN
-----END PGP SIGNATURE-----

--Sr6hGnsCY8KeifOY--


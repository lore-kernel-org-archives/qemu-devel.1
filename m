Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB7DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 23:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40381222B0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 23:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="noyllbJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40381222B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXD99-0006Rd-En
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 18:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45623)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXD6a-0003RG-VX
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 18:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXD6Z-000235-Ji
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 18:40:20 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:59287)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXD6Z-00020T-8V; Tue, 19 Nov 2019 18:40:19 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Hj3z0M7Hz9sPL; Wed, 20 Nov 2019 10:40:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574206815;
 bh=yVzvDR/MMi+Fxp2MoS1bHIxuOIGKj/50GIN1W/Ib+jY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=noyllbJFFrKAtLVd10iv0zbUpYfeE35wSQKzA6WgUCjtEa9DEhVzYOVsqldWeUcyC
 azp3Ju0QfESXCDn50h12zkHfwefvuRfHWu0xWGd2j6vLMKAZeVi4sG1KoDP3wID//f
 d6wjZTRBO0ij4cn4tAAdSa5efBOC7FKzhdvBxQQs=
Date: Wed, 20 Nov 2019 09:06:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 04/23] ppc/pnv: Dump the XIVE NVT table
Message-ID: <20191119220655.GY5582@umbus.fritz.box>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lBR2yNlwcY132B3M"
Content-Disposition: inline
In-Reply-To: <20191115162436.30548-5-clg@kaod.org>
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


--lBR2yNlwcY132B3M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 05:24:17PM +0100, C=E9dric Le Goater wrote:
> This is useful to dump the saved contexts of the vCPUs : configuration
> of the base END index of the vCPU and the Interrupt Pending Buffer
> register, which is updated when an interrupt can not be presented.
>=20
> When dumping the NVT table, we skip empty indirect pages which are not
> necessarily allocated.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive_regs.h |  2 ++
>  hw/intc/pnv_xive.c         | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 1a5622f8ded8..94338b4b551e 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -252,6 +252,8 @@ typedef struct XiveNVT {
>          uint32_t        w0;
>  #define NVT_W0_VALID             PPC_BIT32(0)
>          uint32_t        w1;
> +#define NVT_W1_EQ_BLOCK          PPC_BITMASK32(0, 3)
> +#define NVT_W1_EQ_INDEX          PPC_BITMASK32(4, 31)
>          uint32_t        w2;
>          uint32_t        w3;
>          uint32_t        w4;
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index a4d80fd5e79c..02faf4135e48 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -1554,6 +1554,27 @@ static const MemoryRegionOps pnv_xive_pc_ops =3D {
>      },
>  };
> =20
> +/*
> + * skiboot uses an indirect NVT table with 64k subpages
> + */
> +#define XIVE_NVT_COUNT          (1 << XIVE_NVT_SHIFT)
> +#define XIVE_NVT_PER_PAGE       (0x10000 / sizeof(XiveNVT))

Hrm.  So skiboot uses 64kiB pages, but how does the hardware know
that?  Is the hw fixed to 64kiB pages, or is there some register
controlling the subpage size?  In which case shouldn't you be looking
at that rather than assuming 64kiB?

> +static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
> +                                    Monitor *mon)
> +{
> +    uint8_t  eq_blk =3D xive_get_field32(NVT_W1_EQ_BLOCK, nvt->w1);
> +    uint32_t eq_idx =3D xive_get_field32(NVT_W1_EQ_INDEX, nvt->w1);
> +
> +    if (!xive_nvt_is_valid(nvt)) {
> +        return;
> +    }
> +
> +    monitor_printf(mon, "  %08x end:%02x/%04x IPB:%02x\n", nvt_idx,
> +                   eq_blk, eq_idx,
> +                   xive_get_field32(NVT_W4_IPB, nvt->w4));
> +}
> +
>  void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon)
>  {
>      XiveRouter *xrtr =3D XIVE_ROUTER(xive);
> @@ -1562,6 +1583,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
>      uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
>      XiveEAS eas;
>      XiveEND end;
> +    XiveNVT nvt;
>      int i;
> =20
>      monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
> @@ -1590,6 +1612,14 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monito=
r *mon)
>      while (!xive_router_get_end(xrtr, blk, i, &end)) {
>          xive_end_eas_pic_print_info(&end, i++, mon);
>      }
> +
> +    monitor_printf(mon, "XIVE[%x] NVTT %08x .. %08x\n", blk, 0,
> +                   XIVE_NVT_COUNT - 1);
> +    for (i =3D 0; i < XIVE_NVT_COUNT; i +=3D XIVE_NVT_PER_PAGE) {
> +        while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
> +            xive_nvt_pic_print_info(&nvt, i++, mon);
> +        }
> +    }
>  }
> =20
>  static void pnv_xive_reset(void *dev)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lBR2yNlwcY132B3M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3UZ38ACgkQbDjKyiDZ
s5IWDg//apnneVeenVr/ZxfeC4j5TMFE4En1sOh8xKjct5n2k9kwOy7wibcGZUcO
GUEK6062ND8lbl11KSp+F11gDKk8mEYAj2uB7HOR/HDlDYAFT6JuWxBjVPlsLtNV
oPKfZRHIfoegYB3nGzLCSdMP0IJpJWZ8C75xC7zkkk1YnSi5xmoGAeO0mORRxUoO
UT8d1zNghNT968CQGE2EpGVYVxCbVOEpei6A1gkSITJLlDoxKZHhp5OU1vF3KWl5
vPXLwOliUFlsakr/fnAmvbaMwr2aTauQnXvNuxVX/3gm/Zu5DlFd+gWHBhgXpfQ5
9UnCWBho+9o2KR653moxG8VJvIhViAGfPvQaxtR6x8joEyoSEKN2hq5Tv2BQ7ITs
iuAiAhaXdN5sE/QCeHyzeJZXZYHQjCuxNe9DIFOQwaI2SN7piCNgXLKuwxcWPMfw
F63h76yX4+4GzUEwPkhJoda6p/VpmF5QgfBJp8aiCzheiDlSYbLE5yvdmgbgGXoE
OBCau6/8J3/ld49gir/Xe/dHnbQ7LzQIoTHZ2ZF5LogeD9zDCAL09LLZhPMBfhg4
8/MJXfrqC3A3UmkEV0SHkc3PfbHD/VFpZNwgXvTZc7Ky2Vlkx4o9eh75sbBmVC1J
uOtPUv2tRuX15exqBtbC9jIW/TYlAs1L/I12ZS/4GRR/tAtzumU=
=ZpqZ
-----END PGP SIGNATURE-----

--lBR2yNlwcY132B3M--


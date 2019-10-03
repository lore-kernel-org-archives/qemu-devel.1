Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AA1C4360C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DCA21D81
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cs2wJT4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DCA21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFrH2-0002bd-VC
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5M-00007o-TF
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5K-0000xd-BN
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46397 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5J-0000wq-QL; Wed, 02 Oct 2019 22:43:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHPB3gY4z9sPc; Thu,  3 Oct 2019 12:43:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070590;
 bh=PdftzuUomStjJ4KNS6bJYl992Svkq3oiO/3cVEJjHOw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cs2wJT4hXJalcCEW++lTnESzC4NEzIc9BfmaatydXY9RsU90eqLmeuQseU/1xW50M
 JU/hziPS35JqDdWJx/Vo4yRAOWB4UyzswK7Ije67Jfs5YKcsZdzW3cdNcN7czwbyEX
 ClHCG/s17RC0JAk0uvUWktmMTHWND+kn/TnYXpHc=
Date: Thu, 3 Oct 2019 12:20:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 16/25] ppc/pnv: Remove pnv_xive_vst_size() routine
Message-ID: <20191003022053.GM11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-17-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DMotDPdpQlD4ewOK"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-17-clg@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DMotDPdpQlD4ewOK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:36PM +0200, C=E9dric Le Goater wrote:
> pnv_xive_vst_size() tries to compute the size of a VSD table from the
> information given by FW. The number of entries of the table are
> deduced from the result and the MMIO regions of the ESBs and the ENDS
> are also resized with the computed value.
>=20
> But for indirect tables, the result is incorrect. An indirect table is
> a one page array of VSDs pointing to subpages containing XIVE virtual
> structures. The number of first level VSD entries is page aligned and
> the overall computed size of the table is too large. It can also be
> completely wrong when the first VSD entry is not yet initialized.
>=20
> Remove pnv_xive_vst_size() and use a simpler form for direct tables.
> This is only useful when outputting the XIVE sources on the monitor
> and to resize the ESB MMIO window.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Do.. does this actually correct the value for indirect tables?  Or
just remove the calculation on the grounds that it was already broken
and we'll fix later?  If it's the latter, we should surely have some
error_report()s or something if the guest does attempt to use an
indirect table.

> ---
>  hw/intc/pnv_xive.c | 112 +++++++++++++++++----------------------------
>  1 file changed, 43 insertions(+), 69 deletions(-)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 74d6ccbea3d6..b7d505839e68 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -123,36 +123,22 @@ static uint64_t pnv_xive_vst_page_size_allowed(uint=
32_t page_shift)
>           page_shift =3D=3D 21 || page_shift =3D=3D 24;
>  }
> =20
> -static uint64_t pnv_xive_vst_size(uint64_t vsd)
> -{
> -    uint64_t vst_tsize =3D 1ull << (GETFIELD(VSD_TSIZE, vsd) + 12);
> -
> -    /*
> -     * Read the first descriptor to get the page size of the indirect
> -     * table.
> -     */
> -    if (VSD_INDIRECT & vsd) {
> -        uint32_t nr_pages =3D vst_tsize / XIVE_VSD_SIZE;
> -        uint32_t page_shift;
> -
> -        vsd =3D ldq_be_dma(&address_space_memory, vsd & VSD_ADDRESS_MASK=
);
> -        page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
> -
> -        if (!pnv_xive_vst_page_size_allowed(page_shift)) {
> -            return 0;
> -        }
> -
> -        return nr_pages * (1ull << page_shift);
> -    }
> -
> -    return vst_tsize;
> -}
> -
>  static uint64_t pnv_xive_vst_addr_direct(PnvXive *xive, uint32_t type,
>                                           uint64_t vsd, uint32_t idx)
>  {
>      const XiveVstInfo *info =3D &vst_infos[type];
>      uint64_t vst_addr =3D vsd & VSD_ADDRESS_MASK;
> +    uint64_t vst_tsize =3D 1ull << (GETFIELD(VSD_TSIZE, vsd) + 12);
> +    uint32_t idx_max;
> +
> +    idx_max =3D vst_tsize / info->size - 1;
> +    if (idx > idx_max) {
> +#ifdef XIVE_DEBUG
> +        xive_error(xive, "VST: %s entry %x out of range [ 0 .. %x ] !?",
> +                   info->name, idx, idx_max);
> +#endif
> +        return 0;
> +    }
> =20
>      return vst_addr + idx * info->size;
>  }
> @@ -215,7 +201,6 @@ static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint=
32_t type, uint8_t blk,
>  {
>      const XiveVstInfo *info =3D &vst_infos[type];
>      uint64_t vsd;
> -    uint32_t idx_max;
> =20
>      if (blk >=3D info->max_blocks) {
>          xive_error(xive, "VST: invalid block id %d for VST %s %d !?",
> @@ -232,15 +217,6 @@ static uint64_t pnv_xive_vst_addr(PnvXive *xive, uin=
t32_t type, uint8_t blk,
>          return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
>      }
> =20
> -    idx_max =3D pnv_xive_vst_size(vsd) / info->size - 1;
> -    if (idx > idx_max) {
> -#ifdef XIVE_DEBUG
> -        xive_error(xive, "VST: %s entry %x/%x out of range [ 0 .. %x ] !=
?",
> -                   info->name, blk, idx, idx_max);
> -#endif
> -        return 0;
> -    }
> -
>      if (VSD_INDIRECT & vsd) {
>          return pnv_xive_vst_addr_indirect(xive, type, vsd, idx);
>      }
> @@ -519,19 +495,12 @@ static uint64_t pnv_xive_pc_size(PnvXive *xive)
>      return (~xive->regs[CQ_PC_BARM >> 3] + 1) & CQ_PC_BARM_MASK;
>  }
> =20
> -static uint32_t pnv_xive_nr_ipis(PnvXive *xive)
> +static uint32_t pnv_xive_nr_ipis(PnvXive *xive, uint8_t blk)
>  {
> -    uint8_t blk =3D xive->chip->chip_id;
> -
> -    return pnv_xive_vst_size(xive->vsds[VST_TSEL_SBE][blk]) * SBE_PER_BY=
TE;
> -}
> -
> -static uint32_t pnv_xive_nr_ends(PnvXive *xive)
> -{
> -    uint8_t blk =3D xive->chip->chip_id;
> +    uint64_t vsd =3D xive->vsds[VST_TSEL_SBE][blk];
> +    uint64_t vst_tsize =3D 1ull << (GETFIELD(VSD_TSIZE, vsd) + 12);
> =20
> -    return pnv_xive_vst_size(xive->vsds[VST_TSEL_EQDT][blk])
> -        / vst_infos[VST_TSEL_EQDT].size;
> +    return VSD_INDIRECT & vsd ? 0 : vst_tsize * SBE_PER_BYTE;
>  }
> =20
>  /*
> @@ -664,6 +633,7 @@ static void pnv_xive_vst_set_exclusive(PnvXive *xive,=
 uint8_t type,
>      XiveSource *xsrc =3D &xive->ipi_source;
>      const XiveVstInfo *info =3D &vst_infos[type];
>      uint32_t page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
> +    uint64_t vst_tsize =3D 1ull << page_shift;
>      uint64_t vst_addr =3D vsd & VSD_ADDRESS_MASK;
> =20
>      /* Basic checks */
> @@ -699,11 +669,16 @@ static void pnv_xive_vst_set_exclusive(PnvXive *xiv=
e, uint8_t type,
> =20
>      case VST_TSEL_EQDT:
>          /*
> -         * Backing store pages for the END. Compute the number of ENDs
> -         * provisioned by FW and resize the END ESB window accordingly.
> +         * Backing store pages for the END.
> +         *
> +         * If the table is direct, we can compute the number of PQ
> +         * entries provisioned by FW (such as skiboot) and resize the
> +         * END ESB window accordingly.
>           */
> -        memory_region_set_size(&end_xsrc->esb_mmio, pnv_xive_nr_ends(xiv=
e) *
> -                               (1ull << (end_xsrc->esb_shift + 1)));
> +        if (!(VSD_INDIRECT & vsd)) {
> +            memory_region_set_size(&end_xsrc->esb_mmio, (vst_tsize / inf=
o->size)
> +                                   * (1ull << xsrc->esb_shift));
> +        }
>          memory_region_add_subregion(&xive->end_edt_mmio, 0,
>                                      &end_xsrc->esb_mmio);
>          break;
> @@ -712,11 +687,16 @@ static void pnv_xive_vst_set_exclusive(PnvXive *xiv=
e, uint8_t type,
>          /*
>           * Backing store pages for the source PQ bits. The model does
>           * not use these PQ bits backed in RAM because the XiveSource
> -         * model has its own. Compute the number of IRQs provisioned
> -         * by FW and resize the IPI ESB window accordingly.
> +         * model has its own.
> +         *
> +         * If the table is direct, we can compute the number of PQ
> +         * entries provisioned by FW (such as skiboot) and resize the
> +         * ESB window accordingly.
>           */
> -        memory_region_set_size(&xsrc->esb_mmio, pnv_xive_nr_ipis(xive) *
> -                               (1ull << xsrc->esb_shift));
> +        if (!(VSD_INDIRECT & vsd)) {
> +            memory_region_set_size(&xsrc->esb_mmio, vst_tsize * SBE_PER_=
BYTE
> +                                   * (1ull << xsrc->esb_shift));
> +        }
>          memory_region_add_subregion(&xive->ipi_edt_mmio, 0, &xsrc->esb_m=
mio);
>          break;
> =20
> @@ -1666,8 +1646,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
>      XiveRouter *xrtr =3D XIVE_ROUTER(xive);
>      uint8_t blk =3D xive->chip->chip_id;
>      uint32_t srcno0 =3D XIVE_SRCNO(blk, 0);
> -    uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive);
> -    uint32_t nr_ends =3D pnv_xive_nr_ends(xive);
> +    uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
>      XiveEAS eas;
>      XiveEND end;
>      int i;
> @@ -1687,21 +1666,16 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monit=
or *mon)
>          }
>      }
> =20
> -    monitor_printf(mon, "XIVE[%x] ENDT %08x .. %08x\n", blk, 0, nr_ends =
- 1);
> -    for (i =3D 0; i < nr_ends; i++) {
> -        if (xive_router_get_end(xrtr, blk, i, &end)) {
> -            break;
> -        }
> -        xive_end_pic_print_info(&end, i, mon);
> +    monitor_printf(mon, "XIVE[%x] ENDT\n", blk);
> +    i =3D 0;
> +    while (!xive_router_get_end(xrtr, blk, i, &end)) {
> +        xive_end_pic_print_info(&end, i++, mon);
>      }
> =20
> -    monitor_printf(mon, "XIVE[%x] END Escalation %08x .. %08x\n", blk, 0,
> -                   nr_ends - 1);
> -    for (i =3D 0; i < nr_ends; i++) {
> -        if (xive_router_get_end(xrtr, blk, i, &end)) {
> -            break;
> -        }
> -        xive_end_eas_pic_print_info(&end, i, mon);
> +    monitor_printf(mon, "XIVE[%x] END Escalation EAT\n", blk);
> +    i =3D 0;
> +    while (!xive_router_get_end(xrtr, blk, i, &end)) {
> +        xive_end_eas_pic_print_info(&end, i++, mon);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DMotDPdpQlD4ewOK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VWwUACgkQbDjKyiDZ
s5Jm1g/9G4fHhvFjNdYTjjf41lNIbFsMx6obVPS7dDW4u8ZFPuXhPqQVONh662vY
WR2Phnavp37duxhKP28HoUr/g5kZeVBndhyS/Z5rYBj96LOyBNa2g4ux0Io0p/PM
q/mGtUev2Yo7QJOqUCmtraI9VjBe/1iwmXps6x5Y9ErSX3GSZiuoUXgEVwo+GEvP
thtAImOqgVu70EhpRSJUXEVJV3tCZROp1n2WkfsmbTV4BY7VBdaIHP9pcmV5z36/
NuhDx/uElkMEXDkQCBBpawk6w9puq9AWlhbxf65GRS1AR7SUaHDTTdwuNCHiNAuQ
Xc6GpqPv9r90S+1UKg+ypmI8AlvauN9tquLsLqbCvishddx2q+lnsbMRmm78hWFd
iU4wWIUHq41rAa/4F1FEoSbt+9Mm3eE+dTv23Rs87TJCOdNk80NYJEdFt9kjT6gZ
+iNmcJ/J9H1Vb0mxVlz9hiWbtqBq602dlsErPpWlkVArgqBx1ZYM09Boe/tdwQTC
Y/x2Ra1q3MYsUgXtzdQYtH0HTg9CzA7rUJHMmE2Y/AVeJO0RI5pdJgdPMaGWzkbM
XnY01fr/Znp5Q4Ma8dW4zn7eGRVZpcGX5O4pOgtXI1hpjKj2kAR0UZ+jKZ5+/3y9
DU6BJxjysKhA754urgMbBXCJKwOQBWdnxzS4MaIuSUIhOI/o58k=
=l8Np
-----END PGP SIGNATURE-----

--DMotDPdpQlD4ewOK--


Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE92C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAFF222A4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HBZA7nNK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAFF222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWuDV-0002aB-8Z
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iWuCL-0001Hx-4G
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iWuCJ-0005Vi-Dj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:29:01 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:38609)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iWuCI-0005UB-AO; Mon, 18 Nov 2019 22:28:59 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47HBBH1PYLz9sQp; Tue, 19 Nov 2019 14:28:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574134135;
 bh=IqHiN8wuaBlfL90RjNfdQGFiDRDM4H7HEpZwQfFUCvI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HBZA7nNK6D/XnldPu6T6Jm+tl3+k4YJ0o5nNqYHl45/F1pjdBZnItA+sm0Qlf2Gzg
 Syen1+n8gz2+RR4U6rAiN5RhjAe9OEVGc6HavGRAQGKUveRpsMBzKjZ75eLZ9WLEUM
 bewnoLnZSzrtlzxUF16BUKIr9bsXtxCuxvYBSZg8=
Date: Tue, 19 Nov 2019 14:22:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 03/23] ppc/pnv: Remove pnv_xive_vst_size()
 routine
Message-ID: <20191119032254.GS5582@umbus.fritz.box>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dFvuq/4WPi1dbS7Q"
Content-Disposition: inline
In-Reply-To: <20191115162436.30548-4-clg@kaod.org>
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


--dFvuq/4WPi1dbS7Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 05:24:16PM +0100, C=E9dric Le Goater wrote:
> pnv_xive_vst_size() tries to compute the size of a VSD table from the
> information given by FW. The number of entries of the table are
> deduced from the result and the MMIO regions of the ESBs and the END
> ESBs are then resized accordingly with the computed value. This
> reduces the number of elements that can be addressed by the ESB pages.
>=20
> The maximum number of elements of a direct table can contain is simply:
>=20
>    Table size / sizeof(XIVE structure)
>=20
> An indirect table is a one page array of VSDs pointing to subpages
> containing XIVE virtual structures and the maximum number of elements
> an indirect table can contain :
>=20
>    (PAGE_SIZE / sizeof(vsd)) * (PAGE_SIZE / sizeof(XIVE structure))
>=20
> which gives us 16M for XiveENDs, 8M for XiveNVTs. That's more than the
> associated VC and PC BARS can address.
>=20
> The result returned by pnv_xive_vst_size() for indirect tables is
> incorrect and can not be used to reduce the size of the MMIO region of
> a XIVE resource using an indirect table, such as ENDs in skiboot.
>=20
> Remove pnv_xive_vst_size() and use a simpler form for direct tables
> only. Keep the resizing of the MMIO region for direct tables only as
> this is still useful for the ESB MMIO window.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-5.0, thanks.

> ---
>  hw/intc/pnv_xive.c | 112 +++++++++++++++++----------------------------
>  1 file changed, 43 insertions(+), 69 deletions(-)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 4e56c2e4689c..a4d80fd5e79c 100644
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
> @@ -453,19 +429,12 @@ static uint64_t pnv_xive_pc_size(PnvXive *xive)
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
> @@ -598,6 +567,7 @@ static void pnv_xive_vst_set_exclusive(PnvXive *xive,=
 uint8_t type,
>      XiveSource *xsrc =3D &xive->ipi_source;
>      const XiveVstInfo *info =3D &vst_infos[type];
>      uint32_t page_shift =3D GETFIELD(VSD_TSIZE, vsd) + 12;
> +    uint64_t vst_tsize =3D 1ull << page_shift;
>      uint64_t vst_addr =3D vsd & VSD_ADDRESS_MASK;
> =20
>      /* Basic checks */
> @@ -633,11 +603,16 @@ static void pnv_xive_vst_set_exclusive(PnvXive *xiv=
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
> @@ -646,11 +621,16 @@ static void pnv_xive_vst_set_exclusive(PnvXive *xiv=
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
> @@ -1579,8 +1559,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
>      XiveRouter *xrtr =3D XIVE_ROUTER(xive);
>      uint8_t blk =3D xive->chip->chip_id;
>      uint32_t srcno0 =3D XIVE_EAS(blk, 0);
> -    uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive);
> -    uint32_t nr_ends =3D pnv_xive_nr_ends(xive);
> +    uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
>      XiveEAS eas;
>      XiveEND end;
>      int i;
> @@ -1600,21 +1579,16 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monit=
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

--dFvuq/4WPi1dbS7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3TYA0ACgkQbDjKyiDZ
s5LZRg/9EFQv60kYKoWeKI0M1NZxS48exoYL4DSlbQpnP6sq5l9Yj5U58CFfh1CC
8Gy++Te4bdU0dK0i4AT4zv8UlhNFWFS2n/o+OMubXsQzqN+5QYjfEi14qVDA6RD7
JuN/Kqpj1wVusSpw7rAkSwFD3XD1JHK2u0rFr5QX+/oj9RlSXbvQDAm53x5o3tzW
GpZYBtHOkZ2BljtNyEQrI8H/8KmmpnaUlVlLKBeBauuVCTuLg3ierhx65TgapNkx
LtKPDPFp/gFjbU2ozC3BvYO8xbOb1fxawk426LbyqWhZEDMnX5r2png0e4101BQr
IZhTTz92qac3SN/V50wSfvtnuOj34m/9Rlsw7OCgzpp6tZeU7bNClDlcIqD5q3cr
/X6BF6UC02mA53jhmjbWa75PbqWYnSoHa5GwXafFwmAvYW80KqnUakGOT078TGIK
xThvkdihYTDeE2ECI6g6X0jU+tmmzoXfDAmrugFozpeI3nsCVMLL5VUYXhK07cFt
JP7t4gJnAwbH/RJQ39EeEQOqkl88DyhUCYmrc8DwDBays+h1tEd9luLpTJhLajkD
pESqNvTo5qCtyHbgHKhqMVelehwpyz5uUbeV4LsrGkwD96RaeWaPhtbbAwWeZY2P
H0lCAnetf5Pqvs1yGE3PFyUA8qMHa5YDxXjBrkLYxloz/mjq3NM=
=XCVh
-----END PGP SIGNATURE-----

--dFvuq/4WPi1dbS7Q--


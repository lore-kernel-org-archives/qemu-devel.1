Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C3BC4360C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1881021D81
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 02:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GUFojxOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1881021D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFrIZ-0004Ll-9g
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 22:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5O-000099-Rn
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iFr5N-00010V-5V
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 22:43:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60927 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iFr5M-0000xo-Jy; Wed, 02 Oct 2019 22:43:21 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46kHPB56r5z9sPq; Thu,  3 Oct 2019 12:43:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570070590;
 bh=GCogCCWG7bIkBiycUlw+fZAMxzMcEdS/MZx1/JvYJFY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GUFojxORCUEhiPj/x54rj3RXi3EjHLEvHejh648PASp4lkfTQiE6AIX8JgpoYjILg
 5wBdrVrflVcSVjmyc94Hm/a7uvBZFSrv3Tb2X43qtKYJUR1Hgl47V+1UeO+TEkx4AB
 +uFm3r+KUcBb6vlyf3bOwQv4CmMF9LNcZL4qEnY0=
Date: Thu, 3 Oct 2019 12:22:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v4 18/25] ppc/pnv: Skip empty slots of the XIVE NVT table
Message-ID: <20191003022228.GN11105@umbus.fritz.box>
References: <20190918160645.25126-1-clg@kaod.org>
 <20190918160645.25126-19-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2CW6+cughRlDaKZr"
Content-Disposition: inline
In-Reply-To: <20190918160645.25126-19-clg@kaod.org>
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


--2CW6+cughRlDaKZr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 06:06:38PM +0200, C=E9dric Le Goater wrote:
> We try to loop on the full table skipping empty indirect pages which
> are not necessarily allocated. This is useful to dump the contexts of
> the KVM vCPUs.

I think this patch can be merged into the previous one.  They're both
short, so we might as well get the dumping code correct first time.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/pnv_xive.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 782775136288..a986d4ed9364 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -1641,6 +1641,12 @@ static const MemoryRegionOps pnv_xive_pc_ops =3D {
>      },
>  };
> =20
> +/*
> + * skiboot uses an indirect NVT table with 64k subpages
> + */
> +#define XIVE_NVT_COUNT          (1 << XIVE_NVT_SHIFT)
> +#define XIVE_NVT_PER_PAGE       (0x10000 / sizeof(XiveNVT))
> +
>  static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
>                                      Monitor *mon)
>  {
> @@ -1694,10 +1700,12 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monit=
or *mon)
>          xive_end_eas_pic_print_info(&end, i++, mon);
>      }
> =20
> -    monitor_printf(mon, "XIVE[%x] NVTT\n", blk);
> -    i =3D 0;
> -    while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
> -        xive_nvt_pic_print_info(&nvt, i++, mon);
> +    monitor_printf(mon, "XIVE[%x] NVTT %08x .. %08x\n", blk, 0,
> +                   XIVE_NVT_COUNT - 1);
> +    for (i =3D 0; i < XIVE_NVT_COUNT; i +=3D XIVE_NVT_PER_PAGE) {
> +        while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
> +            xive_nvt_pic_print_info(&nvt, i++, mon);
> +        }
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2CW6+cughRlDaKZr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2VW2QACgkQbDjKyiDZ
s5JHFQ//QcpKzYEZAIbseS3iaPucuopvjTMZoUoC2mcl8q16DqOYXSlPLFaE/cnB
/31T8hVaCcbRbdefUQMBRcf5OskNYMX6OcKKQ5W7V0pHCLoJg/xyTmCxkm2s1bOh
SgIEi+iaNtFs4/AZ3UY9Ah/t9Itg8pj9pjmWGdAMg3ZjONVZb9Zc3/75u+3PSFEm
eNs7wJ6pubywYbeabldOu79/b+fRKj/Nk27WVmWDLrE/3PDtovZRugjzhEM3FIAt
p1dyn6d4zy88yinfZnXBvic6xkhlsPCTuP5vMO/thbIJ/cYYu+QhOb6jn6MRmQl8
avmmWJjMudr++b/AtG3uxzgmgUnZKi/w4Zyq6dIK84ZRVut7/TsbH0ocB1JEFPV/
qDqj+zpHCTh4gnAoUKA77clC6aTHvYdEaS9MuPoVfpLHclvMzzbKnV5YSDnYofyl
Nc4/rqDPQd2+zDedxsTS+VClYxVYsgjgmqI8ilajtQm+OpXp+JexnK+fE9yWkrGq
zJ147TcI+hcBYq1sq4W0pV/dwZi15EfXlm53SlW3vXXyddp+9PIg/nrE9lS3pUJ7
hxLkwim1en0EwjczFp0qAv81hdOIg8fJpU7R7d+7aN136/I3WtUb8zwCA7kWbHON
5LXMtLlnvtGqbEAU74SInhidmDiVwqBhgUNSYu+P5lnY5CFgZTU=
=Z8rF
-----END PGP SIGNATURE-----

--2CW6+cughRlDaKZr--


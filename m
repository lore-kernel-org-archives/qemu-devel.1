Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22B0C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4862073E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 04:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="E0NazzpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4862073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGbVY-0007Ey-NB
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 00:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbUr-0006ka-DM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jGbUp-0008Db-Ks
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 00:49:00 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:38311 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jGbUo-0008B7-BJ; Tue, 24 Mar 2020 00:48:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48mf0M6sQcz9sSL; Tue, 24 Mar 2020 15:48:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585025331;
 bh=bxZxelmebJBmouwxWHIMvReN6q3JRF3WCEg7dFnZteU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E0NazzpYAgpY/mpbavLgKB5UYZPnGBXjnvrIVfpKE9nzjOVAL8f26UOrE9V5WXB3z
 /52hHk2dZhbY2xWubKfEzZMoEhymLw4FpZYDT45z4b+T73QgCi1DPAniSFmW5eurei
 lIKfcZ3YgR3cR3t1Qx0gBPPT+uRosj4n2ieCNgek=
Date: Tue, 24 Mar 2020 15:24:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PULL 11/26] vfio/spapr: Allow backing bigger guest IOMMU pages
 with smaller physical pages
Message-ID: <20200324042425.GD36889@umbus.fritz.box>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
 <20180821043343.7514-12-david@gibson.dropbear.id.au>
 <CAFEAcA_yCceBjJU+QfcSe+wHkSZp90e3XZ-H_Au2VhfY_Zmuxw@mail.gmail.com>
 <11abd8d3-f2f0-c1c2-fb1c-2466091a23fc@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <11abd8d3-f2f0-c1c2-fb1c-2466091a23fc@ozlabs.ru>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2020 at 03:08:22PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 23/03/2020 21:55, Peter Maydell wrote:
> > On Tue, 21 Aug 2018 at 05:33, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> >>
> >> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>
> >> At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
> >> pages and POWER8 CPU supports the exact same set of page size so
> >> so far things worked fine.
> >>
> >> However POWER9 supports different set of sizes - 4K/64K/2M/1G and
> >> the last two - 2M and 1G - are not even allowed in the paravirt interf=
ace
> >> (RTAS DDW) so we always end up using 64K IOMMU pages, although we could
> >> back guest's 16MB IOMMU pages with 2MB pages on the host.
> >>
> >> This stores the supported host IOMMU page sizes in VFIOContainer and u=
ses
> >> this later when creating a new DMA window. This uses the system page s=
ize
> >> (64k normally, 2M/16M/1G if hugepages used) as the upper limit of
> >> the IOMMU pagesize.
> >>
> >> This changes the type of @pagesize to uint64_t as this is what
> >> memory_region_iommu_get_min_page_size() returns and clz64() takes.
> >>
> >> There should be no behavioral changes on platforms other than pseries.
> >> The guest will keep using the IOMMU page size selected by the PHB page=
size
> >> property as this only changes the underlying hardware TCE table
> >> granularity.
> >=20
> > Hi; Coverity has raised an issue (CID 1421903) on this code and
> > I'm not sure if it's correct or not.
> >=20
> >=20
> >> @@ -144,9 +145,27 @@ int vfio_spapr_create_window(VFIOContainer *conta=
iner,
> >>  {
> >>      int ret;
> >>      IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
> >> -    unsigned pagesize =3D memory_region_iommu_get_min_page_size(iommu=
_mr);
> >> +    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu=
_mr);
> >>      unsigned entries, pages;
> >>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof=
(create) };
> >> +    long systempagesize =3D qemu_getrampagesize();
> >> +
> >> +    /*
> >> +     * The host might not support the guest supported IOMMU page size,
> >> +     * so we will use smaller physical IOMMU pages to back them.
> >> +     */
> >> +    if (pagesize > systempagesize) {
> >> +        pagesize =3D systempagesize;
> >> +    }
>=20
> pagesize cannot be zero here (I checked possible code paths)...
>=20
>=20
>=20
> >> +    pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
> >> +                                   (pagesize | (pagesize - 1))));
> >> If the argument to clz64() is zero then it will return 64, and
> > then we will try to do a shift by -1, which is undefined
> > behaviour.
>=20
> ... but the clz64() argument can if lets say container->pgsizes=3D1<<30
> (comes from VFIO) and pagesize=3D1<<16 (decided by QEMU or guest).
>=20
>=20
> I'll sent a patch to handle clz64()=3D>64. Thanks,

Thanks, Alexey.

Peter, I don't think this is urgent however - it's really unlikely in
practice.

>=20
>=20
> > Can the expression ever be zero? It's not immediately obvious to me
> > that it can't be, so my suggestion would be that if it is
> > impossible then an assert() of that would be helpful, and if it
> > is possible then the code needs to avoid the illegal shift.
>=20
> >> +    if (!pagesize) {
> >> +        error_report("Host doesn't support page size 0x%"PRIx64
> >> +                     ", the supported mask is 0x%lx",
> >> +                     memory_region_iommu_get_min_page_size(iommu_mr),
> >> +                     container->pgsizes);
> >> +        return -EINVAL;
> >> +    }
> >=20
> > thanks
> > -- PMM
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl55i3kACgkQbDjKyiDZ
s5JxFBAA4hwCFZE6v9B+TnWL0mykx6M16yNLNMIOllQYbm9vGH8UtJ24+zn66lBS
lhtPSZ6Wi5BSMa/SfuXJ54qDAA4M3ddukYGHWv8zk5N2yjgftMAIls8MZZmiXWJ2
g4W+N+IJ7Zo66qON+SsQ17w9Abe8TcGX6DCzoO0h4cgdYQeTjRL75qVWd7FI38i3
V/sBxq2XLU33c45J+XjBU2ctZpzFFsjv5Qt4JRINlSDi6zwC2X2ZxQX9Cq3HhszL
EbSKXmXUeHwTh7POelbiWFFZxUcgcKXgWlclPNSZK75CIPEj/WoFXl15D5lff+8G
is1RH6pfGjob1KpE96IB8dOddJTmYxdfHveQFegwOBaLKdYxeZjw/V+MoFw91+AS
9Vm+fZB506pBGfBLbwGyVhLsM34YzxBejL/Rbuzx40FftutGfRgQgR+36KOtYo+0
gbud35rDwIiq09Lu0CzJEgweZTpThssg2zBNVVbuDIvY9RgaW9/gdvhEbasYEcnt
XaLfQT2+DhzRzVFcYlsccZxW/6hllmA/RHXnHv5HSZZtfu3gfMTDlw1um1y1VtHJ
yVmc5yqrhaoYKr2yq/t1N+LX7dYP4o0LjJKjy+1srLdBFdmfM393V4Pk0ubR0zPt
RFa0XuqYknq+FlYTCoRUZkD3gEN1q1KynLHFPT2edLzWmhQvQ3M=
=ilKL
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--


Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE27C2D0E7
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794C52073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WqYTqtGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794C52073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGYS-0005XD-HM
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXL-0003lF-4D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXJ-0002H1-3b
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:19 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXH-0002AY-PW; Wed, 25 Mar 2020 20:38:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL80hNxz9sSL; Thu, 26 Mar 2020 11:38:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183088;
 bh=qB0r7NS4r+cvkwy6uhHzmqiPy8DcDIBEFy3LkKL7M/U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WqYTqtGCgvS62pOY7HaWsGQtr0YYvD61DHv8Cl7AFYFsc0wS2dMRkWqh3d5QxpP/p
 rzBEyGNdUs2EoWpP5anTYC93xBtfB2cTVBgsqyNJAP2CBE1cD0u3KHLuANWP3ROGbc
 v88no55MhXglit028rSfE64/M71ik0iUd8XyGd/E=
Date: Thu, 26 Mar 2020 11:11:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] vfio/spapr: Fix page size calculation
Message-ID: <20200326001106.GJ36889@umbus.fritz.box>
References: <20200324063912.25063-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oxV4ZoPwBLqAyY+a"
Content-Disposition: inline
In-Reply-To: <20200324063912.25063-1-aik@ozlabs.ru>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2020 at 05:39:12PM +1100, Alexey Kardashevskiy wrote:
> Coverity detected an issue (CID 1421903) with potential call of clz64(0)
> which returns 64 which make it do "<<" with a negative number.
>=20
> This checks the mask and avoids undefined behaviour.
>=20
> In practice pgsizes and memory_region_iommu_get_min_page_size() always
> have some common page sizes and even if they did not, the resulting page
> size would be 0x8000.0000.0000.0000 (gcc 9.2) and
> ioctl(VFIO_IOMMU_SPAPR_TCE_CREATE) would fail anyway.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-5.1.

> ---
>  hw/vfio/spapr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 33692fc86fd6..2900bd19417a 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -147,7 +147,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  {
>      int ret =3D 0;
>      IOMMUMemoryRegion *iommu_mr =3D IOMMU_MEMORY_REGION(section->mr);
> -    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
);
> +    uint64_t pagesize =3D memory_region_iommu_get_min_page_size(iommu_mr=
), pgmask;
>      unsigned entries, bits_total, bits_per_level, max_levels;
>      struct vfio_iommu_spapr_tce_create create =3D { .argsz =3D sizeof(cr=
eate) };
>      long rampagesize =3D qemu_minrampagesize();
> @@ -159,8 +159,8 @@ int vfio_spapr_create_window(VFIOContainer *container,
>      if (pagesize > rampagesize) {
>          pagesize =3D rampagesize;
>      }
> -    pagesize =3D 1ULL << (63 - clz64(container->pgsizes &
> -                                   (pagesize | (pagesize - 1))));
> +    pgmask =3D container->pgsizes & (pagesize | (pagesize - 1));
> +    pagesize =3D pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>      if (!pagesize) {
>          error_report("Host doesn't support page size 0x%"PRIx64
>                       ", the supported mask is 0x%lx",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl578xoACgkQbDjKyiDZ
s5L5RA//a0u2/sG8OTsTSEX/UTuatMRavqnLezIthO1pHrJdzbi3LsTkHASot9oV
BihCZGnd/tw3V4B50K/I4VJzdNgr2+3IZM99Kkr8SxSFkv9v4SvrYjQ0rC8EMP3k
/ihbTGemV67cA3auQmCGQYIMH3VsDcHjX+aYyf8/4/uadK29jHt7tZ90J2Os75IB
h15ni7Why5xFG0vgNMHyXdX4KEfRSNyGVNbFrhTyBeYk51Ul7GeS+5cZFy8+yB/m
7Zbt/JAY52CghV35cO8ok+hwahXbVFa/Eo+/sV1iQBbcSIBjCVzd8PFlDFdsEEA6
MTACQBIHtrGB6ylqI6iQMQLbg+j/ejsTcLXCBuEFUcErNsBzkmQ8NpBjHT+RwySq
DCnYK6kLoUy+e8SRFXXyQNXYhmTRG3FvG48m61SwRf0llEIXBjNJ6Jo/F2B+ekoL
d31zSyDI4jX5O15ZUBIZ40vYrOjfOyp3BoHSGxTVXxjXoIUSW2/s2OgFENh+MecE
34ZjFL9p3gEran8WzEq/TgS6VCtCQnpiaOBSVOj/fFVSHU61+dx5V2rIxZjRS6oo
rCqApu4PbkzaxuEKQsZG6MXHdp6Tii7fd0TtQPo0V+jLojNMGQRRXc7CACq8eV3R
JMfqKZxj7bWnw14tB6g9RxrJa+FXIYYIyUMaeSIf1B/ns6MnKos=
=24BJ
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--


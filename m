Received: from eggs.gnu.org ([2001:4830:134:3::10]:51495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ1Ir-00078C-4i
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ1Ip-0005Ck-OM
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:14:53 -0500
References: <20170131112308.54189-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9d108abd-a3dd-e644-5359-7bf81fdf0642@redhat.com>
Date: Wed, 1 Feb 2017 21:14:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170131112308.54189-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q8A6TIffMcPMS0a54wEPrNtXkxTd2wghr"
Subject: Re: [Qemu-devel] [PATCH] block: bdrv_invalidate_cache: invalidate
 children first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q8A6TIffMcPMS0a54wEPrNtXkxTd2wghr
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <9d108abd-a3dd-e644-5359-7bf81fdf0642@redhat.com>
Subject: Re: [PATCH] block: bdrv_invalidate_cache: invalidate children first
References: <20170131112308.54189-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170131112308.54189-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 12:23, Vladimir Sementsov-Ogievskiy wrote:
> Current implementation invalidates firstly parent bds and then its
> children. This leads to the following bug:
>=20
> after incoming migration, in bdrv_invalidate_cache_all:
> 1. invalidate parent bds - reopen it with BDRV_O_INACTIVE cleared
> 2. child is not yet invalidated
> 3. parent check that its BDRV_O_INACTIVE is cleared
> 4. parent writes to child
> 5. assert in bdrv_co_pwritev, as BDRV_O_INACTIVE is set for child
>=20
> This patch fixes it by just changing invalidate sequence: invalidate
> children first.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> v2: I've missed that bdrv_invalidate_cache is already recursive, so we
> can change sequence here. Also v1 doesn't cover the case when
> bdrv_invalidate_cache is called not from bdrv_invalidate_cache_all.

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--q8A6TIffMcPMS0a54wEPrNtXkxTd2wghr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSQawSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aa5IIALnxrEFk9Izn7DmRZtvkLMo7X0X2mxGc
eempLlZfZJV07CMSK0Xx/c1M23rEWxLqDLx2qcrnyyFnquFUWggZ1R0AeMqjGBLy
PV94vagNNMWU4Z4tuIKDVLyjUb8gSpc3x3JnyK4+O6RgTFVk5dQ3WTgyOC1I5mI5
k8C1XkuuVTje90SxtnF8RDCulucxzIkEBL55FmynZwBXYY+j7UO8TnU+CkM8JcOm
hbC2Lxh2PeZcohhBi4BOjQ9MpZEjvyxSBjDLigu7W0xjlRrCXHselxi/tnXaHzd0
YA1xqeGMn1NRz0LYcUeDz4/2h9xqgW05AziPwvXVMW+Z8kSzjBh4YFc=
=Yro5
-----END PGP SIGNATURE-----

--q8A6TIffMcPMS0a54wEPrNtXkxTd2wghr--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJYi-00008t-QV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpJYe-0000UB-7F
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:30:52 -0400
References: <20170904101800.22945-1-pbutsykin@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04bb5a08-99fd-5c59-9be6-765a63a06412@redhat.com>
Date: Tue, 5 Sep 2017 14:30:33 -0500
MIME-Version: 1.0
In-Reply-To: <20170904101800.22945-1-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j28PvEbAUjD1De7qrKgs8T3mknCSaBPMK"
Subject: Re: [Qemu-devel] [PATCH] qcow2: move
 qcow2_store_persistent_dirty_bitmaps() before cache flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j28PvEbAUjD1De7qrKgs8T3mknCSaBPMK
From: Eric Blake <eblake@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <04bb5a08-99fd-5c59-9be6-765a63a06412@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: move
 qcow2_store_persistent_dirty_bitmaps() before cache flushing
References: <20170904101800.22945-1-pbutsykin@virtuozzo.com>
In-Reply-To: <20170904101800.22945-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2017 05:18 AM, Pavel Butsykin wrote:
> After calling qcow2_inactivate(), all qcow2 caches must be flushed, but=
 this
> may not happen, because the last call qcow2_store_persistent_dirty_bitm=
aps()
> can lead to marking l2/refcont cache as dirty.
>=20
> Let's move qcow2_store_persistent_dirty_bitmaps() before the ca=D1=81he=
 flushing
> to fix it.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20

Should this cc: qemu-stable?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--j28PvEbAUjD1De7qrKgs8T3mknCSaBPMK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmu+1kACgkQp6FrSiUn
Q2o0Jgf/UdjCqSyqvN1L4lw9s2iX1Jn9ZyT6TRPtbnVz+/+RYLoUaLbvfXWQ6VaV
b9FiHXpssyy1hBUg9aDv5cyofKBAh+KBWRUYnNBG2Db/cSp6JASY3JpKbAAyCOMN
/z5pZ2CHU78MZP+evs11vln4s+7Ss6rrQ+a69cAR863IN/Xxgik9tnOwX8461wRb
xMigv5DS2JvbrzJ+p3fTKbfyU5Rz8AWPcA1LPrvi2QX5NOIohaS+b7C/c+YdvJpJ
f/9olYnxrPXBHE4Vdcgc8pTBYYVtKSReUhSm8q3S2NBvObi29k4la/uv6+qbh2NR
RmNuhceCcFFLCgOqrH1Xw/QKEQ8frA==
=kVQ3
-----END PGP SIGNATURE-----

--j28PvEbAUjD1De7qrKgs8T3mknCSaBPMK--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiizJ-0007br-QD
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eiizJ-0006x0-1H
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:47:21 -0500
References: <cover.1517840876.git.berto@igalia.com>
	<1fd7d272b5e7b66254a090b74cf2bed1cc334c0e.1517840877.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5868a365-6812-beb4-a35e-822bafdab2ab@redhat.com>
Date: Mon, 5 Feb 2018 16:47:11 +0100
MIME-Version: 1.0
In-Reply-To: <1fd7d272b5e7b66254a090b74cf2bed1cc334c0e.1517840877.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eGRqCAxqAAJJ0ZOl4iclmn2IR09SJUY98"
Subject: Re: [Qemu-devel] [PATCH v4 31/39] qcow2: Update qcow2_truncate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eGRqCAxqAAJJ0ZOl4iclmn2IR09SJUY98
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <5868a365-6812-beb4-a35e-822bafdab2ab@redhat.com>
Subject: Re: [PATCH v4 31/39] qcow2: Update qcow2_truncate() to support L2
 slices
References: <cover.1517840876.git.berto@igalia.com>
 <1fd7d272b5e7b66254a090b74cf2bed1cc334c0e.1517840877.git.berto@igalia.com>
In-Reply-To: <1fd7d272b5e7b66254a090b74cf2bed1cc334c0e.1517840877.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-05 15:33, Alberto Garcia wrote:
> The qcow2_truncate() code is mostly independent from whether
> we're using L2 slices or full L2 tables, but in full and
> falloc preallocation modes new L2 tables are allocated using
> qcow2_alloc_cluster_link_l2().  Therefore the code needs to be
> modified to ensure that all nb_clusters that are processed in each
> call can be allocated with just one L2 slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--eGRqCAxqAAJJ0ZOl4iclmn2IR09SJUY98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp4fH8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKJwH/2qxMBPlGjmcrRh8iHnClrB3oxCOeSC0
2dMRCrnGI/SB4C+h+ZD5tQHscLN4VR+OCh2n/GXZcSYyrP9HbeSSzHyCUdlimNN5
dDgjtSiKHRuFsK7VBhzMRXbJNsG5OuIGk/aTKRcYAPDFHI25QGJxg5Uvn+nWwuUc
mSuBNusNYyvECrtQCcWPc3Y0EwNqR3+qywdETQXGHO8aWh+RKEbaKQsfWrx3H6NI
klONWSIqls34nTuFmHqGpZNycB5V+jzZAXePW1PnNYayBG9wyl2tnTARH358a9rN
YQQXKRP2kthDAJznCCipHNyIC1dG6bFoqaH0OCmenasqrjPWInRBlR4=
=2m1s
-----END PGP SIGNATURE-----

--eGRqCAxqAAJJ0ZOl4iclmn2IR09SJUY98--

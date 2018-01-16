Received: from eggs.gnu.org ([2001:4830:134:3::10]:33580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ7t-0007Qt-6N
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ7s-00038e-FY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:50:37 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<4007dce42901324c3d129917d555d3fec4fb82a2.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62b53b4b-ca45-a1b6-5c7e-66c18f99f58c@redhat.com>
Date: Tue, 16 Jan 2018 15:50:28 -0600
MIME-Version: 1.0
In-Reply-To: <4007dce42901324c3d129917d555d3fec4fb82a2.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8d1G7UxwsGCO0o3iwxuziztqOQFGts5wl"
Subject: Re: [Qemu-devel] [PATCH v2 11/32] qcow2: Remove BDS parameter from
 qcow2_cache_is_table_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8d1G7UxwsGCO0o3iwxuziztqOQFGts5wl
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <62b53b4b-ca45-a1b6-5c7e-66c18f99f58c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 11/32] qcow2: Remove BDS parameter from
 qcow2_cache_is_table_offset()
References: <cover.1513342045.git.berto@igalia.com>
 <4007dce42901324c3d129917d555d3fec4fb82a2.1513342045.git.berto@igalia.com>
In-Reply-To: <4007dce42901324c3d129917d555d3fec4fb82a2.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_get_table_addr(). This is no longer necessary so this
> parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c    | 3 +--
>  block/qcow2-refcount.c | 6 +++---
>  block/qcow2.h          | 3 +--
>  3 files changed, 5 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8d1G7UxwsGCO0o3iwxuziztqOQFGts5wl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpec6QACgkQp6FrSiUn
Q2pDgwf/divVEW5p2cTu4Q+DrJeg1BaI67yd4d1xdGXpGW6pWzfCOV1ttTMCOrLI
xuxyTwjIX3KW7FrDFoGrOz2mR/ETC+RdOrI8ROm1n6KD7FePxiHITNxDlwX7Omxn
16AGE/6Pr2puq3fve5DMgMPK4Gy3udn7Wsltt5SGBMe5onfo5QMFn4RQGv7rkC5f
aSbLdedQ6PekXgyIEVlkd0ISh9+aMQPX0KDX6VrkxYgfxPZG+zeZ15yGIE22yznM
U+QB5so294q1pxqS0RtGrx/77sd/XY27L/g+ZXrwjLK/zkUL9n2Ht8Hs18WU37cA
SZPBTedfpdXAGnE6sncG7hy7/0so9A==
=JZLO
-----END PGP SIGNATURE-----

--8d1G7UxwsGCO0o3iwxuziztqOQFGts5wl--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuz1N-0005JY-4q
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuz1M-0003HJ-E8
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:52:25 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<2827c309182950530885b95f0582677b8d99d347.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d3e89744-c88b-a284-87b0-b5c91ee52a2d@redhat.com>
Date: Wed, 29 Aug 2018 13:52:15 +0200
MIME-Version: 1.0
In-Reply-To: <2827c309182950530885b95f0582677b8d99d347.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q2Rfcoii74fHsWI98hjq5JJkLWi4Kr8vq"
Subject: Re: [Qemu-devel] [PATCH 8/9] block: Allow changing 'detect-zeroes'
 on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q2Rfcoii74fHsWI98hjq5JJkLWi4Kr8vq
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <d3e89744-c88b-a284-87b0-b5c91ee52a2d@redhat.com>
Subject: Re: [PATCH 8/9] block: Allow changing 'detect-zeroes' on reopen
References: <cover.1535291602.git.berto@igalia.com>
 <2827c309182950530885b95f0582677b8d99d347.1535291602.git.berto@igalia.com>
In-Reply-To: <2827c309182950530885b95f0582677b8d99d347.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> 'detect-zeroes' is one of the basic BlockdevOptions available for all
> drivers, but it's silently ignored by bdrv_reopen_prepare/commit(), so
> the user cannot change it and doesn't get an error explaining that it
> can't be changed.
>=20
> This should update the detect-zeroes setting, but does nothing:
>=20
>    (qemu) qemu-io virtio0 "reopen -o detect-zeroes=3Don"
>=20
> This should return an error but also does nothing:
>=20
>    (qemu) qemu-io virtio0 "reopen -o discard=3Doff,detect-zeroes=3Dunma=
p"
>=20
> Since there's no reason why we shouldn't allow changing it and the
> implementation is simple let's just do it.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c               | 63 +++++++++++++++++++++++++++++++------------=
--------
>  include/block/block.h |  1 +
>  2 files changed, 40 insertions(+), 24 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--q2Rfcoii74fHsWI98hjq5JJkLWi4Kr8vq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGiO8ACgkQ9AfbAGHV
z0D+8wf+N226mfM7ldNWTYl9uNgQ3kOlc+bk/0PQJTyY5/rFg0DickY6D6QCVnEI
WLMNXhKQuFhkXTcexTeC+wzu1LR/mLb7mhGJSsdA0JgVdHQe7xbhRijvYonXCYm1
5hDV5F7nvesSZ+DoP1XgYYg0pSKicgUn7tN6pE128/gqlm6zkJei56p/teL/IKyH
dwtZyWfLWQDlFWHChBrVcOGJRmK8/OhYXIVnCmCCqzFXBH/U0QuglVc2W66zntFb
P0TteuQ55ztuQXXeALsmpI6B9WR2/hIUyrbh4POeG8/+/SZcb/ao4FA1Ds7wV7eE
jM9ZMI0tCUWV9yAbjVBz/yIIzsrMLA==
=cvhk
-----END PGP SIGNATURE-----

--q2Rfcoii74fHsWI98hjq5JJkLWi4Kr8vq--

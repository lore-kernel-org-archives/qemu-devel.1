Received: from eggs.gnu.org ([2001:4830:134:3::10]:60764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clhpv-0008JH-6a
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 15:05:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clhpu-0000XO-3h
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 15:05:27 -0500
References: <20170308200216.5931-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c25bd323-1324-511b-57c0-d417312b6252@redhat.com>
Date: Wed, 8 Mar 2017 21:05:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170308200216.5931-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TW7nafLPvHiO08XNW3CT1LtHMx45nlIUW"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Drop unmaintained
 'archipelago' driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: chris@include.gr, jcody@redhat.com, qemu-block@nongnu.org, kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TW7nafLPvHiO08XNW3CT1LtHMx45nlIUW
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: chris@include.gr, jcody@redhat.com, qemu-block@nongnu.org,
 kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <c25bd323-1324-511b-57c0-d417312b6252@redhat.com>
Subject: Re: [PATCH for-2.9] block: Drop unmaintained 'archipelago' driver
References: <20170308200216.5931-1-eblake@redhat.com>
In-Reply-To: <20170308200216.5931-1-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 08.03.2017 21:02, Eric Blake wrote:
> The driver has failed to build since commit da34e65, in qemu 2.6,
> due to a missing include of qapi/error.h for error_setg().
> Since no one has complained in three releases, it is easier to
> remove the dead code than to keep it around, especially since it
> is not being built by default and therefore prone to bitrot.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> My proposed alternative for Max's "block/archipelago: Make it compile"
>=20
>  qapi/block-core.json             |   33 +-
>  block/archipelago.c              | 1079 ------------------------------=
--------
>  MAINTAINERS                      |    8 -
>  block/Makefile.objs              |    2 -
>  configure                        |   43 --
>  tests/qemu-iotests/025           |    2 +-
>  tests/qemu-iotests/common        |    6 -
>  tests/qemu-iotests/common.filter |    4 +-
>  tests/qemu-iotests/common.rc     |    8 -
>  9 files changed, 4 insertions(+), 1181 deletions(-)
>  delete mode 100644 block/archipelago.c

Reviewed-by: Max Reitz <mreitz@redhat.com>

But I'd like someone to confirm that I'm not the only one who can't
compile archipelago. ;-)

Max


--TW7nafLPvHiO08XNW3CT1LtHMx45nlIUW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljAY/oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJlcH8wcSmO/hbvRF12oEV0Bry2Kkw/YB9IfF
u1KQQbuO140Qm1ym5Oy7DsICVbpYD2j6SsKb9CZcSh7TTtJR0GRgzsakqlajvFGf
cl2k5D8Aimoj3WCSdcOsCywUVB6P2Vgauym0Rz1I+Q/4RRHriU9yqDj1swVB1oN3
cRGoaGv+VKHxzrMbkkvtiKyDwm7+y+VtbERsImPZjYnyk5Z2Wo0ZRhB07sG2XU3r
Ngc2uxXJBC1ql4HB6fKoEWbVpSnSeJguOt/yZZSWusG9i5Spdob96SzkM7qwu2xn
ypHOyUVIT1hYxAruv3KsRJgoO5843ztB9vc2e2lj7z4g0DYnuLOB6A==
=NPWb
-----END PGP SIGNATURE-----

--TW7nafLPvHiO08XNW3CT1LtHMx45nlIUW--

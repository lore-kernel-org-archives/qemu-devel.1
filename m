Received: from eggs.gnu.org ([2001:4830:134:3::10]:45881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNGGN-0005yF-EG
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNGGM-0008Bz-NX
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:52:15 -0500
Date: Fri, 8 Dec 2017 10:52:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171208105205.GG23880@stefanha-x1.localdomain>
References: <20171206105309.3468-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <20171206105309.3468-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] block: Fix BlockDriver callbacks in
 bdrv_drain_all_begin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 11:53:03AM +0100, Kevin Wolf wrote:
> I was looking into the drain functions in order to develop them a bit in
> the direction that Fam suggested, to unify the code between bdrv_drain()
> and bdrv_drain_all() a bit more, and maybe to find a place to take
> coroutine locks for graph changes.
>=20
> The first thing I found is a bug in bdrv_drain_all(), so I'm already
> sending this part before I have made much progress with my actual plan.
>=20
> v2:
> - Added patches 5 and 6 [Paolo]
> - Fixed commit message of patch 1 [Eric]
>=20
> Kevin Wolf (6):
>   block: Make bdrv_drain_invoke() recursive
>   block: Call .drain_begin only once in bdrv_drain_all_begin()
>   test-bdrv-drain: Test BlockDriver callbacks for drain
>   block: bdrv_drain_recurse(): Remove unused begin parameter
>   block: Don't wait for requests in bdrv_drain*_end()
>   block: Unify order in drain functions
>=20
>  block/io.c              |  31 +++++++----
>  tests/test-bdrv-drain.c | 137 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/Makefile.include  |   2 +
>  3 files changed, 159 insertions(+), 11 deletions(-)
>  create mode 100644 tests/test-bdrv-drain.c
>=20
> --=20
> 2.13.6
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKm7VAAoJEJykq7OBq3PIHX0H/2dSQo/F10S7rJLUnujzAGyw
E3Ad+r9p/OzsTUNyefikwCWHbokBr3mHiK37tf+gwP+vPC4CgeyMxf972GL1NMRC
U4XoskaK+gcqNWcWBNh9xll75NPGasb3Hi5dZFSLk7gOJeXzx9fPHft4m3SNCjgk
MYMuaDVCWwkks/OPOhP7u2Kb87lQAdBQ1oecFDRUKPZtRbIVKt42JfKPfs69eE6p
JQSSjips6ia9kREOIy7YgdDSEBWG++OekZ9oM38tCcwZbltcWG4E6cDtg8vVQcnJ
R/tyD4m58FP8/HqavHJcywno6BqsaDaKJNHd724szzF4Pmc7HN6akL/WXE/WsII=
=Lq2H
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--

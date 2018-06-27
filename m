Received: from eggs.gnu.org ([2001:4830:134:3::10]:42259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY7gH-0008W6-GG
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY7gG-0001PI-PR
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:28:09 -0400
Date: Wed, 27 Jun 2018 11:27:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627102759.GC5955@stefanha-x1.localdomain>
References: <20180627035752.1425-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20180627035752.1425-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Two copy offloading corrections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 11:57:50AM +0800, Fam Zheng wrote:
>=20
>=20
> Fam Zheng (2):
>   qcow2: Remove dead check on !ret
>   block: Move request tracking to children in copy offloading
>=20
>  block/io.c    | 59 ++++++++++++++++++++++++---------------------------
>  block/qcow2.c |  2 +-
>  2 files changed, 29 insertions(+), 32 deletions(-)
>=20
> --=20
> 2.17.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM2avAAoJEJykq7OBq3PI8wkIALoR70HqdsAy4/JkeOp9aB3x
e30v+W+UyTVUGYu4QDiftjp+W4vf9X23h5qlIC2/7wMaqFDTGxRuDIqrr47BLZ9V
S4Dh+vJk0iNuGz9MqAL8/wN6WO+YG7OhbOYjQ2e1Rc/VXAx9LcHMFZXTSaRASwh3
sTv04JuGJ9kVBOjqoGQMmJPYUHr2xkMMZaGn7SrFwkLtzHBWdbo42rq8sE261b4i
8JyBEWV/rCTmUm2NclDlOxC/4i4n1+YHJa1abrQFcWS2+2KO5OoW3n9tRoEqzTN1
f0MO5hntZAONHvRaoRYCNNlU8P7/KYXTa22myfp70RdYii47gs6W3hdC0nonZXA=
=Wo3K
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

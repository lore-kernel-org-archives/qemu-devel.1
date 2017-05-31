Received: from eggs.gnu.org ([2001:4830:134:3::10]:54381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0zP-0005Ok-PE
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0zO-0002Kr-Uy
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:36:31 -0400
Date: Wed, 31 May 2017 11:36:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531103621.GH15666@stefanha-x1.localdomain>
References: <20170526165518.7580-1-mreitz@redhat.com>
	<20170526165518.7580-13-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Content-Disposition: inline
In-Reply-To: <20170526165518.7580-13-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 12/16] block/qcow2: Add
 qcow2_refcount_area()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 06:55:14PM +0200, Max Reitz wrote:
> This function creates a collection of self-describing refcount
> structures (including a new refcount table) at the end of a qcow2 image
> file. Optionally, these structures can also describe a number of
> additional clusters beyond themselves; this will be important for
> preallocated truncation, which will place the data clusters and L2
> tables there.
>=20
> For now, we can use this function to replace the part of
> alloc_refcount_block() that grows the refcount table (from which it is
> actually derived).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.h              |   4 +
>  block/qcow2-refcount.c     | 267 +++++++++++++++++++++++++++++++--------=
------
>  block/qcow2.c              |  20 +++-
>  tests/qemu-iotests/044.out |   2 +-
>  4 files changed, 204 insertions(+), 89 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLpylAAoJEJykq7OBq3PI3AAH/jzt8Pm7AoZByWoJFoeo+wzO
EKC3ykpI4QrrkbjquNxBM0QSVwbKI2JCWUMp1RPWSD7H4qV1xnW0EFm+abcaSMpS
Qkk6/34D7BTcyhrBdsux/lhrpBG3C/LhzwDZ0t48FUjZ3H+V9R+qvXwdEIR/e3a9
lFgjEX5TAK2L86eVFrJAQ9FwksCgHF8OkEr6lNJv09PcOg/5KSV9AciCYwIwg7Jq
HMbJvcgXhYK8JWe6pO1RPwSGMa2/BwJy6MwSGNi9J2H8vXCluxgkT0R/1n92eLEC
r01OBNpzA9ckfxg0WUbxWNj3jRqOCXppmJGGEB4Dxh3AVamX9xFgXvXbTKuExBc=
=hbdI
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--

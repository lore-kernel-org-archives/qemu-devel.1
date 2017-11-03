Received: from eggs.gnu.org ([2001:4830:134:3::10]:51154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAZdL-0005qV-VA
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eAZdL-00024U-6p
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:55:32 -0400
Date: Fri, 3 Nov 2017 10:55:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171103105522.GL5078@stefanha-x1.localdomain>
References: <cover.1509368614.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UUBKWyapWpFAak7q"
Content-Disposition: inline
In-Reply-To: <cover.1509368614.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/3] Don't write headers if
 BDS is INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org


--UUBKWyapWpFAak7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2017 at 02:10:25PM +0100, Jeff Cody wrote:
>=20
> Changes from v1->v2:
>=20
> * Drop previous parallels patches, just check BDRV_O_INACTIVE now
>   (Kevin)
>=20
> git-backport-diff -r qemu/master.. -u github/master
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/3:[----] [--] 'block/vhdx.c: Don't blindly update the header'
> 002/3:[down] 'block/parallals: Do not update header or truncate image whe=
n INMIGRATE'

parallals?!  What happened here?  :)

> 003/3:[----] [--] 'qemu-iotests: update unsupported image formats in 194'
>=20
>=20
> v1:
>=20
> VHDX and Parallels both blindly write headers to the image file
> if the images are opened R/W.  This causes an assert if the QEMU run
> state is INMIGRATE.
>=20
> Jeff Cody (3):
>   block/vhdx.c: Don't blindly update the header
>   block/parallals: Do not update header or truncate image when INMIGRATE
>   qemu-iotests: update unsupported image formats in 194
>=20
>  block/parallels.c      | 7 ++-----
>  block/vhdx.c           | 7 -------
>  tests/qemu-iotests/194 | 2 +-
>  3 files changed, 3 insertions(+), 13 deletions(-)
>=20
> --=20
> 2.13.6
>=20
>=20

--UUBKWyapWpFAak7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZ/EsaAAoJEJykq7OBq3PImmkH/AoSj1iM5VB+KzOfCFAmubn7
I53sQol/XiUjwpQlKJSc+IbALZZ7FbtGoNoAPoxI5Ycrlm1XtdzTWf0yyJSgYfvt
Y8O60EHdtPyT4Z4Qm7groTe6ZUnm/ODrjbq6KZIXq8M2yY33bx7J2aQDQ9TB87oe
Y+TF4HWYoAzcr5nPSJ9NRqzfDj1KOIDvTZWkiPVnIt2EsTgvuKvtpps7SiPwGsrN
qq/IK6k/a7iAXjd+BAdK4U7sHcUnfOHNsVIOfI1WWMz6oJGO+sZmcDUPJtEWZVmU
xxoAWBj5tqUQD3v8Os2mFUgnpf2Uwz1oY8UkG6xqPR8+FNor1hxcHAVNID+Tcuw=
=DGLa
-----END PGP SIGNATURE-----

--UUBKWyapWpFAak7q--

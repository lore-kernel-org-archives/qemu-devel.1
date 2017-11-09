Received: from eggs.gnu.org ([2001:4830:134:3::10]:41230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCkp7-0005Kz-4J
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCkp6-0008C4-2E
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:16:41 -0500
Date: Thu, 9 Nov 2017 11:16:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171109111632.GB17101@stefanha-x1.localdomain>
References: <cover.1510059970.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <cover.1510059970.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 0/4] Don't write headers if
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


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 08:10:32AM -0500, Jeff Cody wrote:
> Changes from v3->v4:
>=20
> Patch 3: Add migrate_del_blocker and error_free (Thanks Stefan)
>=20
>=20
> git-backport-diff -r qemu/master.. -u ba11b69
>=20
> 001/4:[----] [--] 'block/vhdx.c: Don't blindly update the header'
> 002/4:[----] [--] 'block/parallels: Do not update header or truncate imag=
e when INMIGRATE'
> 003/4:[0003] [FC] 'block/parallels: add migration blocker'
> 004/4:[----] [--] 'qemu-iotests: update unsupported image formats in 194'
>=20
>=20
> Changes from v2->v3:
>=20
> Patch 2: Uh... fix that misspelling.  Thanks Stefan :)
> Patch 3: New patch to block migration in parallels
>=20
> git-backport-diff -r qemu/master.. -u 6dc6acb
>=20
> 001/4:[----] [--] 'block/vhdx.c: Don't blindly update the header'
> 002/4:[----] [--] 'block/parallels: Do not update header or truncate imag=
e when INMIGRATE'
> 003/4:[down] 'block/parallels: add migration blocker'
> 004/4:[----] [--] 'qemu-iotests: update unsupported image formats in 194'
>=20
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
> 003/3:[----] [--] 'qemu-iotests: update unsupported image formats in 194'
>=20
>=20
> v1:
>=20
> VHDX and Parallels both blindly write headers to the image file
> if the images are opened R/W.  This causes an assert if the QEMU run
> state is INMIGRATE.
>=20
> Jeff Cody (4):
>   block/vhdx.c: Don't blindly update the header
>   block/parallels: Do not update header or truncate image when INMIGRATE
>   block/parallels: add migration blocker
>   qemu-iotests: update unsupported image formats in 194
>=20
>  block/parallels.c      | 22 +++++++++++++++++-----
>  block/vhdx.c           |  7 -------
>  tests/qemu-iotests/194 |  2 +-
>  3 files changed, 18 insertions(+), 13 deletions(-)
>=20
> --=20
> 2.9.5
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBDkQAAoJEJykq7OBq3PIpLIIAI6ui9Qx8aYPEBjTIQcOpGrW
K/6oiWNofFb3tqAVJEvTVZGDS4NTE+wbaZkpR8mbkBiTaJhF9M96Nqybl4fiNcDr
fRYm4itcVy+eyjDRhq5hJiYxnh/0iihTsmV6uaOs3I9eFQ/6i5ow3IIKDFZ4OfV1
f0jA655WKeF9pUIOVQlxqlEcWpSa5vaYJe8us+bSs2islZz4iAKemFTpGW9BTMfM
EhMTeoPE/bE3RIIJxg/D0UjBAkf0aOnoLbZsEzGUje37vngykuQnosqZyNLEhpkK
qgEtzp+JCmsAy1xm0+pqOHwU44ZbhZaj6rj2APV/gnI1GnCsRs6WpMnMTgMZ9NE=
=Shdv
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

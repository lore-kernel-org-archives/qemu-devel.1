Received: from eggs.gnu.org ([2001:4830:134:3::10]:37797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6bN-0000vp-8S
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6bM-0007Yp-Cq
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:33:25 -0400
Date: Thu, 6 Apr 2017 13:33:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406123315.GH21895@stefanha-x1.localdomain>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-8-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline
In-Reply-To: <20170403160936.28293-8-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 for-2.10 07/16]
 block/file-posix: Generalize raw_regular_truncate
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


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 06:09:27PM +0200, Max Reitz wrote:
> Currently, raw_regular_truncate() is intended for setting the size of a
> newly created file. However, we also want to use it for truncating an
> existing file in which case only the newly added space (when growing)
> should be preallocated.
>=20
> This also means that if resizing failed, we should try to restore the
> original file size. This is important when using preallocation.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 61 ++++++++++++++++++++++++++++++++++++++++++++----=
------
>  1 file changed, 50 insertions(+), 11 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5jWLAAoJEJykq7OBq3PIB/cH/iOfs905vnosdC7kMfNUKMaT
E3cefOYyEa0Sf0ClMd24VPdxjMPk49k8MLfh8u7Fh5qTegHRaUfSGLnBzHHgRrgf
okRNZj2+cBLGm17QH3tzvKAeEh9/jPgbRNuPUV9sPfO+2udflPMI7Ww57gI3yvH1
qBqIZ/Fpxn3PeuUrQXKOI9ntToQBhlvwwTUglqymCT+KZ7EalcF1le4dBqrgt7X9
JEyoWqubsKSMRLRN+Y/jifSmYCN+kD5YiO8n+OyKAkejf2kBQ+ytCnln1dXtsgAo
XmPfT5vMrKzUTPsDxKG92TES4XgiQqykzzHvhfSlYsIJ9wA9b7EDpOFZHOsihdc=
=em0f
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--

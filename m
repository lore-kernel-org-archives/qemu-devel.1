Received: from eggs.gnu.org ([2001:4830:134:3::10]:44251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciL8B-0003b4-18
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:14:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciL89-0000tz-Sk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:14:23 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciL89-0000tn-Mm
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:14:21 -0500
Received: by mail-wm0-x244.google.com with SMTP id r18so13399457wmd.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:14:21 -0800 (PST)
Date: Mon, 27 Feb 2017 13:14:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227131417.GM28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814898026.28146.12256183919348399642.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaap9KN+GmBP785v"
Content-Disposition: inline
In-Reply-To: <148814898026.28146.12256183919348399642.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 11/28] 9pfs: local: unlinkat: don't
 follow symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--yaap9KN+GmBP785v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:43:00PM +0100, Greg Kurz wrote:
> The local_unlinkat() callback is vulnerable to symlink attacks because it
> calls remove() which follows symbolic links in all path elements but the
> rightmost one.
>=20
> This patch converts local_unlinkat() to rely on opendir_nofollow() and
> unlinkat() instead.
>=20
> Most of the code is moved to a separate local_unlinkat_common() helper
> which will be reused in a subsequent patch to fix the same issue in
> local_remove().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2: - use openat_dir()
> ---
>  hw/9pfs/9p-local.c |   99 +++++++++++++++++++++++++++++-----------------=
------
>  1 file changed, 56 insertions(+), 43 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yaap9KN+GmBP785v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCYpAAoJEJykq7OBq3PIdEkH/Ryws50/fxUHn1dkdLr8S2E4
rVToCs9UuZm9hNpOMzSCSEAJxR/+cOPzL0CuFDaoVcrv26YErsDa6D3iBCDtc+zv
lC86D5i+w18uOTT5j4FsdWZvWJFWuSAlDthBz6IYdm4PZYC26UuD2a+tri5LwshV
Z5+9rh5YS0Lxne+H9wPkEyi9FYEGiK91EcJ3wLHKeierMBH/yVBrXDZMQ5ECAYA2
NEWQDM3IM0Eh5QWnEP5Uh4A+eRE8FyfAC7/PDG6O4VBkHQgNqYQrsQ7FQ2n7w98A
Yk2Y4xrO+pySTkc8YN8tAqh0Akb23wdmtJGLeVakiz/M4FYfEur6Et9tD7bKX0Y=
=tVSt
-----END PGP SIGNATURE-----

--yaap9KN+GmBP785v--

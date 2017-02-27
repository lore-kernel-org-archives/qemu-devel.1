Received: from eggs.gnu.org ([2001:4830:134:3::10]:43596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciL6a-0002Jq-AE
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ciL6Z-0000BN-Dk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:12:44 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ciL6Z-0000B3-8T
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:12:43 -0500
Received: by mail-wr0-x241.google.com with SMTP id g10so10077070wrg.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 05:12:43 -0800 (PST)
Date: Mon, 27 Feb 2017 13:12:40 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170227131240.GL28403@stefanha-x1.localdomain>
References: <148814889214.28146.16915712763478774662.stgit@bahia>
	<148814897182.28146.16499801111559710291.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jtcAeju3WzRmRF+o"
Content-Disposition: inline
In-Reply-To: <148814897182.28146.16499801111559710291.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2 10/28] 9pfs: local: lremovexattr: don't
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


--jtcAeju3WzRmRF+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2017 at 11:42:51PM +0100, Greg Kurz wrote:
> The local_lremovexattr() callback is vulnerable to symlink attacks because
> it calls lremovexattr() which follows symbolic links in all path elements
> but the rightmost one.
>=20
> This patch introduces a helper to emulate the non-existing fremovexattrat=
()
> function: it is implemented with /proc/self/fd which provides a trusted
> path that can be safely passed to lremovexattr().
>=20
> local_lremovexattr() is converted to use this helper and opendir_nofollow=
().
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - introduce /proc based fremovexattrat_nofollow()
>     - fix arguments passed to local_removexattr_nofollow()
> ---
>  hw/9pfs/9p-posix-acl.c  |   10 ++--------
>  hw/9pfs/9p-xattr-user.c |    8 +-------
>  hw/9pfs/9p-xattr.c      |   36 +++++++++++++++++++++++++++++++-----
>  hw/9pfs/9p-xattr.h      |    2 ++
>  4 files changed, 36 insertions(+), 20 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jtcAeju3WzRmRF+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtCXIAAoJEJykq7OBq3PI/mQH/0yaN6oVrky5PecXjWlPb7Kf
Sgmu5WikdKt6UiDupu2nZtVwImYjT6C0JHMxXffH0Q9IFwuljlDJyzrQhQj0AEyL
JvSknvH9kQXQ/4ttawjpisFaNtJwUFYXqYco1JgCCAJ2b+yW4X3sWMHS0kiZf3sl
M83a/FecmN5N7slyR97Uuq0f8y5SthR6Ml+tyDFtfwTT2UnGT9PM0805jJMYJh06
spc/Rwhyna0a2nZJVS25N7MIUw1XU2Y5JLzyOt2swmbQHK5b3Gfh1KKDocKRgtJp
uDvKtDQWGKxaxQ11b1DznVesAWmmGrbl6hTJzPTWZsbOvB16ZQYwuKuDAFU4S1I=
=9O1P
-----END PGP SIGNATURE-----

--jtcAeju3WzRmRF+o--

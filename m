Received: from eggs.gnu.org ([2001:4830:134:3::10]:40221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgulV-0001Mk-TT
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgulQ-0006C6-Vo
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:53:06 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgulQ-0006Bs-Q1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 09:53:00 -0500
Received: by mail-wr0-x242.google.com with SMTP id 89so4187837wrr.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 06:53:00 -0800 (PST)
Date: Thu, 23 Feb 2017 14:52:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223145257.GQ30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760169288.31154.16807785388921473289.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4T94Hejb80K+e1gX"
Content-Disposition: inline
In-Reply-To: <148760169288.31154.16807785388921473289.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 17/29] 9pfs: local: readlink: don't follow
 symlinks
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


--4T94Hejb80K+e1gX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:41:32PM +0100, Greg Kurz wrote:
> The local_readlink() callback is vulnerable to symlink attacks because it
> calls:
>=20
> (1) open(O_NOFOLLOW) which follows symbolic links for all path elements b=
ut
>     the rightmost one
> (2) readlink() which follows symbolic links for all path elements but the
>     rightmost one
>=20
> This patch converts local_readlink() to rely on open_nofollow() to fix (1)
> and opendir_nofollow(), readlinkat() to fix (2).
>=20
> This partly fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--4T94Hejb80K+e1gX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrvdJAAoJEJykq7OBq3PIWBoIALorrhdDjPTaliYFW5Eopy75
C+GCeo9rqWHhiNhYIG3CIyqqB+nM59cy/mwgZXt6ImpnEWMRsZac8uIs9e8cwJfd
ZNpihU1M4JUWBGlhdUwrwX9DnBYAcOfVEsaUM/m0+xs0o6x8G6h94c48c83ZsvNh
ejz+D4PIdfv4NZDIO4TT8Fn9tnvMwZqNOReQ0+X8CMa5m/L5BgHR7YYsJz5F0HHj
9mBjG0O0y/n8H9aTU+4ypYt0YGCjB2aXGRkt8O9Dz44LSVljoznYYoJ6XtjHa0AC
pZrCVvd3ZDt7wy49jNXI6epmajh+VPkzDYf7bsvjYi7f+6aNK4aGlP3sYvq6mGY=
=5S8/
-----END PGP SIGNATURE-----

--4T94Hejb80K+e1gX--

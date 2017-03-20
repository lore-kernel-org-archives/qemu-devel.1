Received: from eggs.gnu.org ([2001:4830:134:3::10]:37288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpusL-0002hl-W0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpusL-00008i-98
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:49:22 -0400
Date: Mon, 20 Mar 2017 10:49:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320104914.GG17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline
In-Reply-To: <20170313214045.26857-4-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 06/16]
 block/file-posix: Extract raw_regular_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:40:35PM +0100, Max Reitz wrote:
> This functionality is part of raw_create() which we will be able to
> reuse nicely in raw_truncate().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 144 +++++++++++++++++++++++++++++------------------=
------
>  1 file changed, 78 insertions(+), 66 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7OqAAoJEJykq7OBq3PI+ucH/1yU/B5ohtokLaXqdFCYGlyz
JS2e8OSQyL8T4CKPz8ko/c2J918YnvMQdOVKMwc8CVGPVze5p/OPe3BmOmgxMq+b
KnulWWM2JqxbARzGfaSjdmCnxtgtXNsyISg87iDt6dCN1SweIiu/3Xhlfl+fkIZ8
T/G2F6RJrF+YWrELD2Ph7Y8neGcMX2/H5ZXZ/vqTPCAFG2nZntCAigV9Z88K17bW
Hy+O3sVLA/U7XeR4fOo/tvCnPYuGyaq2HimYzpnR7T4o65nyu2p6g6hAspzMdfnb
ObeupgZMaQrIQuXvmGoOvKLXzjTdX5QSdMozozdMheXDVHtSUj+ua4dY1o+KVl8=
=Sxc3
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--

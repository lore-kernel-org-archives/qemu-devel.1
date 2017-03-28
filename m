Received: from eggs.gnu.org ([2001:4830:134:3::10]:60279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cso2H-0004It-Uo
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cso2D-0003Ei-RM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:07:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cso2D-0003Dw-Kj
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:07:29 -0400
Date: Tue, 28 Mar 2017 11:07:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170328100727.GF26523@stefanha-x1.localdomain>
References: <1490625488-7980-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline
In-Reply-To: <1490625488-7980-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] parallels: wrong call to bdrv_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 05:38:08PM +0300, Denis V. Lunev wrote:
> Parallels driver should not call bdrv_truncate if the image was opened
> in the read-only mode. Without the patch
>     qemu-img check harddisk.hds
> asserts with
>     bdrv_truncate: Assertion `child->perm & BLK_PERM_RESIZE' failed.
>=20
> Parameters used on the write path are not needed if the image is opened
> in the read-only mode.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reported-by: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/parallels.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2jXfAAoJEJykq7OBq3PIUkgIAJ5TKCfBES6es3iDsJ4iurSN
Hj3gfIXElHNn6ROS30YcAB7aEGhq6Hb8QqPZS3FyBZtM+ihREpYRbKgp10n7/6Nv
4Wp6E1GcuIrRJ+ifu4hFZhLCDPWkNmYYEz8kOunAp4lmM/5BaeBadvu6uktz14Pc
y6VNsCgRyCKjU1hRFnlFhcmBxhps0jvtp+jEk/m2tfQndM4oW9dTVyJbYMCNWwkb
NJwDBX3Yp3kKM2lvfI16yasbTzu/C6T4iQKTx2LEvL+s5pVfVi9ERkjnqWh1MbDF
bG+DkxYk7kZ9eBezpLrVekOgh63mg4Nt2kHu5YAB7TG1zAE8l6LPzKeLbZbjQms=
=f2VA
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--

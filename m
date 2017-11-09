Received: from eggs.gnu.org ([2001:4830:134:3::10]:42549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCkx5-00077s-54
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCkx0-0003DT-8t
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 06:24:55 -0500
Date: Thu, 9 Nov 2017 11:24:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171109112435.GD17101@stefanha-x1.localdomain>
References: <20171106165500.30278-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <20171106165500.30278-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Fix error path in
 bdrv_backing_update_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2017 at 05:55:00PM +0100, Kevin Wolf wrote:
> error_setg_errno() takes a positive errno code.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJaBDrzAAoJEJykq7OBq3PIebMH9iBXIrv9KFhlILZj6g2+HFVq
OFaO0rzPnSNGmvwWqpDqz45O07u5lpfWm/tJIqadYSfgmhsGeIu+a/fLpeVYuZYW
Abul0A7BRm0vhKD4Wq7CaqOrdX6mtazA77qoDN+cdqaj7aMWQsN7TRXh2/kXVmky
FzyYeF9yf7Jy9p0g82qn95E/vLv+JapFSM8LccgZxt6RcQ0g+t6Uu0RFgLHluz13
Vy9R/YtJtfA2A4AEw2EHFLJH+WyI1cy3Uoyu8SMp23c95mwmPJEj8ktQ24uopQNb
OVnVpDQ1/Dby9i0Qi73xHYLex9PxMQkEcfvy82wBVBvHLx4eelb3Mm/Vns0H7A==
=u308
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--

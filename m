Received: from eggs.gnu.org ([2001:4830:134:3::10]:44447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrV7-0003Ow-W9
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrV7-0007Mu-A8
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:30:38 -0400
Date: Tue, 11 Jul 2017 10:30:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711093029.GG17792@stefanha-x1.localdomain>
References: <1499687125-22948-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline
In-Reply-To: <1499687125-22948-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] commit: Add NULL check for
 overlay_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 01:45:25PM +0200, Kevin Wolf wrote:
> I can't see how overlay_bs could become NULL with the current code, but
> other code in this function already checks it and we can make Coverity
> happy with this check, so let's add it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZJq1AAoJEJykq7OBq3PIuSoIAKFbFBqTRzR+N3ddVHMCe6yP
2mytuL0dUUTS3RCMGZvzf0ggX0o35T90LbWpJY2TbZa8zyQ6J+EKhGW2BaLpyiVs
l7Qk8NUgGGMu7tck7UOvgDOVWjD8FASp0ZyHbgcsMmUVI4m3PoosedCmZ52pmUE0
J8j2jrVjzCCmRvnW46ToIqkZTmOoxCv8Jo+kmYwPxwIqMohQmd5uuwZyziZcCa2d
yH/H7qyLd2vdqX3OYC1EraRbI9EgOPlDGtlAMQTJ93Jgl5xb/iWWZjlpCIoWZOyX
mySTN0Xj7exHx9FcQlN4cHQ3wbcq9jxV3EFAoXgLS3zayUsXb5mAvhBRIN9lDA4=
=Y72m
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--

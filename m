Received: from eggs.gnu.org ([2001:4830:134:3::10]:53165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2iB-0000u3-VM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2iA-00076U-QM
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:26:51 -0400
Date: Wed, 31 May 2017 13:26:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531122640.GH16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-8-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-8-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 07/29] qed: Make
 qed_copy_from_backing_file() synchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:48PM +0200, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 78 +++++++++++++++++++++++--------------------------------=
------
>  1 file changed, 29 insertions(+), 49 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLraAAAoJEJykq7OBq3PIeKoH/3SISDs3A3qNXYqCK3mh+2tn
HgJSkrM3wnbVU5TOPNlbnxBiRciWlJfjx/6tsSq3d1ghPWpN3pOsT3XuygunW6j5
Hwvu3AewhtYawOiwYF8ROu4OJ3/JGyB+uudZ6a3nyhkGFRLN4k2W1I4iXow9bY/D
BA5IAzBUDuBBGikknb6P9+7C7IhExVaADrbgZRB5FVWPRES2/9swlaOD9XKXVkXx
IjIlPMAK6C7mFVPfJmfMYinkRr1GopRq4fwgoZXCEJWYxjaO27veHGeXCvmEmY4E
TkQK44ogYKui5dWGYol4kczYydCtGMnLXtUL1tL8mVdz3kyniT1vl4fJVvBRGmg=
=8PEh
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--

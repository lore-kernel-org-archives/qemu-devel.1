Received: from eggs.gnu.org ([2001:4830:134:3::10]:49350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2Yl-0003b3-W2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2Yg-0003KY-Vb
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:17:07 -0400
Date: Wed, 31 May 2017 13:16:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531121648.GB16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-3-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-3-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/29] qed: Make
 qed_read_table() synchronous
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


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:43PM +0200, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed-table.c | 56 ++++++++++++++++++-------------------------------=
------
>  1 file changed, 18 insertions(+), 38 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrQwAAoJEJykq7OBq3PIBNkH/3hT+m3BLkQtIphHt4FRDdbZ
u10Z21vR0geIq+zHjPfVA7t8GGEY+tLSkFcfYk7enfZ+YmG70YeMn2uKXEdZIEXm
v9Ql930q8MajPloFGYaHv28ECKSeXloGNUAXfWhjCOjXNFyGo07YNW9BiAJnWRpC
SE7pHoQJnJJUfYK5YmgCDDO503KUYiTfJmI0qTwmKh7ND45GgsgjCDs+eyl+3jV/
KJrG9xpJQiPM1nQ7Fx5XrMu6Ff9r/lv3aGckJv9op7aGOP3q+zCcN2jVldvynpR3
kg4ZA1Q1zQbiBX8T2gmJvE3vMYSzW4Rvlsc6eBV5KJz0j+DDaL1F3HwBKkDFvCY=
=seIu
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--

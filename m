Received: from eggs.gnu.org ([2001:4830:134:3::10]:56446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2qN-0005Mr-Mx
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2qN-0001ti-0R
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:35:19 -0400
Date: Wed, 31 May 2017 13:35:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531123510.GL16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-12-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9sQuz+HmDh2hVO4"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-12-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 11/29] qed: Make
 qed_write_table() synchronous
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


--z9sQuz+HmDh2hVO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:52PM +0200, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed-table.c | 84 ++++++++++++++++++++-----------------------------=
------
>  1 file changed, 30 insertions(+), 54 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--z9sQuz+HmDh2hVO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrh+AAoJEJykq7OBq3PI6JMH/1WoAFvnjtf+jLC9N6OTTEGJ
pNKixM5y7X6Bf28PbZCRlgCcwdR/TiIhs5mCRkyVf+CZH8oPaYSH/iMRbbrfyLBX
jkA4fZL+zn0CcsmBN79ljavc+wYV98IosqHj9AaFGU8sKcExzREa+mtgq05TARKR
ZZKnjp5m55qWyHaZtV6LpSv+OaBr3DAjR1iO8BYXB1UXiHojZFTSXx+Y7/qWS8NE
qYAeKDUIhHp9sjFsFaGUb0erBYK8SRWOEwy4LkNTY2zUmQqsInIgysZ7v+xXRVtE
CqusirvqKLLrWVVM0oV3iPjSOtzdkkIVlHjYKmkaWWRml/EDhWtq3EZ9MC+lvVE=
=iILX
-----END PGP SIGNATURE-----

--z9sQuz+HmDh2hVO4--

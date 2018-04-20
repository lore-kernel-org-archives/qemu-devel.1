Received: from eggs.gnu.org ([2001:4830:134:3::10]:48615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Q9O-0004Mm-9j
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Q9N-0007rd-EO
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:08:06 -0400
Date: Fri, 20 Apr 2018 15:07:54 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420070754.GA15181@stefanha-x1.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20180411163940.2523-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/19] block: Use
 bdrv_do_drain_begin/end in bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 06:39:23PM +0200, Kevin Wolf wrote:
> bdrv_do_drain_begin/end() implement already everything that
> bdrv_drain_all_begin/end() need and currently still do manually: Disable
> external events, call parent drain callbacks, call block driver
> callbacks.
>=20
> It also does two more things:
>=20
> The first is incrementing bs->quiesce_counter. bdrv_drain_all() already
> stood out in the test case by behaving different from the other drain
> variants. Adding this is not only safe, but in fact a bug fix.
>=20
> The second is calling bdrv_drain_recurse(). We already do that later in
> the same function in a loop, so basically doing an early first iteration
> doesn't hurt.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c              | 10 ++--------
>  tests/test-bdrv-drain.c | 14 ++++----------
>  2 files changed, 6 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2ZHKAAoJEJykq7OBq3PIn8QH/iWsL4rDKAXhAr5+4Msvt9ht
twOp0SAUHfKPYRwjUjfMCkFYeZS8mbihHd8ouFmgxJkvL9mWj/vZxg9RFrGRll8X
/NvTSTLMP10ujYtl9l3Wxiv2vf5gQD/K+C+7E5KEopg0l+TgxvtBagC7S+YuEFdu
XBgpDYB86azHTrLp8NxA6k5zXPSXsgDmQUqPOyBdisnm4inTiDyn39dKAByG46bj
6/HZRRxqDe1rI5sfD0E1a0Nr2Z9BrsXMNwfvD6FtegCyn/5OXrujC+7uU4QFlvVJ
hdFY5aS9MkOZ5CyHh3QfA8VnG3NY9MvxNVN9AZ5FCtuEujyZJztFayt+2Nn5+QM=
=aNAA
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6ixh-0001Ub-AJ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6ixg-0000m1-Ed
	for qemu-devel@nongnu.org; Fri, 05 May 2017 15:32:21 -0400
References: <20170504173745.27414-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <422dbc7f-6a6b-7706-781e-eac345b3bc14@redhat.com>
Date: Fri, 5 May 2017 21:32:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170504173745.27414-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x0wbMt2dvRxNrWJaDbtbAq5m5Anb3ViAf"
Subject: Re: [Qemu-devel] [PATCH] block: Simplify BDRV_BLOCK_RAW recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x0wbMt2dvRxNrWJaDbtbAq5m5Anb3ViAf
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <422dbc7f-6a6b-7706-781e-eac345b3bc14@redhat.com>
Subject: Re: [PATCH] block: Simplify BDRV_BLOCK_RAW recursion
References: <20170504173745.27414-1-eblake@redhat.com>
In-Reply-To: <20170504173745.27414-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 19:37, Eric Blake wrote:
> Since we are already in coroutine context during the body of
> bdrv_co_get_block_status(), we can shave off a few layers of
> wrappers when recursing to query the protocol when a format driver
> returned BDRV_BLOCK_RAW.
>=20
> Note that we are already using the correct recursion later on in
> the same function, when probing whether the protocol layer is sparse
> in order to find out if we can add BDRV_BLOCK_ZERO to an existing
> BDRV_BLOCK_DATA|BDRV_BLOCK_OFFSET_VALID.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--x0wbMt2dvRxNrWJaDbtbAq5m5Anb3ViAf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM0zISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJ5MH/1lBnHcWQVWYtrYxLBgG/eI0D2Y6cart
pCSipULL0HJgnN2xlIvCzL7ozggVLmwT9cQdzq9zNwazECfbOWTrPZcIp91JN/1C
vTpLyXqZZVcAPz/5JdBbnqX9a3TSrVxf6tsYqkGKwJK4pis6W8ab0qKaM6vqUtXD
3xC2coEammo5df1Stt6BcKK84T+bO7E3JGvR1KHg4L3tEc2qfyAM3L3cC/xBOBy2
OvvWUqlIc8oZvVYTmqVKgIXdOKlP0d2sr13VeuUQaS7U3Y9BLvkEC23rXoILiu/O
Ebn54jaeIHS0JMa9I4fyw5YFWIIGexNkZAxbb3lFq5HgpCjB0tqzhGs=
=KJwe
-----END PGP SIGNATURE-----

--x0wbMt2dvRxNrWJaDbtbAq5m5Anb3ViAf--

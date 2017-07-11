Received: from eggs.gnu.org ([2001:4830:134:3::10]:42690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrPa-0000qi-2l
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:24:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrPW-0004T7-Vy
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:24:54 -0400
Date: Tue, 11 Jul 2017 10:23:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711092346.GF17792@stefanha-x1.localdomain>
References: <20170710150559.30163-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <20170710150559.30163-1-den@openvz.org>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/1] block: fix shadowed
 variable in bdrv_co_pdiscard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 06:05:59PM +0300, Denis V. Lunev wrote:
> We've had a shadowed 'ret' variable, which risks returning the wrong
> value, introduced in commit b9c64947.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> ---
>  block/io.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZJkiAAoJEJykq7OBq3PICKMH/ivFr7G64xd9SK8mR9bRoyl4
Y2iiFEA5LD8COpWfFkbXUN8+FdT2kqQ9+ee6eq2bu2thnYtGsPSG6T0iz45oHFho
mJ6zENu47mrKJ9dRt2gwQovSkiJT1j3xzf2oYiKv8cu9NYO55jPSy2L3ZONt2AFM
3fUmzFgXaIQq3eZH9YjqCpzjVwQ9kkAV1btHA1uk12kriy0IuBXq5ngPSLM5tgVl
swtnnBPOzVIA779H9msvkyCZ3hhe+x5CKnDUdnvVXg3jZmh91DiQMth05pP17CN4
pR3lnkNvrW3zjXFga26UT8mUxPRT0V4LyVNQe3jpGHAkOGz22KgV19frWYKd5No=
=EhfW
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVEzb-0004Aj-CE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dVEzW-00009d-If
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:35:39 -0400
Date: Wed, 12 Jul 2017 11:35:29 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170712103529.GF6923@stefanha-x1.localdomain>
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline
In-Reply-To: <20170711163748.17817-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v4 3/4] block: remove bdrv_truncate
 callback in blkdebug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, qemu-block <qemu-block@nongnu.org>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 07:37:47PM +0300, Manos Pitsidianakis wrote:
> Now that bdrv_truncate is passed to bs->file by default, remove the
> callback from block/blkdebug.c and set is_filter to true.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/blkdebug.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZftxAAoJEJykq7OBq3PIJ2cIAIvhP5Xxh87qH7bcb71BhLc7
eWI17qbpNL9kZVG4wHT4GXH+yW91qUfks59GFiFKHClaCpeAf8352b8UUfCu5Wd/
ZP81Ug5jno4tSQI+fNKL4B81/Yy2rmORNPTDzdhbAKbifIffTpPvnwxemTtdBgi7
PrKQRNbhyX5CImJirZ7/fOeH79t8gh/Te+SsZ4AD7gkhqlCoe9bSiTOKNl+/CszC
Z0ZZddN50HL6iIiC9pNNK5C0HqwAlKhA9yrhGfPvMr7L+ugXkaimlvL5zpKuICbg
2jAXEP325h8UZH/cEFOiaGe+tu8p0rD3W+pZ39/Oip8OlCwuthQ/Sr6nQoq9bCM=
=DUqu
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--

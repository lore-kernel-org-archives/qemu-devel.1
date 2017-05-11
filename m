Received: from eggs.gnu.org ([2001:4830:134:3::10]:57375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8ulw-0007GN-Ny
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8ult-0002nA-Ky
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:33:16 -0400
Date: Thu, 11 May 2017 16:33:10 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511203310.GR24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-16-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hw0FrjWlp+qkNlJP"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-16-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 15/16] block: Add perm
 assertion on blk_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--Hw0FrjWlp+qkNlJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 05:43:55PM +0800, Fam Zheng wrote:
> Now that all BB users comply with the BLK_PERM_AIO_CONTEXT_CHANGE
> rule, we can assert it.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Hw0FrjWlp+qkNlJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMqGAAoJEJykq7OBq3PIrbUH/0DfT5IkT6ai565fpNZJcGVj
s+EZyScTaQn0unPLujQ0D8+kvvYzaK3EP/m/bE3k8Zn5KUT9aFmQrqZKUcB1p/Tn
Ky61CETqmaO4jIWSburcbKJUNj2sma6TTf1GPa+58nQEzyChCX4DVpUtUukyNhn2
r33IHvBxABqZVZvFD4AXl1HY5JeE3oaIkUftuAKCJ970QAkMlba9rYuXCTvlsQwI
7Fpo7eNGDC7whwRGWmt7Y68DQVyh+6UahRtUt1eaMec/BtgQgcyGjoON5NAkWQ4s
uwJ8CQEVkCWVoSTcYQk9U2FOhc4Ql/Ax2HuGfD3VuRi1UaSurKeSItL+gBfVdL8=
=rT8q
-----END PGP SIGNATURE-----

--Hw0FrjWlp+qkNlJP--

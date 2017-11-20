Received: from eggs.gnu.org ([2001:4830:134:3::10]:44863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGnS9-0000TQ-5x
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGnS7-0006SI-6m
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:53:41 -0500
Date: Mon, 20 Nov 2017 14:53:36 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120145336.GI4516@stefanha-x1.localdomain>
References: <1510851298-59922-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510851298-59922-4-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ijf6z65S790CMqo8"
Content-Disposition: inline
In-Reply-To: <1510851298-59922-4-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/4] block-stream: add
 compress option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com


--ijf6z65S790CMqo8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2017 at 07:54:57PM +0300, Anton Nefedov wrote:
> It might be useful to compress images during block-stream;
> this way the user can merge compressed images of a backing chain and
> the result will remain compressed.
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  qapi/block-core.json      |  4 ++++
>  include/block/block_int.h |  4 +++-
>  block/stream.c            | 16 ++++++++++++----
>  blockdev.c                | 13 ++++++++++++-
>  hmp.c                     |  2 ++
>  hmp-commands.hx           |  4 ++--
>  6 files changed, 35 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ijf6z65S790CMqo8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaEuxwAAoJEJykq7OBq3PIlfEH/26/MzzKxGMo0GvWUbPVC8ae
Xfs+ukHbYOzcQiamHVcm1XEx2rubRNXI8FrfLe5fWXvZahvA1TT7wqF8GU6HsmWQ
+quoPhtxhDyyebo68ost7itNSNUVSoGnf+aIpoHzlbHLDrnoTFbsiNdOrPIfLYOg
Wkgv5qQGy0LalnIdU7TLBtL50VrZovcjuoGyl9BWUIN4K53L1zNBmx5xcPgSDh5V
esgb0zXl1KoGaz2yOGhjAbZubangjidajCNnaFykADOehZuOQ2z88clYLe/Br3Us
K1NBG9IZ7BLCdgJ6VaT/itTGDMiLz5E6gVkZ9xReEq5COsEA5BJwgGM5MpM0rEI=
=D5Gp
-----END PGP SIGNATURE-----

--ijf6z65S790CMqo8--

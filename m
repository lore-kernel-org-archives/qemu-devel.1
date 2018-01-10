Received: from eggs.gnu.org ([2001:4830:134:3::10]:52074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLXq-0007qW-6S
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZLXp-00071n-DL
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:56:14 -0500
Date: Wed, 10 Jan 2018 18:55:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180110185556.GF24212@stefanha-x1.localdomain>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <20180110091846.10699-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/9] block: Introduce buf register API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 05:18:41PM +0800, Fam Zheng wrote:
> Allow block driver to map and unmap a buffer for later I/O, as a performa=
nce
> hint.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c          | 10 ++++++++++
>  block/io.c                     | 24 ++++++++++++++++++++++++
>  include/block/block.h          | 11 ++++++++++-
>  include/block/block_int.h      |  9 +++++++++
>  include/sysemu/block-backend.h |  3 +++
>  5 files changed, 56 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVmG8AAoJEJykq7OBq3PIIckH/RVrRaUJQUV22j4W4w4TkbJO
p20GSt8pw5PFidvldwHzQ3GBjztdFNTNZj8oiomraR8E3WOBrVHj3GvKqXkQfAvh
BnwmNHfeZJeeK2DTs4xd4Llg2WVpHi+FLeQrQnnBkSwWzhZDR+MLRaj6MQ+XMAx6
cdLxhHBy1gtD3sYjcU5jZKCqH1bFiOlYeXT4gKJAr7b8nFLBk3wSz7va6J9f8eic
8JAoeQ7SX0aMo1hgVfVbcF6vZslecMWsgKBbP2yYEpzMfUepzEvimia20d9jAJyh
dSKtfNDMzzHnroaeVaErnCCHAYM7Gztyu7fTyKvfVPGbwzvgAxAPbtGe8SN0pJY=
=rQaa
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

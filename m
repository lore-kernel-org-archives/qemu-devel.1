Received: from eggs.gnu.org ([2001:4830:134:3::10]:34391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY93N-00051A-ME
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY93M-0007es-KM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:56:05 -0400
Date: Wed, 27 Jun 2018 12:56:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627115600.GI5955@stefanha-x1.localdomain>
References: <20180626142434.22090-1-kwolf@redhat.com>
	<20180626142434.22090-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <20180626142434.22090-5-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] block: Move bdrv_truncate()
 implementation to io.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 04:24:32PM +0200, Kevin Wolf wrote:
> This moves the bdrv_truncate() implementation from block.c to block/io.c
> so it can have access to the tracked requests infrastructure.
>=20
> This involves making refresh_total_sectors() public (in block_int.h).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int.h |   2 +
>  block.c                   | 111 +---------------------------------------=
------
>  block/io.c                | 109 ++++++++++++++++++++++++++++++++++++++++=
+++++
>  3 files changed, 112 insertions(+), 110 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM3tQAAoJEJykq7OBq3PIjNgIAL7C63mDC0h7DE8jihOCR+Q/
ouy4dHRvWPQjEucMV1puWSNe4CcKUSiP6TNuKW/toiVL3+6bBL0mU/t2Y8PUjK7Z
ZrtXpV3YtRzCR1wDROIn8K/LZF8R1dwox2cvzzwqZm09G177x1fGDM+3fdaXSUTv
EJkAUJSvjEEamBKZyejr7iXZ2PGUq2egnGOVrTTcipGsjSIx7xz809vP5Bmj1DIw
AGuWXJwrpaOATwMDh6Czyz9tczqFMXDQEYH++83DAqbMdtnL3r+cKwUvnpVJ+En1
GvaGGjruB2Xy83ZhZ4k0PZDPwpeSAO79DR6AZVYweuGLNQ2Zd7kFESsvZnT/g28=
=Wxr0
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--

Received: from eggs.gnu.org ([209.51.188.92]:35295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmc8I-000320-BH
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmbvB-00081v-T5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:07:42 -0500
Date: Thu, 24 Jan 2019 10:07:36 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190124100736.GC4764@stefanha-x1.localdomain>
References: <20190122121926.25554-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <20190122121926.25554-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Apply auto-read-only for
 ro-whitelist drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 01:19:26PM +0100, Kevin Wolf wrote:
> If QEMU was configured with a driver in --block-drv-ro-whitelist, trying
> to use that driver read-write resulted in an error message even if
> auto-read-only=3Don was set.
>=20
> Consider auto-read-only=3Don for the whitelist checking and use it to
> automatically degrade to read-only for block drivers on the read-only
> whitelist.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSY5oAAoJEJykq7OBq3PI6TAH+gLqZsS1GuV4BnH6oI6cIVP7
Odf7Dr+VFL3u2bsXaTFxVOtOeEt7+dfPncQpbuOjVnaJdbekQLF8EIgqQYGVe0HY
yWabjbuAvFqFTh1ysNJJKaxGeNEekKLdOYVY1rT7FpL6iAQCwouHuAhGLYinIVUI
qkvHfJbDTBfNZxbQ/FiKetrciuMzTPAk5ZSyOLLE6hYODw/YyTCkroQyZHgSz4nJ
hKCbImdA9ryFvHkJkTOG3CyJ/yRRuxAPdu8j7J1CIQ7lfot0AKOIM70wKBN6Qfk9
VFiqGOSeKaY0UeVinCoVcMgH+fNRhaRuSXeh8CfqDZNXuRpPmyOAWh+NCawlOpg=
=p5QV
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--

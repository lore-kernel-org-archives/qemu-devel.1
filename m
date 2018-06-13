Received: from eggs.gnu.org ([2001:4830:134:3::10]:49959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6vX-00073y-9l
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6vT-0001Ro-Vm
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:39:11 -0400
Date: Wed, 13 Jun 2018 15:38:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613143856.GY24528@stefanha-x1.localdomain>
References: <20180601144328.23817-1-peter.maydell@linaro.org>
	<20180601144328.23817-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lYVfafuUkPqz/tKz"
Content-Disposition: inline
In-Reply-To: <20180601144328.23817-2-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] stellaris: Stop using armv7m_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>


--lYVfafuUkPqz/tKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 03:43:27PM +0100, Peter Maydell wrote:
> The stellaris board is still using the legacy armv7m_init() function,
> which predates conversion of the ARMv7M into a proper QOM container
> object. Make the board code directly create the ARMv7M object instead.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/stellaris.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lYVfafuUkPqz/tKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbISyAAAoJEJykq7OBq3PIC/YIAMlH038PrZW0uS7wt54qFRO8
nKuVI7KZD+IJpd7hzSBB5/DBFGSUQAYDCkX/npgb7pjBakV9dDLNqQiik1ft7RCR
ZisTHOJdW8brAPT54WUTm7DRbsznDnRoZy2WdABSzAkM+Loz+nOr47r3lJdXiLr0
WJWvWpj5/StzobkZJTngkLJv725+A2Ncy3bhokQPRks3smO9MG1j78tgxTqA1Zrm
Fkexnje62vv0cgP1PRwaieyV3h9lT2a4JRoYVbtWgxyU80BO8/p6ZOuk8XWJepfa
Y4koRvGQYDjsoCCeo1uRuom0ebLIcrZuFV33bX1LaQcYsNFzpo2E3WIqNjufjjA=
=+alR
-----END PGP SIGNATURE-----

--lYVfafuUkPqz/tKz--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6Oc-0007ex-SS
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6Oa-0003xw-37
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:05:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fT6OZ-0003wr-UK
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:05:08 -0400
Date: Wed, 13 Jun 2018 15:05:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613140505.GS24528@stefanha-x1.localdomain>
References: <20180612204632.28780-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zn93sY2JrH9m7VZ"
Content-Disposition: inline
In-Reply-To: <20180612204632.28780-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow ARMv6-M Thumb2
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>


--6zn93sY2JrH9m7VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 12, 2018 at 11:46:32PM +0300, Julia Suvorova wrote:
> ARMv6-M supports 6 Thumb2 instructions. This patch checks for these
> instructions and allows their execution.
> Like Thumb2 cores, ARMv6-M always interprets BL instruction as 32-bit.
>=20
> This patch is required for future Cortex-M0 support.
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  target/arm/translate.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)

Does make the undefined instruction test case that I recently posted
pass (including all commented out instructions that weren't working
yet)?

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6zn93sY2JrH9m7VZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbISSRAAoJEJykq7OBq3PIJ74IAJrDqGett6dN+GcrbEiMHOZi
lW2Rbfr67Qf4sm1TRhPP2YL1uXwoeSl0I9Sh/n+igH3kh+APuny5nplQDd2EDtfW
ZzBBNL4WWw9peCOtl9Hp5q5i0QlzR3CbTH9WSo0r9E4iXPyS8XOA3KFnIRZkP9IR
D2TQr7kf/bUanjT3XXQmjLlQTmoiHvZfenpcSWHAiEorbXT+vQTv3CtB+sVHGtvy
TgHbSt7qHabfXXCn+t3io8191zxp1JNw5oIuA5hSDvaCLtjtoZhwTpxQBM8jEaSp
CkLIrKS80yNQAEXOf7Za4JqcL+xwM7IfKawOF9EZuasO/XW5qEa5CFy4ERppeV4=
=eN5J
-----END PGP SIGNATURE-----

--6zn93sY2JrH9m7VZ--

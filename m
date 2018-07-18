Received: from eggs.gnu.org ([2001:4830:134:3::10]:51215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffoTg-000605-DI
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffoTd-0004cf-AV
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:34:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ffoTd-0004c8-5o
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:34:53 -0400
Date: Wed, 18 Jul 2018 13:49:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180718124915.GG21825@stefanha-x1.localdomain>
References: <20180718095628.26442-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <20180718095628.26442-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v2] arm: Add ARMv6-M programmer's model
 support
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


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 12:56:28PM +0300, Julia Suvorova wrote:
> Forbid stack alignment change. (CCR)
> Reserve FAULTMASK, BASEPRI registers.
> Report any fault as a HardFault. Disable MemManage, BusFault and
> UsageFault, so they always escalated to HardFault. (SHCSR)
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
> v2:
>     * Changed CCR reset value
>=20
>  hw/intc/armv7m_nvic.c | 10 ++++++++++
>  target/arm/cpu.c      |  4 ++++
>  target/arm/helper.c   | 13 +++++++++++--
>  3 files changed, 25 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbTzdLAAoJEJykq7OBq3PIjCMIALjwhgGkcfEHTF0B1xvtmITQ
tC/tX/3Q9or3EyZlsnjCEoXciL1/AxdPrZOsKzU98RqFSA5HbV1KXBfAY+QOcH5C
5u+sJ+ZcDRXM6eIew+HK00JUGGVKXfYKV6x1v9BDmZDsu5ngSukx6aJK8r0d/W5L
q+cZek+zQSkqjlAVfIStAVsYGxvU8+PHAcHfGwmcBimdNu49dlzmO0gllxXBSDyn
D3ZRqBE2H57M33WKlUP7ykn/GGTYfEAWhv/NCmhH0Ne3HScHbxsvyj568ReUGPbu
0v2r0HVK8Nb7C2LODyD8yjIOr53Dt6kqjFaCt3d4aa/0qRCAM4hLMXdMm7w5kB0=
=c+2J
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--

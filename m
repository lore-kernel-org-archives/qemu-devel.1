Received: from eggs.gnu.org ([2001:4830:134:3::10]:44391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fezNY-0002B2-DS
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fezNV-00005m-14
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:01:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fezNU-000051-Fk
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:01:08 -0400
Date: Mon, 16 Jul 2018 10:01:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180716090104.GA3535@stefanha-x1.localdomain>
References: <20180713103059.12539-1-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20180713103059.12539-1-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] arm: Add ARMv6-M programmer's model support
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


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 01:30:59PM +0300, Julia Suvorova wrote:
> Forbid stack alignment change. (CCR)
> Reserve FAULTMASK, BASEPRI registers.
> Report any fault as HardFault. Disable MemManage, BusFault and
> UsageFault, so they always escalated to HardFault. (SHCSR)
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
> This is the last cortex-m0 patch.
>=20
>  hw/intc/armv7m_nvic.c | 10 ++++++++++
>  target/arm/cpu.c      | 10 ++++++++++
>  target/arm/helper.c   | 13 +++++++++++--
>  3 files changed, 31 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbTF7QAAoJEJykq7OBq3PINKkH/2eAjBZXTwrU2CdQtnkn9dx0
W9DGKAoy3ZsqqbOssshxNcne24Ci7mwSuqwJXE10iKjAUoXTRXiNGj1G1VcLXEcv
LrOZwCbQF5a/k2BAhvjWs9tSGLSgCcx83Wi6zgOXqM2eqXzGCQMWVw1am6M78zeD
o89A77tkXiiaTXSLgn6/4GQ6u/K4mZZriy+4K+LQ/BV2CfKzEzPTtj+N6pd2Led6
WBbyzoplk3q3zUAIuLVyTtYUVqSXC6k9ncFbTT/5LO02e2753ozpwbdbVu6i+kd8
2epX34JpY9ZuUIJTZI1rwznQPXFJwM3wuBMTiGuXK3d+FdL9YLnlED7A90ZQ4gw=
=FC80
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6vp-0007EY-Us
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT6vo-0002Ew-Vn
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:39:29 -0400
Date: Wed, 13 Jun 2018 15:39:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613143919.GZ24528@stefanha-x1.localdomain>
References: <20180601144328.23817-1-peter.maydell@linaro.org>
	<20180601144328.23817-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H7BIH7T1fRJ3RGOi"
Content-Disposition: inline
In-Reply-To: <20180601144328.23817-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/armv7m: Remove unused
 armv7m_init() function
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


--H7BIH7T1fRJ3RGOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 03:43:28PM +0100, Peter Maydell wrote:
> Remove the now-unused armv7m_init() function. This was a legacy from
> before we properly QOMified ARMv7M, and it has some flaws:
>=20
>  * it combines work that needs to be done by an SoC object (creating
>    and initializing the TYPE_ARMV7M object) with work that needs to
>    be done by the board model (setting the system up to load the ELF
>    file specified with -kernel)
>  * TYPE_ARMV7M creation failure is fatal, but an SoC object wants to
>    arrange to propagate the failure outward
>  * it uses allocate-and-create via qdev_create() whereas the current
>    preferred style for SoC objects is to do creation in-place
>=20
> Board and SoC models can instead do the two jobs this function
> was doing themselves, in the right places and with whatever their
> preferred style/error handling is.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/arm.h |  8 ++------
>  hw/arm/armv7m.c      | 21 ---------------------
>  2 files changed, 2 insertions(+), 27 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--H7BIH7T1fRJ3RGOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbISyXAAoJEJykq7OBq3PIOs0IAKAH2H2D5E5P5jGpKM7t0Fb8
H7ohNN/GM1Xeyzny2FqaGZQTEsktHTpF52YwryqazQO2oZdjw/FuEMfsHaTQEgtb
6F3XnC4Hbrw1CaRrv1wlUlMmVxlJqcuWaeal9dbVr++X7son3l3itn7oGOMpQQwT
yPFGwHRaxLaVtxEYXW02avXgj+Q64DXWNqN75Mckn4wYfGk73R1TWUVB955+K2zl
lmc5M5pyWybeBNbRdF9o6FU7oykPU2iFveRZrqTzU5aoWesob55Hxt4z7HqBhGOn
o1wGjkIghJDBsKnSbkPvbekxQ4cSUuiq7gWi2wPpl2Mrsf8rMlVGJqG93XUVOXE=
=3dWH
-----END PGP SIGNATURE-----

--H7BIH7T1fRJ3RGOi--

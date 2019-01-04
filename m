Received: from eggs.gnu.org ([208.118.235.92]:50955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfM8k-0005Z0-20
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfM8i-0002UT-Ut
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:51:42 -0500
Date: Fri, 4 Jan 2019 09:51:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190104095130.GA30381@stefanha-x1.localdomain>
References: <20190103091119.9367-1-stefanha@redhat.com>
	<20190103091119.9367-3-stefanha@redhat.com>
	<51ac1e9a-6576-9a54-91f3-76bf66040cc7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <51ac1e9a-6576-9a54-91f3-76bf66040cc7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/11] arm: Add header to host common
 definition for nRF51 SOC peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 11:40:30AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 1/3/19 10:11 AM, Stefan Hajnoczi wrote:
> > From: Steffen G=F6rtz <contrib@steffen-goertz.de>
> >=20
> > Adds a header that provides definitions that are used
> > across nRF51 peripherals
> >=20
> > Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/hw/arm/nrf51.h       | 45 ++++++++++++++++++++++++++++++++++++
> >  include/hw/char/nrf51_uart.h |  1 -
> >  hw/arm/nrf51_soc.c           | 33 ++++++++++----------------
> >  3 files changed, 57 insertions(+), 22 deletions(-)
> >  create mode 100644 include/hw/arm/nrf51.h
> >=20
> > diff --git a/include/hw/arm/nrf51.h b/include/hw/arm/nrf51.h
> > new file mode 100644
> > index 0000000000..175bb6c301
> > --- /dev/null
> > +++ b/include/hw/arm/nrf51.h
> > @@ -0,0 +1,45 @@
> > +/*
> > + * Nordic Semiconductor nRF51 Series SOC Common Defines
> > + *
> > + * This file hosts generic defines used in various nRF51 peripheral de=
vices.
> > + *
> > + * Reference Manual: http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.=
0.pdf
> > + * Product Spec: http://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.1=
=2Epdf
> > + *
> > + * Copyright 2018 Steffen G=F6rtz <contrib@steffen-goertz.de>
> > + *
> > + * This code is licensed under the GPL version 2 or later.  See
> > + * the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef NRF51_H
> > +#define NRF51_H
> > +
> > +#define NRF51_FLASH_BASE      0x00000000
> > +#define NRF51_FICR_BASE       0x10000000
> > +#define NRF51_FICR_SIZE       0x00000100
> > +#define NRF51_UICR_BASE       0x10001000
> > +#define NRF51_SRAM_BASE       0x20000000
> > +
> > +#define NRF51_IOMEM_BASE      0x40000000
> > +#define NRF51_IOMEM_SIZE      0x20000000
> > +
> > +#define NRF51_UART_BASE       0x40002000
> > +#define NRF51_TIMER_BASE      0x40008000
> > +#define NRF51_TIMER_SIZE      0x00001000
> > +#define NRF51_RNG_BASE        0x4000D000
> > +#define NRF51_NVMC_BASE       0x4001E000
> > +#define NRF51_GPIO_BASE       0x50000000
> > +
> > +#define NRF51_PRIVATE_BASE    0xF0000000
> > +#define NRF51_PRIVATE_SIZE    0x10000000
> > +
> > +#define NRF51_PAGE_SIZE       1024
>=20
> I'd keep this file in hw/arm (not include/...).

This header file avoids duplicating definitions in
tests/microbit-test.c.

How would you structure it differently?

Stefan

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLyyiAAoJEJykq7OBq3PI6GUH/js0NDZi6qIts9vXgtVMhREZ
sO05FQjiCnVnfJuBDqyUw3Or9JxnlPzdmoppEx4qxQNMWoknmnBmRk+WF0Jblh0o
RZdmFIQd72XZTOALhVKhMVJhsbDManXm2g5F/OVlnqqLBBgL6nIOL5NpSuDSQ1/r
43nKYfwdbrzubbvhig1IG1K2NekVkGEazKPmlC5PZbVuOaD1Y8qp2Zz4yZt7XO54
X+Wja808NdtN2y2CxcxNCN8cWvSpeYNlkqEfDqjmRa77yrhRIIBchHNp8NtuJPTl
EQSgnHuXKJf7emTuQvrePg5EWqQXFnefRNrtul33dQo7gpZg7OpMQwLjzPH/gUE=
=mSUR
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

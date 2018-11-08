Received: from eggs.gnu.org ([2001:4830:134:3::10]:54635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gKgfi-0000z9-RL
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gKgfc-0005U6-TK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:32:18 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gKgfb-0005Kp-Im
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 04:32:12 -0500
Received: by mail-wm1-x343.google.com with SMTP id a8-v6so496118wmf.1
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 01:32:11 -0800 (PST)
Date: Thu, 8 Nov 2018 09:32:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181108093208.GC17083@stefanha-x1.localdomain>
References: <20181102170730.12432-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <20181102170730.12432-1-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [PATCH v4 00/13] arm: nRF51 Devices and Microbit
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 01:07:17PM -0400, Steffen G=F6rtz wrote:

Thank you, Steffen!  I have posted my Reviewed-by on all patches.

Joel: Will you send pull requests for the microbit machine types or do
you want Peter to merge this?

> This series contains additional peripheral devices for the nRF51822
> microcontroller.=20
>=20
> Included devices:
> - Random Number Generator
> - Non-volatile Memories
> - General purpose I/O
> - Timer=20
> - Stub for clock peripheral
>=20
> v4:
>     * Use int's instead of long's in set_irq_in, allow arbitrary base, fi=
x documentation (Laurent)
>     * Do not clear UICR on reset (Stefan)
>     * Remove c99 style variable declaration (Peter)
>     * Default case for is_connected (Stefan)
>     * Timer retrigger after live migration (Stefan)
>     * Various small fixes (Stefan)
>=20
> v3:
>     * Included device instantiation in this patch
>     * All devices use the common definitions provided by the header
>     * Removed obsolete comment from NVM header
>     * Device Struct names have consistent capitalisation
>=20
> v2:
>     * Factored out common definitions to won header (Stefan)
>     * Add set_irq_in command to support tests for GPIO
>     * Add tests for GPIO
>     * Removed LED matrix from this patch set
>     * Small tidy ups on RNG, NVM, GPIO and Timer
>=20
>=20
> Based-on: 20181025005052.27661-1-jusual@mail.ru
>=20
> Steffen G=F6rtz (13):
>   qtest: Add set_irq_in command to set IRQ/GPIO level
>   arm: Add header to host common definition for nRF51 SOC peripherals
>   hw/misc/nrf51_rng: Add NRF51 random number generator peripheral
>   arm: Instantiate NRF51 random number generator
>   hw/nvram/nrf51_nvm: Add nRF51 non-volatile memories
>   arm: Instantiate NRF51 special NVM's and NVMC
>   tests: Add bbc:microbit / nRF51 test suite
>   hw/gpio/nrf51_gpio: Add nRF51 GPIO peripheral
>   arm: Instantiate NRF51 general purpose I/O
>   tests/microbit-test: Add Tests for nRF51 GPIO
>   hw/timer/nrf51_timer: Add nRF51 Timer peripheral
>   arm: Instantiate NRF51 Timers
>   arm: Add Clock peripheral stub to NRF51 SOC
>=20
>  Makefile.objs                  |   1 +
>  hw/arm/nrf51_soc.c             | 150 ++++++++++++--
>  hw/gpio/Makefile.objs          |   1 +
>  hw/gpio/nrf51_gpio.c           | 300 +++++++++++++++++++++++++++
>  hw/gpio/trace-events           |   7 +
>  hw/misc/Makefile.objs          |   1 +
>  hw/misc/nrf51_rng.c            | 262 +++++++++++++++++++++++
>  hw/nvram/Makefile.objs         |   1 +
>  hw/nvram/nrf51_nvm.c           | 333 +++++++++++++++++++++++++++++
>  hw/timer/Makefile.objs         |   1 +
>  hw/timer/nrf51_timer.c         | 368 +++++++++++++++++++++++++++++++++
>  hw/timer/trace-events          |   5 +
>  include/hw/arm/nrf51.h         |  45 ++++
>  include/hw/arm/nrf51_soc.h     |  11 +
>  include/hw/char/nrf51_uart.h   |   1 -
>  include/hw/gpio/nrf51_gpio.h   |  69 +++++++
>  include/hw/misc/nrf51_rng.h    |  83 ++++++++
>  include/hw/nvram/nrf51_nvm.h   |  70 +++++++
>  include/hw/timer/nrf51_timer.h |  75 +++++++
>  qtest.c                        |  43 ++++
>  tests/Makefile.include         |   2 +
>  tests/libqtest.c               |  10 +
>  tests/libqtest.h               |  28 +++
>  tests/microbit-test.c          | 242 ++++++++++++++++++++++
>  24 files changed, 2087 insertions(+), 22 deletions(-)
>  create mode 100644 hw/gpio/nrf51_gpio.c
>  create mode 100644 hw/gpio/trace-events
>  create mode 100644 hw/misc/nrf51_rng.c
>  create mode 100644 hw/nvram/nrf51_nvm.c
>  create mode 100644 hw/timer/nrf51_timer.c
>  create mode 100644 include/hw/arm/nrf51.h
>  create mode 100644 include/hw/gpio/nrf51_gpio.h
>  create mode 100644 include/hw/misc/nrf51_rng.h
>  create mode 100644 include/hw/nvram/nrf51_nvm.h
>  create mode 100644 include/hw/timer/nrf51_timer.h
>  create mode 100644 tests/microbit-test.c
>=20
> --=20
> 2.19.1
>=20

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb5AKYAAoJEJykq7OBq3PIFPsIAIdve9eLIx8yd6Sd6y11Qn+z
c0ANXx3ZcxYQ1UtLlLrgXDpmHQod8qBnakPZF/VA+712+juq9jztey/JOFH9IgoQ
thOtH0GX3H6SIwe0pWkQjsEnqcx/bPDESzpbMzE/sQ1yUyo7e5uXB/dOyGLcbIMZ
Dht1PdRsZ1eviaOPhXj0/ZW0me7kQN3ALmv9yWbbWjTqO1eFBAAjtrAPW6BQ0o8S
gfYSNAgwKT0lvma40VXIscq9ALMe5Z/d3xCm16O1zbybII8CBPl+1BJLXsruHXrk
Y3lJzzlo/OCp+aqkdMo9t01dFtuFNIt/mVh5CJoHGmmMlfLtSTSTZMVNHmDjKb4=
=xhyk
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

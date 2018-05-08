Received: from eggs.gnu.org ([2001:4830:134:3::10]:34661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG1NT-0004p3-As
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG1NN-0007yW-9O
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:05:55 -0400
Date: Tue, 8 May 2018 13:05:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508120545.GK19710@stefanha-x1.localdomain>
References: <20180503090532.3113-1-joel@jms.id.au>
	<20180503090532.3113-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline
In-Reply-To: <20180503090532.3113-2-joel@jms.id.au>
Subject: Re: [Qemu-devel] [PATCH 1/2] arm: Add Nordic Semiconductor nRF51 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Jim Mussared <jim.mussared@gmail.com>


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2018 at 06:35:31PM +0930, Joel Stanley wrote:
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> new file mode 100644
> index 000000000000..a2e3d6f013f0
> --- /dev/null
> +++ b/hw/arm/nrf51_soc.c
> @@ -0,0 +1,101 @@
> +/*
> + * Nordic Semiconductor nRF51 SoC
> + *
> + * Copyright 2018 Joel Stanley <joel@jms.id.au>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.

Please include the link in the comment:

  The reference manual is available here:
  http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf

> +static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
> +{
> +    NRF51State *s = NRF51_SOC(dev_soc);
> +    DeviceState *nvic;
> +    Error *err = NULL;
> +
> +    /* IO space */
> +    create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
> +
> +    /* FICR */
> +    create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
> +
> +    MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *sram = g_new(MemoryRegion, 1);
> +    MemoryRegion *flash = g_new(MemoryRegion, 1);
> +
> +    memory_region_init_ram_nomigrate(flash, NULL, "nrf51.flash", FLASH_SIZE,
> +            &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;

Please free resources (e.g. sram and flash) in error code paths.

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8ZKZAAoJEJykq7OBq3PIjnAH/3BpDyCxCuP1mq8lY6wkk2wH
kejCscpdqCAw5XLUWw6kstCjYqOjQ9QSiRKEohDwQcXwMp2SJuVJG44ZhR0EhsGM
S23rYGycW2O9EjyEvObBHCgvK5l2WVd9eY5SsGk3TKCjlgjVUkIkPN2eoVG8JeGD
hiPsGxXP1q21UmwKLI0rVMrRTp1eowqCorzndQl8pwH7Szyn1iH85WQvdS2p4DD8
5+7vmN2xtPayI8Rqy5fIEWnFgu5eLe4qtZNKkYCH2Ckn7F014Hxv+Q2q0464D+g6
u9apQhB0VO+yQUQmBQuoaN0+vUZMfUCYRRVL5E2KzWyvVrLDz8Gl7zi57Yl2QXU=
=4Qc7
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--

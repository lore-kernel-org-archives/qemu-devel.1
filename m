Received: from eggs.gnu.org ([2001:4830:134:3::10]:41941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOTw-0007Ry-U0
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOTr-0002FV-S0
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:11 -0400
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-6-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <35949e51-b9d9-6914-8285-15797cb3b7da@greensocs.com>
Date: Wed, 22 Aug 2018 10:26:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180821132811.17675-6-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lrnG1M2Y4EX9NvhvQogiD1jyIrRRW9oDk"
Subject: Re: [Qemu-devel] [PATCH 5/9] hw/arm/fsl-imx6ul: Connect VIRQ and
 VFIQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lrnG1M2Y4EX9NvhvQogiD1jyIrRRW9oDk
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <35949e51-b9d9-6914-8285-15797cb3b7da@greensocs.com>
Subject: Re: [PATCH 5/9] hw/arm/fsl-imx6ul: Connect VIRQ and VFIQ
References: <20180821132811.17675-1-peter.maydell@linaro.org>
 <20180821132811.17675-6-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/21/18 3:28 PM, Peter Maydell wrote:
> Connect the VIRQ and VFIQ lines from the GIC to the CPU;
> these exist always for both CPU and GIC whether the
> virtualization extensions are enabled or not, so we
> can just unconditionally connect them.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/fsl-imx6ul.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index 258f4706234..4b56bfa8d16 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -207,6 +207,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, E=
rror **errp)
>          irq =3D qdev_get_gpio_in(d, ARM_CPU_IRQ);
>          sysbus_connect_irq(sbd, i, irq);
>          sysbus_connect_irq(sbd, i + smp_cpus, qdev_get_gpio_in(d, ARM_=
CPU_FIQ));
> +        sysbus_connect_irq(sbd, i + 2 * smp_cpus,
> +                           qdev_get_gpio_in(d, ARM_CPU_VIRQ));
> +        sysbus_connect_irq(sbd, i + 3 * smp_cpus,
> +                           qdev_get_gpio_in(d, ARM_CPU_VFIQ));
>      }
> =20
>      /*
>=20


--lrnG1M2Y4EX9NvhvQogiD1jyIrRRW9oDk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9HkUACgkQd8knW3Qn
Tr7hoBAArSaKzfEjaLKs9qPF/MT703dXmAyz2D7JIBIW09TET5pJEbAVzoK2PZ5G
Ohrb0Qs6fZLj5btNYHx7YbL3q8gBiTBnjyxu86+6ekr/lJ4OG7dA1uWWFbadeO0X
SXxsMdP822uXzsmuIpsHxwQsfj9Dx2KlNrtTU3pUF7L/A3genR4fwPnjZbhdCLgP
Q0JZKQa0FKDYhJDEtJlfljmAgcooR8S4xN0PySkoh6gLFs/r8wZHyeyIgPTRdRxm
FA5gKlEdVT418wugS9+F4fBkrjdm4ZmFnU78doFKPePUpb6AcrF2oEsRbkIwZB8t
oXnUShlObPz3lBr+UbQkEz3P0sUVxoE7yrRCQfxSwQORQI3doMsT9Q1MfgLVoyD9
vbGIzV4eZI2K9DyOoCkFsMtg/EAasOOqdaWSIMbdH1++tDAer2KJAh+INZ/dAOF5
glpnp4PsQseov21PGjXGsgattMsioC751AnSxS75rhZkEyFTAWj9FLKD7XoIihjT
6I/S+lSFTVimR2jCdeuo5NChWsDha2NQsijIrPrkIwv4oRrwhyoQ+Soe2JOwU1Mj
JaTWi2T6upemo5eKQPrPbHBHtknj2dsj0gnI/S558ah3zjQzxPUWAvd4OpY8G+cO
RUoxovLu9avmeOLmV1PzcYTCiDztrLO4zqeU7YB0o2LRqBZ89Q0=
=kqCq
-----END PGP SIGNATURE-----

--lrnG1M2Y4EX9NvhvQogiD1jyIrRRW9oDk--

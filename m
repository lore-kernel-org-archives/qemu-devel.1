Received: from eggs.gnu.org ([2001:4830:134:3::10]:32925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1el167-0007y9-69
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 18:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1el165-0006rZ-Ji
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 18:31:51 -0500
Message-ID: <1518391890.10440.3.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 12 Feb 2018 10:01:30 +1030
In-Reply-To: <20180209085755.30414-2-f4bug@amsat.org>
References: <20180209085755.30414-1-f4bug@amsat.org>
	<20180209085755.30414-2-f4bug@amsat.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-TDJMey167qvL9LdLtzE4"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/arm/aspeed: directly map the
 serial device to the system address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


--=-TDJMey167qvL9LdLtzE4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-02-09 at 05:57 -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> (qemu) info mtree
>  address-space: cpu-memory-0
>    0000000000000000-ffffffffffffffff (prio 0, i/o): system
>      0000000000000000-0000000007ffffff (prio 0, rom): aspeed.boot_rom
>      000000001e600000-000000001e7fffff (prio -1, i/o): aspeed_soc.io
> -      000000001e784000-000000001e78401f (prio 0, i/o): serial
>      000000001e620000-000000001e6200ff (prio 0, i/o):
> aspeed.smc.ast2500-fmc
>      000000001e630000-000000001e6300ff (prio 0, i/o):
> aspeed.smc.ast2500-spi1
>      [...]
>      000000001e720000-000000001e728fff (prio 0, ram): aspeed.sram
>      000000001e782000-000000001e782fff (prio 0, i/o): aspeed.timer
> +    000000001e784000-000000001e78401f (prio 0, i/o): serial
>      000000001e785000-000000001e78501f (prio 0, i/o): aspeed.wdt
>      000000001e785020-000000001e78503f (prio 0, i/o): aspeed.wdt
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  hw/arm/aspeed_soc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index c83b7e207b..2a5d041b3b 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -257,7 +257,8 @@ static void aspeed_soc_realize(DeviceState *dev,
> Error **errp)
>      /* UART - attach an 8250 to the IO space as our UART5 */
>      if (serial_hds[0]) {
>          qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic),
> uart_irqs[4]);
> -        serial_mm_init(&s->iomem, ASPEED_SOC_UART_5_BASE, 2,
> +        serial_mm_init(get_system_memory(),
> +                       ASPEED_SOC_IOMEM_BASE +
> ASPEED_SOC_UART_5_BASE, 2,
>                         uart5, 38400, serial_hds[0],
> DEVICE_LITTLE_ENDIAN);
>      }
> =20
--=-TDJMey167qvL9LdLtzE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJagNJSAAoJEJ0dnzgO5LT5DQYP/RlebWcj5CXw4ucpYQbYfioh
2bw9FXCrebmlJ5uM620SOQzAUZrtN+v6zEuNAE21snKThCf/aezitsTpbYg6YYQ0
7nRGeQ2J05LAdEiDLKTbhENOcp+U0ArNiCro0Yk2INN5jhEC33oCOWk20MlFkjrQ
RW1D4VcKuMmTEnv/29WFpLAdORhfqKXZtQG2KY206ZG6qks3kU/NuEipQ9TfM6iL
3JfS+8lp8VULk6/LPE/4+/ad7VX4iHWD7FDVuKZBs6E6JGLp5i4mShY5ULfbSICh
adbs76zF7EkGRUuLhg6phIWlIhEg6kdXVh5N3w+eaHMdVnd1NFfaPtjfBHevHOkB
lClpwtoGtr9KJHFYWYDK60DulZ4AuYcdGPn8/rrFyMuwYoid5siC6i0TV7kjXDRH
NCy+ol+rwJxbMCdr1WZKToYq5Nhgnn9XP5u9CSQPLItAcu6coPwluzD5DXVaa5uj
+a4lxRbV4x9qnKlaIMT22WQZyA0Qmx+4NsIhVujPv2ZvJbUGpMz2GrtkGLZSKhZe
f0jSPNvwCATVqADMPis2yE1rgZW9LRku+L4c8veKyRdFLaU1xAbLOlpMsFxDFMor
b3uCjFot66QITJ54oDf9zMMRfWvu9mzeaBh46SLx/uTePOqPvm5lh2/uxT7fEgTB
E8/G4OfOeQc7FX/LSN4B
=Og61
-----END PGP SIGNATURE-----

--=-TDJMey167qvL9LdLtzE4--

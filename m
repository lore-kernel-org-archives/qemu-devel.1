Received: from eggs.gnu.org ([2001:4830:134:3::10]:33064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ek4VF-0001C7-Jo
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ek4VB-00064S-NK
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:57:53 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180208172202.9984-1-f4bug@amsat.org>
	<20180208172202.9984-2-f4bug@amsat.org>
	<CAFEAcA_0rt7cCJs43BjW3OcQh=oeby+4j2dtFPSzgCn9tqW1qQ@mail.gmail.com>
	<5562bd02-5399-b1af-f183-d9a16b0a1c62@amsat.org>
	<1518136859.14456.14.camel@aj.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d252eb0c-1a17-40a1-3f6b-5a7378bba73b@amsat.org>
Date: Fri, 9 Feb 2018 05:57:41 -0300
MIME-Version: 1.0
In-Reply-To: <1518136859.14456.14.camel@aj.id.au>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="SoLE2oQ2TqFhsTa5Fsp4aJ0kRqY8eOcoP"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] hw/arm/aspeed: directly map
 the serial device to the system address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SoLE2oQ2TqFhsTa5Fsp4aJ0kRqY8eOcoP
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <d252eb0c-1a17-40a1-3f6b-5a7378bba73b@amsat.org>
Subject: Re: [Qemu-arm] [PATCH 1/2] hw/arm/aspeed: directly map the serial
 device to the system address space
References: <20180208172202.9984-1-f4bug@amsat.org>
 <20180208172202.9984-2-f4bug@amsat.org>
 <CAFEAcA_0rt7cCJs43BjW3OcQh=oeby+4j2dtFPSzgCn9tqW1qQ@mail.gmail.com>
 <5562bd02-5399-b1af-f183-d9a16b0a1c62@amsat.org>
 <1518136859.14456.14.camel@aj.id.au>
In-Reply-To: <1518136859.14456.14.camel@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/08/2018 09:40 PM, Andrew Jeffery wrote:
> On Thu, 2018-02-08 at 14:40 -0300, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 02/08/2018 02:30 PM, Peter Maydell wrote:
>>> On 8 February 2018 at 17:22, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
=2Eorg> wrote:
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> ---
>>>>  hw/arm/aspeed_soc.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>>>> index c83b7e207b..a786750e14 100644
>>>> --- a/hw/arm/aspeed_soc.c
>>>> +++ b/hw/arm/aspeed_soc.c
>>>> @@ -257,7 +257,7 @@ static void aspeed_soc_realize(DeviceState *dev,=
 Error **errp)
>>>>      /* UART - attach an 8250 to the IO space as our UART5 */
>>>>      if (serial_hds[0]) {
>>>>          qemu_irq uart5 =3D qdev_get_gpio_in(DEVICE(&s->vic), uart_i=
rqs[4]);
>>>> -        serial_mm_init(&s->iomem, ASPEED_SOC_UART_5_BASE, 2,
>>>> +        serial_mm_init(get_system_memory(), ASPEED_SOC_UART_5_BASE,=
 2,
>>>>                         uart5, 38400, serial_hds[0], DEVICE_LITTLE_E=
NDIAN);
>>>>      }
>>>
>>> Is this a bug fix? It certainly changes behaviour, which
>>> suggests that a fuller commit message would be useful.
>>
>> This patch is buggy indeed, using system_memory the serial address
>> should be ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE.
>>
>=20
> If you'd like to test, you can grab images from here:
>=20
> https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3Dromulu=
s/
>=20
> For example (without the patch):
>=20
>     $ wget     https://openpower.xyz/job/openbmc-build/1240/distro=3Dub=
untu,target=3Dromulus/artifact/deploy/images/romulus/image-bmc

Thanks for this useful link!

> ...
> $ qemu-system-arm -M romulus-bmc -m 512 -drive file=3Dimage-bmc,if=3Dmt=
d,format=3Draw -nographic

good candidate for an Avocado / pyexpect test...

>=20
>=20
> U-Boot 2016.07 (Jan 25 2018 - 16:31:27 +0000)  =20
>=20
>        Watchdog enabled                        =20
> DRAM:  496 MiB                                 =20
> Flash: 32 MiB                                  =20
> *** Warning - bad CRC, using default environment
>=20
> In:    serial                                  =20
> Out:   serial                                  =20
> Err:   serial                                  =20
> Net:   aspeednic#0                             =20
> Error: aspeednic#0 address not set.            =20
>=20
> Hit any key to stop autoboot:  0               =20
> ## Loading kernel from FIT Image at 20080000 ...
> ...
>=20
> And yeah, this patch breaks output.

Sorry I didn't care enough testing this series :|

>=20
> Thanks for the cleanup though.
>=20
> Andrew
>=20


--SoLE2oQ2TqFhsTa5Fsp4aJ0kRqY8eOcoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp9YoUACgkQ4+MsLN6t
wN7UfxAAzTAub1oVc+CTBQ1SCmL1YixJbqFMJ7sHmAy6wVSu2S6QGf1IClvtLpr7
qroFx+z7VHyNUPK/J1yIFOMK31jP1hDUM6mFq26/tnjKyZ9CgVZRyubuLLSBB1Sq
xN2nT8TIwCAgTG0QUv/5AXAxidJT+3jq07eVMmKdkt/ea+ueV1sq3SRXXw7G3K71
PwD84vx2jXryEV/wxADFUr4xJbYFxN/CuP1bXAHIHOdB+dgHFMSpA1Izo8uspgu2
Q1OfxVTwNvnNpH0Wt/LdUb0wjqZ0rXNGba6cymY5kr4gor0dAhPLiVUDWnwmjfGU
HDa0qsXH3mPvyKDDMwxoE9AVWRWn9kQYNAmLCsZHelSbdFtSBGyHNl0WzHFLvkC+
yo5NOPQS2FRenbP4bOd87pT742szrozpL6OnpFaYeEyM18ZUYb4bPe1vkjPC1GlF
kU9Bh2wPy+E2N4+RD7u+9NmILVoc7sycUFMLVEcIJGiCAO3rr3lP6MEmNJ0CdEU4
4QGwuokRrxYSDk5gteNTbEAcRKkKmDa1kAQ7Uu4dDcaPRrItkMU0DaCrXdga6eYE
aC33/m5/ds2hi4j2l2suu4dXyCs3YLCOi1tSpOZvK7a3taA4GZjA4U+G9xNU88+p
NPivJmI5JXaUwLHo0K+PTBQEKyqz6mahy4++vYYiNZiOvDOgoXs=
=Qe+9
-----END PGP SIGNATURE-----

--SoLE2oQ2TqFhsTa5Fsp4aJ0kRqY8eOcoP--

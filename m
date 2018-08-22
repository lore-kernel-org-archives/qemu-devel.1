Received: from eggs.gnu.org ([2001:4830:134:3::10]:41765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOTh-0007Fi-2w
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOTb-00025Y-O2
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:26:54 -0400
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-5-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <f724ba64-30e5-d1eb-89ee-b85425733a99@greensocs.com>
Date: Wed, 22 Aug 2018 10:26:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180821132811.17675-5-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3CPjHXtSHGh7z7JZCWPSpf8opm7NpjskL"
Subject: Re: [Qemu-devel] [PATCH 4/9] hw/arm/highbank: Connect VIRQ and VFIQ
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
--3CPjHXtSHGh7z7JZCWPSpf8opm7NpjskL
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <f724ba64-30e5-d1eb-89ee-b85425733a99@greensocs.com>
Subject: Re: [PATCH 4/9] hw/arm/highbank: Connect VIRQ and VFIQ
References: <20180821132811.17675-1-peter.maydell@linaro.org>
 <20180821132811.17675-5-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-5-peter.maydell@linaro.org>
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
>  hw/arm/highbank.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 6d42fce2c37..fb9efa02c35 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -243,6 +243,8 @@ static void calxeda_init(MachineState *machine, enu=
m cxmachines machine_id)
>      int n;
>      qemu_irq cpu_irq[4];
>      qemu_irq cpu_fiq[4];
> +    qemu_irq cpu_virq[4];
> +    qemu_irq cpu_vfiq[4];
>      MemoryRegion *sysram;
>      MemoryRegion *dram;
>      MemoryRegion *sysmem;
> @@ -282,6 +284,8 @@ static void calxeda_init(MachineState *machine, enu=
m cxmachines machine_id)
>          object_property_set_bool(cpuobj, true, "realized", &error_fata=
l);
>          cpu_irq[n] =3D qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ);
>          cpu_fiq[n] =3D qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_FIQ);
> +        cpu_virq[n] =3D qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_VIRQ);
> +        cpu_vfiq[n] =3D qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_VFIQ);
>      }
> =20
>      sysmem =3D get_system_memory();
> @@ -329,6 +333,8 @@ static void calxeda_init(MachineState *machine, enu=
m cxmachines machine_id)
>      for (n =3D 0; n < smp_cpus; n++) {
>          sysbus_connect_irq(busdev, n, cpu_irq[n]);
>          sysbus_connect_irq(busdev, n + smp_cpus, cpu_fiq[n]);
> +        sysbus_connect_irq(busdev, n + 2 * smp_cpus, cpu_virq[n]);
> +        sysbus_connect_irq(busdev, n + 3 * smp_cpus, cpu_vfiq[n]);
>      }
> =20
>      for (n =3D 0; n < 128; n++) {
>=20


--3CPjHXtSHGh7z7JZCWPSpf8opm7NpjskL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9HjgACgkQd8knW3Qn
Tr7LDw//eidxfLDqEHUtEwIEiMQJScK4eIdgfZFHyeRlaROL4fL1UvqEvQm/TQ73
dg39ETwhjtxmfFOKSXpM6QEmmXfOSBZlzn3iI4hmk1U17Rc9lqIzPljB9JgXiIPw
e3qSLeA4deOWywXBqHwmVV53kpEkBEq6Q/AIR5oeBkOAhiEP8M+g/Wj6cn7b1Ytj
RniV4Cln8mD0vGyxh2PiWCBvIF3idjCkRKu/rnRT75G/WSnMYsMsUXHor2ZN/SkA
wm8ppyYQxN4kMgDVr3UXMOys/c9BVBYqqG5EFgLmeVfKRtRGaRvpI80ZlWy6VpLw
IR3EEWBmCaY6x5Hje6LvPCZB9afPq67bxpj6Zak7UWWLm+99NvO9W+nzJ1ptHXBZ
UlUoAMzjiFuF18USQMpehTln7PmPPX7WOgCao8rbiqdQp3uuzzxqpFId7OwJ4Vro
54TFPQsAcrz7qLG5nJfz5U6ADMex9qnO8IfiRkZEgH7F4/E7flrSKblMmGRx/JSw
nWRmaD57gJ8KnLTiHY8ecJ5KOUYuM7eYMS7v72WrzaviZrhHkCdzhnwzEWsPxXql
3sVeKNPJaxS5dm6rGH9e0s1phE7uTFvDz7ANkX7U7OIp4OYjUGETPwW8v5rnf69D
IKQDLm0kxwLnQhRmBeuMS/jGqaGr9h1pvIASiI1C3jnNdP1YGK4=
=TRoT
-----END PGP SIGNATURE-----

--3CPjHXtSHGh7z7JZCWPSpf8opm7NpjskL--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0H-0007Jc-EW
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0E-00029n-GR
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:25 -0400
Date: Sat, 23 Sep 2017 15:10:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170923051041.GY4998@umbus.fritz.box>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ng9nCnWcMXS7n1y7"
Content-Disposition: inline
In-Reply-To: <20170922160111.31885-2-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 24/34] hw/timer/mc146818: rename rtc_init()
 -> mc146818_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Richard Henderson <rth@twiddle.net>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org


--Ng9nCnWcMXS7n1y7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 01:01:01PM -0300, Philippe Mathieu-Daud=E9 wrote:
> and remove the old i386/pc dependency
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/timer/mc146818rtc.h | 3 ++-
>  hw/alpha/dp264.c               | 2 +-
>  hw/i386/pc.c                   | 2 +-
>  hw/isa/i82378.c                | 3 ++-
>  hw/mips/mips_fulong2e.c        | 2 +-
>  hw/mips/mips_jazz.c            | 2 +-
>  hw/mips/mips_malta.c           | 2 +-
>  hw/mips/mips_r4k.c             | 2 +-
>  hw/ppc/pnv.c                   | 2 +-
>  hw/timer/mc146818rtc.c         | 2 +-
>  10 files changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rt=
c.h
> index 7c8e64b203..fe6ed63f71 100644
> --- a/include/hw/timer/mc146818rtc.h
> +++ b/include/hw/timer/mc146818rtc.h
> @@ -6,7 +6,8 @@
> =20
>  #define TYPE_MC146818_RTC "mc146818rtc"
> =20
> -ISADevice *rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq);
> +ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
> +                             qemu_irq intercept_irq);
>  void rtc_set_memory(ISADevice *dev, int addr, int val);
>  int rtc_get_memory(ISADevice *dev, int addr);
> =20
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 2253990654..df6dadf13f 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -80,7 +80,7 @@ static void clipper_init(MachineState *machine)
>                             clipper_pci_map_irq);
> =20
>      /* Since we have an SRM-compatible PALcode, use the SRM epoch.  */
> -    rtc_init(isa_bus, 1900, rtc_irq);
> +    mc146818_rtc_init(isa_bus, 1900, rtc_irq);
> =20
>      i8254_pit_init(isa_bus, 0x40, 0, NULL);
>      isa_create_simple(isa_bus, TYPE_I8042);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 76d4be5991..788844e0de 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1545,7 +1545,7 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq=
 *gsi,
>              rtc_irq =3D qdev_get_gpio_in(hpet, HPET_LEGACY_RTC_INT);
>          }
>      }
> -    *rtc_state =3D rtc_init(isa_bus, 2000, rtc_irq);
> +    *rtc_state =3D mc146818_rtc_init(isa_bus, 2000, rtc_irq);
> =20
>      qemu_register_boot_set(pc_boot_set, *rtc_state);
> =20
> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> index 7a8baef23c..14b006cadc 100644
> --- a/hw/isa/i82378.c
> +++ b/hw/isa/i82378.c
> @@ -21,6 +21,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/i386/pc.h"
>  #include "hw/timer/i8254.h"
> +#include "hw/timer/mc146818rtc.h"
>  #include "hw/audio/pcspk.h"
> =20
>  #define TYPE_I82378 "i82378"
> @@ -106,7 +107,7 @@ static void i82378_realize(PCIDevice *pci, Error **er=
rp)
>      isa =3D isa_create_simple(isabus, "i82374");
> =20
>      /* timer */
> -    isa_create_simple(isabus, "mc146818rtc");
> +    isa_create_simple(isabus, TYPE_MC146818_RTC);
>  }
> =20
>  static void i82378_init(Object *obj)
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 6dc6a0ac18..7ebbffa8f2 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -371,7 +371,7 @@ static void mips_fulong2e_init(MachineState *machine)
>      /* Super I/O */
>      isa_create_simple(isa_bus, TYPE_I8042);
> =20
> -    rtc_init(isa_bus, 2000, NULL);
> +    mc146818_rtc_init(isa_bus, 2000, NULL);
> =20
>      serial_hds_isa_init(isa_bus, 0, MAX_SERIAL_PORTS);
>      parallel_hds_isa_init(isa_bus, 1);
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 1b54602c1d..439bbd71fe 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -295,7 +295,7 @@ static void mips_jazz_init(MachineState *machine,
>      fdctrl_init_sysbus(qdev_get_gpio_in(rc4030, 1), -1, 0x80003000, fds);
> =20
>      /* Real time clock */
> -    rtc_init(isa_bus, 1980, NULL);
> +    mc146818_rtc_init(isa_bus, 1980, NULL);
>      memory_region_init_io(rtc, NULL, &rtc_ops, NULL, "rtc", 0x1000);
>      memory_region_add_subregion(address_space, 0x80004000, rtc);
> =20
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 050da36f1d..6945fa47c3 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1225,7 +1225,7 @@ void mips_malta_init(MachineState *machine)
>      /* Super I/O */
>      isa_create_simple(isa_bus, TYPE_I8042);
> =20
> -    rtc_init(isa_bus, 2000, NULL);
> +    mc146818_rtc_init(isa_bus, 2000, NULL);
>      serial_hds_isa_init(isa_bus, 0, 2);
>      parallel_hds_isa_init(isa_bus, 1);
> =20
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 946097a31f..349da59912 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -279,7 +279,7 @@ void mips_r4k_init(MachineState *machine)
>      i8259 =3D i8259_init(isa_bus, env->irq[2]);
>      isa_bus_irqs(isa_bus, i8259);
> =20
> -    rtc_init(isa_bus, 2000, NULL);
> +    mc146818_rtc_init(isa_bus, 2000, NULL);
> =20
>      pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
> =20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 47221158d4..d188b899c5 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -647,7 +647,7 @@ static void ppc_powernv_init(MachineState *machine)
>      serial_hds_isa_init(pnv->isa_bus, 0, MAX_SERIAL_PORTS);
> =20
>      /* Create an RTC ISA device too */
> -    rtc_init(pnv->isa_bus, 2000, NULL);
> +    mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
> =20
>      /* OpenPOWER systems use a IPMI SEL Event message to notify the
>       * host to powerdown */
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 82843ed03f..f7d8c4bae4 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -997,7 +997,7 @@ static void rtc_realizefn(DeviceState *dev, Error **e=
rrp)
>      qdev_init_gpio_out(dev, &s->irq, 1);
>  }
> =20
> -ISADevice *rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
> +ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq interc=
ept_irq)
>  {
>      DeviceState *dev;
>      ISADevice *isadev;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ng9nCnWcMXS7n1y7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnF7NEACgkQbDjKyiDZ
s5K7tQ/+NVPSEqNZ5Op81mWHWKiPdthWMUBcCs0YLUICL/vbqdbVw5zyCFX14Jmv
EcVIDgrXnOjKuO9/InrOlVuQpiDuuoQBoVWO9ZghdJtVZ0vGGlf0tSuOlg8Rl+IH
9sZ/V7tUuDyfydMnRgpDS+6CMzWrdS4PQRTWbT+IbXdZxjiK5GFjOJUCOltKKCdh
2tb7uBe507vH5GAHyqW+joQXyi1WWT224fc6hGfcZ1AuQH/rRrUEaCHUtgvmHnj2
wTuwzoNpIWrZUieU1FRWvTvro4ckALbqzdFqqKNr5qXg24fg8YEucl+ZwCwTFLsX
AbG2GWpGndFWQH33fAIkOj+i4juGgIVMJc+/E9WvBVkJs/DZJNUZMqk8CkpIK40w
dTdnPAPO0ZvjwYvGBkLMI1YNy8cGCAnUSjdNPsh+covJyN2JuAEH/YSK8jEsTyHV
q0GRDwiLyV8Uimq+ijmzifl/lUbLL/SFWogK0ZY8atWRjaG9VRP5FWl3LE9TcOat
aulxAPOIXqra6MFO84n9eW3DMkslPe5OeUeVKf1GGoRLRvEp6uyZh03rzPYmcz6S
+2PeA3/x4qfJKXBqlUZhi6yNTP8TMSGVuJhSt7sWa4at3M7WUbs1NO/bo8I3Bcp3
Qs8irH+fDl9nzPhoA74+Rk2s4to/oXwI8q7XI01rZf+osA7j85U=
=EnLC
-----END PGP SIGNATURE-----

--Ng9nCnWcMXS7n1y7--

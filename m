Received: from eggs.gnu.org ([2001:4830:134:3::10]:36101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0G-0007JP-38
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0F-0002AB-3o
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:24 -0400
Date: Sat, 23 Sep 2017 15:11:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170923051109.GZ4998@umbus.fritz.box>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vDpQvD79HZx/5O2q"
Content-Disposition: inline
In-Reply-To: <20170922160111.31885-3-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 25/34] hw/timer/m48t59: use TYPE_M48T59_ISA,
 add entries to MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org


--vDpQvD79HZx/5O2q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 01:01:02PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

ppc portion

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/timer/m48t59.h | 2 ++
>  hw/ppc/prep.c             | 2 +-
>  hw/timer/m48t59-isa.c     | 2 +-
>  MAINTAINERS               | 2 ++
>  4 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/timer/m48t59.h b/include/hw/timer/m48t59.h
> index db5e43a8da..069bb045d7 100644
> --- a/include/hw/timer/m48t59.h
> +++ b/include/hw/timer/m48t59.h
> @@ -25,6 +25,8 @@ typedef struct NvramClass {
>      void (*toggle_lock)(Nvram *obj, int lock);
>  } NvramClass;
> =20
> +#define TYPE_M48T59_ISA "isa-m48t59"
> +
>  Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
>                         int base_year, int type);
>  Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 16f4537093..1f8ef4819b 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -777,7 +777,7 @@ static void ibm_40p_init(MachineState *machine)
>      /* add some more devices */
>      if (defaults_enabled()) {
>          isa_create_simple(isa_bus, TYPE_I8042);
> -        m48t59 =3D NVRAM(isa_create_simple(isa_bus, "isa-m48t59"));
> +        m48t59 =3D NVRAM(isa_create_simple(isa_bus, TYPE_M48T59_ISA));
> =20
>          dev =3D DEVICE(isa_create(isa_bus, "cs4231a"));
>          qdev_prop_set_uint32(dev, "iobase", 0x830);
> diff --git a/hw/timer/m48t59-isa.c b/hw/timer/m48t59-isa.c
> index ea1ba703d7..077346f7ca 100644
> --- a/hw/timer/m48t59-isa.c
> +++ b/hw/timer/m48t59-isa.c
> @@ -49,7 +49,7 @@ typedef struct M48txxISADeviceClass {
> =20
>  static M48txxInfo m48txx_isa_info[] =3D {
>      {
> -        .bus_name =3D "isa-m48t59",
> +        .bus_name =3D TYPE_M48T59_ISA,
>          .model =3D 59,
>          .size =3D 0x2000,
>      }
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a79723601c..3cb6bc190c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -708,6 +708,8 @@ F: hw/pci-host/prep.[hc]
>  F: hw/isa/i82378.c
>  F: hw/isa/pc87312.[hc]
>  F: hw/dma/i82374.c
> +F: hw/timer/m48t59-isa.c
> +F: include/hw/timer/m48t59.h
>  F: pc-bios/ppc_rom.bin
> =20
>  sPAPR

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vDpQvD79HZx/5O2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnF7O0ACgkQbDjKyiDZ
s5IjZRAAt0e4gzC/3XWGzGLnz62ymtGKLaigfGpSlGae7iCsLfK+tDz6q5BT/mVx
VThhjlKqHQ/Lfy2LKdhvlI2oXpw6ca/f8RBqyoMEhJaq2vNJRzQMxv+OkJxuVq6k
UQxnVQuv1pGVYMEfCychUWkFHmbBYWeNQbbD53PvaNkUh6zb68dR+30wmXBUz55n
t4+ULgcM3pyr56MITC+K4I/Tf+JvmN4wpcFvMPlrBqkvK/KqA9C/TdCz5rxZQmCo
PQMtBxCLL6e3dAgMviQ3rsUsshL1tair3gPtbj+CSUylzisEIxzNYaORmX9WVuan
SGz/jsFqLDCsas99uLa/kFzxGqlEIMMtJRtqmX6gkB0mmKkUKmEuzekDjKEx1Uif
KVSnypYhsTak997M9TxUUdmD/fpdgvhhH0rA7HC/f1hulynoSb/pm1jDqXYU/XGt
rBlvbBRPRsGlqoTvkKZVIXhTr2CL6/MBO55uNx+KRwbosURLvKMZOw7mo1OYj7iH
u74SrjtjvohDaHi7D36UKpfFezhaCF8PD5us4XuVP99il8vn/kfQkZz0iQXy1UoD
z0kVp+EPnw0sFK0zHDYqb6TyTVrzIRqz8JZhpRz3O5W6VMeJkpSytsaZ+/5RG4J/
osJCo5Rs+4+9nb9H86ql+ewZZOEi94G3x2/pS1Gw85fLpD5Lc04=
=Afmo
-----END PGP SIGNATURE-----

--vDpQvD79HZx/5O2q--

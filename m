Received: from eggs.gnu.org ([2001:4830:134:3::10]:38227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJ91e-0002hP-EO
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 21:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJ91b-0001Fq-A5
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 21:20:02 -0500
Date: Mon, 27 Nov 2017 12:52:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171127015209.GB11775@umbus.fritz.box>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
In-Reply-To: <20171125151610.20547-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] ppc: e500: Allow only supported
 dynamic sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:16:07PM -0200, Eduardo Habkost wrote:
> platform_bus_create_devtree() already rejects all dynamic sysbus
> devices except TYPE_ETSEC_COMMON, so register it as the only
> allowed dynamic sysbus device for the ppce500 machine-type.
>=20
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Do you need me to take this through my tree (for 2.12), or do you have
another merge patch in mind?

> ---
> Changes series v1 -> v2:
> * New patch added to series
> ---
>  hw/ppc/e500plat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index 438118c29b..81d03e1038 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -12,6 +12,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "e500.h"
> +#include "hw/net/fsl_etsec/etsec.h"
>  #include "hw/boards.h"
>  #include "sysemu/device_tree.h"
>  #include "sysemu/kvm.h"
> @@ -64,8 +65,7 @@ static void e500plat_machine_init(MachineClass *mc)
>      mc->desc =3D "generic paravirt e500 platform";
>      mc->init =3D e500plat_init;
>      mc->max_cpus =3D 32;
> -    /*TODO: allow only sysbus devices that really work with this machine=
 */
> -    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlobb8kACgkQbDjKyiDZ
s5LpnxAAvuNZZttX+GWxpB6zwMODBHrzPJ2KdlDEtswpcqudyESpSpim0R6eah2Y
d6FBaF1nBg+DVppWeE8d2e45YVyIUX6w2zdYPrkqIRKnL5kTyRL+k9hhv0SHVeDP
FaNeFqpAqIdEMCjwnorH6lhVx7gQHJ+BxAuBvOf5ndIlAqW8O/uxbBOO6GamREf3
bO8hqBXP6+2amMdp0FlSf94CU6bzkyZe9S8B2Se4OyncJsEKHUIq9L0faOZ5lwy8
YediMk8G/hddPGQj49DMLIDn1PDRnSQfZmnW9ZLodmXTfpiC0Q1OMT7LkcCX4AoJ
wVPw67kWAIxf9xVR986a2wVax5dV4lueU+y9gu503CFV/wWr4gkxCUzHQckhKTB5
utsTfub6rdOuiMPIT9Dc7Ww8fNcD9BlGYrs9Sl0a40pQskt1N39c9gW1iNX1leyu
d1n/mpjYhUyhHMzBVrvgKooc/uEt/es6TUnIQZpgF8GbaxmcZEsJk05qDIKgpVX+
/ECgc6VNEHwgil0QmHjpFxV1aIQkSKCYljebL+cJltP9RHuyNABPRsn8Sv5tvYa1
Vuwzj/feZH+pZNx9bsauaV8YhCmAw6DsEYAKjxJtMW3DMw0Tvnko0gb8+AIVEDnu
zav8DBPKDvyoXpAFIlehfh9KKnB8Q5vUcEO/69+JCjmkbfgpOAg=
=bvC4
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

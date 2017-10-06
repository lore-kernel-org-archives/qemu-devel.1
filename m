Received: from eggs.gnu.org ([2001:4830:134:3::10]:40304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPG-0004Vu-Ew
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPE-0008EF-Uk
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:54 -0400
Date: Fri, 6 Oct 2017 19:47:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006084727.GB10961@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-24-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-24-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/23] ppc: pnv: consolidate type
 definitions and batch register them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:50PM +0200, Igor Mammedov wrote:
> Use a new DEFINE_TYPES() helper to simplify type registration
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/pnv.c | 92 ++++++++++++++++++++++--------------------------------=
------
>  1 file changed, 34 insertions(+), 58 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index ab7083b..e23dc3c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -730,13 +730,6 @@ static void pnv_chip_power8e_class_init(ObjectClass =
*klass, void *data)
>      dc->desc =3D "PowerNV Chip POWER8E";
>  }
> =20
> -static const TypeInfo pnv_chip_power8e_info =3D {
> -    .name          =3D TYPE_PNV_CHIP_POWER8E,
> -    .parent        =3D TYPE_PNV_CHIP,
> -    .instance_size =3D sizeof(PnvChip),
> -    .class_init    =3D pnv_chip_power8e_class_init,
> -};
> -
>  static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -751,13 +744,6 @@ static void pnv_chip_power8_class_init(ObjectClass *=
klass, void *data)
>      dc->desc =3D "PowerNV Chip POWER8";
>  }
> =20
> -static const TypeInfo pnv_chip_power8_info =3D {
> -    .name          =3D TYPE_PNV_CHIP_POWER8,
> -    .parent        =3D TYPE_PNV_CHIP,
> -    .instance_size =3D sizeof(PnvChip),
> -    .class_init    =3D pnv_chip_power8_class_init,
> -};
> -
>  static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -772,13 +758,6 @@ static void pnv_chip_power8nvl_class_init(ObjectClas=
s *klass, void *data)
>      dc->desc =3D "PowerNV Chip POWER8NVL";
>  }
> =20
> -static const TypeInfo pnv_chip_power8nvl_info =3D {
> -    .name          =3D TYPE_PNV_CHIP_POWER8NVL,
> -    .parent        =3D TYPE_PNV_CHIP,
> -    .instance_size =3D sizeof(PnvChip),
> -    .class_init    =3D pnv_chip_power8nvl_class_init,
> -};
> -
>  static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -793,13 +772,6 @@ static void pnv_chip_power9_class_init(ObjectClass *=
klass, void *data)
>      dc->desc =3D "PowerNV Chip POWER9";
>  }
> =20
> -static const TypeInfo pnv_chip_power9_info =3D {
> -    .name          =3D TYPE_PNV_CHIP_POWER9,
> -    .parent        =3D TYPE_PNV_CHIP,
> -    .instance_size =3D sizeof(PnvChip),
> -    .class_init    =3D pnv_chip_power9_class_init,
> -};
> -
>  static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
>  {
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> @@ -1001,15 +973,6 @@ static void pnv_chip_class_init(ObjectClass *klass,=
 void *data)
>      dc->desc =3D "PowerNV Chip";
>  }
> =20
> -static const TypeInfo pnv_chip_info =3D {
> -    .name          =3D TYPE_PNV_CHIP,
> -    .parent        =3D TYPE_SYS_BUS_DEVICE,
> -    .class_init    =3D pnv_chip_class_init,
> -    .instance_init =3D pnv_chip_init,
> -    .class_size    =3D sizeof(PnvChipClass),
> -    .abstract      =3D true,
> -};
> -
>  static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
>  {
>      PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
> @@ -1145,27 +1108,40 @@ static void powernv_machine_class_init(ObjectClas=
s *oc, void *data)
>      powernv_machine_class_props_init(oc);
>  }
> =20
> -static const TypeInfo powernv_machine_info =3D {
> -    .name          =3D TYPE_POWERNV_MACHINE,
> -    .parent        =3D TYPE_MACHINE,
> -    .instance_size =3D sizeof(PnvMachineState),
> -    .instance_init =3D powernv_machine_initfn,
> -    .class_init    =3D powernv_machine_class_init,
> -    .interfaces =3D (InterfaceInfo[]) {
> -        { TYPE_XICS_FABRIC },
> -        { TYPE_INTERRUPT_STATS_PROVIDER },
> -        { },
> +#define DEFINE_PNV_CHIP_TYPE(type, class_initfn) \
> +    {                                            \
> +        .name          =3D type,                   \
> +        .class_init    =3D class_initfn,           \
> +        .parent        =3D TYPE_PNV_CHIP,          \
> +    }
> +
> +static const TypeInfo types[] =3D {
> +    {
> +        .name          =3D TYPE_POWERNV_MACHINE,
> +        .parent        =3D TYPE_MACHINE,
> +        .instance_size =3D sizeof(PnvMachineState),
> +        .instance_init =3D powernv_machine_initfn,
> +        .class_init    =3D powernv_machine_class_init,
> +        .interfaces =3D (InterfaceInfo[]) {
> +            { TYPE_XICS_FABRIC },
> +            { TYPE_INTERRUPT_STATS_PROVIDER },
> +            { },
> +        },
>      },
> +    {
> +        .name          =3D TYPE_PNV_CHIP,
> +        .parent        =3D TYPE_SYS_BUS_DEVICE,
> +        .class_init    =3D pnv_chip_class_init,
> +        .instance_init =3D pnv_chip_init,
> +        .instance_size =3D sizeof(PnvChip),
> +        .class_size    =3D sizeof(PnvChipClass),
> +        .abstract      =3D true,
> +    },
> +    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class_ini=
t),
> +    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_ini=
t),
> +    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_i=
nit),
> +    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
> +                         pnv_chip_power8nvl_class_init),
>  };
> =20
> -static void powernv_machine_register_types(void)
> -{
> -    type_register_static(&powernv_machine_info);
> -    type_register_static(&pnv_chip_info);
> -    type_register_static(&pnv_chip_power8e_info);
> -    type_register_static(&pnv_chip_power8_info);
> -    type_register_static(&pnv_chip_power8nvl_info);
> -    type_register_static(&pnv_chip_power9_info);
> -}
> -
> -type_init(powernv_machine_register_types)
> +DEFINE_TYPES(types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXQx8ACgkQbDjKyiDZ
s5L2Xw//ddzcZq8Ln4hAaPjJwIwijRXY85qMna3/mqIH1aeYXgcYLKPhHblpDk/I
RZjJwQJg/tr+FCo6H9di+jpRnJkc7geTXtoQJ26AG6JTJiMp0MqMaKXkt9zt1DpV
xGMg2dWBEAQ4s9nE/ddcNf/n2+aSg09GV1kguWj14jMg77wPnOlvmRscPNHUVgDQ
xcofPNH+LTfbO/dc2ADpHRtW3d7qKVixqcgkyz+zPq4k2ZBDd4cmoB7yy477pFKb
zKxse1Ozbma6RdgDIf7MjSwvnNAZbOmutit0HXAqhW0aIE86y4y0Ln6n3iO3fEGb
8MhqbmS/+TlmE2573UmCoccq+qMH3EDWU9/phdYTXd4IE3QHUQB4LkT8lJUswPJV
R3Q3zYEWXwxDYk33k2ORyTt4GrtPWqEpoJL/PtWlEXspO0eB35Mxd85PP97fGHY9
vkw/10ukPGqfGJWDbugiOMjn0QyWiJ57R5ay6jh7/GDhx4V8jguqmS8wSHnLSfci
yo9Y+3bscysh9riYiwtN7r9RmVOiJ4A49DDXS7m83JxvvTACUUV8yQGcIYZnGfUR
HPYkcuEwitLxt8/Kg8M6iPHmaJWghbkSD/dZtbyNJsIoO3oKixWOaMa7tUY51PI/
ht8T6RDxiyxvnZOFVG7EXfgXo9jlsFaoZc6LN7PKGp9BKrw/1sU=
=mJbO
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

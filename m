Received: from eggs.gnu.org ([2001:4830:134:3::10]:44087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUfon-0007xX-2V
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUfok-0005Vk-Ut
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:38:57 -0500
Date: Thu, 6 Dec 2018 09:30:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181205223035.GH768@umbus.fritz.box>
References: <20181205205827.19387-1-ehabkost@redhat.com>
	<20181205205827.19387-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="17/8oYur5Y32USnW"
Content-Disposition: inline
In-Reply-To: <20181205205827.19387-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 4/5] spapr: Delete instance_options
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>


--17/8oYur5Y32USnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 06:58:26PM -0200, Eduardo Habkost wrote:
> Now that all instance_options functions for spapr are empty,
> delete them.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Do you want me to stage the ppc patches in my ppc-for-4.0 tree, or
would you prefer to keep your series together to go in via your tree?

> ---
>  hw/ppc/spapr.c | 85 --------------------------------------------------
>  1 file changed, 85 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0c3b27a8cc..523e5d83f8 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3939,16 +3939,10 @@ static const TypeInfo spapr_machine_info =3D {
>              mc->is_default =3D 1;                                      \
>          }                                                            \
>      }                                                                \
> -    static void spapr_machine_##suffix##_instance_init(Object *obj)  \
> -    {                                                                \
> -        MachineState *machine =3D MACHINE(obj);                        \
> -        spapr_machine_##suffix##_instance_options(machine);          \
> -    }                                                                \
>      static const TypeInfo spapr_machine_##suffix##_info =3D {          \
>          .name =3D MACHINE_TYPE_NAME("pseries-" verstr),                \
>          .parent =3D TYPE_SPAPR_MACHINE,                                \
>          .class_init =3D spapr_machine_##suffix##_class_init,           \
> -        .instance_init =3D spapr_machine_##suffix##_instance_init,     \
>      };                                                               \
>      static void spapr_machine_register_##suffix(void)                \
>      {                                                                \
> @@ -3959,10 +3953,6 @@ static const TypeInfo spapr_machine_info =3D {
>  /*
>   * pseries-4.0
>   */
> -static void spapr_machine_4_0_instance_options(MachineState *machine)
> -{
> -}
> -
>  static void spapr_machine_4_0_class_options(MachineClass *mc)
>  {
>      /* Defaults for the latest behaviour inherited from the base class */
> @@ -3976,11 +3966,6 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
>  #define SPAPR_COMPAT_3_1                                              \
>      HW_COMPAT_3_1
> =20
> -static void spapr_machine_3_1_instance_options(MachineState *machine)
> -{
> -    spapr_machine_4_0_instance_options(machine);
> -}
> -
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
>      spapr_machine_3_1_class_options(mc);
> @@ -3995,11 +3980,6 @@ DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
>  #define SPAPR_COMPAT_3_0                                              \
>      HW_COMPAT_3_0
> =20
> -static void spapr_machine_3_0_instance_options(MachineState *machine)
> -{
> -    spapr_machine_3_1_instance_options(machine);
> -}
> -
>  static void spapr_machine_3_0_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4029,11 +4009,6 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
>          .value    =3D "on",                                             =
 \
>      },
> =20
> -static void spapr_machine_2_12_instance_options(MachineState *machine)
> -{
> -    spapr_machine_3_0_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_12_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4051,11 +4026,6 @@ static void spapr_machine_2_12_class_options(Machi=
neClass *mc)
> =20
>  DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> =20
> -static void spapr_machine_2_12_sxxm_instance_options(MachineState *machi=
ne)
> -{
> -    spapr_machine_2_12_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4074,11 +4044,6 @@ DEFINE_SPAPR_MACHINE(2_12_sxxm, "2.12-sxxm", false=
);
>  #define SPAPR_COMPAT_2_11                                              \
>      HW_COMPAT_2_11
> =20
> -static void spapr_machine_2_11_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_12_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_11_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4096,11 +4061,6 @@ DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
>  #define SPAPR_COMPAT_2_10                                              \
>      HW_COMPAT_2_10
> =20
> -static void spapr_machine_2_10_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_11_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_10_class_options(MachineClass *mc)
>  {
>      spapr_machine_2_11_class_options(mc);
> @@ -4120,11 +4080,6 @@ DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
>          .value    =3D "on",                                             =
 \
>      },                                                                 \
> =20
> -static void spapr_machine_2_9_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_10_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_9_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4149,11 +4104,6 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
>          .value    =3D "off",                                      \
>      },
> =20
> -static void spapr_machine_2_8_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_9_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_8_class_options(MachineClass *mc)
>  {
>      spapr_machine_2_9_class_options(mc);
> @@ -4238,11 +4188,6 @@ static void phb_placement_2_7(sPAPRMachineState *s=
papr, uint32_t index,
>       */
>  }
> =20
> -static void spapr_machine_2_7_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_8_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_7_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4267,11 +4212,6 @@ DEFINE_SPAPR_MACHINE(2_7, "2.7", false);
>          .value    =3D stringify(off),\
>      },
> =20
> -static void spapr_machine_2_6_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_7_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_6_class_options(MachineClass *mc)
>  {
>      spapr_machine_2_7_class_options(mc);
> @@ -4292,11 +4232,6 @@ DEFINE_SPAPR_MACHINE(2_6, "2.6", false);
>          .value    =3D "off", \
>      },
> =20
> -static void spapr_machine_2_5_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_6_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_5_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4314,11 +4249,6 @@ DEFINE_SPAPR_MACHINE(2_5, "2.5", false);
>  #define SPAPR_COMPAT_2_4 \
>          HW_COMPAT_2_4
> =20
> -static void spapr_machine_2_4_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_5_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_4_class_options(MachineClass *mc)
>  {
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4341,11 +4271,6 @@ DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
>              .value    =3D "off",\
>          },
> =20
> -static void spapr_machine_2_3_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_4_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_3_class_options(MachineClass *mc)
>  {
>      spapr_machine_2_4_class_options(mc);
> @@ -4365,11 +4290,6 @@ DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
>              .value    =3D "0x20000000",\
>          },
> =20
> -static void spapr_machine_2_2_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_3_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_2_class_options(MachineClass *mc)
>  {
>      spapr_machine_2_3_class_options(mc);
> @@ -4384,11 +4304,6 @@ DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
>  #define SPAPR_COMPAT_2_1 \
>          HW_COMPAT_2_1
> =20
> -static void spapr_machine_2_1_instance_options(MachineState *machine)
> -{
> -    spapr_machine_2_2_instance_options(machine);
> -}
> -
>  static void spapr_machine_2_1_class_options(MachineClass *mc)
>  {
>      spapr_machine_2_2_class_options(mc);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--17/8oYur5Y32USnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwIUYsACgkQbDjKyiDZ
s5Lwxw/9F8phlhWC8sDy/QqFDlu3G2LYn9yLXKAA6k8nuBq9THTKLeXWg8q5bje/
Ej1VAmn8pbbyaWF7dSd/WXdEkCu6tGv6xh7YvCZYQA38LjbVzUhhczAW19t7AKxS
mZS3niYLFh98ZUr7tjIj41zAGMHGWmmEOw1N61jahS52HqaJ7iuwpK6wk6G2lifE
lPgrJFUYjF74459eXQ8lcUI5k9wdZSBJ6mxXNbffL/HTBjH8mDvMz+cctNJw/EYp
Q2h87hDSue0xPoUkLnQlwfeBpbO7ro4t3GYF2thXazuWaVnxYcnS+yxxBwS6ojwT
YBY+mr+rKRgkfbl67dtK5CV9vFuZCPLg+Yi5BJNM/yMp1/oPoSfPebO7KGvoNJVn
I1GGgZIEshxe6kU8N7VstscbqrfoubDf5RMbBa+MP19CZuD77jCvz62hXTZeAsSM
gG4OMB+U7lanCMHP+7iAhNWjn31ZITjZYboHYu2LBRxmkbsFn+Bg0ljs6I6mAGgK
Qnqklb8/8Sjxgmf7ggmObBpaZQA1cuDekP0i7RfAsLImsgPQeumZOAQr4a3g4lvI
p2WTXi34MEw1Syr0y8nUBb++mXrUHFp4OKugnv6AwzWqtaNtR7clMQWRfK1NwwG5
72C1BB25KU+G+aFJq+9F5EzHMOJemAF42SO1ONKjFkJKQLTKSEY=
=sAV/
-----END PGP SIGNATURE-----

--17/8oYur5Y32USnW--

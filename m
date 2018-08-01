Received: from eggs.gnu.org ([2001:4830:134:3::10]:40626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkinV-0000ta-Pb
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 00:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fkinU-0004I2-Jz
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 00:31:41 -0400
Date: Wed, 1 Aug 2018 14:27:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180801042759.GO2708@umbus.fritz.box>
References: <20180730141134.31153-1-clg@kaod.org>
	<20180730141134.31153-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Content-Disposition: inline
In-Reply-To: <20180730141134.31153-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 1/4] spapr: Add a pseries-3.1 machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 30, 2018 at 04:11:31PM +0200, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-3.1, thanks.

> ---
>  include/hw/compat.h |  3 +++
>  hw/ppc/spapr.c      | 23 +++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index c08f4040bb80..6f4d5fc64704 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
> =20
> +#define HW_COMPAT_3_0 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_12 \
>      {\
>          .driver   =3D "migration",\
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 421b2dd09b51..3c72173c7e0f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4058,19 +4058,38 @@ static const TypeInfo spapr_machine_info =3D {
>      }                                                                \
>      type_init(spapr_machine_register_##suffix)
> =20
> + /*
> + * pseries-3.1
> + */
> +static void spapr_machine_3_1_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void spapr_machine_3_1_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
> +
>  /*
>   * pseries-3.0
>   */
> +#define SPAPR_COMPAT_3_0                                              \
> +    HW_COMPAT_3_0
> +
>  static void spapr_machine_3_0_instance_options(MachineState *machine)
>  {
> +    spapr_machine_3_1_instance_options(machine);
>  }
> =20
>  static void spapr_machine_3_0_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_3_1_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_0);
>  }
> =20
> -DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
> +DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
> =20
>  /*
>   * pseries-2.12

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlthNs8ACgkQbDjKyiDZ
s5It5Q//YZLcKKhOU1E5nUL29oc0o1s2ah1MEUlFTlcRGjLffhUW2WNkGeJ4TBwk
t33rj1oUywmiPe8ncy1urMWrKlfkCXd4r1HBknQICiNeU8o1OCGjoK0lhtXCl4LC
HWLrVKHACe530KuMZOhjKnCtT3rpDDXSeaWO5ZMyQCPbSM+Rhv40o6/31W2/qadX
r8lI/WNuLu6Aaig4+HWBiubl4F4nDNQxmFgkf7v/7OkBsjr7TgmlojyQSUgR0i4Y
ktI08dnGKOJhgSc/tcRroSCFUn52l/fJEEuS2IS0SbHAOfgzMDT8WDEK3mEZbjKU
IXL5qLrpyn5VtEqDgD0/x6o1hrv78W0NtPrx/EjQhsOmDkiWBGRJ1sTuDYARr73i
QyYiMA4uuZG7JIDgs9S0DNn9qzRPb7CH+Cj+tUo2+0oQAIYdm287LwpPZa8Cgzk1
UCis/xEel2Dw5lJvEPvEveKV4C8XYWZvLPc02lK5xXUhbYzyYHPkks9df0zbshAV
0dgZvi0hTNKWqxTQxxnKipwoOfQ4idGlO1C5GbKGouWfTWE/LD1ofRwu7YG5RU1h
ev4f+K4KnahI1jccG67+HLZxMHGiFQQCLG4eeI1b5qXddh2bTfH6oZeqGyzKd1J9
v7bevomJh3VV4leBHXRPdL2k17yIbKj08g0IKqOW7E2g10CTCAs=
=7N4f
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--

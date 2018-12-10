Received: from eggs.gnu.org ([2001:4830:134:3::10]:58101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWFRP-0004Gl-D5
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWFRJ-0003kD-HH
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:53:18 -0500
Date: Mon, 10 Dec 2018 17:45:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181210064447.GW4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-18-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VAM/tfeJyUfWz6bO"
Content-Disposition: inline
In-Reply-To: <20181209194610.29727-18-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 17/19] spapr: Add a pseries-4.0 machine
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--VAM/tfeJyUfWz6bO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 08:46:08PM +0100, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, since we'll need something like this sooner or later anyway.
I may have conflicts to resolve since I think a patch including a
similar chage is in someone else's tree, but it shouldn't be too hard
to deal with.

> ---
>  include/hw/compat.h |  3 +++
>  hw/ppc/spapr.c      | 25 ++++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 6f4d5fc64704..70958328fe7a 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
> =20
> +#define HW_COMPAT_3_1 \
> +    /* empty */
> +
>  #define HW_COMPAT_3_0 \
>      /* empty */
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index fa41927d95dd..4012ebd794a4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3971,19 +3971,38 @@ static const TypeInfo spapr_machine_info =3D {
>      }                                                                \
>      type_init(spapr_machine_register_##suffix)
> =20
> - /*
> +/*
> + * pseries-4.0
> + */
> +static void spapr_machine_4_0_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void spapr_machine_4_0_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> +
> +/*
>   * pseries-3.1
>   */
> +#define SPAPR_COMPAT_3_1                                              \
> +    HW_COMPAT_3_1
> +
>  static void spapr_machine_3_1_instance_options(MachineState *machine)
>  {
> +    spapr_machine_4_0_instance_options(machine);
>  }
> =20
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_4_0_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
>  }
> =20
> -DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
> +DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> =20
>  /*
>   * pseries-3.0

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VAM/tfeJyUfWz6bO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwOC14ACgkQbDjKyiDZ
s5JX8Q/+K+nfFTv5A0U6Fixvedi4y3yUcScUlYOZZgb/3xsiWXVn8tuyfKvY59bm
4eVWv+2CLYrov+4yYEnqtBCMGNp9bqaLMcQe5bW64QBYlZSfvVVafTmenBD0AUbc
XnYuyiPMH+EFKRwaKiBiDvaaU6m3t5zcM5ODCfwwEl4UG3UiZOXUzU5q7IiSKYRx
yyDfUY1IgzYIebxuOSMXvXXVKZbmOJmSKmUbez7/Zsy/SNpUq9s7yDGYFykt8dok
ElIgxcHYWxlFFDfLUeeBUqDWmpmguw/FrU14/TwIQDQSb3eJW87A4bcdT7mNx3Xo
84/k+nfoKtfW6KcWFh12ZP/i5x/dEf9qx9ekGwbuXQiN8cJkmXPDiGAjygmd9gok
vagPgFTQ/2qUnaKynEfM5Lyfkzj8AmBiQhna2HsKnP+nXfnm4fUGYLIgB1s/F9L+
Cm5eydysc/dXpDGhsdYakA8rMJy479/L4n1YXvSeqjfcdcdGmj9vzyHyASknmoTg
wmhk5hMFNwJHHXmJ+IuD+CMQoq5b84exRirYtERSXudBKpMBi5Xslqk1ysRosBUa
JqbpfK7m3UI4tDzxflHNkn6eysGV4WmUWciZxL/Y+KlN8wt5sgH7/DVrlXS0Lg0M
hZFT7KWQe6BL2a4iElae+GtA02UVyBbSeJno84IAPCP0wNEvCGI=
=+ox5
-----END PGP SIGNATURE-----

--VAM/tfeJyUfWz6bO--

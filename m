Received: from eggs.gnu.org ([2001:4830:134:3::10]:58392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eE7mj-0006HH-QC
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 00:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eE7mi-0005GV-Gt
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 00:59:53 -0500
Date: Mon, 13 Nov 2017 16:51:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171113055103.GD1014@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Content-Disposition: inline
In-Reply-To: <20171110152017.24324-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 01/11] spapr: add pseries 2.12
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 03:20:07PM +0000, C=E9dric Le Goater wrote:
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d682f013d422..a2dcbee07214 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3687,6 +3687,20 @@ static const TypeInfo spapr_machine_info =3D {
>      type_init(spapr_machine_register_##suffix)
> =20
>  /*
> + * pseries-2.12
> + */
> +static void spapr_machine_2_12_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void spapr_machine_2_12_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> +
> +/*
>   * pseries-2.11
>   */
>  static void spapr_machine_2_11_instance_options(MachineState *machine)
> @@ -3698,7 +3712,7 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
>      /* Defaults for the latest behaviour inherited from the base class */
>  }
> =20
> -DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> +DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> =20
>  /*
>   * pseries-2.10

Uh.. not quite right.  You also need to chain the 2.11 hooks onto the
new 2.12 ones.  Never mind, we'll need it sooner or later, so I've put
my own version into ppc-for-2.12.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloJMsUACgkQbDjKyiDZ
s5KeQhAAhDFVtefT6GwxqtMLrngmlMxxC49455+91ZjyFLKcTeqGF3lkMpd+cF7A
DPrudtYBwJkHmtaMEnYt3xm0EmNsfoCuCCNzn53B80w1/fM6yHTVH8nvwQ0ZXn9W
j6YkDJ8dWuZYnOQMVpjxQ+h2BCXkHjEC7BO1lGbO2OlVKA2OWyQ7pEyLc0hVBmd0
OWkTdrOuQ3AeeLC/2iYGPA2DmEfFa3+OnYRin7whuY3S9VE1NRWNamLIvZ4dEvA7
6RhIXRAajIDX2vf8G9nF19HsbAmHOnjAU0RngAFVA8yeT6h/kFD/GqdKsLJbORjB
ojSfO+ipsZvURpGqBcke0YvQISUywlxR/9lM0IR8dyuFFTftsEya70U2U4BeZ4jU
Cd8JlA4VAwEZ9BGvlZYSQCg5FI0N5g9o4BJ6TIX+zuXuMU/A8Ejp6dTSYu8qMyq/
hlqoiU2Fe78PD05hOkrWfK4/m1/ZSVtBdWfT/2P1poLHCNhpinO7UEY4agzFwX6N
B5U8SFbWzduToGfeNajfXeLFg/6NFWukLEd02cB2tgf8RuvSGoocDNqMt7bmIIAa
AOceaHjBd1g50HuduWKANDBhYCLmWz2FURYD0k0JXTGwxhn1+dIs2VIcrlcO77C9
jgIIa/AorqoHL0/Yeow6MNc5q+1lbYN9bGSKuBHt3QLEjOFskGo=
=N2gT
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUfol-0007we-BG
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUfok-0005Qr-0I
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:38:55 -0500
Date: Thu, 6 Dec 2018 09:29:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181205222948.GG768@umbus.fritz.box>
References: <20181205205827.19387-1-ehabkost@redhat.com>
	<20181205205827.19387-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <20181205205827.19387-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 3/5] spapr: Use
 default_machine_opts to set suppress_vmdesc
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


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 06:58:25PM -0200, Eduardo Habkost wrote:
> Instead of setting suppress_vmdesc at instance_init time, set
> default_machine_opts on spapr_machine_2_2_class_options() to
> implement equivalent behavior.
>=20
> This will let us eliminate the need for separate instance_init
> functions for each spapr machine-type.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f6b60e6fbd..0c3b27a8cc 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4368,13 +4368,13 @@ DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
>  static void spapr_machine_2_2_instance_options(MachineState *machine)
>  {
>      spapr_machine_2_3_instance_options(machine);
> -    machine->suppress_vmdesc =3D true;
>  }
> =20
>  static void spapr_machine_2_2_class_options(MachineClass *mc)
>  {
>      spapr_machine_2_3_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_2);
> +    mc->default_machine_opts =3D "modern-hotplug-events=3Doff,suppress-v=
mdesc=3Don";
>  }
>  DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwIUVwACgkQbDjKyiDZ
s5Jh0RAAjEWhdwXw6e4q3OY47a6vraX1Ce5YZ/ZX4dD1yw1dORiI5j8aLqQpK8GJ
t2ezZocEasi2GGiWbyfLxworJ5zE4hRhOXnGLXtPEFdvSX0fe5qfgb+8tdVcN9z4
kPl1eEWtrnzuTvNilLwFHP7sbnLmhqRfv1eLh+64Bm6q0DqnTEoIxsub+JYnso+H
6bb02rP9ynx58nj2DEp2PU7Ucdrbky1wuhbXyttDOKakfLgCObMlQblKGZ+k4Ynt
BYYX9rkVByRZAjJemfAc6KnEnUVORPBOKkkJz71JGoF/kpn2XjiEOOXTe8/Jl1PE
rik95eUSFCrvm/u2yat492ukZ6NoHIgNVm+2k1yVydPAOR31oPxjjJ2ksF1rS+pJ
OxCoygBF+HTksypQCUfJZe0yyZe+VYdt4rd27PslhocvhoILw9fQjiFUI2+nc3nY
yEYv6erDMuUuH6U7uFvgwANzdLTqSuUnuj4SXRHBt/O6htZPsfFq0JdFG3D1mX1z
0WWOblK3ULPk8+AcocgK9lQ1U9o4kS4imL8Fm3pk5AnBtp2y1B8wyTVPryODsxd/
CEO3P3kMLqU45OUpx3hvZYj8bo53GQqJoVtvVETCQz7dC72LQSV2P+DorzHgpoh1
/WmQnaEZ85aX4C15ICkOjhrsWHwPhYfOqe+JgzqadWQvqDJmVs4=
=/aQo
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--

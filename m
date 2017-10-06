Received: from eggs.gnu.org ([2001:4830:134:3::10]:36768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCl-0002MH-Qb
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCk-0005HG-7F
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:39 -0400
Date: Fri, 6 Oct 2017 14:08:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006030849.GH3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-6-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r21wuLfwIlf/vvzy"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-6-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/23] ppc: mac_newworld: use generic
 cpu_model parsing
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


--r21wuLfwIlf/vvzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:32PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/mac_newworld.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 6d0ace2..3fa7c42 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -174,16 +174,8 @@ static void ppc_core99_init(MachineState *machine)
>      linux_boot =3D (kernel_filename !=3D NULL);
> =20
>      /* init CPUs */
> -    if (machine->cpu_model =3D=3D NULL) {
> -#ifdef TARGET_PPC64
> -        machine->cpu_model =3D "970fx";
> -#else
> -        machine->cpu_model =3D "G4";
> -#endif
> -    }
>      for (i =3D 0; i < smp_cpus; i++) {
> -        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
> -                                           machine->cpu_model));
> +        cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>          env =3D &cpu->env;
> =20
>          /* Set time-base frequency to 100 Mhz */
> @@ -520,6 +512,11 @@ static void core99_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->max_cpus =3D MAX_CPUS;
>      mc->default_boot_order =3D "cd";
>      mc->kvm_type =3D core99_kvm_type;
> +#ifdef TARGET_PPC64
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("970fx_v3.1");
> +#else
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("7400_v2.9");
> +#endif
>  }
> =20
>  static const TypeInfo core99_machine_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r21wuLfwIlf/vvzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW88EACgkQbDjKyiDZ
s5LaOA//QnTDyNqv4gCWltb8mnveyvQXKs+jn4WGnzCG1w5QHglYnzF0NsVJ3JUB
SwhslFC1DJJNipsSQ3EBPrZJa7KY/OPDVvIAcqBYvkVMWYgRFYo6UVrybXHKbpRO
09g3r+ntxRpG/XFj17ktiQiFWnzFxWS6AirBTpV1y9qR7V+Dvjz1VcR7wqzs0C5c
D7GYUNCdWiX9Oi1CPQrfQ1JJmUvjrDZ63iQ3QI/yVQlQDxVtmIZeZTwMNS8bY1zP
ktL+tph+L4B3N7kaqFnAVjdP82aWR6G+XqV70GtOqZZQqrRdlrAKY7hj49nEn/Zg
dFUgUqr2AD5gExqrYUh6qoahI7zKzn/xFQ+gR5wlNcwXJfQmEIpRC4LHbBBPbJ6u
7xrSLre3c1cPpA+kpjeOkBiF2SVfVK4ilHQqYJkJqzIDI2rez8xFnLNlK+nrWAH+
bExuZ20PRkBPw3GvQjybcIoJYSv0R54yOdrvhB5ir7WbTiQ4XYjJtUflpXtMJiFw
lyUSdnRewjDsdoKhddHEozinENm7/6DrgjO8n/dkBYqAxd6H28Vz/x7HiW8yRmtj
IF7DOwSeCrJxwMKOMNPI3enUKLGdqsWGvpw/HClj0pWMRwASSULf0JR+GmJ5xNN0
fQvpK54q0s8vSw91ISiCosNgSECTCL5IatDLKavrmuBp1nF7siM=
=yLN+
-----END PGP SIGNATURE-----

--r21wuLfwIlf/vvzy--

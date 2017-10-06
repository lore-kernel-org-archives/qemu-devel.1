Received: from eggs.gnu.org ([2001:4830:134:3::10]:36879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCy-0002cR-QT
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCj-0005Gd-L6
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:52 -0400
Date: Fri, 6 Oct 2017 14:09:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006030925.GI3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-7-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="je2i5r69C8+2chMc"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-7-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/23] ppc: mac_oldworld: use generic
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


--je2i5r69C8+2chMc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:33PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/mac_oldworld.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index bc7c8b7..010ea36 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -108,11 +108,8 @@ static void ppc_heathrow_init(MachineState *machine)
>      linux_boot =3D (kernel_filename !=3D NULL);
> =20
>      /* init CPUs */
> -    if (machine->cpu_model =3D=3D NULL)
> -        machine->cpu_model =3D "G3";
>      for (i =3D 0; i < smp_cpus; i++) {
> -        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
> -                                           machine->cpu_model));
> +        cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>          env =3D &cpu->env;
> =20
>          /* Set time-base frequency to 16.6 Mhz */
> @@ -385,6 +382,7 @@ static void heathrow_class_init(ObjectClass *oc, void=
 *data)
>      /* TOFIX "cad" when Mac floppy is implemented */
>      mc->default_boot_order =3D "cd";
>      mc->kvm_type =3D heathrow_kvm_type;
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("750_v3.1");
>  }
> =20
>  static const TypeInfo ppc_heathrow_machine_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--je2i5r69C8+2chMc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW8+UACgkQbDjKyiDZ
s5LzNw/+IqK5U+3hgPz91F3W3GZaWT9w5DKNApYV9ZPBOx217UF2gBG7ALcShXA+
nLssTeE/KCgkAXBkeNEY0WuBqU/Vftc+j3amsslPEw+N8Pje+iKOVCYcar0ZeWiA
LX/ilSvzw3JPlVUFwMT9dNF8YTjGcQGh6RyxPUxey4LUyS52E5wJpoCEum2a7vLs
rD6M5iWXrukuSqMNgZClh5UEmK3nQFaopO/0qilWPA3Ivukq3FK9typktXKaynrT
IqO2ViTTqnSPlewTaaBGN7yX/3R7SW+2YFp/ad3x/YNGpEB3dJzubvFhuf5joGIa
qI5YBwYBWtV2/SoQsj8QAB8/ZC47JX+o6R5j8J0dHCHwnZJw7CT3wHLgnu4C4EMf
fKVJ9BtECRmKWBzy1gTZVzlxTRzR+fmuISw1FxNPueDUP4jrtVFCzOQCyvERES82
TRUj9nTRnhApxquvSqJ4sOlAEzXPEmuvvscYbkzOwOt5qdYcrx07Gjtq8YprWKrj
eMCpt24Qph9BqGA03N4kyCtT6YUjzPkJRQhNPG8M0+83+zJK+dR3m1UPGDO3psBO
Z6vomofhQdHjVHrNclT/0+Svi5HJZN80FIf5hp3IB7r6sfr30XS68GUnp+gHedDg
JtxuYFi4GEMsFneSRDxk5fjm5pp6dZ/iOH5cJHou/X7EzQMu+aw=
=1v68
-----END PGP SIGNATURE-----

--je2i5r69C8+2chMc--

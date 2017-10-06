Received: from eggs.gnu.org ([2001:4830:134:3::10]:36661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCi-0002Ly-CQ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCg-0005Di-TJ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:36 -0400
Date: Fri, 6 Oct 2017 14:13:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006031335.GL3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-10-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8i0lXXx49qphuFT"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-10-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/23] ppc: virtex-ml507: replace cpu_model
 with cpu_type
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


--a8i0lXXx49qphuFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:36PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/virtex_ml507.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index ed9b406..5ac4f76 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -89,14 +89,14 @@ static void mmubooke_create_initial_mapping(CPUPPCSta=
te *env,
> =20
>  static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_size,
>                                        int do_init,
> -                                      const char *cpu_model,
> +                                      const char *cpu_type,
>                                        uint32_t sysclk)
>  {
>      PowerPCCPU *cpu;
>      CPUPPCState *env;
>      qemu_irq *irqs;
> =20
> -    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
> +    cpu =3D POWERPC_CPU(cpu_create(cpu_type));
>      env =3D &cpu->env;
> =20
>      ppc_booke_timers_init(cpu, sysclk, 0/* no flags */);
> @@ -211,11 +211,7 @@ static void virtex_init(MachineState *machine)
>      int i;
> =20
>      /* init CPUs */
> -    if (machine->cpu_model =3D=3D NULL) {
> -        machine->cpu_model =3D "440-Xilinx";
> -    }
> -
> -    cpu =3D ppc440_init_xilinx(&ram_size, 1, machine->cpu_model, 4000000=
00);
> +    cpu =3D ppc440_init_xilinx(&ram_size, 1, machine->cpu_type, 40000000=
0);
>      env =3D &cpu->env;
> =20
>      if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
> @@ -307,6 +303,7 @@ static void virtex_machine_init(MachineClass *mc)
>  {
>      mc->desc =3D "Xilinx Virtex ML507 reference design";
>      mc->init =3D virtex_init;
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440-xilinx");
>  }
> =20
>  DEFINE_MACHINE("virtex-ml507", virtex_machine_init)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a8i0lXXx49qphuFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW9N8ACgkQbDjKyiDZ
s5JAww//QSItiyfkJkKaO/Imova9QpSVh03OPk5VDA0OhMVfm/RcqM/pAxXj2wB+
V+Te5QSO/sQd40ppYU7vyZpWiEWQKyGTu6dhS694CXi48kYeisEWpFMboWZpn1SZ
blWFwbSwEaI9A0EKJCQ2VJORm1RkU3t+Y+0jbi99uAMbSO5WpV1hNl3JZgqvAz3r
wfD9xC5e8g8Vl6Tr0xztIWpL34ifuE99swkdZVVlg+6Y7WPH+46hvvMbU85jtV45
a06/9N+SYT9V+F9AI0Qn1jbCAFcYjW0prucgnTQWwYmDNa/iiYTPr0G253nYwP6p
VGx/SlqNOwcBpz0xOAKw+P56UKh0Rp8S/w8RP2H/Bhl9ow6Z29NbOB5lMQNVEr5h
nP71WgSPr1JoJ33d1UmDiZqmL40ayOIyyPTECep9YGxqg6qcpmzrcYCFI/ZUnOWx
djb1vzsiq7WjMf0OY+5tNhtWu5gK3B3ETsxscjEVrmhLiFnpTKi0cX/SoYxErHw9
0PM9F1l55CIl3SG8qVfErBz7XOsfGDOE+OxyEBB+j5hSJ+tKBcgmlvyGgciIMnQW
JeFXB03ES/tHF+6kKnPQzlD3EbUmVrhTlPnDXTPWBldlUJ/gHCutWblxc4oINrRM
TaInOTyozMpqpVfM8ADcA+M3vSkj2Ki2MoGZQYZY8qiyDHHKRnM=
=Bd1l
-----END PGP SIGNATURE-----

--a8i0lXXx49qphuFT--

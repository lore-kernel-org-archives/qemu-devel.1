Received: from eggs.gnu.org ([2001:4830:134:3::10]:36731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCk-0002MA-Ms
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCj-0005GW-Kv
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:38 -0400
Date: Fri, 6 Oct 2017 14:14:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006031416.GM3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-11-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bNLLTo5eXWXFd6av"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-11-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/23] ppc: 40p/prep: replace cpu_model
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


--bNLLTo5eXWXFd6av
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:37PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/prep.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 94138a4..6f8accc 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -517,11 +517,8 @@ static void ppc_prep_init(MachineState *machine)
>      linux_boot =3D (kernel_filename !=3D NULL);
> =20
>      /* init CPUs */
> -    if (machine->cpu_model =3D=3D NULL)
> -        machine->cpu_model =3D "602";
>      for (i =3D 0; i < smp_cpus; i++) {
> -        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
> -                                           machine->cpu_model));
> +        cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>          env =3D &cpu->env;
> =20
>          if (env->flags & POWERPC_FLAG_RTC_CLK) {
> @@ -684,6 +681,7 @@ static void prep_machine_init(MachineClass *mc)
>      mc->block_default_type =3D IF_IDE;
>      mc->max_cpus =3D MAX_CPUS;
>      mc->default_boot_order =3D "cad";
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("602");
>  }
> =20
>  static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
> @@ -718,10 +716,7 @@ static void ibm_40p_init(MachineState *machine)
>      char boot_device;
> =20
>      /* init CPU */
> -    if (!machine->cpu_model) {
> -        machine->cpu_model =3D "604";
> -    }
> -    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_=
model));
> +    cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>      env =3D &cpu->env;
>      if (PPC_INPUT(env) !=3D PPC_FLAGS_INPUT_6xx) {
>          error_report("only 6xx bus is supported on this machine");
> @@ -894,6 +889,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
>      mc->default_ram_size =3D 128 * M_BYTE;
>      mc->block_default_type =3D IF_SCSI;
>      mc->default_boot_order =3D "c";
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("604");
>  }
> =20
>  DEFINE_MACHINE("40p", ibm_40p_machine_init)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bNLLTo5eXWXFd6av
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW9QgACgkQbDjKyiDZ
s5IrcxAA5d8iNRAfgSkbapmUztJyKbCW4hTdGAxeP3dj18Y01ZSq1Fu/rP4cLB+H
pvJ/5HXGIQJLonZ0mbC4BYtuj45pNc4K0jCrlsAYnGUvzYTIJIHVggOQWYVKw3Iu
VxbewRB6xigdI4Ydmp3LKb49YDeVrHK/tzF2OWtdRraT0uxELFTqXf+Xcyy+KNXf
7jGS8Tm2cLjGHM2NZSYdWL+ez1pHU9OZA2fzsOnQ5fdEA9O0OoUMv/T+Nq+lWahJ
vt0aKuF/W4Otz6s8SERCUqyIVJQosivNmfmbsELgpDdk0+CfN5PexV8FWrL1fpJu
1HOYGYe75UfG+oTs+nAC4ll2DQ6YQU5OzRtGPdTcCjRsEe4RuSJy00hO7h3jXSde
8G6SEeS1shnof/eHqlfJfUsfFltolP/XFvknpGks8Z6Sp1m3jaE/90rdmYlyfB6j
thzx56fX/Yrnww9HmWF2HI7rkZHFybnWoSyLXgDtDSET4GhvzRTTAIhEcfmF1IER
Rwpe4H7rQ2icsrHIu2yju/M4L7zcMapyQecyXF5MqUvm4tqlNagknLesJX6y84mq
5eWjfnoM2UYk+PKTIiRoWLJJH0uzasMSTbesFCLY61KF+urCXDIzfl2xlQ5jGfqc
by9CRGrB5gt4bS+7jhn5ByReQPqMteIcnmrW0nuIxvWvxXY1+50=
=JMgk
-----END PGP SIGNATURE-----

--bNLLTo5eXWXFd6av--

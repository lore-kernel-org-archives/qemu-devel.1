Received: from eggs.gnu.org ([2001:4830:134:3::10]:32849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE2bD-0003yT-10
	for qemu-devel@nongnu.org; Wed, 02 May 2018 20:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE2b9-0007ys-Sv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 20:59:55 -0400
Date: Thu, 3 May 2018 10:58:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503005824.GD13229@umbus.fritz.box>
References: <20180424113045.25687-1-clg@kaod.org>
	<20180424113045.25687-5-clg@kaod.org>
	<f949a056-23c2-fcfa-d9e0-6a2cb1142051@kaod.org>
	<f33e541e-b026-b933-7926-10a29b300a20@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <f33e541e-b026-b933-7926-10a29b300a20@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] target/ppc: add hash MMU support
 for PowerNV POWER9 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 02:41:47PM +0200, C=E9dric Le Goater wrote:
> On 04/24/2018 02:03 PM, C=E9dric Le Goater wrote:
> >> +hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
> >> +{
> >> +    CPUPPCState *env =3D &cpu->env;
> >> +
> >> +    /* We should not reach this routine on sPAPR machines */
> >> +    assert(!cpu->vhyp);
> >> +
> >> +    /* PowerNV machine */
> >> +    if (msr_hv) {
> >> +        if (env->mmu_model & POWERPC_MMU_3_00) {
> >> +            return ppc64_v3_get_patbe0(cpu);
> >> +        } else {
> >> +            return cpu->env.spr[SPR_SDR1];
> >> +        }
> >> +    } else {
> >> +        error_report("PowerNV guest support Unimplemented");
> >> +        exit(1);
> >=20
> > I just noticed that this breaks 970 CPUs ...
>=20
> How about ?

Hmm.. I'm not actually seeing why it breaks 970.

I really want to ditch 970 support, but we have to go through the
deprecation process first.

>=20
>     if (env->mmu_model < POWERPC_MMU_2_07) {
>         return cpu->env.spr[SPR_SDR1];
>     }
>=20
>     /* P8/P9 PowerNV machine */
>     if (msr_hv) {
>         if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
>             return ppc64_v3_get_patbe0(cpu);
>         } else {
>             return cpu->env.spr[SPR_SDR1];
>         }
>     } else {
>         error_report("PowerNV guest support Unimplemented");
>         exit(1);
>     }
>=20
> and I have to fix all the :
>=20
> 	env->mmu_model & POWERPC_MMU_3_00
>=20
> by :
>=20
> 	env->mmu_model =3D=3D POWERPC_MMU_3_00
>=20
> I tripped over with the recent changes

Right.. eventually I actually want this to be something more like
	if (cpu->radix64_opts)
but I'm not sure on the details yet.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqXrAACgkQbDjKyiDZ
s5KHnA/+IiLlqBxJIPODaKcSp/F0mmGo7k0pEpOow6HJdyXg8FXcGvigEuUxmyiG
6nWm1nl28YzE+MJnmi0AGzswy2kl85DqwnGZSNFHUNGxR5OgAdLktFIj6Mjmtnji
YBDxi7Q28Zga+PALFXWXdlEpDZUmNhZ0Zhed3m1WD9KQQTWMeS1U8itq8cQYWbSZ
81iMJogw2CJuSEN0PlQuYlCwT4x+qmUCKqoZU/ZibexalQv8YnTcCx5C1gQdDqFe
rHvq9wIRo4aMOCGpJ3vKsa1drXqx7yTT93Jkwr0C4F3jk1QMNhKxEHv0iRjyIX++
IgKRPnlVkSvnfRIMlAhlYvI1IHSjxMmfk0by+DQdWwJVcM3kaX33RgTUW1rkYZw1
dAf9aCIA6WjGRa9xOhk2JC1s2jVmEkUEPjdgz2iurdfqEoU9w22We+EeU3pYanFZ
9ZWDr8wJ8E7OKqr1LelOnyTAhZpM40WGGg6Ddr2BFbjO8/DNz1J6CzSiLq3SxBR2
Ul+2zYAvIspLda0GI3MElkGAN4/Vzumsz0odzWgH9DYQMLLbCn+5EBAwlSBE5bxC
kdB60+Rfyc892RcErpAd2Z2pMYn8OcJjZ1LJciqNBmjBDPTAvWIwCoZBL8vx+qBZ
y800T1TejlMLG2sGOEgKccrjAmC/Pp92OemAU1y3RUVueZxp1Gk=
=QCuj
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--

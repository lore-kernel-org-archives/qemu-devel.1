Received: from eggs.gnu.org ([2001:4830:134:3::10]:49830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE84e-0005y9-AX
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE84V-00023V-BY
	for qemu-devel@nongnu.org; Thu, 03 May 2018 02:50:40 -0400
Date: Thu, 3 May 2018 16:36:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503063603.GX13229@umbus.fritz.box>
References: <20180424113045.25687-1-clg@kaod.org>
	<20180424113045.25687-5-clg@kaod.org>
	<f949a056-23c2-fcfa-d9e0-6a2cb1142051@kaod.org>
	<f33e541e-b026-b933-7926-10a29b300a20@kaod.org>
	<20180503005824.GD13229@umbus.fritz.box>
	<6e331f5e-47f2-6525-7807-a5c262e13a4c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D+UG5SQJKkIYNVx0"
Content-Disposition: inline
In-Reply-To: <6e331f5e-47f2-6525-7807-a5c262e13a4c@kaod.org>
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


--D+UG5SQJKkIYNVx0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 07:52:32AM +0200, C=E9dric Le Goater wrote:
> On 05/03/2018 02:58 AM, David Gibson wrote:
> > On Tue, Apr 24, 2018 at 02:41:47PM +0200, C=E9dric Le Goater wrote:
> >> On 04/24/2018 02:03 PM, C=E9dric Le Goater wrote:
> >>>> +hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
> >>>> +{
> >>>> +    CPUPPCState *env =3D &cpu->env;
> >>>> +
> >>>> +    /* We should not reach this routine on sPAPR machines */
> >>>> +    assert(!cpu->vhyp);
> >>>> +
> >>>> +    /* PowerNV machine */
> >>>> +    if (msr_hv) {
> >>>> +        if (env->mmu_model & POWERPC_MMU_3_00) {
> >>>> +            return ppc64_v3_get_patbe0(cpu);
> >>>> +        } else {
> >>>> +            return cpu->env.spr[SPR_SDR1];
> >>>> +        }
> >>>> +    } else {
> >>>> +        error_report("PowerNV guest support Unimplemented");
> >>>> +        exit(1);
> >>>
> >>> I just noticed that this breaks 970 CPUs ...
> >>
> >> How about ?
> >=20
> > Hmm.. I'm not actually seeing why it breaks 970.
>=20
> it does not have MSR_SHV bit.

It does, actually.  At least, as long as it's not strapped into "Apple
mode".

> > I really want to ditch 970 support, but we have to go through the
> > deprecation process first.
>=20
> Is it causing a lot of maintenance issues ?

Enough.  The explicit RMA allocation stuff is a particular pain.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--D+UG5SQJKkIYNVx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqrdEACgkQbDjKyiDZ
s5LtehAAmPlBoUTcJ5EKEUz5IOtkvnFC6GKCygbi+rK3T4U2Q4aEcfneXNW+Dkyv
JY+D8koKSXmxOlNOyhEwrzKlathHLITmw6dm9K4VCQIN0gNFkejrz7w5PpYIgqcG
9Ww/u+UztS8X0HB5N10QN/tQvm+A371aseudmWpcWZIwSEgMFBHhzTc7Le3krwMk
CmEIujSo+0nH6rvCqF7nh5b4YazXnkbVQ1xtCKpYP0TrwXw94+3ufh6vrbOkGPPD
h/0kJZjSPjyz0nGMXKAAG7An7TULjDrzMUn/BVz9sR3cY02zL3NxMjfLuY2PtN/y
P4fvRooWimJJb8UDWIaAZ1ycCfJpDlOYWnY9LRQWd/8WW3l/IYBZ26YfvT5N2D/f
ZR7dMe/ddUnQcgm+KS127TfFUp0rj175gUAwRC1mQnQEW3Cr3potslBDIZHCEW7N
kV9GrXR+1b2Dc7rBwPxyM28kf8h1uEDx7cXW13g6RHn9FQpC6hYfx36vWyWB8ITQ
+IucFFM5ELySRFGq0O092tNhEx3urB8QpePcajzUXhmIYziOEqzoh0Ts0Uhf1io+
BvdbWdZThxGemfL/5L+usEwia9VQOBgumT8UHXEZ/k0mxbDRMn4Rj6qxRoB4zWF1
zD9+MQ8BuNyRrlHYaVhapSunqstCvYJDn3jt5jzmtG7Qevep9IE=
=pIQL
-----END PGP SIGNATURE-----

--D+UG5SQJKkIYNVx0--

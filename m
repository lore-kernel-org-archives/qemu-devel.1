Received: from eggs.gnu.org ([2001:4830:134:3::10]:44760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsmRV-00083r-OO
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsmRS-0007xz-OY
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:57:45 -0400
Date: Fri, 15 Sep 2017 18:51:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915085115.GN5250@umbus.fritz.box>
References: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
	<20170909070212.GT2735@umbus.fritz.box>
	<87k2153jnx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170913073519.GK7550@umbus.fritz.box>
	<8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915064830.GI5250@umbus.fritz.box>
	<87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
Content-Disposition: inline
In-Reply-To: <87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> >>=20
> >> I thought, I am doing the same here for PowerNV, number of online cores
> >> is equal to initial online vcpus / threads per core
> >>=20
> >>    int boot_cores_nr =3D smp_cpus / smp_threads;
> >>=20
> >> Only difference that I see in PowerNV is that we have multiple chips
> >> (max 2, at the moment)
> >>=20
> >>         cores_per_chip =3D smp_cpus / (smp_threads * pnv->num_chips);
> >
> > This doesn't make sense to me.  Cores per chip should *always* equal
> > smp_cores, you shouldn't need another calculation for it.
> >
> >> And in case user has provided sane smp_cores, we use it.
> >
> > If smp_cores isn't sane, you should simply reject it, not try to fix
> > it.  That's just asking for confusion.
>=20
> This is the case where the user does not provide a topology(which is a
> valid scenario), not sure we should reject it. So qemu defaults
> smp_cores/smt_threads to 1. I think it makes sense to over-ride.

If you can find a way to override it by altering smp_cores when it's
not explicitly specified, then ok.

But overriding smp_cores with a different variable that's the "real"
number of cores is not acceptable.  If that means the user has to
specify cores explicitly, so be it.  Slight awkwardness in command
line is preferable to breaking the assumption that smp_cores =3D=3D (# of
cores per next level up cpu object) which is used all over the place.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7lIEACgkQbDjKyiDZ
s5LUHBAA4d4dAJJmCCbfiqe3lxVUIaP49v55GUuRgEqM5D41Gd4f24ANhvL4JuF9
rylzFkxp1UWdBx+Vq/H0//Wl+cxhrl4xJdzLUGLed98LHKfO9y+aEVEXjrqFwug1
EI5qpkDNIcsqDkrJky3hb1zHMZ0pk9lO2IeyikqI8DC4MlJSVHEYXDB8jSdYe8zD
B5HaZA5+xfsQcbSKpUOBU8BihO7KdE7c8o/L7G4SBT6bQ7nlDmS9FHAMRfOTUM0Z
7BbBZLuOSXtVnz5Q/tLltIr6jncICQ4B89Pkkpfw6FVlNaE1g6nLJbyBVmMQvJ0L
+3jrXzj/0znXcpV7czr2liIN3iIGZIbw8hmjnKajDVju38mmC9F6P0Mvfc7EssXl
YKviJAp3imn3CZCU9eE2DWxa4iXdfAwUymcHJOi++RX20ppfbW69vVsH3C5De8nu
vqESxxb24Ng6V+oL2GDoL1OVtqMRG9c6r6KyPuJIhl8z9/e/P2TKj8rXkeSQS4GI
8PanB1qX1hkPqL77coNganIxOt8mRj13u2GQss8Bm51gYI8lBViZuxTTcyCG06Kf
Xf5oH2hiKaGCH3IFri4T8gPpNGjvqsNYSJhdPl8SfVO/CxIeDZBp+ODNwGH8KyWM
rc5pAHNwoITka6je2Or9WotPefBd7cwXvGWINlLHTVOuLpYxKUY=
=5HKj
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFta-0001It-PB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtX-0002yc-5v
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:50 -0400
Date: Tue, 19 Sep 2017 18:24:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919082421.GU27153@umbus>
References: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
	<20170909070212.GT2735@umbus.fritz.box>
	<87k2153jnx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170913073519.GK7550@umbus.fritz.box>
	<8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915064830.GI5250@umbus.fritz.box>
	<87377omkuk.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170915085115.GN5250@umbus.fritz.box>
	<87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qgEfXXHyyarqcYJd"
Content-Disposition: inline
In-Reply-To: <87y3pgl45f.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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


--qgEfXXHyyarqcYJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadhania wrote:
> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >>=20
> >> >>=20
> >> >> I thought, I am doing the same here for PowerNV, number of online c=
ores
> >> >> is equal to initial online vcpus / threads per core
> >> >>=20
> >> >>    int boot_cores_nr =3D smp_cpus / smp_threads;
> >> >>=20
> >> >> Only difference that I see in PowerNV is that we have multiple chips
> >> >> (max 2, at the moment)
> >> >>=20
> >> >>         cores_per_chip =3D smp_cpus / (smp_threads * pnv->num_chips=
);
> >> >
> >> > This doesn't make sense to me.  Cores per chip should *always* equal
> >> > smp_cores, you shouldn't need another calculation for it.
> >> >
> >> >> And in case user has provided sane smp_cores, we use it.
> >> >
> >> > If smp_cores isn't sane, you should simply reject it, not try to fix
> >> > it.  That's just asking for confusion.
> >>=20
> >> This is the case where the user does not provide a topology(which is a
> >> valid scenario), not sure we should reject it. So qemu defaults
> >> smp_cores/smt_threads to 1. I think it makes sense to over-ride.
> >
> > If you can find a way to override it by altering smp_cores when it's
> > not explicitly specified, then ok.
>=20
> Should I change the global smp_cores here as well ?

I'm pretty uneasy with that option.  It would take a fair bit of
checking to ensure that changing smp_cores is safe here.  An easier to
verify option would be to make the generic logic which splits up an
unspecified -smp N into cores and sockets more flexible, possibly
based on machine options for max values.

That might still be more trouble than its worth.

> > But overriding smp_cores with a different variable that's the "real"
> > number of cores is not acceptable. If that means the user has to
> > specify cores explicitly, so be it.
>=20
> Right, we would error out in case there is mismatch.
>=20
> > Slight awkwardness in command line is preferable to breaking the
> > assumption that smp_cores =3D=3D (# of cores per next level up cpu obje=
ct)
> > which is used all over the place.
>=20
> Regards
> Nikunj
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qgEfXXHyyarqcYJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnA1DQACgkQbDjKyiDZ
s5IjMRAAhy7VoRP0k+RF4YgNIYOb+b8mlDztMvKiboztyGi5uaG+1jLwHIlcfZ/6
n+z4uWBCMtzeL5ltw6ccZkwPhRWUsPTSIt/vfC7Jvy6WZK0h8yoVopI/uCh7YZOP
UBS+hBJ/Egn2P59S6VC/J8d+nFJ6ZIrT14ge6Z/SQ/GM+yu6Vv9hv+ZQeUMmrJ+B
IS59rld3vMNmuwUMjfBSwrX770lgmUfC5GvyXUEloFRvYXfVwUNsxJKJwbyzo7ZC
gFwGFo5ednwObtcpbd5vZitk1YMMiQ4MsnVIHX27KKYaqBQ/HRiIAKV4D3u4Xfqn
c/2ah+jDT9GqCE0GGoOvyQTLk2W2oLD6ZpFckV+bPnx0Wlqq3vtuBaERE+U439CT
YVMOGAdM8e5ejyIVAKcN3VqD5ztkfZMtKzv3KF4NVv9IK8fg3M03fHNkDtXm8Tjn
JEnSHxSjDCgGka7JHZVHedJXliVJMDa0VrRdkHiuJ8nuAo3mKm+SIyiB25O7Hojd
80f8HsVacH5dL1eicS4LfOpXa5zKdfwnB5htC7WdYK1blsimIQB2+kbbSvzizO84
Q8OJAPLgOvm6z4l+2hKdDZgQF63eQ0W4QD/RJ2cQ5NbVk85cSF7eIotrRq5C1IrH
XZRm7vWf2uJqsoIorvv9baU0ZKbUI4xmf8GLvzNmPvX7HjgBOfM=
=K1Pq
-----END PGP SIGNATURE-----

--qgEfXXHyyarqcYJd--

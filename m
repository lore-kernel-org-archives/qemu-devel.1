Received: from eggs.gnu.org ([2001:4830:134:3::10]:36258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0M-0007NB-5J
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvd0K-0002D9-Lb
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:30 -0400
Received: from ozlabs.org ([103.22.144.67]:47155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dvd0K-0002A2-Ax
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:29:28 -0400
Date: Sat, 23 Sep 2017 15:23:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170923052336.GF4998@umbus.fritz.box>
References: <20170919213611.8988-1-jsnow@redhat.com>
	<20170919213611.8988-2-jsnow@redhat.com>
	<68ca6f8d-5673-4177-fadf-ca512258257b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V4N4TvXMNzuFMHdo"
Content-Disposition: inline
In-Reply-To: <68ca6f8d-5673-4177-fadf-ca512258257b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] ppc: remove unused CPU definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, agraf@suse.de


--V4N4TvXMNzuFMHdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 08:47:43PM +0200, Thomas Huth wrote:
> On 19.09.2017 23:36, John Snow wrote:
> > Following commit aef77960, remove now-unused definitions from
> > cpu-models.h.
> >=20
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  target/ppc/cpu-models.h | 32 --------------------------------
> >  1 file changed, 32 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> > index df31d7f..b34b512 100644
> > --- a/target/ppc/cpu-models.h
> > +++ b/target/ppc/cpu-models.h
> > @@ -291,34 +291,6 @@ enum {
> >  #endif
> >      CPU_POWERPC_e200z5             =3D 0x81000000,
> >      CPU_POWERPC_e200z6             =3D 0x81120000,
> > -    /* MPC55xx microcontrollers */
> > -#define CPU_POWERPC_MPC55xx          CPU_POWERPC_MPC5567
> > -#if 0
> > -#define CPU_POWERPC_MPC5514E         CPU_POWERPC_MPC5514E_v1
> > -#define CPU_POWERPC_MPC5514E_v0      CPU_POWERPC_e200z0
> > -#define CPU_POWERPC_MPC5514E_v1      CPU_POWERPC_e200z1
> > -#define CPU_POWERPC_MPC5514G         CPU_POWERPC_MPC5514G_v1
> > -#define CPU_POWERPC_MPC5514G_v0      CPU_POWERPC_e200z0
> > -#define CPU_POWERPC_MPC5514G_v1      CPU_POWERPC_e200z1
> > -#define CPU_POWERPC_MPC5515S         CPU_POWERPC_e200z1
> > -#define CPU_POWERPC_MPC5516E         CPU_POWERPC_MPC5516E_v1
> > -#define CPU_POWERPC_MPC5516E_v0      CPU_POWERPC_e200z0
> > -#define CPU_POWERPC_MPC5516E_v1      CPU_POWERPC_e200z1
> > -#define CPU_POWERPC_MPC5516G         CPU_POWERPC_MPC5516G_v1
> > -#define CPU_POWERPC_MPC5516G_v0      CPU_POWERPC_e200z0
> > -#define CPU_POWERPC_MPC5516G_v1      CPU_POWERPC_e200z1
> > -#define CPU_POWERPC_MPC5516S         CPU_POWERPC_e200z1
> > -#endif
> > -#if 0
> > -#define CPU_POWERPC_MPC5533          CPU_POWERPC_e200z3
> > -#define CPU_POWERPC_MPC5534          CPU_POWERPC_e200z3
> > -#endif
> > -#define CPU_POWERPC_MPC5553          CPU_POWERPC_e200z6
> > -#define CPU_POWERPC_MPC5554          CPU_POWERPC_e200z6
> > -#define CPU_POWERPC_MPC5561          CPU_POWERPC_e200z6
> > -#define CPU_POWERPC_MPC5565          CPU_POWERPC_e200z6
> > -#define CPU_POWERPC_MPC5566          CPU_POWERPC_e200z6
> > -#define CPU_POWERPC_MPC5567          CPU_POWERPC_e200z6
> >      /* e300 family */
> >      /* e300 cores */
> >      CPU_POWERPC_e300c1             =3D 0x00830010,
> > @@ -326,11 +298,7 @@ enum {
> >      CPU_POWERPC_e300c3             =3D 0x00850010,
> >      CPU_POWERPC_e300c4             =3D 0x00860010,
> >      /* MPC83xx microcontrollers */
>=20
> I think you should also remove the above comment now?
>=20
> > -#define CPU_POWERPC_MPC831x          CPU_POWERPC_e300c3
> > -#define CPU_POWERPC_MPC832x          CPU_POWERPC_e300c2
> >  #define CPU_POWERPC_MPC834x          CPU_POWERPC_e300c1
> > -#define CPU_POWERPC_MPC835x          CPU_POWERPC_e300c1
> > -#define CPU_POWERPC_MPC836x          CPU_POWERPC_e300c1
> >  #define CPU_POWERPC_MPC837x          CPU_POWERPC_e300c4
> >      /* e500 family */
> >      /* e500 cores  */
>=20
> With the above comment removed:
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

No, there's still one entry left in that subsection, so the comment
should stay.  Applied.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V4N4TvXMNzuFMHdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnF79gACgkQbDjKyiDZ
s5J6Jw/9H/vPT/W9PkIiYQgmR5Wy/UM2paatcK9dDLSMdzB0VLyj6DdTJHjg23Pk
vxom3iXCL1y05JNA5jQ2svgV2wBE49Fb1vb7O4AanRgvSgH3gBwuXdHyyXmV4K3Q
ou9Z+7O2T4s4YObDymxwiVfYrr+SxfrqR046H1GjiStFAdJ+ggM2I3qysS/Cdvn/
3bkUIgUlifzWAlf3cMBtzcd8nLGFGiUIDKzsJHc1TLPpwBnawozCt9wJVx3J3h/z
UIBtefZv64E1DmbUsmCxChlkA3MNtlB4mBeRPgqMqoW91XB9w34cHYv6JjyALLEF
jSxYHV5JBwAN72vAkpcsynbSjvKTBS8VeS5Y9ddhbIcl8aeIjjh6nl197z7NxOBV
MNbPADVXBitQY3zEYzpZfiEabzJBrKRZ0PaJSmWTFLZ28m7M+g0wf6SVCkAdAGKn
UTkHvOC1vqbUCqDG8UNxhqYUT1FIkLRJiA5ZyEItSZ/MbR6tRh0ftsQH0KjUusCv
02fTWez3YdEDvGmCq+ufxB+dj0Xi4PDvilrA0xmzv9u6Q2u1Zn8tDX0ut1C8GrOE
/g+4s/r80SS+6kdKIHb9dbaqqgqVoHwkhrhkPvOSj74o4hMK7qG5sNISBkHNJxdk
wI1XbVHwSXYFJRoFe8cUwoHDDt1cC8jB9eoF6jsbz117tstSoNU=
=tZ/n
-----END PGP SIGNATURE-----

--V4N4TvXMNzuFMHdo--

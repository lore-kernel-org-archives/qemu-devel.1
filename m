Received: from eggs.gnu.org ([2001:4830:134:3::10]:33548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE71z-0002yG-PZ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE71w-0000M9-Kt
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:43:51 -0400
Date: Thu, 3 May 2018 15:43:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503054341.GT13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
	<dafe2911-9755-2007-5723-686de5aeceb8@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cUjMc5fB5G+GsIM6"
Content-Disposition: inline
In-Reply-To: <dafe2911-9755-2007-5723-686de5aeceb8@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 06/35] spapr/xive: introduce a XIVE
 interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--cUjMc5fB5G+GsIM6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 09:39:44AM +0200, C=E9dric Le Goater wrote:
> >> =20
> >> +static XiveNVT *spapr_xive_get_nvt(XiveFabric *xf, uint32_t server)
> >> +{
> >> +    PowerPCCPU *cpu =3D spapr_find_cpu(server);
> >> +
> >> +    return cpu ? XIVE_NVT(cpu->intc) : NULL;
> >> +}
> >=20
> > So this is a bit of a tangent, but I've been thinking of implementing
> > a scheme where there's an opaque pointer in the cpu structure for the
> > use of the machine.  I'm planning for that to replace the intc pointer
> > (which isn't really used directly by the cpu). That would allow us to
> > have spapr put a structure there and have both xics and xive pointers
> > which could be useful later on.
>=20
> Here is a quick try of the idea. Tested on pnv and spapr machines.
> I lacked inspiration on the name so I called the object
> {Machine}Link.

This is a bit overkill compared to what I had in mind.  I don't think
the thing we're pointing to has to be a fully realized QOM object.  I
was just going to replace the Object * with a void *, that it's up to
the machine to interpret.

I'm also wondering about restricting this idea to vhyp platforms.  The
idea is that for physical-esque machines the cpu really does (or
should) know how things are connected to it.  It's the abstraction of
the paravirt platform that makes it fuzzy.  In which case I'd see it
as the "opaque" pointer that goes along with the vhyp function
pointers.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cUjMc5fB5G+GsIM6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqoY0ACgkQbDjKyiDZ
s5LkBg/5AQbfussMkVEMUAZXNRPExAYPlydSZROC3HESo8By8g2rck7CsumfxfKB
nrVvaLWS7lmbvc6N3Cc78K/GAkmgYxhresKY/EhnBcqRzqjupt8xU5k4IR8iU+dU
SglRT9knkUoNq0Io7Nu4Cm2wXi7AQslR7TXURJNY+l0V0tECg1ZlHto8MEP0apGo
THGZqVtw0Bi8WBxEYlge9r7ZsJr/FGQxIJpigPeZtpxIIGH53wA/tvCcd5sPlEJq
1/pN0Yr0U1wQ//wr6l0H14+g+sbHyRt3uySG6PSj/hyqEaoiud14uk0PPGcf89Dn
ACl3JmvqUvLyGlufrGIzpuU4N4Yj5528wqXANC7z3wcdriJpQ1BoQivaChl5XylY
d0+wbpJvhpAIKsPK4DdOhqrmrcBUNRoA1HjNP+8XHbfGohJ7vVMt2y9juF8nRmzn
r7apwUzZCM07dKPWvjFZy52KeOtPccBG8Bmo9hVuO611VFwKExuakYtAPHtn/BSp
hf09ZleqySCTCVvaQ58ajtdWXsvm7PWAFh8Sef+2DTdCNcFAl0/ENpfjyQiloIwe
ZKnoLvf+VPY4R3IoxNg6tnf6Tp2TNJCJO4IHKmcfLB1MoXZkApj//H45rLh243tq
w/2L8gptMDQV3SAvNgGRG6b7rZgGn2MumSBAJ7GZHGtEZWfoWa0=
=7S8T
-----END PGP SIGNATURE-----

--cUjMc5fB5G+GsIM6--

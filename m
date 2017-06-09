Received: from eggs.gnu.org ([2001:4830:134:3::10]:53004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbK-0007hi-DR
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbJ-00061L-FU
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:10 -0400
Date: Fri, 9 Jun 2017 19:43:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609094341.GI26521@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
	<20170608020112.GT13397@umbus.fritz.box>
	<20170608104530.65b7d53e@bahia.ttt.fr.ibm.com>
	<20170609022452.GE26521@umbus.fritz.box>
	<20170609084550.53aece8d@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Content-Disposition: inline
In-Reply-To: <20170609084550.53aece8d@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/5] xics: setup cpu at realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 08:45:50AM +0200, Greg Kurz wrote:
> On Fri, 9 Jun 2017 12:24:52 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jun 08, 2017 at 10:45:30AM +0200, Greg Kurz wrote:
> > > On Thu, 8 Jun 2017 12:01:12 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Wed, Jun 07, 2017 at 07:17:09PM +0200, Greg Kurz wrote: =20
> > > > > Until recently, spapr used to allocate ICPState objects for the l=
ifetime
> > > > > of the machine. They would only be associated to vCPUs in xics_cp=
u_setup()
> > > > > when plugging a CPU core.
> > > > >=20
> > > > > Now that ICPState objects have the same lifecycle as vCPUs, it is
> > > > > possible to associate them during realization.
> > > > >=20
> > > > > This patch hence open-codes xics_cpu_setup() in icp_realize(). Th=
e vCPU
> > > > > is passed as a property. Note that vCPU now needs to be realized =
first
> > > > > for the IRQs to be allocated. It also needs to resetted before IC=
PState
> > > > > realization in order to synchronize with KVM.   =20
> > > >=20
> > > > Ok, what enforces those ordering constraints?
> > > >  =20
> > >=20
> > > I'm not sure about what you're asking... I had to re-order because
> > > xics_cpu_setup() used to be called after the vCPU is realized and
> > > put in PAPR mode. =20
> >=20
> > Duh, sorry, I wasn't thinking to ask about realize order, since that's
> > manual and you've re-ordered it to be correct.
> >=20
> > You also mention that reset order matters, and I'm less clear on what
> > guarantees that the reset handlers for the components get called in
> > the right order.
> >=20
>=20
> Oops... my bad, this is a mistake in the changelog. The KVM error I was
> seing isn't related to CPU reset as I was thinking first but to
> cpu_ppc_set_papr()... :-\
>=20
> The last sentence should rather be something like:
>=20
> "We also need to call spapr_cpu_init() before ICPState realization in
>  order to enable PAPR mode in KVM."
>=20
> Can you fix this in your tree or should I send an updated version ?

Uh.. too late, I already sent a pull request.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOm3KAAoJEGw4ysog2bOSUR8P+wRvg9kO1ByS12/fVULTjFDE
prtPpCWzGL8Onvbw3tz9138O3bPqqY8u/9LNfQKugglQwqHzLyS5RV+CS5FPQkZr
Wc0+tcA0dREMgnLu2ibNlGYpyQIFqi0SSski0nAxN3IWBT1Mpd2wO7KOcqxjzSFX
5jK1z7mrCLSbUXu8fD5MeHYF/XAY9hQh0AHbUvUNz/K2GlCAMqrLsl0b3qf/tDmo
y8gGOkQ5+nAgpkq2hnQ9WbRxTixfdw0dAtWbei6l/SUL5Ey9GmG2ssXAyuECUOav
T+A/0ABVig8phRUPivplHm/qSx6H92PQBHVh4J6b7NsLKrF3LHm+I+5GVl3mHJqh
wPMaWl6701WuSynCOtJBZFTO91cU5JdD23zZSvJu4gpCNchKhIWdiB5YAeGHCNDf
ByjaHM9V43v0SSqtftBAitF/aXj4swC7vDn83DlBxw1MrS643C4hBBXxYLxbicY/
IX59/60cUOduxEVS6x8UmZ5CAnIJbILw/hE8pxhjVkzPsWR6enVTIEGA4wJqgIg0
nrOgYS+GarXO23963bxrUUKXC41b0zAVMz3jTJ/h0UzSIoROAwoQEbEQZW9L//R1
X05hzYCSjkMESzPTUMUS+2fIpsLfWwUI7Z/nnCSf5Wr12h+DE3gzon8b+RhSt4Jx
xCx6dwV6rApZLXSVn2c7
=hi0Z
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--

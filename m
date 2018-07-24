Received: from eggs.gnu.org ([2001:4830:134:3::10]:43807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhpDe-0005Bi-Rt
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 00:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhpDd-00073Y-Sl
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 00:46:42 -0400
Date: Tue, 24 Jul 2018 14:10:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180724041054.GG6830@umbus.fritz.box>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<bc6c5befa0a24b35f439419d6dea493dc19035b9.camel@kernel.crashing.org>
	<20180723041614.GD6830@umbus.fritz.box>
	<3692f644f72a1af49b7d5988d6b8482ea2f1e271.camel@kernel.crashing.org>
	<20180724021456.GF6830@umbus.fritz.box>
	<f8268fd70e4e91bc6333402ac48598d39a42e38e.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zGQnqpIoxlsbsOfg"
Content-Disposition: inline
In-Reply-To: <f8268fd70e4e91bc6333402ac48598d39a42e38e.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--zGQnqpIoxlsbsOfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 01:49:32PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2018-07-24 at 12:14 +1000, David Gibson wrote:
> > > I don't know, is there much shared logic ? And the shared bits are the
> > > subclassing, that's handled that way...
> > >=20
> > > This is really a different piece of HW, a separate ICS implementation,
> > > that has its own quirks, is configured via different registers, does
> > > EOI differently etc...
> > >=20
> > > Even the resend stuff is done differently, the resend bitmap is
> > > actually SW visible via an IODA table.
> > >=20
> > > I mean, we could (maybe we do these days not sure) have an ICS
> > > superclass wrapper on the actual icp_irq() but that's really all there
> > > is to it I think.
> >=20
> > Hm, yeah, fair enough.  I realized what I was suggesting would
> > actually need another layer of qirqs than we have, so it's not a good
> > idea after all.  Ok, I'm happy proceeding with exposing icp_irq().
>=20
> The only idea I have if you want to keep icp_* private is to put a
> 'helper' in the ICS superclass that the subclass uses to encapsulate
> the ICP call, but at this point it's just churn.

I concur.

>=20
> But yeah you really don't want a layer of qirqs, it wouldn't work any
> way, it's really an ICS, it will send messages to the ICP with a XIRR
> value in them etc... just like an ICS, it's not somethign you want
> qirq's for .
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zGQnqpIoxlsbsOfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltWpssACgkQbDjKyiDZ
s5JdbhAAvn0qiM+0oDSdctb07cLhAcEiBHT0sTwgTWgTSKTlTA9ZvjAOYFx3g1gv
nSkKYOgL2fQWVAfLF61IoN9nNXh8YaZe/VRmT9iVRGiQD66hpQeCm4qH6fhZmPUE
o59T8rpuA2dyRXwGJApuhGLSwOvaEhI6jFO/15/vrtr6VYjvzrtSRTzhEt6MvsHH
rpZ+dldQAJn5zcgU6ckOi0hJPsfU59ZA7c0qQRJxN9eJ/uZbSjhoVIssYqTL9WLl
vg8n36UjMxudtnGDxdTgBdiES7hNmqGXZ8qwJ5nCi3CJGnJJ6Gh+MXV8EyojQaTp
dhS5WZdOD1YbOwRPFbkB8osuSyZjdEsrrnMAJrYHeFXbHyKWohK52sQFqntEaUpW
QpMunPSU0P5AzVd4B3kJWKCyDG0iRxXpU7QSDct+Gblax5/PZI2AwqxLXWvtA6on
3pbHnq4FBgvRBkLvM4f/7upg7IbQtNBkVsy4Ltp0oNHlafPGl1EeGcrmtcGxE93l
768PQUe/ktcRuQdDBYpxTbTMOfFb/m8H+Hm9MDGSl/qjb+QKSLFCT0YJnd8LxsAk
cgEMPDDk1NUhHsCupl0eSt7MEzV6IELebbUCyclMI9/0FYUglWWbtCONcTVee4ws
qnEv3VApjouHn4/ShXG1QyvjknYte+LGJe+PSwgvgyEQn9qESk0=
=ucSB
-----END PGP SIGNATURE-----

--zGQnqpIoxlsbsOfg--

Received: from eggs.gnu.org ([209.51.188.92]:42150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grCJt-0001hQ-KM
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 20:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grCJs-0000HJ-9E
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 20:48:09 -0500
Date: Wed, 6 Feb 2019 12:47:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190206014755.GS22661@umbus.fritz.box>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774528595.1208625.15523908858345133758.stgit@bahia.lan>
	<20190205061346.GM22661@umbus.fritz.box>
	<20190205155915.32033d52@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QHhm1I6mwQR20oIa"
Content-Disposition: inline
In-Reply-To: <20190205155915.32033d52@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3 03/19] xics: Disintricate allocation and
 type setting of interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--QHhm1I6mwQR20oIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 03:59:15PM +0100, Greg Kurz wrote:
> On Tue, 5 Feb 2019 17:13:46 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jan 17, 2019 at 06:14:46PM +0100, Greg Kurz wrote:
> > > The current code assumes that an interrupt is allocated as soon as its
> > > type is set to MSI or LSI. PHB hotplug will require to be able to set
> > > the type of an interrupt before actually allocating it. =20
> >=20
> > Hm.. why?
> >=20
>=20
> The justification for that is given in patch 6 actually:
>=20
> Every PHB needs to claim 4 LSIs to support legacy PCI devices. This is
> currently done at PHB realize. When using in-kernel XICS (or upcoming
> in-kernel XIVE), QEMU synchronizes the state of all irqs, including
> these LSIs, later on at machine reset.
>=20
> In order to support PHB hotplug, we need a way to tell KVM about the
> LSIs that doesn't require a machine reset. Since these irq numbers are
> fixed values derived from the PHB index, let's identify them all at
> machine init. Older machines that don't have fixed irq numbers cannot
> support PHB hotplug and keep the existing behavior.

Sounds good.

> FYI, I'm currently reworking that part entirely. Maybe not worth wasting =
to
> much time on reviewing this v3.

Ok, I have plenty of other stuff to review, so I'll wait for the next spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QHhm1I6mwQR20oIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxaPMsACgkQbDjKyiDZ
s5Ja8xAAhsG8X5bdOl1eb5YwywUm9bwwL+KUk4RFNBv/gN/o2ZHDxdNreMF8h+kW
L8lEYg/cnOmPiDu7NgFVcLOpjsLKMfQ7OJhqYMxxzXd+G3ae/cOcT1DHjIF9MiNN
8D40J1Exvu/EctiO8ZgrnnYYrTytFnBbqF7Kfhmn6SGBuW+XLI07uSBUAzSTtVy6
w5FdRDqdf200r4PqC3rR861u7Oz/wG9Y8bz4Jd+SSVXUlEDeIhHEYbpPjFhzxBKK
xTNs6n4lXwsOswpG/tW3K3f/x8MBvI/bcExWg9JKernd+q6dvanwurFqf7Lu3zEU
reOPLWyKApGCRmu+jX5Q8cB/fhnElJlWl+7fhjp/7V6jjxbelrg9pR8v1KlcXcHN
HUlnTJb5QpbRn6Ip4mKo4MCQR9ymeFGhJUc2KGXnJIs9wJWUIyzcqtcO/EjEjyLh
Ry5LlfBphiY1/CXy3LG56196CaEzZtgCqjfCzHTYmZ3K8epPgjSyZiaWDYRDWmPO
+yCyl9CGaPF420uDjN8BcgJzZg42fxJtdl0j77CciNj3phPxpJy6uwPP7BoiVOS2
fqrQrzKzDRDu4K90FmJEB1O+QwrE4zePQaHgsiSvQl+ivPghUsa9KWTCxOi5vhIp
ajRK90D3M4FNq77zR6BB5RkU0oyadPT1ccPC2KbMrCZJ+l5JKtE=
=8uaC
-----END PGP SIGNATURE-----

--QHhm1I6mwQR20oIa--

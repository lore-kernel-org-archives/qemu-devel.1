Received: from eggs.gnu.org ([2001:4830:134:3::10]:39455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLiuK-0006em-RF
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 00:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLiuH-0007iS-Nm
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 00:03:08 -0500
Received: from ozlabs.org ([103.22.144.67]:56641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eLiuH-0007hM-3k
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 00:03:05 -0500
Date: Mon, 4 Dec 2017 15:40:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204044020.GM2130@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-4-david@gibson.dropbear.id.au>
	<abaddfae-f0f0-cbe3-93b5-b2f102290725@redhat.com>
	<20171130040248.GU3023@umbus.fritz.box>
	<20171201182840-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+2GlJm56SCtLHYlr"
Content-Disposition: inline
In-Reply-To: <20171201182840-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [for-2.12 3/7] pci: Fold pci_bus.h into pci.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org


--+2GlJm56SCtLHYlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 06:29:39PM +0200, Michael S. Tsirkin wrote:
> On Thu, Nov 30, 2017 at 03:02:48PM +1100, David Gibson wrote:
> > On Wed, Nov 29, 2017 at 12:38:00PM +0200, Marcel Apfelbaum wrote:
> > > On 29/11/2017 10:46, David Gibson wrote:
> > > > include/hw/pci/pci_bus.h is now very small and can only safely be i=
ncluded
> > > > after hw/pci/pci.h.  So, just fold it into pci.h.
> > > >=20
> > >=20
> > > I don't get the benefit from merging the header files.
> > > I would go the other way around and find stuff specific
> > > to pci_bus and add it there, like the pci_bus_new*
> > > you touched in the prev patch.
> >=20
> > Hrm.  Except the point of the earlier patch was that those are
> > actually spoecific to root buses, so would really belong in say
> > pci-host.h, rather than pci-bus.h.
> >=20
> > A log of PCI stuff deals with interaction between the device and bus
> > though, so it just seemed like more trouble than it was worth to go
> > disentangling them properly.
> >=20
> > > Maybe if *all* code files requiring pci.h would automatically
> > > need pci_bus.h would make sense, but I didn't check that.
> >=20
> > Yeah, I don't think every user of pci.h needs pci_bus.h, although a
> > fair few do as you can see from the diff.  Well, I guess it's up to
> > Michael.  I'll be tolerably content either way - I'd say this is the
> > least important patch of the series.
>=20
> I'm inclined to agree with Marcel also because it's lots of noise for no
> real win.  The next patch depends on this one. I skipped this and next
> one, pls feel free to repost next one.

Ok, will do.  I have some other cleanups in mind, so if I can finish
them time, I'll fold them in as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+2GlJm56SCtLHYlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlok0a4ACgkQbDjKyiDZ
s5I1qxAAt+2Haf+k15rHgP8kOGkkLGlbip1W7D8pNN3yV23Paln55qB8RNVtKLkd
wvy2Z7ew6nLv5CoqvSVj4xuiyGS6HEDQ/1N7sfzsuvs72qzDwV5LppyOYki6sykV
oDjNLn7DSkg7gDggsnx7l/YhpfAivW8H+mCkKXZsaLEwruH1dxIc6UKt6+bR0YoQ
vpCa+ybfQuFZWg4wFTL6cB5yrxcnPQsdSNIio0Cvb1jR7imdHBjpj13egHGBCrPR
lVyzDISaP5jGsK/WYnF0JS0DG/n0/W4/eFoAe9kHeKo33SbDPDMMXTv5+wYlx8+U
0DoXoPqNW9D5n7lZGUOyx7/UMUHKgMOcckoccW09XQXytotlKm7UsHb+Yu4dSNOi
tOcm033ala25ka4m0Nn/EmTGgIY1FecZTBIJ3U/MisxaK5G2smSMrRDcswg6ZlCk
jb7wMZKcF/71K+MnoB9Dgznjsrlrd+8Z6uQPGZibuAy6788Kbv41AQax7YeM55Xd
k5wiOy1805L8WuYPtVWD/8jRoamUGH48p5bcIYYazNCTS+aBecSgfYaowjMx2Zdi
g5KjQnOsvG7muQCCNCCsEe31KTlECL77gs8M9c/nIJ/joc4yGD0kePnymXvG7Wg3
sXSWCNw1NiDICkx7qyDu8SH4oxekj1jzVqkZ4peI5AU7FwXVT7E=
=iSMl
-----END PGP SIGNATURE-----

--+2GlJm56SCtLHYlr--

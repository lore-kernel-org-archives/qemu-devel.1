Received: from eggs.gnu.org ([2001:4830:134:3::10]:48373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYO5Z-00009B-EW
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fYO5W-0007Vy-An
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:59:21 -0400
Date: Thu, 28 Jun 2018 13:59:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180628035909.GE23134@umbus.fritz.box>
References: <20180626135928.23950-1-clg@kaod.org>
	<7d5dbadc1bb62c40da5de76c2a02807b0b96e7c0.camel@redhat.com>
	<dfe396c1-05f2-c776-f2af-303e9325c332@kaod.org>
	<8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <8a5d8ae0f382003f8fc2ebf9083c995177c90695.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: Add model for Power8 PHB3 PCIe
 Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2018 at 12:22:31PM +0200, Andrea Bolognani wrote:
> On Tue, 2018-06-26 at 19:02 +0200, C=E9dric Le Goater wrote:
> > On 06/26/2018 05:57 PM, Andrea Bolognani wrote:
> > > On Tue, 2018-06-26 at 15:59 +0200, C=E9dric Le Goater wrote:
> > > > This is a model of the PCIe host bridge found on Power8 chips,
> > > > including PowerBus logic interface, IOMMU support, PCIe root comple=
x,
> > > > XICS MSI and LSI interrupt sources.
> > > >=20
> > > > 4 PHBs are provisioned under the Power8 chip model to fit hardware =
but
> > > > only one is currently initialized.
> > >=20
> > > What's the advantage in creating 4 PHBs instead of a single one,
> >=20
> > The Power8 chip comes in different flavors: Venice, Murano, Naple,=20
> > each having a different number of PHBs. We don't need to initialize=20
> > them all to plug only a couple of devices (net, storage, usbs)=20
> >=20
> > When time comes, we might want to test some more complex configurations
> > or extend the modeling with CAPI support. That's why we have a :
> >=20
> > 	#define PNV_MAX_CHIP_PHB 4
> > 	    PnvPHB3      phbs[PNV_MAX_CHIP_PHB];
> >=20
> > under the chip, and a 'num_phbs' attribute to increase the number
> > of controllers. It still needs to be tested but that's the goal.
[snip]
> > I didn't follow that discussion but this is "another" kind of PHB.
> > This one models the baremetal controller as found on OpenPOWER and
> > IBM Power machines. pSeries has a virtual PHB.
>=20
> I understand that, and of course libvirt will need to learn about
> this new type of PHB and make sure both pSeries and PowerNV guests
> get the correct one assigned to them.

Hmm.. does it?  I would have thought pnv could act more like x86, in
that libvirt doesn't attempt to create PHBs at all and just use the
ones that are built in.

Though, come to that, I wouldn't think pnv support for libvirt would
be much of a priority anyway.  The machine type is still very much in
flux, and it's designed primarily for testing and development, not
"real world" usage.

> What I meant is that pSeries guests get a single PHB by default,
> with additional ones being instantiable through -device; this is
> also consistent with how PCI controllers are added to other guest
> types including pc, q35 and aarch64/virt, so it would be really
> nice if PowerNV behaved the same way.

Well.. sure.. but it doesn't.  pSeries is a virtual platform, so we
have a reasonable amount of flexibility to define it as we want.
PowerNV is an emulation of existing hardware which has a specific
behaviour which we need to match.

> > > As it is, this will confuse the heck out of libvirt's PCI address > a=
llocation algorithm :)
> >=20
> > The pci bus name should be directly related to the PHB index. But
> > I agree we need to be careful. That's why you are in cc: :)
>=20
> Thanks, I really appreciate you keeping me in the loop :)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls0XQ0ACgkQbDjKyiDZ
s5IYFQ/+Na1jNn4GWzAGWIEnYPhcVWejUP9qFhnBB96rIIM3C4hhRRKDHZSNn06Z
W2eDHtJxndkIxlZJ8triL0WiK0EChY4gQh5MtFaWaqJnNuAn5s9bEUV22yE4ojYP
11FJX0g5JhQKKlH9Y8J7Gk6iIXwV4ly1yohm3+L5mJ8ZWp3fV0vU91v8/z5+2wux
c5w+Zkn2AaQL5B7I8VQWHNQn7ntMRim5NPI/Elwn+UDaSSlSPG/6VKOrQbbMqgP6
sh+xJdEhr3uJKh63jgreXmiUtKAA1nhkeBrDcvoEzLcpX0YXu+KnhN/yYoRPdP38
RId19uCiz9BkDZcUVq5FX607LgygDXj9FCV+txWJEj2lNVAjKd1PmOW7sQ2gh699
YrVcU6Z+BERqumUpPFXvxSVMLB8jXSXO0KocMrwSVNA1KHOrlQXR9NqPd+X4kloM
wfrVAGcdjLmg8I8IRpYIYIFcvK4GFQdz6GGrhSe3vY3paDt/lD5CABc9RpTdZ0xG
BJ9E5SenTOkPYd+PPGnv11ACv1upC2JXrO8+M0O55VpAVahW1WD2zj1HZ+1+6ace
p3JZhCNZn4X5y5BIpOK1IAhapCQ4uG8rgBkpYG/LrqwGTEjq9ndSdhSkc9xMNeVp
GaZKcq7rBjkV8WxQH9jwckVTe6mbylLAa0DGJc2J81TjhBGzZ4w=
=Dc99
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--

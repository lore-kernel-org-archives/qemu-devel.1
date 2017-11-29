Received: from eggs.gnu.org ([2001:4830:134:3::10]:46330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eK2Mw-0002SC-NX
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eK2Mv-0003iQ-EH
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:25:42 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:51517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eK2Mu-0003fW-R8
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:25:41 -0500
Date: Thu, 30 Nov 2017 00:15:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171129131521.GN3023@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-7-david@gibson.dropbear.id.au>
	<9b0e9672-e0d7-53c3-9a42-ab3f6011b59b@redhat.com>
	<20171129114109.GZ3037@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rPgHZmYkQ+bUEpVC"
Content-Disposition: inline
In-Reply-To: <20171129114109.GZ3037@localhost.localdomain>
Subject: Re: [Qemu-devel] [for-2.12 6/7] pci: Eliminate redundant
 PCIDevice::bus pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org


--rPgHZmYkQ+bUEpVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 09:41:09AM -0200, Eduardo Habkost wrote:
> On Wed, Nov 29, 2017 at 12:54:04PM +0200, Marcel Apfelbaum wrote:
> > On 29/11/2017 10:46, David Gibson wrote:
> > > The bus pointer in PCIDevice is basically redundant with QOM informat=
ion.
> > > It's always initialized to the qdev_get_parent_bus(), the only differ=
ence
> > > is the type.
> > >=20
> > > Therefore this patch eliminates the field, instead creating a pci_get=
_bus()
> > > helper to do the type mangling to derive it conveniently from the QOM
> > > Device object underneath.
> > >=20
> >=20
> >=20
> > Hi David,
> >=20
> > I personally don't see why the caching of the bus bothers you.
> > It makes the code a little easier to read, but indeed is a duplication
> > of data; let's see what Michael has to say, is a matter of
> > taste I suppose.
>=20
> I'm all for removing duplication of data because it makes the
> code less fragile.  We don't even take care of clearing
> pci_dev->bus when the device is removed from the bus, so there's
> a window between unplugging a device and actually freeing the
> object where pci_dev->bus can become a dangling pointer.

Right.  In some other things I'm working on I also got bitten by the
fact that the PCI parent pointer wasn't initialized until realize()
time, when I needed to get to the bus before that.

As a rule I like to keep data normalized, because it's harder for
things to get out of sync confusingly.  The fact that on modern
hardware recalculating things is generally faster than the the extra
cache footprint is just a bonus.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rPgHZmYkQ+bUEpVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloesucACgkQbDjKyiDZ
s5LBhw//Yg0U0SxjkNsl4xFPRDss7x1gAGBsN2sq2116mbyq5+H6w2Z/fAdWIyT0
3sZ9rx4smVDJktr8fJ4zvDp5gsYCqx9SbMZES7iIVy6s4q1zn4n32b4ApARgy4K4
9kntnH3NTADuXoZUe+pb7lVyZiUgED9RymS34/bH34s/0eajVGhdTPyjtZjJFmtV
DDKlH/sib3vxcrcki5JF57HMbbJWOqz/CUsJyhVN0iGwP/JRroT8xLCkgSHg41Va
VP165yd/de9MxVUEUuwvdFnumkUt7XnL39hktruSZWxaFAn0nX8APopz/koM10kk
Y8WYkoKLIqEbGe722gc/JSEl4PlfLuJvG6L9sqNxjf9Z+wRfAqipTKL4yt/6QmF9
m3JJ38Pg+rkwvGQgwbbLtM83XbYOzNBY87JSCu8qI7Iq9tJE2B8V3atpdbGqfdqQ
kcpOrL2PZswod8eJChPB1D30iZNfkJykz5GcDwzUCJMjCfM02Y6b+foqEDpFr65G
uHApmF97dPwD8nUe85Bz68pkgXWNdORpf4La1YQjjQ3qH3v3t72zz9SeZJijTl9P
ktA1rUAsn+fw7WeO6N6jkq6Py43Sv0jhwhrtoBc192vyA/P69KlXm7repuXYQzV0
Ma57211gzuNiT+wLQ5cFR8FFebPMjEGx0YhxkVZ9HPfbNcaFKLE=
=lwOk
-----END PGP SIGNATURE-----

--rPgHZmYkQ+bUEpVC--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLi77-00085I-I7
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 23:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLi76-0004eu-9n
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 23:12:17 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:53267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eLi75-0004cS-MJ
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 23:12:16 -0500
Date: Mon, 4 Dec 2017 15:01:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204040110.GL2130@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-4-david@gibson.dropbear.id.au>
	<abaddfae-f0f0-cbe3-93b5-b2f102290725@redhat.com>
	<20171130040248.GU3023@umbus.fritz.box>
	<20171201182840-mutt-send-email-mst@kernel.org>
	<20171202005920.GB2130@umbus.fritz.box>
	<20171203070618-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vJI8q/aziP9idhqk"
Content-Disposition: inline
In-Reply-To: <20171203070618-mutt-send-email-mst@kernel.org>
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


--vJI8q/aziP9idhqk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2017 at 07:07:36AM +0200, Michael S. Tsirkin wrote:
> On Sat, Dec 02, 2017 at 11:59:20AM +1100, David Gibson wrote:
> > On Fri, Dec 01, 2017 at 06:29:39PM +0200, Michael S. Tsirkin wrote:
> > > On Thu, Nov 30, 2017 at 03:02:48PM +1100, David Gibson wrote:
> > > > On Wed, Nov 29, 2017 at 12:38:00PM +0200, Marcel Apfelbaum wrote:
> > > > > On 29/11/2017 10:46, David Gibson wrote:
> > > > > > include/hw/pci/pci_bus.h is now very small and can only safely =
be included
> > > > > > after hw/pci/pci.h.  So, just fold it into pci.h.
> > > > > >=20
> > > > >=20
> > > > > I don't get the benefit from merging the header files.
> > > > > I would go the other way around and find stuff specific
> > > > > to pci_bus and add it there, like the pci_bus_new*
> > > > > you touched in the prev patch.
> > > >=20
> > > > Hrm.  Except the point of the earlier patch was that those are
> > > > actually spoecific to root buses, so would really belong in say
> > > > pci-host.h, rather than pci-bus.h.
> > > >=20
> > > > A log of PCI stuff deals with interaction between the device and bus
> > > > though, so it just seemed like more trouble than it was worth to go
> > > > disentangling them properly.
> > > >=20
> > > > > Maybe if *all* code files requiring pci.h would automatically
> > > > > need pci_bus.h would make sense, but I didn't check that.
> > > >=20
> > > > Yeah, I don't think every user of pci.h needs pci_bus.h, although a
> > > > fair few do as you can see from the diff.  Well, I guess it's up to
> > > > Michael.  I'll be tolerably content either way - I'd say this is the
> > > > least important patch of the series.
> > >=20
> > > I'm inclined to agree with Marcel also because it's lots of noise for=
 no
> > > real win.  The next patch depends on this one. I skipped this and next
> > > one, pls feel free to repost next one.
> >=20
> > Ok, will do.  Is the tree you've merged the others to public
> > somewhere, so I can rebase on it?
>=20
> git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git branch is named
> pci

Thanks.

> pls note this is a rebased branch, commit IDs won't be stable.

Understood.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vJI8q/aziP9idhqk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlokyIMACgkQbDjKyiDZ
s5J7cA/+OgEvUw7ecd5U31gmyiFc18wxYnAejdcZc7jFkcNR53QGrN2ybuVcU7pI
mRMlZQ/7m6eRsd1X6fGmLAdxusaInFgxbdx81Hytd0DtqQM6dIbC3rpTphvekw9a
UY9uxBLUjEUXkoly+vgPg0M6AN5XLyitlFZ4DFl7KPDmo5JXecs5HsncqwB8XVI4
xKdIkcyjX6+sLxq3ANrU2VdR8cAR2ifrsXZZo9B7GrcAneMlxoq196ugJk9nHkC5
Ea1w3r0ADwRXUKz4kfSKfX7Q1sf8N5zcj3Ch53deC848EanfAqjyPBvJROCB8DRO
QNGqW3XU2/+dM2isN0o7gqbCsWF5IsUBHszpBAwHtx097lcmZP99R+n/QyglzJgo
kT3Hwk3teqG28pJLEKy83hnn2ONjR0vMWd9/uslb9xiJ3noAhinW3YpPhMjumXzH
dij/EahYIRl4FdsT2ChXi8QW1BQFdYnG3bX/Iwxs1JzaQoGnNsYEDZOqQxlx5FFO
aRmxBsvENhjjzILDQlinUd2N2b3rPc2blYZ7pVj2LfysMpUAHUr0CI9t4xDzCiwV
inO+mie8SAky+6eNCDigVT9Rwh1GBYpwkUcJzx/KWaTAKg5M2NmGG1OtQEGj5jXP
c1iBObu5H1lJy90iiOP0Jn0moKX3djKmWEj0tsa7TEPEu63T+5w=
=JjP9
-----END PGP SIGNATURE-----

--vJI8q/aziP9idhqk--

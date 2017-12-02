Received: from eggs.gnu.org ([2001:4830:134:3::10]:35554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKwdy-0003pV-QL
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 20:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKwdx-0002MH-EL
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 20:31:02 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:52197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eKwdw-0002Jv-L8
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 20:31:01 -0500
Date: Sat, 2 Dec 2017 11:59:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171202005920.GB2130@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-4-david@gibson.dropbear.id.au>
	<abaddfae-f0f0-cbe3-93b5-b2f102290725@redhat.com>
	<20171130040248.GU3023@umbus.fritz.box>
	<20171201182840-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
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


--i0/AhcQY5QxfSsSZ
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

Ok, will do.  Is the tree you've merged the others to public
somewhere, so I can rebase on it?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloh+uYACgkQbDjKyiDZ
s5K8URAAp8afVUiKXqwy9jTlfQhKP2i/BFWRgMySZLV4823UPCmwGcLYeLeybFlb
cVgFm7XeQ/iQAgcEepQ738ngHhMgWwgVfnu4zve151B0du1urrj12r+1bgogAv6o
EPyq+u7TKgp2mPmdpjqQb+rWiD6mjFYAjVtbfzQ8Gup0QPEK3HzMey6b88GMiuaC
4zBsCfa6WcT8WHTpRETnK0A5iTYSu4WSl6v95+vJssymNZvfOFGb3SWqVUxrJ70w
GQ+jKK/vLVNT1V+H5t8GDyri6+i3BJPQPB0XSW9tMNo5qgbX4BwfRrtfGVQJ6jmQ
GLSdkdnMXtPDI1ODNEJke9Tgt2BZ+ubknYtth1GrXHDDm6tWnYO6iXzXiElW+9E0
h37Rx2j4xrvZQz/NCxvwYsMBCvacjR6r7kNwjIabXTMocT+xTQS4uegrh+Yw8rpz
/Cs78dGyGHjXt4aZ+3tEw2KeDFI13mikgPihi8eehj75807yAk3fm6diBxo0p+U7
zFPTLVHVKhvxRusaE3O/o3OqSIYfrU3FIWoiuita7+sSg6z7hovd9K5JiI4/M1Pk
VZIwLEZRzvTSJe3fCr8kSzagdgLh9ofGlvls7+6pLgUozJxK7h0ZaTO9/AiJACCO
AevYgZO+soB3A9h4Fy/q5e4mD7iiWvZStXCtPM0MBjwhnNUvTps=
=s8l1
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--

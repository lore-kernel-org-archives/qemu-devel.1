Received: from eggs.gnu.org ([2001:4830:134:3::10]:32829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQOyq-0002qh-W4
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 20:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQOyp-0000px-HH
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 20:42:37 -0500
Date: Mon, 9 Jan 2017 10:46:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170108234621.GB12515@umbus.fritz.box>
References: <20170105054618.GA12106@umbus.fritz.box>
	<1483724069.4199.80.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <1483724069.4199.80.camel@redhat.com>
Subject: Re: [Qemu-devel] Proposal PCI/PCIe device placement on PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, marcel@redhat.com, aik@ozlabs.ru, groug@kaod.org, ehabkost@redhat.com, mdroth@linux.vnet.ibm.com, libvir-list@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laine@redhat.com


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2017 at 06:34:29PM +0100, Andrea Bolognani wrote:
> [Added Laine to CC, fixed qemu-devel address]
>=20
> On Thu, 2017-01-05 at 16:46 +1100, David Gibson wrote:
> [...]
> >=A0=A0=A0* To allow for hotplugged devices, libvirt should also add a nu=
mber
> >=A0=A0=A0=A0=A0of additional, empty vPHBs (the PAPR spec allows for hotp=
lug of
> >=A0=A0=A0=A0=A0PHBs, but this is not yet implemented in qemu).
>=20
> "A number" here will have to mean "one", same number of
> empty PCIe Root Ports libvirt will add to a newly-defined
> q35 guest.

Umm.. why?

> >=A0=A0=A0=A0=A0When hotplugging
> >=A0=A0=A0=A0=A0a new device (or PE) libvirt should locate a vPHB which d=
oesn't
> >=A0=A0=A0=A0=A0currently contain anything.
>=20
> This will need to be a PHB-specific behavior, because at the
> moment libvirt will happily pick one of the empty slots in
> an existing PHB.

Exactly.  Well, whether it's PHB model specific or machine type
specific is up to you really.  We can only have PAPR PHBs on a PAPR
machine type, so it's kind of arbitrary.

>=20
> >=A0=A0=A0* libvirt should only (automatically) add PHBs - never root por=
ts or
> >=A0=A0=A0=A0=A0other PCI to PCI bridges
> >=A0
> > In order to handle migration, the vPHBs will need to be represented in
> > the domain XML, which will also allow the user to override this
> > topology if they want.
>=20
> We'll have to decide how to represent them in the XML, but
> that's basically your average bikeshedding.

Right.  Maybe we'd best get started with it, in the hopes of finishing
it in the forseeable future.

> Overall, the plan seems entirely reasonable to me.
>=20
> It's pretty clear at this point that pseries guest are
> different enough in their handling of PCI that none of
> the address allocation algorithms currently implemented
> in libvirt could be quite adapted to work with it, so
> a custom one is in order.

Yes, that was my conclusion as well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYcs9NAAoJEGw4ysog2bOSjysQALFH42hCfe78Hm/ogSd05mkX
yMmXZ6mLDWs3n65EFJkJnoFtLbtJPyF8FlAKwH00cvJT9khl6LlVcgmEnuWzi8Du
resESge32if6BfjN7LJVxiOjZ+77y46N2iNPXvrDsF4KXpJPrayPWDpWe3LyliI0
EP8Ts03d+Ez7+Q35z6+M5HunK5MagplYeSvLmVt6Aposp1tzwEpicB9htWnppZx8
d66FJwhgEPGXtq2I7wpdwnfv5ybl3cmbpC88K4Uz+SdnagRuiDDPy+g46E7JIL3n
1WhxB+yPvk6npPAf8X7e18TrT7tHC9UR/TNJFGtxagjKgvIXLQ5Wxk0kzJv7xU70
2WeUSgKAnKibmc1XbuePJhM/cZx87+onDdFd93Be0wSDvTfAi7BDexuqFp7xdjYg
5udPHvaAcHUQbQXTPs1Kq4lRXgekMY2BXNoEE5qLi009825J7OkpE1/FnJBZyqHL
GmNG6p0ZlavI+vXw53laHzWpDo7SyUWDMZY37GW5zNGqEj/zuW7jvDD159hv/LCK
lA56GdQVLrZM+6qr3z10YjlVIE0dC/r2s9dIV9M27J1OuANvPMQGrrAmd6KnHWMe
3BMl0JUX7Yj57f5XT4bfFv/Wqdib1v/4grHvgO/DEWWEJwP80gehWhFo4ILgDIQU
EIiafNjMbJIdAJsVSH91
=+1sE
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--

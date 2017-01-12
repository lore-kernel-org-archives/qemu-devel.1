Received: from eggs.gnu.org ([2001:4830:134:3::10]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0F-000879-Oy
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:41:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cRp0E-0001xa-LW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 18:41:55 -0500
Date: Fri, 13 Jan 2017 09:57:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170112225736.GB13656@umbus.fritz.box>
References: <20170105054618.GA12106@umbus.fritz.box>
	<1483724069.4199.80.camel@redhat.com>
	<20170108234621.GB12515@umbus.fritz.box>
	<1484217095.7948.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <1484217095.7948.1.camel@redhat.com>
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


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2017 at 11:31:35AM +0100, Andrea Bolognani wrote:
> On Mon, 2017-01-09 at 10:46 +1100, David Gibson wrote:
> > > >=A0=A0=A0=A0* To allow for hotplugged devices, libvirt should also a=
dd a number
> > > >=A0=A0=A0=A0=A0=A0of additional, empty vPHBs (the PAPR spec allows f=
or hotplug of
> > > >=A0=A0=A0=A0=A0=A0PHBs, but this is not yet implemented in qemu).
> > >=A0
> > > "A number" here will have to mean "one", same number of
> > > empty PCIe Root Ports libvirt will add to a newly-defined
> > > q35 guest.
> >=A0
> > Umm.. why?
>=20
> Because some applications using libvirt would inevitably
> start relying on the fact that such spare PHBs are
> available, locking us into providing at least the same
> number forever. In other words, increasing the amount at
> a later time is always possible, but decreasing it isn't.
> We did the same when we started automatically adding PCIe
> Root Ports to q35 machines.
>=20
> The rationale is that having a single spare hotpluggable
> slot is extremely convenient for basic usage, eg. a simple
> guest created by someone who's not necessarily very
> familiar with virtualization; on the other hand, if you
> are actually deploying in production you ought to conduct
> proper capacity planning and figure out in advance how
> many devices you're likely to need to hotplug throughout
> the guest's life.

Hm, ok.  Well I guess the limitation is the same as on x86, so it
shouldn't surprise people.

> Of course this all will be moot once we can hotplug PHBs :)

Yes.  Unfortunately, nobody's actually working on that at present.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYeAngAAoJEGw4ysog2bOS8cEQAM6cWX5B61V9m+Ap3bhKRsMs
+4S9e1HFTnupXATEI/GQDdefRhtaAw2CqmqKaUdrTFBGgT6l+2ZQnPR+x+ZLvCqQ
ncsephoPsKGEtUORbmQc26+8YTP2QLRJWYcCi4ZtDTODhW5caFV2JVCTDNdUhpKu
R9txwMKAgdWFnoI1dU8yEsO+6HfqSCg1v50zMbizszoZ90sfJBCnQmDIZnBiAdyB
+4aKGPfU6WbZiRCY0A3TjPXal639rVDt/iZ5pyfXYj+SDX8jis5oEPhfUH1gZNtI
n9qQShUvliBgiKQLcBAhpOOrFOAXO01tF5PcjV/w3DgFk1VDP6fx6biaDJjT3cSn
WuphvKKs6Lo8fLy453uJmpJu8JekIFsv5bR6Jp9SFOQyJbp2R811atJCijIL7Koy
FNbolqZAWoQp8JP1DzmTggOI4nTK2wyfSJLoSUQsMFENUjjvApSzzlRB5I95QQTW
1mZ1toiWjB0XW7lSOOS83Vmny8Hp+Nx3k99r15Z9mEnxx+gXwlaxLf/YpQn88qeO
yBMqDz+ddUSi0LP5mutwknIXB/FP/fJBQT6v2N4k4TGFOZb78P2T36Y55/yzbLur
5x4XSQ4aj20I2rKmGu2lWuRhvbkLFVQPkIvQB7aySEGcWGUaypc7O9afiO6wQek2
gMQ7t6Mvj8CMIzHswh6Q
=nV6X
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

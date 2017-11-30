Received: from eggs.gnu.org ([2001:4830:134:3::10]:57639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKG48-0004Dy-Us
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:03:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKG45-0001Jg-Ps
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:03:12 -0500
Received: from ozlabs.org ([103.22.144.67]:39103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eKG44-0001Ih-OI
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 23:03:09 -0500
Date: Thu, 30 Nov 2017 15:02:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130040248.GU3023@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<20171129084628.12336-4-david@gibson.dropbear.id.au>
	<abaddfae-f0f0-cbe3-93b5-b2f102290725@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bGopQmzlzQgFk3Fg"
Content-Disposition: inline
In-Reply-To: <abaddfae-f0f0-cbe3-93b5-b2f102290725@redhat.com>
Subject: Re: [Qemu-devel] [for-2.12 3/7] pci: Fold pci_bus.h into pci.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org


--bGopQmzlzQgFk3Fg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 12:38:00PM +0200, Marcel Apfelbaum wrote:
> On 29/11/2017 10:46, David Gibson wrote:
> > include/hw/pci/pci_bus.h is now very small and can only safely be inclu=
ded
> > after hw/pci/pci.h.  So, just fold it into pci.h.
> >=20
>=20
> I don't get the benefit from merging the header files.
> I would go the other way around and find stuff specific
> to pci_bus and add it there, like the pci_bus_new*
> you touched in the prev patch.

Hrm.  Except the point of the earlier patch was that those are
actually spoecific to root buses, so would really belong in say
pci-host.h, rather than pci-bus.h.

A log of PCI stuff deals with interaction between the device and bus
though, so it just seemed like more trouble than it was worth to go
disentangling them properly.

> Maybe if *all* code files requiring pci.h would automatically
> need pci_bus.h would make sense, but I didn't check that.

Yeah, I don't think every user of pci.h needs pci_bus.h, although a
fair few do as you can see from the diff.  Well, I guess it's up to
Michael.  I'll be tolerably content either way - I'd say this is the
least important patch of the series.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bGopQmzlzQgFk3Fg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofgucACgkQbDjKyiDZ
s5KEnA//YB5ALYNRgdw1YxjIfMehyFPemPJSTwSE+9My3x/DtLQS3+XYiJL+cjtB
BrSMkjAyBgT6Y+lAxiChl1+vizjmfZpwPJpnJsqEkrsNwJ/yrCq0hC29+5oQztkj
nvy720g6tNQ3FH2HkNTUPnHbi/G61EG+Zlfhs2Uhqboj1RTivAbRr2jz2JiQHHpq
KHjwJlTxyFR5QiXVBQAhJuooAzwnv/TF26lIB/MhZjVppKY9d1DwKQEnHHakPsRq
nHYW2LyctWhDne7AtEUzqkPPveHaMx5/djYUpZ9WIivT/vQUarMnx+0cV8uSQ6jG
ppGdxS5geAqyyFNlh8iTYQN+wdy4Pi4shEyXKyq4qjvyDVCgwViRqw32SS4wMQXB
Y5AUxsMXQtA3MiNPLHciK4OYNygAnMKaF9ZRBzhbW1rRsW0USaqsaP5J4PhKFgkK
Gb0wHPibFgEnErMrmMl/bYsLLs0ofx9Hl7+HhytBGOl7lhV0uUmupQcQOpq+xg3b
fo/tJ9x1YKAfk319iKh8zap/1SzlQwtKlT7QSr3zmI9ladGe3xlhvFvlD7QIIsRH
/94Q9yLr8qw+qEVX1FUhEaIwJvsLDxciB27AIwQM6MH1rSb90ymbcJ6AAKQVpuAy
YXwPVrhs7HXQQGgoIKUgt7bJjMyxZsXTc8YqEQdDlPTCYl4673U=
=Ca5m
-----END PGP SIGNATURE-----

--bGopQmzlzQgFk3Fg--

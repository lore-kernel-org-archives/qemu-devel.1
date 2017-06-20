Received: from eggs.gnu.org ([2001:4830:134:3::10]:51693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN7wQ-0005J9-HA
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 21:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dN7wP-0008TB-HM
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 21:26:50 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dN7wO-0008Rc-6b
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 21:26:49 -0400
Date: Tue, 20 Jun 2017 09:02:58 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170620010258.GK22449@umbus>
References: <CAFEAcA_3Uf-t7MgvTqO52XX61z3Mcnmpk1XNJRqgdFJiVP1ALQ@mail.gmail.com>
	<08ab93cb-4d42-2b8b-71e6-057b9529d0b7@suse.de>
	<e72dab1b-7544-65ea-0e07-abfd78413706@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2pR2RtFp0tAjF3C"
Content-Disposition: inline
In-Reply-To: <e72dab1b-7544-65ea-0e07-abfd78413706@redhat.com>
Subject: Re: [Qemu-devel] spapr guests warn "System page size 0x2000 is not
 enabled in page_size_mask (0x11000). Performance may be slow" on SPARC
 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>


--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2017 at 12:32:48PM +0200, Thomas Huth wrote:
> On 19.06.2017 11:39, Alexander Graf wrote:
> > On 06/15/2017 03:33 PM, Peter Maydell wrote:
> >> I've just noticed that on a SPARC host, some of the PPC guests
> >> warn during make check:
> >>
> >>    /ppc64/prom-env/pseries:
> >> qemu-system-ppc64: System page size 0x2000 is not enabled in
> >> page_size_mask (0x11000). Performance may be slow
> >>
> >> Is this really a performance problem on a TCG guest?
> >> It makes the 'make check' output a bit noisy, but not
> >> unbearably so.
> >=20
> > From what I can tell this really only affects DDW which should be page
> > size agnostic when only using emulated devices. Maybe Alexey thought of
> > using VFIO-pci devices in a TCG guest?
>=20
> Maybe we could at least silence the warning by checking
> qtest_enabled()?


So,

1) Yes, we should at least silence the warning.

2) Certainly the mentioned slowdown shouldn't be significant for TCG
guests.

3) I _think_ the restriction which causes the slowdown doesn't even
exist for TCG, but I haven't 100% convinced myself of this.  I've been
sick lately, so my brain isn't working all that well.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZSHQ9AAoJEGw4ysog2bOSb6sP/jwlQZH40DXo9XoLHu6KnmZb
awrmPn6Tjib69rorSrg0R5xNkwdBpvJtYaQs53AT0XYbw4Eh2MDX7YbuVoIyQDdD
Z7lJCwC6arorJRnFh/QlPo5n88l/X0trU+YEZS+yip/+ZkahWco7ec67b3EHJ0Ze
zjyO8T0JgnIKsQqgYxxQ/N5enoJ2xHIeqTZXJTg35AqiDXaxsJmVD5KpNBG8A2A2
pDdTIAYacM/IWx0LmNyuFa+dfFc9ELBxQPfXEoO3X31K6QOcrRTy9nzTmD7hsPgE
E45JQC1MrdqOyec1fd10lTqvZrOMHjGFKHAMKJFHWYo0Jy0UI6lJ6sTAMHqHqmF4
ZVLlcdelO/i0ZRFHUdeP/JbedKaE+Si+w4Mg/VTdND1WCoTvwccTrkFsW6mH4NJD
Td8suIwpuvjfc9L5go9aQCiqCedoFM/XD2gJ9Bs/nNuF+YGIHv5PCijhUl8eEeaS
GXS/X+ngxRSdgr6v8Exn6w6ZpHCS6xnNUlJk3qVs56NXOk4jRxk8mU7NKppOdxae
mC59Gp7IiwlQf5jwJElN/xis9i+z/3lVarI3JoDO60G8fkf+oeBvW4vRSCOeB+zB
KlAHTjG4rWTR9NaP7IO446VtPE7NFZXG5ISXgqSDOT+9HJAiYhuIzNg+yNjpi0p3
sAuSzuU14CEWqIuXTmHL
=qzrz
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--

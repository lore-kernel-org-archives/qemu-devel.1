Received: from eggs.gnu.org ([2001:4830:134:3::10]:45228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dahCg-0002RU-F6
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dahCf-000385-Ge
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:43:42 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:56925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dahCe-000346-T1
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:43:41 -0400
Date: Thu, 27 Jul 2017 20:53:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170727105348.GG7970@umbus.fritz.box>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<CAFEAcA_t8EDNnWTeRzuHEcdfq3DJFTN3ug=DHnGvWef3=wyFzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eVzOFob/8UvintSX"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_t8EDNnWTeRzuHEcdfq3DJFTN3ug=DHnGvWef3=wyFzA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>


--eVzOFob/8UvintSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 10:11:48AM +0100, Peter Maydell wrote:
> On 27 July 2017 at 02:30, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
> > quiesced by vfio-pci's finalize() routine until up to 6s after the
> > DEVICE_DELETED was emitted, leading to detach-device on the libvirt sid=
e pretty
> > much always crashing the host.
>=20
> My initial naive thought is that if the host kernel can crash then
> this is a host kernel bug... shouldn't the host kernel refuse
> the subsequent libvirt rebind if it would cause a crash ?

I think so too, but I haven't been able to convince Alex.  Nor
find time to fix it in the kernel myself.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eVzOFob/8UvintSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll5xjoACgkQbDjKyiDZ
s5I7AxAAkE9dAgjb7/sE9FD4yeqJoAs+RQbt5in3F6HqWlP6TlIKiB3L3WWRxZi9
v4R3gRMRoL5WAHKqmpNqdRprdzUltKttAvJ25UDYkJJ63aYGawDkFbRtSbo/zSKT
DaSBoL8R5GeVwdhUePWT1v7/UiJXbqqjF3nrTy0E/aNTMp33X31PtCHGWayM+YQj
OobHL3zXCgCVpYrccFIJF0dH/UHy1Nv4E84eH6CQmunioyUBrLECDq+QBZBhTr3Z
JZ/FAVdw3IY91r1tA55W8IyIsbz7lxfVcUdn1thhv+mU35LUUNMY5YruW9asJ46Z
TpldsBPW8AXZ7LEmXo4xqPNJWSsluODv+5R258bWS8LoFKj6nUirHuP4Ubrh0Lmv
9XulykAv+SbUFuS2caGSFoLqgGHnc+ZoTh7Xlows40DBmx/XtFhePoBVBcPAL6G3
IeVEsSmAJQubnNRY4oDXm9Lac5wXE8kATYCTXKYLg/dyOcUSOr4OlKg9jFbMjMzV
j1Q25iJc2q0DHBbYy7VBA69R4qrorRnTuVfb6Fi36rOMbEwuO1gosmzAK2rMrYZ6
vFORJuEmycGwbwwNXOrkz6JfPWHtCtfPD7j1Ge8xjcCnlJKi9Khichqj9+mtx7E3
DxjXsgBHI0dIeFszqjV/WJ8gskqbG0Ky2G3+uhq3Qy36k1A5G1Y=
=FlMg
-----END PGP SIGNATURE-----

--eVzOFob/8UvintSX--

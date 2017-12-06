Received: from eggs.gnu.org ([2001:4830:134:3::10]:59998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMXcU-0005HV-7t
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMXcS-0001zU-UX
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 06:12:06 -0500
Date: Wed, 6 Dec 2017 22:11:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206111157.GE3057@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<15378780eee5dc9ebc68361463a0fd6acea55556.1511731946.git.mdavidsaver@gmail.com>
	<20171205065304.GK3057@umbus.fritz.box>
	<9f529ae2-9f89-b542-5933-9f57c451aae0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SqEuGDw53xMPnx3c"
Content-Disposition: inline
In-Reply-To: <9f529ae2-9f89-b542-5933-9f57c451aae0@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 13/17] e500: move PCI host bridge into CCSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--SqEuGDw53xMPnx3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 10:42:25PM -0500, Michael Davidsaver wrote:
> On 12/05/2017 01:53 AM, David Gibson wrote:
> > On Sun, Nov 26, 2017 at 03:59:11PM -0600, Michael Davidsaver wrote:
> >> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> >=20
> > Hmm.  Is there anything you're *not* planning to move under the CCSR.
>=20
> Well, the decrementer/timebase initialization for one as this has
> nothing to do with the CCSR registers.

Right, but no actual devices, even small ones?

> I haven't added the TSEC/eTSEC instances either.
> Partly this is because the existing boards, for reasons I don't understan=
d,
> use virtio NICs.
>=20
> Further, the mpc8540 has TSEC instances 1 and 2, while the mpc8544
> has instances 1 and 3.  So I decided to leave NIC setup to the Machine
> rather then add the extra code to parameterize this under the CCSR device.
>=20
> > If not, I'm really wondering if the CCSR ought to be a device in its
> > own right, rather than just a container memory region used within the
> > machine.
>=20
> I don't think I follow what you mean by "device" in this context?
> The CCSR object is a SysBusDevice in the qom tree ("/machine/e500-ccsr").
> What device-like characteristics could it have?

Sorry, I wasn't clear.  the CCSR definitely *is* a device in the
current scheme, but I'm wondering if that was a good idea.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SqEuGDw53xMPnx3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlon0HsACgkQbDjKyiDZ
s5I32A//YteUyQUc9RMUtACP61J4x4/PlLHboNF7esPK5wfSJP4g5LgmHjv99nId
R4ULstUnT4YaLBQGR2IFdZT+QjwXWDZcJaFPju1rjZRNeU/NnglxghQQSuTmvk7g
Y23C98Ii0pY8bVu65AqjcZrE9DzqMGBZ5fEjDMI26+vEBkqTWKi7F81Ki8Uz2h6Y
OfTroV76F2kmRtRO2EFGnfYQGc9QVXQ74lRQzNLjzny/h0aDLcvTt4y1tbL7nXlA
5OQs6bVOPGyG9g/pasHH7srSj40JyJLQ76B3nlsiKE92CrI05LS0tB6u4f4F0fNz
ogj3qkUWb601zabMtseMCA0TJf0YJis43U52+iNdfMdZCPVEuxAhCJ7UhjJQrsbT
97flzC5GBfAUkkIXg4sEfTD/HF5ygvNfc8bIwlBAp0si60o6SRuUstWS/Vs9pxhe
xstPtASYOiKRUp77dO3KCu6BpMLvKo9l6yFwGN0ixlgDBXyBDgGV9J9Jkbbq1O5i
IXnWvVAtZTHJMhDhSaEVa+o8vE/vtqfwrX83j/fy0o0vi8TOw2M5ZZNx/LcrUYu9
+/PCDSylS7027ABuGn2FLiIpHuoa5DHNOlHGwJCxQR1s+cHwyhHkfrzun9oxNJ+R
fQu+bO6RC/9ei5I1nw7k+dsT12jORtViuURuNcUe3OPNe6R+xe4=
=q48J
-----END PGP SIGNATURE-----

--SqEuGDw53xMPnx3c--

Received: from eggs.gnu.org ([209.51.188.92]:50022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hB5uT-0001kp-TU
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hB5uS-00061Z-BS
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 19:00:09 -0400
Date: Tue, 2 Apr 2019 09:52:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190401225214.GA9231@umbus.fritz.box>
References: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <155414129703.574858.5054152366329409898.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] spapr: Fix extended config
 space accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 07:54:57PM +0200, Greg Kurz wrote:
> Recent commit c2077e2ca0da7 added stricter checks that now prevent
> a guest to access the extended config space of a PCIe device connected
> attached to a PHB on a pseries machine.
>=20
> PAPR compatible PHBs act like legacy PCI busses, but they do allow access
> to the full 4k config space of PCIe devices. As discussed several times on
> the list ([1] and [2]), we cannot really change PAPR PHB to have a true
> PCIe root bus since it would call for massive and unwanted changes in
> libvirt.
>=20
> This series tries to address the issue with a new PCI bus class method
> that tells if the PCI bus supports extended config space accesses,
> instead of relying on pci_bus_is_express() which wants a PCIe root bus.
> A new legacy PCI bus type is added to implement the PAPR behaviour.
>=20
> Note that this fixes a potential 4.0 regression, hence the for-4.0 tag.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07377.html
>     https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02839.html
>=20
> [2] https://lists.gnu.org/archive/html/qemu-ppc/2017-01/msg00034.html

So, I actually had some patches I'd been working on that address both
the c2077e2ca0da7 issue and the PAPR fixup in what I think is a
cleaner manner.  Can't remember now if I posted and they got lost, or
I didn't get around to posting.

Nonetheless, at this point we're fixing a real regression on PAPR.
I'll look at cleaning this up post 4.0.

Reviewed-by: David Gibson <david@gibson.dropbe

I can take this through my tree if people are ok with that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyilhkACgkQbDjKyiDZ
s5L4lBAAiqN8oWHdZRVu76Ses4cb/nzDnB7OPN7aPng0p/Bz93yUiL9stNA1LUGF
LSyuVJcvc24N7/IjN8Xl+TL1iA+bdVo+2HkA+LpS1hvEFyeNye8Ti9LLXJ6iuBGC
OAfF1CfPAl0Gka1mvJKFfx0Kf5VcKlXwHJ+1B4UU6Jnd/n6VxlsGjSMyVU0oo/RU
uGS3iJsXYu4jd88qRA5Ea3Ae/mi744PGwWNk7veOfJch60l6VzgzBtv39w/wm5lg
DuA0XZ7pzYKKAsvZ3GYxzrEjNqqfzNRwgzvPiJ2jikr7CIwq57ywAA0YZwaKQ56m
ZXHoGp65WfQLAdVvT398MOPUVRMeDCLn3cGbgZM9eNgYA2hbEvHxwC6YmepUFKEl
lrMq3+TVqlu65tcWR+mFXK+8toF2tKHJFqRTyyt1Ja7JAq6EZ/TEA2ZjKnCOxRrP
O0/y5UkN7//m7H48ZTcoo30f+VsGO9AeaQMln3mz9lSMh/8uKFxOiK+etbozyIpv
fnBY9a02N4ztxaS9ojB4H2U7KJ0lcW9ACQ/E2lVoqqEPMr28GUTGcBurmz9/00vi
OJzevRUYsZNf2Q+U3tV4+4RfzAq/tirMs8C2f5M680usCPL3aL6+xrljErqqoHjT
OL/g2LoIjdqsSbkQ8fuzx8yamfBZ1R4PwmdGnr5MFT0ZiQftdCY=
=GiHv
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

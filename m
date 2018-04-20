Received: from eggs.gnu.org ([2001:4830:134:3::10]:58244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9Vqb-0003xB-9K
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f9VqX-0000w6-Vw
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:13:05 -0400
Date: Fri, 20 Apr 2018 22:57:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180420125700.GU2434@umbus.fritz.box>
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-4-david@gibson.dropbear.id.au>
	<20180420133414.434f8bab@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Pq8tEKHpn00JYbZk"
Content-Disposition: inline
In-Reply-To: <20180420133414.434f8bab@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.13 03/10] target/ppc: Remove
 unnecessary initialization of LPCR_UPRT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: benh@kernel.crashing.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Pq8tEKHpn00JYbZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 01:34:14PM +0200, Greg Kurz wrote:
> On Tue, 17 Apr 2018 17:17:15 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > In cpu_ppc_set_papr() the UPRT and GTSE bits of the LPCR are initialized
> > based on on ppc64_radix_guest().  Which seems reasonable, except that
> > ppc64_radix_guest() is based on spapr->patb_entry which is only set up
> > in spapr_machine_reset, called much later than cpu_ppc_set_papr().
> >=20
> > So the initialization here is pointless.  The base cpu initialization
> > already sets a value that's good enough until the guest uses an hcall to
> > configure it's preferred MMU mode.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Merged to ppc-for-2.13.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Pq8tEKHpn00JYbZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZ45oACgkQbDjKyiDZ
s5KCzQ//ZfYPmY3CP9qB7hn13DFy0m0wkNURzeTuzsf3L9KfG1dKd6y10Tu2ZSC1
QjXikh76AbJoiXyyP2Hlg1Hb36qGhSWYAgwxKJQ9pyMgavQwfqF7xw3B04nSQ9CU
nkpz3c3086YpvRr8IDsHpt3sLLxeW8qaNkvVoJm2ta+kKhldQFfjmQscNUJL+n2D
OEp3jojBpV8loMp4rWcnqJZVD2bJhLJiNwT11LOiLMqVjvUPbvflEZQBjNGJktHJ
DEAFwh49i+BLF7iSsL/eewq1Y3sEhnUNDgZ4Nsk7/LeykBZh3ucfH+IN8ls1izqZ
/n/iJOLJ3mmPRXrwmwyCRoufxfQELmUse0etQKwk9rREPoHN12uPrcBnOBEs9VDL
QGOdakFPE/RCTYZr2V+lgxwqiqjqxqZkbJ9VYNVz2rqpXlWqdHG4iH61rEwaCmw5
BWyjkmSzqEXnEUBmXFjqsdxf/pMPbOYW9IM1E+RLuCNDFBvxZeO7PmvhXaFdVWpY
aYhzkHmqypivgox8hkcfTIYpg+/wDKxGp5m2d1IjJ89Y7qJWhZKUasbMFMkfXbed
3qRBHeni3gRFjI2abRju0p0+KZRuLQ+mh6i62OgBXXdHfv6PGP4v292v5PFSk/KO
c0ic1RHHZa5PVyKOEJYBixQaT6S/NjiN/XYk2Otd1Fr+UL+PUcY=
=mJA4
-----END PGP SIGNATURE-----

--Pq8tEKHpn00JYbZk--

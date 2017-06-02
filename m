Received: from eggs.gnu.org ([2001:4830:134:3::10]:37311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgcp-0008EY-7S
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgcm-0000rt-4R
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:03:59 -0400
Date: Fri, 2 Jun 2017 13:49:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602034914.GN13397@umbus.fritz.box>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GEn4szYucjS2InE7"
Content-Disposition: inline
In-Reply-To: <20170601015218.9299-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH 0/4] spapr:DRC cleanups (part I)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: lvivier@redhat.com, nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com


--GEn4szYucjS2InE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 11:52:14AM +1000, David Gibson wrote:
> The code managing DRCs[0] has quite a few things that are more
> complicated than they need to be.  In particular the object
> representing a DRC has a bunch of method pointers, despite the fact
> that there are currently no subclasses, and even if there were the
> method implementations would be unlikely to differ.
>=20
> This appears to be a misguided attempt to "abstract" or hide things in
> a way which is bureaucraticl, rather than meaningful.  We may have an
> object model, but we don't have to adopt Java's kingdom-of-nouns
> nonsense[1].
>=20
> This series makes a start on simplifying things.  There's still plenty
> more, but you have to start somewhere.
>=20
> [0] "Dynamic Reconfiguration Connectors" a firmware abstraction used
>     in hotplug operations
> [1]
>     https://steve-yegge.blogspot.com.au/2006/03/execution-in-kingdom-of-n=
ouns.html

I've had enough acks that I've merged this series (with minor
corrections) into ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GEn4szYucjS2InE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMOA1AAoJEGw4ysog2bOSaL4QAOGYGTR0GnJanG227155vktR
+9uc8EoxCpDnRyrxY9utPY31F5ooKWXMrrTavsdXRahD671s2uDjtJ/L3xUGSbqX
FjBLveww6BrR4UhMeYhNOPqTW1k6WoaM3GAJNukYVznMIcU65eM8c+lKzG9DsITR
sw3skk8SotV6IPSFAh8l2fJYI6UypcH2yu9o7w+2CiNQRUwEPIr7Cf222fZoLOf9
sXFTVfnvqmk9NUtM5iCVd4jnwsGDQDD11JxurHg3G7ZCirmtowwsOwvOMeJTYQLc
lsVlCWaOGpbUmIjzMoRV4bdf+u0QTZraZMW0HRMURQp8+gMfz0jQok+BNj4TICyY
ejjSZcazPjfAt5sYBntZZZVDTuBn15I4t0xZGlXYrKBWqSTrV95dai7kgTiPruK4
zWZe6xuNCr07PiN+hE+r36BzRkWmfNEFDKJ2FzR0QzXvM7rv4F5/vwpK+UhXFo41
1TlmyR+LdBAA+77X/kj0qDGN3tnNjIzvpWo+C/ODhhfAuwKQgHAqqRz9WQ+x2rMr
0fJjr89lki1hLzigP0zCNA0Y2uLzvNh1dgPzlZz6R7yeLBPXiblQ8rw8rY2H2BCo
tVKnIAQXO7xKfm8FcTQ5OyzIxiS/vPVWRCdMzHAJrDwW1VbPpsQ7MCSyBeenM79r
tx+QcIlno69drvlMLCiW
=D9V3
-----END PGP SIGNATURE-----

--GEn4szYucjS2InE7--

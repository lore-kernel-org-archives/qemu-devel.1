Received: from eggs.gnu.org ([2001:4830:134:3::10]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1didLw-0004fm-0S
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1didLu-000723-UL
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:14:03 -0400
Date: Fri, 18 Aug 2017 16:10:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170818061028.GU5509@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<5e493fd14e60d92d4fd80492ceff5ba13eb7b558.1502643878.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WQ40utMgiyDduspJ"
Content-Disposition: inline
In-Reply-To: <5e493fd14e60d92d4fd80492ceff5ba13eb7b558.1502643878.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [RFC PATCH 12/12] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>


--WQ40utMgiyDduspJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> Add emulation of aCube Sam460ex board based on AMCC 460EX embedded SoC.
> This is not a full implementation yet with a lot of components still
> missing but enough to start a Linux kernel and the U-Boot firmware.
>=20
> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

There are a *lot* of devices defined here.  Most of them look like
they belong to the SoC, not the board (since they use DCRs), so it
doesn't really make sense to define them in a board file.  It would
also make it easier to review if they were split up into separate
patches.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WQ40utMgiyDduspJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmWhNIACgkQbDjKyiDZ
s5LWIhAArL9huhKrovWIHVD6RoUX5ec/wp8ma9Z5ZbsmXO9UA1G4vu8U6rZqJB9/
7bWlfcqrfWllgs8ebPivupnEURu/eh64X8Lien/5L6+K+C/xEUTKXMM7AMDXVwn2
GyqMjLzqbvwlOFHfrr9Moj588OObZsRhqD+ebAvV4+BpaLJrb2+gKOu5ypX+pwco
7xq5hp98koMcxmGCT3BemhRLpX7d5glq/Kyi0py0ShjlV0QSQ3pMmd19J4xc5HDK
GyqxxtpXH7goxsxTKSDkX4tyrrz9sxEZfk/KXcKq9A3oFojfVyn2fi2QdOkvTGsa
I1FsUIZnxgB32J8+xBhq2wKjPD2NaFckPkL9agy7vc600gvKiCUo6Q/O9Os0vEdm
2/if2HtKsdm4yzgTBWsUXH+jZYQXqNi+l99m+iwDLXZt3jyz2qXNewKqieSuwhBl
fNt8Wsj66rAPP7iTTPnP9tJQx9s2k5uSd/BylUivR64Ik3FWz2pA5jiGMDm574vq
5lK3UCmMDxqhV6k5lFd7ftGgm1fQniLJ7wTIJZSDmC+n8nTTG34zFfB1B/YOE0dW
qQOfcqb8wEkLjf9YUSLwkivTqAjgMj36DE2Ozj/HyNQQYCtjMIV9sl0ul0YOzigy
uYgU43dgt6xmfov4q/kqH4yEqDP1nvhAXn/jM4Kj8n7utgNObns=
=8Xaa
-----END PGP SIGNATURE-----

--WQ40utMgiyDduspJ--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eaune-0007qA-HB
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 21:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eaund-0003qF-Ea
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 21:47:02 -0500
Date: Mon, 15 Jan 2018 13:46:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180115024648.GB2027@umbus.fritz.box>
References: <20180112053345.13075-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <20180112053345.13075-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 0/3] target/ppc: Rework
 spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 04:33:42PM +1100, Suraj Jitindar Singh wrote:
> The following patch series reworks the implementation of spapr_caps
> to allow for a increased number of possible values in the internal
> representation.
>=20
> It also adds 3 new tristate capabilities.
>=20
> A new H-Call is implemented which a guest will use to query the=20
> requirement for and availability of workarounds for certain cpu=20
> behaviours.
>=20
> Applies on top of David's series - spapr: Add optional capabilities
> Based on ppc-for-2.12
>=20
> The patches could be split up more, but in the interest of getting
> them out there they are as they are.

I've applied 1/3.  2/3 will need rework since the necessary kvm
changes were nacked, 3/3 isn't much use without it, so I'll wait on a
respin of those.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpcFhUACgkQbDjKyiDZ
s5KCRg//e0Sfa89hvpGywlx0jFqwl8/zECqhB4tTag+2H//GHtk25as+OOq/HRPT
0CJBU+axDIxge7N337EJ50uxQYq6UYGQj1CcE9+QPM3eV/uOP06AUg78fdydZIIA
CVx+KKnyembG5yXRbTBTHGp3FfY59vXR0U9lFx2AjcS9D0A3KcFwPPuG/3l65nGU
4nX0Vg4R2lErTq4REwf7dU7r6WWcjIpUrVD4mECHZAHZRatNy3rf28FhOD7g9zlB
w+6v0deaZLzvJ8h8iqTJ3K22oWYCXiWVoam00W9Cecj7hjsP06RdXj5Ikavq6LBg
oYvuWuY63qT9Pe0M0X7c89/P+fHtCURt90FDDyfYBfx1sSByV4F8ZNkitFLVMiN3
Hylh5pnsPi6BmhUOxsdpR8pLt3z7ErRfl7hFMW8txsKU8KOG2Bi0jd9U6hRkes+J
Zw863DZQ98nn1IPEaQktHNwRnSnqyQXS7Lox7Ni8QjBlq55rYjJRD5Qv1ZNc7TFL
39eWMnd8xDlNsB/3khMJmnIRkxFS9Z5dhpSbx78TRNM6LHkJ1+i1EnsKy43f6nPn
+yYgEVR2gQjmCeMwbrhdlrU5qZSFdwfgKy1qsrS5lHq9Tyj+zujkmnZwVuv6NC6l
B4bjrLswXX0QpV9sf+cpVy1vCvGLiEGMp1vmUZ/s1BWGYoCv/eM=
=LlEU
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

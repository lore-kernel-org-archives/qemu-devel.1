Received: from eggs.gnu.org ([2001:4830:134:3::10]:50599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eqqCL-0002Og-I4
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 20:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eqqCI-000169-Du
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 20:06:21 -0500
Date: Wed, 28 Feb 2018 11:42:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180228004247.GA11706@umbus.fritz.box>
References: <151974496089.17040.8929640429507724311.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <151974496089.17040.8929640429507724311.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 0/2] spapr: fix migration of old guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Lukas Doktor <ldoktor@redhat.com>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 04:22:40PM +0100, Greg Kurz wrote:
> Recent VSMT work broke migration of old guests as reported in this BZ:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1549087
>=20
> Patch 1 fixes the issue, while patch 2 is a tentative code reorg to
> ensure VSMT is set before anyone tries to use spapr->vsmt.

Nice job tracking this down.  Applied to ppc-for-2.12.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqV+wQACgkQbDjKyiDZ
s5IY7g/8C0v4zwYk7kLxTostQF5hxlFPCHYxgtB70UANCZLhIJQnvO8iiR1lZJ5+
8AcK1bOm97M9+t7lVByjBxCz9nTxsAOtK2TK1TrX+G1xTNZVbMST2ZkCaMvE/EEi
SWvTogrfSLwWmogv8ofUQb6Eoi+Nhk3qJ7b49qqQSXUoRwDLgTLTSym0MEy6ZEP4
XiJ6NZNfpO6gP5L/+qjuETgAJwiV/2+3qMOM3nARaPXCmup2pyIkZ8+2kqc3dkQ5
pH16AGl8sg1F5AXSw/roiRfh4If08v/2eK7z8U/nDKbT96ozYsN/zv1tdYxVQfzY
bxxftw/M5X7sOZ4AtXgFEdRN5lRcDghxluAWJ7Q9p8yT+3nBS5Y3zReIwl4Twabo
ZGEb52n9e5TBnx5ELKjdbH3o8rDumjHo1VvBUK7JELeGZ1VC+7K4+Yv4q4omHV/0
KQMZFto58WyvvNxoeC5WuvLROB05VMQezK9VklHCkouaUYalW7GCIRex3FvlfyzF
e8ZfOHgq6048IOXrD/He7fJhZH/y2WGpG2vYDt0rW2YxE8Mz26qMtKXCxiOdG3Rg
VwcMML+HA61Bj7dBrm8mbi1e7s5rz5Z2/mDPQdtKUzO4UaMCuFH9pN3mWgo7tn6W
FMELxuJ/TsnMJQDKCp2EPCRCcFq247Zor/ofgtyAcgiLkasS9ZM=
=S8/Z
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSK70-0003fi-Gz
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSK6z-0003KR-Fr
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 05:27:14 -0400
Date: Tue, 4 Jul 2017 19:22:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170704092204.GB2180@umbus.fritz.box>
References: <20170703131455.25424-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20170703131455.25424-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 0/2] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>, Greg Kurz <groug@kaod.org>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 03:14:53PM +0200, Laurent Vivier wrote:
> This patch series allows to use "-cpu POWER9" with a POWER9
> DD1 host and KVM HV. With TCG, "-cpu POWER9" selects
> POWER9_v2.0 (POWER9 DD2).

Since these fix a real bug, I've applied them to ppc-for-2.10.  There
are some revisions which might be good as a follow up.

>=20
> v3:
>   add the patch to move POWER9 DD1 workaround to
>   the generic part (not only for "-cpu host").
>=20
> v2:
>   add POWER9_v2.0
>   sent as RFC as "-cpu POWER9" breaks the kernel
>=20
> Laurent Vivier (2):
>   target/ppc/cpu-models: set POWER9_v1.0 as POWER9 DD1
>   target/ppc: move POWER9 DD1 workaround to ppc_cpu_initfn
>=20
>  hw/ppc/spapr_cpu_core.c     |  5 ++++-
>  target/ppc/cpu-models.c     |  6 ++++--
>  target/ppc/cpu-models.h     |  1 +
>  target/ppc/kvm.c            | 11 -----------
>  target/ppc/translate_init.c | 10 ++++++++++
>  5 files changed, 19 insertions(+), 14 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZW145AAoJEGw4ysog2bOSAcUQAOCOiYt+lWDwnavB41/R9tU4
vnZa/0AC5of7sKK6ymJiqQjAQgJHWo4BqIHiVU9Mr5mVkvNVga7EG9Xh6SDPhr5x
EvK0WQI/AMd6vCM8G9ToH63hRKdqmgpdw6ILVwoPd948Nd8rvzP/KoR1DwfIJkkW
o1PaFgGfuVOjytvZLQ+lJCf/R/8HRVlVnDESwNiyB1xlBSFzBi5eSVzHzSswERld
GH5LclNCb9YVzbyINHJq0kAArfmHA+2rRnE+IDaOuQYwYqcp9LKBrWPO40i46b7k
hxj+caOjOkLAfY9tMbyeIuKo94R0Nyqmc5IH+R885vPU8Ww0F7RTOWgl+bWnEUut
ymfvE8l0WmRvO9Y/MlrSSWx8bAguH3wHDPt1tzKxskj3UwzIgMNAXlu0Fvzkqmgu
VHHDVcZo7dDPtDL7oldfdXASLRCbDirIj4MvNXjOrYyfi/eYo0WIDGjoWxx/J0I5
TdmJQBcWBnk1MoJF0aSJy6UK+EwrsUtGUDl+y6n0O9tC5Us5udxxs6f3KOzG1+Ch
m+I0kBBlWq8OTNQYxUTqvxVYUk5idcyM/MIOzYS+nzdV9zOw5sMXMLhlAYqEWlSn
TieUcVz3kv0CRW8xcWAWT0ytGmFD8JiIVOUFQC+WupRPWAfi4vZSMbpHg2bjwFP6
c8ElsaMauCXD/MBrYZex
=oVJ9
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

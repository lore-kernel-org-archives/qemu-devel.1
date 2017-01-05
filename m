Received: from eggs.gnu.org ([2001:4830:134:3::10]:34482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVo-0008A3-Md
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVl-0000gD-Gm
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:56 -0500
Date: Fri, 6 Jan 2017 09:21:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170105222122.GG13763@umbus.fritz.box>
References: <1483630188-32021-1-git-send-email-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Content-Disposition: inline
In-Reply-To: <1483630188-32021-1-git-send-email-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] qtest: enable several tests for
 ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 04:29:43PM +0100, Laurent Vivier wrote:
> This series enables some tests existing for i386 and which
> can also work on ppc64.
>=20
> VGA tests and netfilter tests are trivial, but ivshmem test
> needs to enable the SPAPR PCI framework. We also fix a bug
> in qpci_map() for SPAPR, where the PCI base is not correctly
> set in the CPU address space.

Applied to ppc-for-2.9 (replacing the earlier version that was in
there).

>=20
> v2:
> - extract ivshmem conversion to libqos and
>   update log message
>=20
> Laurent Vivier (5):
>   qtest: add netfilter tests for ppc64
>   qtest: add display-vga-test to ppc64
>   libqos: fix spapr qpci_map()
>   qtest: convert ivshmem-test to use libqos
>   qtest: add ivshmem-test for ppc64
>=20
>  tests/Makefile.include   |  7 ++++++-
>  tests/display-vga-test.c |  7 ++++++-
>  tests/ivshmem-test.c     | 46 +++++++++++++++++++++++++++++-------------=
----
>  tests/libqos/pci-spapr.c |  4 ++--
>  4 files changed, 43 insertions(+), 21 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbsbgAAoJEGw4ysog2bOSK8UQAI3cUh0GZog5d6uk+QTnTbe9
ai4pPNf298+8EimKXK67URTF66jm2gyoJHfsA6C8Hn5URwSiUkfGJObhhxr0p9Io
bO6P1DC6cAPAoV9WWymRVQXQ70Q8DeokEkWb2spZS7gcYn88yJWO9Uk2vL/+ogP/
s4GH+vAbExNkujBG/RUD9l+xvAlOueIUHQaNov1+sIIvxgzCfOkjqdHuR60Zw9+O
Z/8uFPR0qaJb1fdVJv+t+TZLY8/KaHpxIn0rsUi7aFF4HWSlYTXys0kjmch6H9eM
bTfQ/a7o4/jSZ58uxCxmP0lM5e9NP1+1EGGTZItB6v5T117bsgK9cLqlweC81GTi
nDhOrVjL6H7iJCgmCkZ5b2YwDXEp3+hpdNPEewO4gEvb9AIkib1kHW7c18lNBXow
aLVTW6dzzB4mpcZfKuPgS4pZupkAIh7khe0+tiCCzv3UcTHgETrR35XesOKskTyT
uIxactqvHG/sipLLe2geWxzXXrPEiMSfAo6y/FlozKcT/b2J6CjMpXYVYrc+ZVqs
G+fP5IFY5q8YO2OQ0PbAHqSJOrdLxe4+4NXqYyKSHRyW7sEVU0NVqakcbWiBtk+t
WlSeFbqqQAQAWI2ZoX2rv3lkN1VPKeIHYcSIYDK+wVgCMa2YWyVplWbj53DjpFoE
ed2pbxPc4RgOjCRRQX4q
=YQkV
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dieap-0002x3-4e
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dieao-0006U3-2O
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:33:31 -0400
Date: Fri, 18 Aug 2017 20:33:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170818103318.GB3658@umbus.fritz.box>
References: <150305073858.13788.4068645609072927349.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <150305073858.13788.4068645609072927349.stgit@aravinda>
Subject: Re: [Qemu-devel] [PATCH v4 0/5] target-ppc/spapr: Add FWNMI support
 in QEMU for PowerKVM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 03:36:44PM +0530, Aravinda Prasad wrote:
> This series of patches adds support for FWNMI in PowerKVM guests.
>=20
> Memory error such as bit flips that cannot be corrected
> by hardware is passed on to the kernel for handling
> by raising machine check exception (an NMI). Upon such
> machine check exception, if the address in error belongs
> to guest then KVM causes a guest exit with KVM_EXIT_NMI
> exit reason.
>=20
> This patch series adds functionality to pass on such
> machine check exception to the guest kernel by suitably
> handling KVM_EXIT_NMI exit and building the error log.
>=20
> The KVM changes are now part of the upstream kernel
> (commit e20bbd3d). This series containe QEMU changes.
>=20
> Change Log v4:
>     - Included the RTAS_DISP_FULLY_RECOVERED scenario in
>       patch 4/5.

You don't seem to have addressed any of the other comments from the
last round, however.

>=20
> Change Log v3:
>     - Rebased to v2.10.0-rc0 (git://github.com/dgibson/qemu)
>=20
> Change Log v2:
>     - Added KVM capability
>     - Serialized multiple NMIs with a conditional wait
>=20
> ---
>=20
> Aravinda Prasad (5):
>       ppc: spapr: Register and handle HCALL to receive updated RTAS region
>       ppc: spapr: Handle "ibm,nmi-register" and "ibm,nmi-interlock" RTAS =
calls
>       Wrapper function to wait on condition for the main loop mutex
>       target/ppc: Handle NMI guest exit
>       ppc: spapr: Enable FWNMI capability
>=20
>=20
>  cpus.c                   |    5 ++
>  hw/ppc/spapr.c           |   12 ++++++
>  hw/ppc/spapr_hcall.c     |    8 ++++
>  hw/ppc/spapr_rtas.c      |   52 ++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h   |   14 ++++++-
>  include/qemu/main-loop.h |    8 ++++
>  target/ppc/kvm.c         |   93 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/kvm_ppc.h     |   82 +++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 272 insertions(+), 2 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmWwmsACgkQbDjKyiDZ
s5Lg2g//Qdg+MAtrZxbrfMNmg3h1v03AzsMXIRO9asdvOpu0DvnCY81G28/z30nl
dFMX+CXOuYs1hTaKbjj1mgnT2GqElBkZUnGAoyV3Rv6botgtzHL7/Jm4MlnGO6Xd
6Ee2V9H1irXPKdP4cdJ6o+WadhSBY6M+OTkwIgjTOBw1t0btx2/sYW7TL/n8x0dT
hDHdjNI8KLSly0FHYhyJPwTeMVhGvCj5l6s2FBeUu/bFXlyY5bo8w7nc50oL6v2b
KeX+9hVm/QLRmY9Tf6nOjEy+tMXgn2Vbvzq+p1hxv0vJX0SgzSDoTVax4GZ+4MsU
HbzQCbr5HqLvCCMlMnajMq5qQuntaaGMpY+Q1MPWjOfaqOzPGz+xdBWdopZPjum3
4ynMNeF8QstAr6Mp2GTf1hfqX9Ib94S6AXg/5wB+pqUDR2LCkO3dsIsHzdhZ2BtE
3f01rUcPKpoqWS+E15vhP4ykQWXIezKR0td4WUBoLskIZ0P4J8G9X0oVLo54xys0
EhNWi35FNUpkGQpmGBTm+cEAA6uvGBys8RHst6OwcCgWRKyWSsZEmu535UGAfd1X
KxSvFmvGWZjwUIkzcxOiN4fAvJi3gSYPRtLLKdEKRPhhf03vUp87NsPGNllh/+FY
bOOwOspbf5Hcwbxw7h9w06Rr72VgRyqAmR+Ea4h7d+uxvzSFPOk=
=W722
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

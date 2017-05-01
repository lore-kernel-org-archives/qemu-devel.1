Received: from eggs.gnu.org ([2001:4830:134:3::10]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d558a-00026d-Ih
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d558Z-0004qn-PN
	for qemu-devel@nongnu.org; Mon, 01 May 2017 02:48:48 -0400
Date: Mon, 1 May 2017 16:08:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501060802.GN13773@umbus.fritz.box>
References: <20170427051824.30194-1-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ie5iOtK4e9kgqh2F"
Content-Disposition: inline
In-Reply-To: <20170427051824.30194-1-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] The series enables Multi-Threaded
 TCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net, alex.bennee@linaro.org, bharata@linux.vnet.ibm.com


--Ie5iOtK4e9kgqh2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 10:48:18AM +0530, Nikunj A Dadhania wrote:
> Patch 01: Use atomic_cmpxchg in store conditional
>       02: Handle first write to page during atomic operation
>       03: Generate memory barriers for sync/isync and load/store conditio=
nal
>       04: Fix CPU unplug in MTTCG
>       05: Enable MTTCG by default on PPC64
>       06: Fixes a bug in PPC where the reservation is reset=20
>           causing atomic operations to never succeed=20
>=20
> Patches are based on ppc-for-2.10

Applied to ppc-for-2.10, thanks.

>=20
> Changelog:
> v2:=20
> * David found problem related to clang and "make check" that was=20
>   root caused to a tcg bug and the patch is in mainline:
>=20
>   79b1af9 tcg: Initialize return value after exit_atomic
>=20
> * Fixed a bug in ppc_cpu_exec_enter(), which was resetting the=20
>   reserve_addr, this should be done in powerpc_excp()
>=20
> v1:
> * Rewrote store_conditional as suggested by Richard
>=20
> Bharata B Rao (1):
>   cpus: Fix CPU unplug for MTTCG
>=20
> Nikunj A Dadhania (5):
>   target/ppc: Emulate LL/SC using cmpxchg helpers
>   cputlb: handle first atomic write to the page
>   target/ppc: Generate fence operations
>   tcg: enable MTTCG by default for PPC64 on x86
>   target/ppc: do not reset reserve_addr in exec_enter
>=20
>  configure                   |  2 ++
>  cpus.c                      |  6 ++++++
>  cputlb.c                    |  8 +++++++-
>  target/ppc/cpu.h            |  2 ++
>  target/ppc/excp_helper.c    |  3 +++
>  target/ppc/translate.c      | 37 +++++++++++++++++++++++++++++++------
>  target/ppc/translate_init.c |  9 ---------
>  7 files changed, 51 insertions(+), 16 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ie5iOtK4e9kgqh2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBtDAAAoJEGw4ysog2bOSRcEQAOJfVOLBBE1bGvINt1hv8Rd6
ewihFcbv+plSe4KwjC4KWW9OpJJzS5BUDkfcsSS+iCgJ7Cv9s4xFNGjYXePfmVLR
915P/mjU0Z5ev3OoFysYCKu90f8lYVffcT7AisDxLeXyIDCqcTyn+zzjH1RXQ/Kk
/tbHTZlS6lrsKzxV/ehrWhj3J1iz86riPcg+I2bbdBXDcyEnOsyUzm6CD+ff7AIK
B8XJyi39lAGE6lnEQlxf9w3mPEaMroZCE1YNRsd3l63RsbB6Q2j3e1S0YrSPFOG2
OhGAJjVDZtm1VDHvwHmE6nKS2f13p3jhz3Jqtiyhm5SKHAhHmCyn+ycgBRrJb5ej
8IlgfJJiaQ8BVIQFqRg3AgAQXh3D6/fTMkMsbnnt3vZM8RYn5U1UcHEpMXOt/fdK
ac7OF29y6FYrNVbN54wsOEmSy8NrdJV31vV5WKAzgmfT7DlivYuzb35sySpy63zJ
uE6GZn/6KDqbxAZJdTwdQlX2OVTqoNmbnPg99WK3aEIy+9GOdWc0BjsqEEWljFlV
/KuMwKNvL7WaRQ5VlKEAuwKRaod3C4C0jE+ft1h0jvLqokWEcRT+Cy1vcFUl6dJm
S3C8uKodzzlzNrTV2NUGuKEzpM6cgZZ0oXe4R7K1p7NIMs2MPBWZVg4Ql5Sewk4o
CkJMIXO6chMU11LzW24A
=Zco8
-----END PGP SIGNATURE-----

--Ie5iOtK4e9kgqh2F--

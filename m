Received: from eggs.gnu.org ([209.51.188.92]:59731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvtiV-0003Ir-RW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvtiU-0003qK-TV
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:56:59 -0500
Date: Tue, 19 Feb 2019 11:44:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219004456.GE9345@umbus.fritz.box>
References: <20190215161648.9600-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
In-Reply-To: <20190215161648.9600-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 00/10] ppc: Add Hypervisor Virtualization
 Interrupt on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 05:16:38PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> Here is a series of fixes and extensions provided by Ben which modify
> the POWER9 interrupt model to prepare ground for the support of the
> XIVE interrupt controller as found on POWER9 PowerNV machines.

Applied to ppc-for-4.0 (but after yesterday's pull request).

>=20
> Thanks
>=20
> C.
>=20
> Changes since initial patchset :
>=20
>  - modified the commit log to comment the use of EXCP_HLT instead
>    of POWERPC_EXCP_STOP
>  - modified the icp_realize() and xive_tctx_realize() to take
>    into account explicitely the POWER9 interrupt model
>  - introduced a specific power9_set_irq for POWER9
>=20
>=20
> Benjamin Herrenschmidt (10):
>   target/ppc: Fix nip on power management instructions
>   target/ppc: Don't clobber MSR:EE on PM instructions
>   target/ppc: Fix support for "STOP light" states on POWER9
>   target/ppc: Move "wakeup reset" code to a separate function
>   target/ppc: Rename "in_pm_state" to "resume_as_sreset"
>   target/ppc: Add POWER9 exception model
>   target/ppc: Detect erroneous condition in interrupt delivery
>   target/ppc: Add Hypervisor Virtualization Interrupt on POWER9
>   target/ppc: Add POWER9 external interrupt model
>   target/ppc: Add support for LPCR:HEIC on POWER9
>=20
>  include/hw/ppc/ppc.h            |   2 +
>  target/ppc/cpu-qom.h            |   5 +
>  target/ppc/cpu.h                |  26 ++++-
>  hw/intc/xics.c                  |   3 +
>  hw/intc/xive.c                  |   3 +
>  hw/ppc/ppc.c                    |  44 ++++++++-
>  target/ppc/excp_helper.c        | 164 +++++++++++++++++++++-----------
>  target/ppc/translate.c          |  28 ++++--
>  target/ppc/translate_init.inc.c |  34 ++++++-
>  9 files changed, 238 insertions(+), 71 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrUYYACgkQbDjKyiDZ
s5JekxAA4W1DnNzkquAjXpG2s2qAqxQnnNwCwoRC2YCCbpMdbq6vanRJbGpJvLZg
B1NAtuB/3Uph3ZJD5kVmKw67bpQN1mvBQ4AOFKjeHYHYcUOZIHrtsFryNlVXfzAG
GxAoJxNIfK6qWlsbR2051b2HKTLUDi/IdzPCdjmoVuzWZs6bK80Di68xXls9oZjz
602UFsWJqpsxwg4OT9LRhwU6k2XA37K5ELBUnMFZ6lC9WRJ5BKDclBzQ/sYRC46C
VhHJvyHvqJFVvh70P4ZolmqueAUj7jCPSTSa8tQyWHFSoUXJGiRKQknahhdx42qo
fruvAi1o0QLVg++PworGrDWMpW8UMgzxkkQZvSe/JROVdGGKU40ZH/MXe6TwfJ3A
0eZfjvupTGTYOSKoA1wnOxon5k3+BEEErBVFUp14qZ4qLPY0bodEgTEQ9/TuHLbR
saJcw8fyGUyWm2lIvAsQPe31DhdzuXS/zFQ8d3onE4AShvoDXcRKZcHRUhF+1dky
ytCELvNXOFSTb9vo+JA3Dy4mSoc4VTlLhgkLsDwhObGAgtfrs9Ap7FCX1/0jLnUL
UAc67HIvxtlLxp4ax5hDSq4T9fuG6T93yY9t9w41HdvzKVkxpQcb6fw0ChMM2cVR
Ly7hKFR/IsVwfBBqXIgcepBRgUmauqH9Lx6JAMR6bXsDpfsTmN0=
=EhQz
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--

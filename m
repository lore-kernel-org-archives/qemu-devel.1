Received: from eggs.gnu.org ([2001:4830:134:3::10]:52681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkix-0006Uo-N6
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkiw-0004xg-G3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 23:09:47 -0500
Date: Thu, 23 Feb 2017 15:09:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223040936.GN12577@umbus.fritz.box>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aWauiwyUFlp3+edf"
Content-Disposition: inline
In-Reply-To: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 00/10] target/ppc: Implement
 POWER9 pseries tcg legacy support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--aWauiwyUFlp3+edf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:04:28PM +1100, Suraj Jitindar Singh wrote:
> This is V3 of the patch series to implement tcg emulation support for a
> POWER9 cpu model for the pseries machine type running a legacy kernel.
> That is a kernel which doesn't use the new radix mmu mode or the new hash
> mmu mode with segment tables.
>=20
> To use a POWER9 cpu provide the command line option "-cpu POWER9".
>=20
> This series attempts to avoid precluding KVM-HV support for the POWER9
> cpu model but doesn't attempt to support KVM-PR or the powernv machine
> for the POWER9 cpu model as these aren't currently supported or
> implemented and further code changes will be required in the event these
> are implemented.
>=20
> This series is used as a base to implement radix support.

This is looking pretty good.  Main thing is it will need some rework
to rebase on my HPT cleanup as discussed.  I've made a few other
comments, but they're all small things.
>=20
> The changes from V2 are as follows:
>=20
>  - Only migrate the partition table entry on non-zero value
>  - Change how register generation works to simplify adding/removing
>    registers
>  - Rename mmu.h -> mmu-book3s-v3.h
>  - Error report and abort on attempt to use segment tables
>=20
> Suraj Jitindar Singh (10):
>   target/ppc/POWER9: Add ISAv3.00 MMU definition
>   target/ppc: Fix LPCR DPFD mask define
>   target/ppc/POWER9: Adapt LPCR handling for POWER9
>   target/ppc/POWER9: Direct all instr and data storage interrupts to the
>     hypv
>   target/ppc: Add patb_entry to sPAPRMachineState
>   target/ppc: Don't gen an SDR1 on POWER9 and rework register creation
>   target/ppc/POWER9: Add POWER9 mmu fault handler
>   target/ppc/POWER9: Add POWER9 pa-features definition
>   target/ppc/POWER9: Add cpu_has_work function for POWER9
>   hw/ppc/spapr: Add POWER9 to pseries cpu models
>=20
>  hw/ppc/spapr.c              |  47 ++++++
>  hw/ppc/spapr_cpu_core.c     |   3 +
>  include/hw/ppc/spapr.h      |   1 +
>  target/ppc/cpu-qom.h        |   5 +-
>  target/ppc/cpu.h            |  21 ++-
>  target/ppc/mmu-book3s-v3.h  |  50 ++++++
>  target/ppc/mmu-hash64.c     |  53 +++++-
>  target/ppc/mmu-hash64.h     |   4 +-
>  target/ppc/mmu_helper.c     |  44 ++++-
>  target/ppc/translate.c      |   7 +-
>  target/ppc/translate_init.c | 391 ++++++++++++++++++++++++++++++--------=
------
>  11 files changed, 485 insertions(+), 141 deletions(-)
>  create mode 100644 target/ppc/mmu-book3s-v3.h
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aWauiwyUFlp3+edf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrmCAAAoJEGw4ysog2bOSHkgP/09OKdRxOJnVuZG5gy8eZuTx
APBuvVtBDQDADPV5UV+eWEFoHyshM3gt5n6GLkuwGZgaxc7QpDwyu7CtSsXPPYLo
ql6CIBDu6qmBujECJQk60Wd1NFUpnk18k3mJItP0SGbck/dBa0dJ7QsucOBe/diI
Z1I0ljv+D7KSmxPfuymwsCg5oExnc1fJkP9U0joQKcIHgOmmXKn16gNza5Rrr0by
UxIGtjoOt1H/vINZzS58BkeiV590KlMX9IXdeIXDBdzJDBGzjcQ8+vw8XHEzifMY
opCeUI5aM9to/KoM2d54re8YTsipZ6fA0LqEZlJQs+hC2SvhgTXMfenkwQDPmnpX
+NwN7tf4/x4vl7EE4Fqw3D5aqOqERTUDbMUbaLl4oJ6gOWtixpUvz8LuWR+52E4X
MFvSzaDx9LXNEAPk5SjD82n9LDkWHwG1C3ls40mj+nZ0O1jQlWiV9xjrv25cUIRb
MWNE6xENUEUfIa9YR2f8r4pY9+qrUIxcIIIxVrfxoOtO+ZrsCiug/NmXW9heMxn+
HvweyG/hZrBAfqB/1ZB6J/sw0KMEHvlqXawrY6+4ItuaBgJzgeG5jtQ6xfylo2Ly
jjSoqSfEwyiKgOImB107MlYXLKSHPNG1oTfmMgkkM202pzsHeZ8ZrCtpGz5FuvHS
UMhVJBZnnlC8l8Puq+1J
=RgNh
-----END PGP SIGNATURE-----

--aWauiwyUFlp3+edf--

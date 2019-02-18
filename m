Received: from eggs.gnu.org ([209.51.188.92]:52663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiE-0008Dq-Nc
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiA-0005dx-1n
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:08 -0500
Date: Mon, 18 Feb 2019 11:16:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190218001606.GA3093@umbus.fritz.box>
References: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20190215100058.20015-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 00/17] target/ppc: convert instructions to
 use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 10:00:41AM +0000, Mark Cave-Ayland wrote:
> Now that all the pre-requisite patches and bugfixes have been merged, her=
e is
> the remainder of Richard's "tcg, target/ppc vector improvements" patchset=
 that
> converts various PPC VMX/VSX instructions over to use TCG vector operatio=
ns.
>=20
> Compared to the original posted patchset I've made a few minor changes:
>   - A fix to the boffs calculation for little-endian hosts in patch 4
>     (already reported and fixed on-list)
>   - A formatting fix to patch 8 to keep checkpatch happy
>   - Added David's A-B tags from the original series
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-4.0, thanks.

>=20
>=20
> Mark Cave-Ayland (2):
>   target/ppc: convert VMX logical instructions to use vector operations
>   target/ppc: convert vaddu[b,h,w,d] and vsubu[b,h,w,d] over to use
>     vector operations
>=20
> Richard Henderson (15):
>   target/ppc: convert vspltis[bhw] to use vector operations
>   target/ppc: convert vsplt[bhw] to use vector operations
>   target/ppc: convert VSX logical operations to vector operations
>   target/ppc: convert xxspltib to vector operations
>   target/ppc: convert xxspltw to vector operations
>   target/ppc: convert xxsel to vector operations
>   target/ppc: Pass integer to helper_mtvscr
>   target/ppc: Use helper_mtvscr for reset and gdb
>   target/ppc: Remove vscr_nj and vscr_sat
>   target/ppc: Add helper_mfvscr
>   target/ppc: Use mtvscr/mfvscr for vmstate
>   target/ppc: Add set_vscr_sat
>   target/ppc: Split out VSCR_SAT to a vector field
>   target/ppc: convert vadd*s and vsub*s to vector operations
>   target/ppc: convert vmin* and vmax* to vector operations
>=20
>  target/ppc/arch_dump.c              |   3 +-
>  target/ppc/cpu.h                    |   6 +-
>  target/ppc/helper.h                 |  57 ++------
>  target/ppc/int_helper.c             | 129 +++++-------------
>  target/ppc/machine.c                |  44 ++++++-
>  target/ppc/translate.c              |   1 +
>  target/ppc/translate/vmx-impl.inc.c | 251 +++++++++++++++++++-----------=
------
>  target/ppc/translate/vsx-impl.inc.c | 147 +++++++++------------
>  target/ppc/translate_init.inc.c     |   7 +-
>  9 files changed, 290 insertions(+), 355 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp+UQACgkQbDjKyiDZ
s5Jblg//aHbMu5XAv68MrgXPJLW6MffaeTtufGEW6PxNNH9wMKTk1ElEXKvyO1e6
RptCSCFNv+FnQ5gUvE/gwoj5hJeJyHIZQlh0PikmdjWw2hU3AV4U40PifLzsnegx
I3qO1zw0/LFjRPuxT480YDJvOP/oinc3N5hEAN/hksdeqKGEyxGoalDpNwRHxow+
W/1pHz2nyhMHyOSn/ID5ySXvNFAT8uxSvP2BkHkjpNps6if7i6pIBFLrOz5vOfRX
14DczU2nDoU3AtDwKCAMX+3gEnRfGZCtqoTxW1NUdYC7zsu3UzK6GGFCabauXWUD
pPvrJrT9lMda20hqqkIFHaeVFapjl7OA41UT1R9lnTZ1JZZpuRrmASZoCt5vWX3M
+aG9EtlUIgvIYgXOgaAi4jO5e55lkC65A9lsG5A7i9V3cJ9PYla+zDr+CyWcg+5f
6EFmVoi6M4pvS6SCzGysebT2yTdedDk6GSW3C7UU5uP8m6avx3Vv3MGsNzC3L6Bd
3byc7441el9U3NBdP/y1lVG1hv0cRjORixfIj+a6H+OFHLOemnfdr/wZr3uvF0iB
qv1lCty/4kC6LO+yC4kKLNKcxoQRtT32zovwzZfAaytoImlmW9jlmlsryg9xKfDU
VIG1Xb5JykcqUExaiepvCLhQpQ7LcoUJHy5LKOx8IjkZH83EbV4=
=G8vQ
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTGkc-0000IH-3i
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTGka-0000zY-4K
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:46 -0500
Date: Tue, 17 Jan 2017 08:21:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170116212125.GD15853@umbus>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-4-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <1484288903-18807-4-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 03/17] target/ppc: Add pcr_supported to
 POWER9 cpu class definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 05:28:09PM +1100, Suraj Jitindar Singh wrote:
> pcr_supported is used to define the supported PCR values for a given
> processor. A POWER9 processor can support 3.00, 2.07, 2.06 and 2.05
> compatibility modes, thus we set this accordingly.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This looks fine to go ahead now, so I've merged it to ppc-for-2.9.

> ---
>  target/ppc/cpu.h            | 1 +
>  target/ppc/translate_init.c | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 2a50c43..afb7ddb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2250,6 +2250,7 @@ enum {
>      PCR_COMPAT_2_05     =3D 1ull << (63-62),
>      PCR_COMPAT_2_06     =3D 1ull << (63-61),
>      PCR_COMPAT_2_07     =3D 1ull << (63-60),
> +    PCR_COMPAT_3_00     =3D 1ull << (63-59),
>      PCR_VEC_DIS         =3D 1ull << (63-0), /* Vec. disable (bit NA sinc=
e POWER8) */
>      PCR_VSX_DIS         =3D 1ull << (63-1), /* VSX disable (bit NA since=
 POWER8) */
>      PCR_TM_DIS          =3D 1ull << (63-2), /* Trans. memory disable (PO=
WER8) */
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 626e031..bfc1f24 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8797,6 +8797,8 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>      dc->props =3D powerpc_servercpu_properties;
>      pcc->pvr_match =3D ppc_pvr_match_power9;
>      pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_0=
7;
> +    pcc->pcr_supported =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPA=
T_2_06 |
> +                         PCR_COMPAT_2_05;
>      pcc->init_proc =3D init_proc_POWER9;
>      pcc->check_pow =3D check_pow_nocheck;
>      pcc->insns_flags =3D PPC_INSNS_BASE | PPC_ISEL | PPC_STRING | PPC_MF=
TB |

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYfTlTAAoJEGw4ysog2bOS/jUP/2yvfHzA310V5siADlZFGHpL
vhaD6raS0qHH+BvYz3cdb/D/zwgoZzotjU+9NYe/54Jm5+0/h3022/6VsnBTsAKt
mUISrCsD4U9cNUKSTDREgZy/2Ls0SmqXZUNDg85cYeHtadjaNVqm5oIWmNTX01os
fe8NSI5u02dG1vX4q1zu4j496LjOhPdH4IrqxhgwixbEVknUt7RQSOxjpTM6dpyy
xsCO4/rMRHpxB1vYPCbWCU4eqxu8qi7HXizd859h0z1wWhNmgtgzjDZmvroUZuMO
TxWk250fa8US0kUrMlnKjzzHfw4Z6JCEVLE6rWJ2jXPYug6AnacI7U8JAe/8MzYL
drIguWtLBNRC3KDyeLaw+zWOXVMkTi5Gzn2oeyYv1U+6JOhOkT+Ls/tYO/rrww1F
P4LDPLNfsbHyyX7kZsRA5/yq4t5BO0ZxtvVouyKHlwi+kDLG/HYmDv8R/FgVaUtf
hRVUT4G2+8Z4VlPEDdh5DVrpBohfNHajlBO6iqy/QrzAQ6Q7BUPi6sEH0XPk1sIT
DpS5/IpCiZ5g8ucwD5tcniEiXOB3kAsHLtF9AhiwqmoavWok/T3aweakqzW/Y5Ey
T8+J+1TynucMwDuzJqgdpztvNdckMm809fzZFKRsWM8Y9g1XvVcSUyi7dTaYk1b/
Vt5uJU4R2nkJuywOXEp6
=TNYs
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:34762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dHgLF-0006FS-Hb
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dHgLE-0006yx-Gv
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 20:57:57 -0400
Date: Mon, 5 Jun 2017 10:57:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170605005739.GY13397@umbus.fritz.box>
References: <20170605004951.1009-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zzd9Wh/bp6DhMAqJ"
Content-Disposition: inline
In-Reply-To: <20170605004951.1009-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fixup set_spr error in
 h_register_process_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de


--Zzd9Wh/bp6DhMAqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 10:49:51AM +1000, Suraj Jitindar Singh wrote:
> set_spr is used in the function h_register_process_table() to update the
> LPCR_GTSE and LPCR_UPRT values based on the flags passed by the guest.
> The set_spr function takes the last two arguments mask and value used to
> mask and set the value of the spr respectively.
>=20
> The current call site passes these arguments in the wrong order and thus
> bot GTSE and UPRT will be set irrespective, which is obviously
> incorrect.
>=20
> Rearrange the function call so that these arguments are passed in the
> correct order and the correct behaviour is exhibited.
>=20
> It is worth noting that this wasn't detected earlier since these were
> always both set in all cases where this H_CALL was made.
>=20
> Fixes: 6de833070ca2 ("target/ppc: Set UPRT and GTSE on all cpus in H_REGI=
STER_PROCESS_TABLE")
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to ppc-for-2.10, thanks.

> ---
>  hw/ppc/spapr_hcall.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index aae5a62..aa1ffea 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -992,9 +992,10 @@ static target_ulong h_register_process_table(PowerPC=
CPU *cpu,
> =20
>      /* Update the UPRT and GTSE bits in the LPCR for all cpus */
>      CPU_FOREACH(cs) {
> -        set_spr(cs, SPR_LPCR, LPCR_UPRT | LPCR_GTSE,
> +        set_spr(cs, SPR_LPCR,
>                  ((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ? LPCR_UPRT=
 : 0) |
> -                ((flags & FLAG_GTSE) ? LPCR_GTSE : 0));
> +                ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
> +                LPCR_UPRT | LPCR_GTSE);
>      }
> =20
>      if (kvm_enabled()) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zzd9Wh/bp6DhMAqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNKyDAAoJEGw4ysog2bOSI1MQAOcoiFvOIsVN49N1qk3TvGz8
EsRIugZtBbecLQMHdV9nP1pvzNUu5hz+HKnp8RLjw4bg9UTVKvvS1Ne5zQ/PPPua
2+e+pdAaQ3+xm8u5MtEt60BRmY56t5ySaWsB/V2tqv+nGfS+C7mCHzSoet00/dmV
CWlK8LnaRH7JQ8XN5/n/UA4REBRg0K1ngT4Ea1Lp/J+o53mN47qzSvDGv0wb7rDo
e7ZzZ31ny4fcp7hV70FXhLiHH+MNtdHoJiEn26RQPUYkbsNh/PwYI/MXe3FPpunk
x1AeTB8F+bmQQZise0tgT5aQDem7Alec89V7dSgdQE0E5OsSDkBiCnjjgPL38EUn
pWjebLyY/5rxN+e3dgQlPGp24UcgqoPU0zZYByg2dLUENeJY6ccBfQ0KCeAr3tIr
IWVVafG1/29Qa1g6fDTiBy8S9uJC73yprRTrwoTxJCKq2IAA0GKF8DXpy9SpM2s0
vuJzFGhijsd+dDYSKYZN/dSdGDzbOKDi8AuXfpiIrlSBYkFrJVDuwBE6AtgypvXn
7t343tV+o4xFQdRuxFtLPxKO4+rzbVAGXknNz7mySUStGtYDwB7xd+gwDNjhIErv
qqEooQrfPvabgYbpd18FRKvRHPGpv8yITxPZvhl+CmmWgKVRX7ivLUSY3jEx+eDn
RMyuSskTilYE62zhRqgU
=nSK2
-----END PGP SIGNATURE-----

--Zzd9Wh/bp6DhMAqJ--

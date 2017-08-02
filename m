Received: from eggs.gnu.org ([2001:4830:134:3::10]:60892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dci9r-0006aq-Sp
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 21:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dci9o-00073r-Nd
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 21:09:07 -0400
Date: Wed, 2 Aug 2017 10:43:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170802004317.GA2838@umbus.fritz.box>
References: <1501577097-14248-1-git-send-email-frederic.konrad@adacore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <1501577097-14248-1-git-send-email-frederic.konrad@adacore.com>
Subject: Re: [Qemu-devel] [RFC PATCH] booke206: fix MAS update on tlb miss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 10:44:57AM +0200, KONRAD Frederic wrote:
> When a tlb instruction miss happen, rw is set to 0 at the bottom
> of cpu_ppc_handle_mmu_fault which cause the MAS update function to miss
> the SAS and TS bit in MAS6, MAS1 in booke206_update_mas_tlb_miss.
>=20
> Just calling booke206_update_mas_tlb_miss with rw =3D 2 solve the issue.
>=20
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Applied to ppc-for-2.10.

> ---
>  target/ppc/mmu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index b7b9088..f06b938 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -1551,7 +1551,7 @@ static int cpu_ppc_handle_mmu_fault(CPUPPCState *en=
v, target_ulong address,
>                      env->spr[SPR_40x_ESR] =3D 0x00000000;
>                      break;
>                  case POWERPC_MMU_BOOKE206:
> -                    booke206_update_mas_tlb_miss(env, address, rw);
> +                    booke206_update_mas_tlb_miss(env, address, 2);
>                      /* fall through */
>                  case POWERPC_MMU_BOOKE:
>                      cs->exception_index =3D POWERPC_EXCP_ITLB;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmBICAACgkQbDjKyiDZ
s5IkaQ//bunFpsWXONfvok2cgDLzHzaaZL+AVJJenaJMcHl76PZKBs2u/OVh1eNH
+lmmRfi1B5FiPLDp65OloBmk/0WAlFrFjnUnHepuhMkZocWyA/ci3k21qJ8GBUoc
cF0hE5lxq9PGHr9UGYa1nhVOttoOXmnUDlmEjvXi4aLamBk8LLa7MYHijMvParop
RF3ZJVRAWO5S2/D05rIhN/6Meo2x3XO8wybJNlxs9iA8t79jMnQpsQpFieBK37Lj
IWQMajSFq19hOJUvV0dsRNzoywNCmF9ub2GPV5PadvoxhLiT34EVBUGXsX1rpr05
AayZuUZFrCKWH8vga0tLvTL73aEqYa4y13w7R9E/v3Grk+AAzIL6d5EYbzGHJwV9
NiJNBlfRtfqP3BWqcTlNnYi32GnJTYsLdCMc0SpxJqa2VfiEpK0REpOpnxciAmkk
x+k4xubbVhX1FgoU0l8J/IkwIOyA0iqw7CDQOtXjNYX8N9tfJGLGiOyNwheCPETv
178IEtjm9rmeq9l7YYIr/QqTfyDNNsleoC37XieNVzyRjZ4I+6DzPifrelwW9K6R
GD9NCdyaLb21/AdFGwoHasPvUuFH+jddCpnLcVuueS7JlNIKQE+1LgClImWCLOd8
9lJ4vaJw3C9ofZeQcQxFDAheS0Jic4zT6wILJ0Y6sv6iQrxm7Eo=
=gOZK
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

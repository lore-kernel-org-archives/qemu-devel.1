Received: from eggs.gnu.org ([209.51.188.92]:42227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240M-0006F6-PB
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240J-0000z9-PT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:52 -0500
Date: Fri, 8 Mar 2019 11:59:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308005913.GS7722@umbus.fritz.box>
References: <20190307223548.20516-1-clg@kaod.org>
	<20190307223548.20516-16-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L+vyn3np+Um+N09T"
Content-Disposition: inline
In-Reply-To: <20190307223548.20516-16-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 15/15] target/ppc: add HV support for
 POWER9
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


--L+vyn3np+Um+N09T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 11:35:48PM +0100, C=E9dric Le Goater wrote:
> We now have enough support to boot a PowerNV machine with a POWER9
> processor. Allow HV mode on POWER9.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied.

> ---
>  target/ppc/translate_init.inc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index af70a3b78c9a..0bd555eb1913 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8895,7 +8895,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                         PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
>                         PPC_MEM_SYNC | PPC_MEM_EIEIO |
>                         PPC_MEM_TLBSYNC |
> -                       PPC_64B | PPC_64BX | PPC_ALTIVEC |
> +                       PPC_64B | PPC_64H | PPC_64BX | PPC_ALTIVEC |
>                         PPC_SEGMENT_64B | PPC_SLBI |
>                         PPC_POPCNTB | PPC_POPCNTWD |
>                         PPC_CILDST;
> @@ -8907,6 +8907,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                          PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
>      pcc->msr_mask =3D (1ull << MSR_SF) |
> +                    (1ull << MSR_SHV) |
>                      (1ull << MSR_TM) |
>                      (1ull << MSR_VR) |
>                      (1ull << MSR_VSX) |

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L+vyn3np+Um+N09T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBvmEACgkQbDjKyiDZ
s5JAnA//U5ibBgraW4AwntuvPpAahKZVIHrzQmv0HkGSHUWpo77lUsaOrii5w5OY
+YFAS0OVBpBlY6gpKSX7sEDhH4Eq21Owl226FitUDRH8K9ptYP++8N0ao3qnD/Ey
O/5N6j9XuD7+teIBvJCEXvbn78Ogy56HG4glj+/uV8a9VtR/AMfViIP/1vvF140F
RQwEeA4t1Lb7ebUIOVapnDgH5CLA1aResEiGTtJoxBaZVVDMEGczoPjpKAK5i6mi
ZniDJsYj9Pu36WUk1nqhj4h62Teln+JQNvXJzyIscOwQ9T/MCGH2z0s3RlXEVNmg
6tA0wwwbLXfJnWEBL3LfXrRThkeXew8ZPr+4I6g6JUzdDN6p2pGsVJJpMgufrBX2
iF5/xYnuwXOu97A8aiMtdRTqS7Va+8mlcbETFuGgMhhHvJQuSog1im/3jk2P5lMp
UCgslsDRMJqpz5A1ZSbuGy7hlQcsUFc/DDdA3ar1xgNraQamC/8/K7iqZpLUq+Wo
PFs8xfiWoWZZzme/heblZ/PyWSae0nQxHbgq4NHv1+71CRvWsxGAbdTXYsXUNXf/
xaEiREcfuPDspoDSLWA1Ll/VfUvIiU6O92u7bWCQpAB7UpFkNGCCI2ZwcCTNanIW
ibNhFSzprvxwHhSjseKQVGlHzBZlGp1wPVO0FwPpxIAkh7S/EZ8=
=uJtp
-----END PGP SIGNATURE-----

--L+vyn3np+Um+N09T--

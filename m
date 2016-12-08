Received: from eggs.gnu.org ([2001:4830:134:3::10]:60729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xo-0005Hh-Or
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xn-0002UE-EI
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:04 -0500
Date: Fri, 9 Dec 2016 09:50:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161208225053.GG13139@umbus.fritz.box>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481135102-20011-8-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <1481135102-20011-8-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 7/9] target-ppc: implement xsnegqp
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 11:55:00PM +0530, Nikunj A Dadhania wrote:
> xsnegqp: VSX Scalar Negate Quad-Precision
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Merged to ppc-for-2.9.

> ---
>  target-ppc/translate/vsx-impl.inc.c | 4 ++++
>  target-ppc/translate/vsx-ops.inc.c  | 1 +
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
> index 6a81b2e..01b95df 100644
> --- a/target-ppc/translate/vsx-impl.inc.c
> +++ b/target-ppc/translate/vsx-impl.inc.c
> @@ -663,6 +663,9 @@ static void glue(gen_, name)(DisasContext *ctx)      =
             \
>      case OP_NABS:                                                 \
>          tcg_gen_or_i64(xbh, xbh, sgm);                            \
>          break;                                                    \
> +    case OP_NEG:                                                  \
> +        tcg_gen_xor_i64(xbh, xbh, sgm);                           \
> +        break;                                                    \
>      }                                                             \
>      tcg_gen_mov_i64(cpu_vsrh(xt), xbh);                           \
>      tcg_gen_mov_i64(cpu_vsrl(xt), xbl);                           \
> @@ -673,6 +676,7 @@ static void glue(gen_, name)(DisasContext *ctx)      =
             \
> =20
>  VSX_SCALAR_MOVE_QP(xsabsqp, OP_ABS, SGN_MASK_DP)
>  VSX_SCALAR_MOVE_QP(xsnabsqp, OP_NABS, SGN_MASK_DP)
> +VSX_SCALAR_MOVE_QP(xsnegqp, OP_NEG, SGN_MASK_DP)
> =20
>  #define VSX_VECTOR_MOVE(name, op, sgn_mask)                      \
>  static void glue(gen_, name)(DisasContext * ctx)                 \
> diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
> index 0216efe..d798edb 100644
> --- a/target-ppc/translate/vsx-ops.inc.c
> +++ b/target-ppc/translate/vsx-ops.inc.c
> @@ -106,6 +106,7 @@ GEN_XX3FORM(xscpsgndp, 0x00, 0x16, PPC2_VSX),
> =20
>  GEN_VSX_XFORM_300_EO(xsabsqp, 0x04, 0x19, 0x00, 0x00000001),
>  GEN_VSX_XFORM_300_EO(xsnabsqp, 0x04, 0x19, 0x08, 0x00000001),
> +GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
> =20
>  GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
>  GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSePLAAoJEGw4ysog2bOSdgAP/jGVfQ8t0lYyQ4nxG7fRLooe
QsPwh0oqbtySqgBLIi+RFpt9cQb4AGzVr4FYNhU999ix76BfCXIc1Xwr6jYPrFff
bVa+haz4iNVUnXDX+WOiDgWazYvIpEdAuQy5aPsYt2ng9AFLRczxITCRoKuPno8F
Jx0heuuZgHUuwedzpZ36MS9KLzva3d/HJHeZOnaDdBrw0ffqqD7942TjZSP+71ah
ZNykweefBaLhdMXvjHp1TxM/Q4p3Y5IqUWUAeRwa9N6BCUfwIL63Y/c4Jxxg7NbX
H1iu54N5nEHaHLrj4rumM757Ntv9mxL5YY1kfkM2E7YVFjveeXXsNIzUcKer1CzJ
RJs6P7aRKikjQS6irm9sR4oBPD16OHBLSeGa46KvqnUzVGyw7sapxIOx5Nk94klQ
74qiLw4adU+rrmFgkaJBKcAJbUcjfwB4wsLRVowRJtej186erkkrUWI388DB+uaL
5zlb28SPzghLeWYPd3lvRQmvcKjWBzN9qnaYZbj6431jR7Qk2Qd/didT+9wUpmvD
qUDyQkOUzxNUINRAaARMZ/xKi7y7CxMEfeIrR6rmsfcOza8K/sRnc2y/Za9wMaZI
rMLEVxXmVawzY1uUcS8h3ioKc4QfJgEu3ILFW++CDp5luMk7y2YKIoFBEtG1849z
scMT7jLx0Y5LfZUSpbp0
=2uRU
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--

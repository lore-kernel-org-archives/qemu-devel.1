Received: from eggs.gnu.org ([2001:4830:134:3::10]:34287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVM-0007oQ-B9
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVJ-0000an-9n
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:28 -0500
Date: Fri, 6 Jan 2017 09:03:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170105220306.GF13763@umbus.fritz.box>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1483615579-17618-5-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline
In-Reply-To: <1483615579-17618-5-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 04/14] target-ppc: Replace isden by
 float64_is_zero_or_denormal
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


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 04:56:09PM +0530, Nikunj A Dadhania wrote:
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
>=20
> Replace isden() by float64_is_zero_or_denormal() so that code in
> helper_compute_fprf() can be reused to work with float128 argument.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target-ppc/fpu_helper.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>=20
> diff --git a/target-ppc/fpu_helper.c b/target-ppc/fpu_helper.c
> index 4da991a..5a7aa75 100644
> --- a/target-ppc/fpu_helper.c
> +++ b/target-ppc/fpu_helper.c
> @@ -47,15 +47,6 @@ uint32_t helper_float64_to_float32(CPUPPCState *env, u=
int64_t arg)
>      return f.l;
>  }
> =20
> -static inline int isden(float64 d)
> -{
> -    CPU_DoubleU u;
> -
> -    u.d =3D d;
> -
> -    return ((u.ll >> 52) & 0x7FF) =3D=3D 0;
> -}
> -
>  static inline int ppc_float32_get_unbiased_exp(float32 f)
>  {
>      return ((f >> 23) & 0xFF) - 127;
> @@ -96,7 +87,7 @@ void helper_compute_fprf(CPUPPCState *env, float64 arg)
>                  fprf =3D 0x02;
>              }
>          } else {
> -            if (isden(arg)) {
> +            if (float64_is_zero_or_denormal(arg)) {
>                  /* Denormalized numbers */
>                  fprf =3D 0x10;
>              } else {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbsKaAAoJEGw4ysog2bOShNwQAJyQXVn1ij/Ct+W2eySHdlsq
e0tPymsE58aixO05cdAHH9ucJyzFZsN32nUjtjfG+Of16SzpsYJcJ5RK1JbFBspa
b9LPeUqs0PAqOdtM/p9DFPq4/5J1y5nparhWm8LTOefI49Lgk1U6Tqh+G2k8NND8
5i17IO/7LE3hnpa+47KuZ5e2xZ3bG6Re5nPaHyDpM7Mx9fLkGyOzS2lh/0PtUbr8
CaxGtxeFQNjcQOjSMtErqgG5rnYXTxXs+HMuh6tg1P8SVpOTMP15mnboGt+WXkXO
xkinHQyiRiHL9sTCAbdWdZZDBnc76GUTKV4iw97AY1uwQOYec8kxSC6DfcB+OUfd
eD9QC4d+bQNgLumd3iy2mW3vMHksu3MdX76PEEYrRicK9oZkk/S8lnzAkMZsiKYZ
Pgq73iicpxKXHCfn4jaYAZUvLc0tUFghcdlbbJVpwwPPvZ99lZWGx6MafjXDH8Cr
dQFo6NSVBTgXUMjvSQ2LMLMscTX83HjsDdfy9WvZWElOu/1phJUYgbX/UmRLe6CB
dnpfFYD3ybHKyoiVYsumLEUDbfEQdmZgq2Py2NF+zEmS2Lc4aOMHfZaubnZwHCmG
+WuYwd2X1Btlgh1Yr+0PrOzRZfFKwhxgO1xtoH7VQx6Jp67efMsEb0A722cu8kRD
NKek1E9myC7QtxKcLDDg
=UXpp
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--

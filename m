Received: from eggs.gnu.org ([2001:4830:134:3::10]:58426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWBct-00076p-8x
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 21:48:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWBcs-0007GN-H6
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 21:48:55 -0500
Date: Mon, 10 Dec 2018 13:40:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181210024036.GC4261@umbus.fritz.box>
References: <20181207171314.30769-1-leonardo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
In-Reply-To: <20181207171314.30769-1-leonardo@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] Changes requirement for "vsubsbs"
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonardo Bras <leonardo@linux.vnet.ibm.com>
Cc: "Paul A. Clarke" <pc@us.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 03:13:14PM -0200, Leonardo Bras wrote:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>=20
> Changes requirement for "vsubsbs" instruction, which has been supported
> since ISA 2.03. (Please see section 5.9.1.2 of ISA 2.03)
>=20
> Reported-by: Paul A. Clarke <pc@us.ibm.com>
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> Signed-off-by: Leonardo Bras <leonardo@linux.vnet.ibm.com>

Those instruction generating macros are super-confusing, but I think
this is right.  vsubsbs has been there for ages with altivec, bcdtrunc
is new in ISA 3.0.

Applied to ppc-for-4.0.

> ---
>  target/ppc/translate/vmx-ops.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate/vmx-ops.inc.c b/target/ppc/translate/vm=
x-ops.inc.c
> index 139f80cb24..84e05fb827 100644
> --- a/target/ppc/translate/vmx-ops.inc.c
> +++ b/target/ppc/translate/vmx-ops.inc.c
> @@ -143,7 +143,7 @@ GEN_VXFORM(vaddsws, 0, 14),
>  GEN_VXFORM_DUAL(vsububs, bcdadd, 0, 24, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM_DUAL(vsubuhs, bcdsub, 0, 25, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM(vsubuws, 0, 26),
> -GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_NONE, PPC2_ISA300),
> +GEN_VXFORM_DUAL(vsubsbs, bcdtrunc, 0, 28, PPC_ALTIVEC, PPC2_ISA300),
>  GEN_VXFORM(vsubshs, 0, 29),
>  GEN_VXFORM_DUAL(vsubsws, xpnd04_2, 0, 30, PPC_ALTIVEC, PPC_NONE),
>  GEN_VXFORM_207(vadduqm, 0, 4),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwN0iEACgkQbDjKyiDZ
s5JNxBAAsyktygl6tClb46/+Murg96tlYtG7gMnKaSGLju+hFih8gMUhDMP9DdA7
xffRaun4Wnfxw1YxzwX23Vth0SkKyvKZjeFZpJuzMZTXm9nBpx3Zsw2SYzWHcG6l
mnfgJ5izdObudle+OrgfQk1Qg44mDLP3fXBlp1ECgE+ici3uxZzXXqow+/WTUAUj
ombNVYRLlcP2cc2e1Thx+xF0VVpSqpmWZHogHUcdw5qArDOaxwtrwplAyF2Ep5lr
1KZblQRCKZ6Y39bQcNDEKlsIdcIssB7GBx5JJtMIjkuu7WzSF2wsPoLDDCrCLYNn
9j7/CqSqate8s3dCbsc+3iOHV1tuU/vmkKodlpVwCd0CHfyLY8WiWToFLq1pYIrQ
2/Xdzdc99+s7288Yk9/C7klSUFZ/BnZh8toHgqUDXteSDUgpuw1OtMxEhLEW+PDe
CsCtigG13XXdNVax9UgBdPrHrBsYLQSmqa2fkETK+0JKoHf9vaIOIYLu6RIpRgw1
MjkPBK8oPjv0CGjOJr1rU+ndPmkoahTMO2GEbacy98t5QZueaX5G3kUILca0QODW
pDNVow+TKRm3WUq6joGjEIU0di1Jp1HuxHVL5fKVrfHpTf9HF1tooWrJjmLAyZtR
OW4vSmUYuPVHKrLwLaAl1TY8lYMCB7QP3Cg8Aqg0cqproakpJa4=
=dpVa
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--

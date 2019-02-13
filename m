Received: from eggs.gnu.org ([209.51.188.92]:45508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtn6V-0008Hl-Qh
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmwR-00055o-Rh
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:18:41 -0500
Date: Wed, 13 Feb 2019 16:07:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213050705.GN1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xrUWgNVErK0vNKPg"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-13-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 12/19] target/ppc: Disable ISA 2.06 PM
 instructions on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--xrUWgNVErK0vNKPg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:18AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> The ISA 2.06/2.07 Power Management instructions (doze, nap & rvwinkle)
> don't exist on POWER9, don't enable them.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This looks like a correct fix regardless of the rest of the series,
applied to ppc-for-4.0.

> ---
>  target/ppc/translate_init.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 076d94f45755..f235162a1f6b 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8880,7 +8880,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>                          PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
>                          PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
> -                        PPC2_TM | PPC2_PM_ISA206 | PPC2_ISA300 | PPC2_PR=
CNTL;
> +                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
>      pcc->msr_mask =3D (1ull << MSR_SF) |
>                      (1ull << MSR_TM) |
>                      (1ull << MSR_VR) |

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xrUWgNVErK0vNKPg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjpfkACgkQbDjKyiDZ
s5Jj7xAAjfwPrMqB2rxADJidQ8ASNowL+KhQTQcAM2u9peprNT+JMA1JK8HEvdSq
dqGXEGLD9BCtTlX4U2fTZKOnFUqt2dw78/Mh+QN+D8qNMIgr32SxCZJ9K80ubWET
rXih7jqxeMbqdbbCANzJqMvc5+DbWaG628H3yVUPmjrRMX5+0bt7HOFw+ROeB7X2
4uZE1aeDIthIcMZ0zrwk8tlbfz6yvRR5B3vJ8A7JIFumzm5RGCoatvXa5H91t0kJ
Qpd9bG0a25fMUJf5maONs+FccDOERvHZ+rdugYipBG66VK6dxLXReQ86a8nU4QDT
Y7vrBO0TLqaHkhMbcNVTVikviqZbeGJsOMvzlKR4up1f5aZoJHXfjk39Dye4JZFa
0x5oU52IYs/vHy+dBHxpI9bn2nQ2dylZhR8gIAxhr3U9loolJ6MrKDDFuD7LpMAm
3/TeoHHpves9FW3d44cw0rT7PGwfmK5PNA7Tn19lDT5ecJAFFY0cdZp/+uGojz57
MhhDNJPRcwQ3s5d8V7wIEm/1ZqyCgucynJpGtG4DbAIU0WJnCrf6OkMT41yKUJ42
zjyO6WVikmwLMEWVoWJl41s1zs05LxLrkuxhgV/ZWant+7SGVuvg8HRS7obX1sC7
4cqHbdZ3j4/keWSSQGlA+Zilk7i6j1eJW/IHrDYKlEYSmhedVMI=
=bR8k
-----END PGP SIGNATURE-----

--xrUWgNVErK0vNKPg--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fputg-0000Lo-35
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fputb-0003vr-Rd
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:27:31 -0400
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-5-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <714f9631-163f-8a8a-f6bc-171ed0e2c6ed@greensocs.com>
Date: Wed, 15 Aug 2018 14:26:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-5-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lRC9tqZOOPNk1nQJ9uk2wINBknlQmrn8N"
Subject: Re: [Qemu-devel] [PATCH 04/10] target/arm: Implement AArch32 HVBAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lRC9tqZOOPNk1nQJ9uk2wINBknlQmrn8N
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com
Message-ID: <714f9631-163f-8a8a-f6bc-171ed0e2c6ed@greensocs.com>
Subject: Re: [PATCH 04/10] target/arm: Implement AArch32 HVBAR
References: <20180814124254.5229-1-peter.maydell@linaro.org>
 <20180814124254.5229-5-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/14/18 2:42 PM, Peter Maydell wrote:
> Implement the AArch32 HVBAR register; we can do this just by
> making the existing VBAR_EL2 regdefs be STATE_BOTH.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-By: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/arm/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 14fd78f587a..b6412fe9d1f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3750,7 +3750,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] =3D {
> =20
>  /* Used to describe the behaviour of EL2 regs when EL2 does not exist.=
  */
>  static const ARMCPRegInfo el3_no_el2_cp_reginfo[] =3D {
> -    { .name =3D "VBAR_EL2", .state =3D ARM_CP_STATE_AA64,
> +    { .name =3D "VBAR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 12, .crm =3D 0, .opc2 =3D 0,
>        .access =3D PL2_RW,
>        .readfn =3D arm_cp_read_zero, .writefn =3D arm_cp_write_ignore }=
,
> @@ -3899,7 +3899,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 4, .crm =3D 0, .opc2 =3D 0,
>        .access =3D PL2_RW,
>        .fieldoffset =3D offsetof(CPUARMState, banked_spsr[BANK_HYP]) },=

> -    { .name =3D "VBAR_EL2", .state =3D ARM_CP_STATE_AA64,
> +    { .name =3D "VBAR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 12, .crm =3D 0, .opc2 =3D 0,
>        .access =3D PL2_RW, .writefn =3D vbar_write,
>        .fieldoffset =3D offsetof(CPUARMState, cp15.vbar_el[2]),
>=20


--lRC9tqZOOPNk1nQJ9uk2wINBknlQmrn8N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt0HA8ACgkQd8knW3Qn
Tr5tGRAAhvi2IS6EwzLtlafPxQsXkp+/qWqwZwgOYMIHdKVJ48QdfmCalW7vMhr1
MWzaucEhTUHOeUOz08dem20FcVJYchUTl+uN4N9weojRPg+ZX+GPN/SIsITJURGB
CsWAYXv4vccP/2KfJb3tbsrE+Qv2ij625pUXFrCxDFqO32JTaXXSl17ac/soy9SN
EBD4JiLVnsJAPIklNIPcoMx//Twq8xOCzOyWKoW8GGYTX+zyj0LBMkBfESSXKEZn
23DjruRBbqFHEKNJ8UmqyuOsjp7cCERrpg6M4ateQhtKcHmDlqy5JMW/B0eKyWKG
C92QggE0Pw/qVC1gMHN6UOfZYzm4OipY6tHnfx+H+aYLYybh4E3M4wFgG2Ug8O3S
smkSZAMygKTkaHBfBuxueatWLdotbQJJeLfOg+QRO9x+W8e/4X437nxrQ90taxas
x/uGj5hAnGwlFYJ4gzrYkYRy4XnVllpFyCoPh6P8Zv5Yqh0zQaHObWq62kZoj4E1
doNfShAmR+PefYkzbPvYmHT7jtPh9rBNqcbVXkz6Wp1BakSFsjZYmXqQQepfxibs
MrQYM+Gmhn9ogVuN+wOfItxnzoC+0oXBuRLLPbzrN5CzNo63HdUK1Bn7z5V92QL/
SVLtHSmdB8AyFqaQI7+uO8OYhKROGNfO+jy4NyeLMq+IieB+K/M=
=Q6Ie
-----END PGP SIGNATURE-----

--lRC9tqZOOPNk1nQJ9uk2wINBknlQmrn8N--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fprpN-0003ns-5w
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fprpM-0002nn-0L
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:10:53 -0400
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-3-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <40cb6cd0-0a77-53d9-38fe-1c6786d1dbd5@greensocs.com>
Date: Wed, 15 Aug 2018 11:10:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-3-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hSkkQ020v1tV7MfegIP28u01v2zCgzXlI"
Subject: Re: [Qemu-devel] [PATCH 02/10] target/arm: Add missing .cp = 15 to
 HMAIR1 and HAMAIR1 regdefs
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
--hSkkQ020v1tV7MfegIP28u01v2zCgzXlI
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com
Message-ID: <40cb6cd0-0a77-53d9-38fe-1c6786d1dbd5@greensocs.com>
Subject: Re: [PATCH 02/10] target/arm: Add missing .cp = 15 to HMAIR1 and
 HAMAIR1 regdefs
References: <20180814124254.5229-1-peter.maydell@linaro.org>
 <20180814124254.5229-3-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/14/18 2:42 PM, Peter Maydell wrote:
> ARMCPRegInfo structs will not default to .cp =3D 15 if they
"will default" as suggested by Edgar.
> are ARM_CP_STATE_BOTH, but not if they are ARM_CP_STATE_AA32
> (because a coprocessor number of 0 is valid for AArch32).
> We forgot to explicitly set .cp =3D 15 for the HMAIR1 and
> HAMAIR1 regdefs, which meant they would UNDEF when the guest
> tried to access them under cp15.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-By: Luc Michel <luc.michel@greensocs.com>

> ---
> A quick grep suggests these are the only ones we got wrong.
> ---
>  target/arm/helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2c5e02c0b1a..466c8ae492e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3767,14 +3767,14 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo=
[] =3D {
>        .access =3D PL2_RW, .type =3D ARM_CP_CONST,
>        .resetvalue =3D 0 },
>      { .name =3D "HMAIR1", .state =3D ARM_CP_STATE_AA32,
> -      .opc1 =3D 4, .crn =3D 10, .crm =3D 2, .opc2 =3D 1,
> +      .cp =3D 15, .opc1 =3D 4, .crn =3D 10, .crm =3D 2, .opc2 =3D 1,
>        .access =3D PL2_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },=

>      { .name =3D "AMAIR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 10, .crm =3D 3, .opc2 =3D 0,
>        .access =3D PL2_RW, .type =3D ARM_CP_CONST,
>        .resetvalue =3D 0 },
>      { .name =3D "HAMAIR1", .state =3D ARM_CP_STATE_AA32,
> -      .opc1 =3D 4, .crn =3D 10, .crm =3D 3, .opc2 =3D 1,
> +      .cp =3D 15, .opc1 =3D 4, .crn =3D 10, .crm =3D 3, .opc2 =3D 1,
>        .access =3D PL2_RW, .type =3D ARM_CP_CONST,
>        .resetvalue =3D 0 },
>      { .name =3D "AFSR0_EL2", .state =3D ARM_CP_STATE_BOTH,
> @@ -3917,7 +3917,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>        .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.=
mair_el[2]),
>        .resetvalue =3D 0 },
>      { .name =3D "HMAIR1", .state =3D ARM_CP_STATE_AA32,
> -      .opc1 =3D 4, .crn =3D 10, .crm =3D 2, .opc2 =3D 1,
> +      .cp =3D 15, .opc1 =3D 4, .crn =3D 10, .crm =3D 2, .opc2 =3D 1,
>        .access =3D PL2_RW, .type =3D ARM_CP_ALIAS,
>        .fieldoffset =3D offsetofhigh32(CPUARMState, cp15.mair_el[2]) },=

>      { .name =3D "AMAIR_EL2", .state =3D ARM_CP_STATE_BOTH,
> @@ -3926,7 +3926,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>        .resetvalue =3D 0 },
>      /* HAMAIR1 is mapped to AMAIR_EL2[63:32] */
>      { .name =3D "HAMAIR1", .state =3D ARM_CP_STATE_AA32,
> -      .opc1 =3D 4, .crn =3D 10, .crm =3D 3, .opc2 =3D 1,
> +      .cp =3D 15, .opc1 =3D 4, .crn =3D 10, .crm =3D 3, .opc2 =3D 1,
>        .access =3D PL2_RW, .type =3D ARM_CP_CONST,
>        .resetvalue =3D 0 },
>      { .name =3D "AFSR0_EL2", .state =3D ARM_CP_STATE_BOTH,
>=20


--hSkkQ020v1tV7MfegIP28u01v2zCgzXlI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAltz7gwACgkQd8knW3Qn
Tr69kxAArFluoL30P+J9/ql3MCcnF0PNu44YX8kGil5ho/O1tFKQ+KKy0ewMZ9Ed
8JiwSTUlRvCVuykM45vuq+T2KGENCbYlgUSve1MQlg70+dNiPlCvzGM5be+okwLT
+ScKB86fzkZYxEbJrHu+Qh1QYA4RyfjT42+eIx6d+xhq6I4/qvXJEz+u7hjbBLuB
XN8RGBP8o4+Jgy5wqc6Q5jH1KGrjRvL2/7NBXnknWOhamWr+tcK82VhqfTEetBtN
N3zHpmhL4H7zrE07NwkuOgzC4eDNtSHTDJsx+HVE5ZfBIgc47O+GV7PqCfZEvO/4
IJL9OCTctsAf8ha4iknLRMXPfzQIkmuHwqRUwvebg3FqbVxGJGTyzFeQEZ1XDPHr
/xQCwDEqDYzy53AT3jn4iD83ulFHVoJAmXDZGcXbtgfXn322mdC5Hi0iT7Nt3BAr
oQd94+sMVNom4Kfekona8zYUee952FQ/JOcnDJG2UV5YpvKLkS674nJ8Ce6a9IHb
bhHQV5JHd7AjCus3tmS7AVhlZd/mO9kBFrnjXp4ttiWKVdpx2ACehyLIeyH7kiwA
PsUNs7djpqENHeCAIsGT+qopSEshUZxNBF1zgEIrIVwYaqnAEKRc2zFklS0GbMXw
lFvqk7sU2MzlYg2bCXxt8SHONtl5M40GPo9ij/T5tL2WPgN0E60=
=Mu9L
-----END PGP SIGNATURE-----

--hSkkQ020v1tV7MfegIP28u01v2zCgzXlI--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqEOR-0006pV-TN
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fqEOP-00013j-Up
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:16:35 -0400
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-8-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <0b5b7ec5-0955-95ff-8967-503f639c6171@greensocs.com>
Date: Thu, 16 Aug 2018 11:16:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-8-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AopwHDsiapTafFGpOWDxis63yaKWlpbu8"
Subject: Re: [Qemu-devel] [PATCH 07/10] target/arm: Implement ESR_EL2/HSR
 for AArch32 and no-EL2
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
--AopwHDsiapTafFGpOWDxis63yaKWlpbu8
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com
Message-ID: <0b5b7ec5-0955-95ff-8967-503f639c6171@greensocs.com>
Subject: Re: [PATCH 07/10] target/arm: Implement ESR_EL2/HSR for AArch32 and
 no-EL2
References: <20180814124254.5229-1-peter.maydell@linaro.org>
 <20180814124254.5229-8-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/14/18 2:42 PM, Peter Maydell wrote:
> The AArch32 HSR is the equivalent of AArch64 ESR_EL2;
> we can implement it by marking our existing ESR_EL2 regdef
> as STATE_BOTH. It also needs to be "RES0 from EL3 if
> EL2 not implemented", so add the missing stanza to
> el3_no_el2_cp_reginfo.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-By: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/arm/helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d6e98e9d606..80855302089 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3763,6 +3763,10 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[=
] =3D {
>        .cp =3D 15, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 4,
>        .access =3D PL2_RW,
>        .type =3D ARM_CP_CONST, .resetvalue =3D 0 },
> +    { .name =3D "ESR_EL2", .state =3D ARM_CP_STATE_BOTH,
> +      .opc0 =3D 3, .opc1 =3D 4, .crn =3D 5, .crm =3D 2, .opc2 =3D 0,
> +      .access =3D PL2_RW,
> +      .type =3D ARM_CP_CONST, .resetvalue =3D 0 },
>      { .name =3D "CPTR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 1, .crm =3D 1, .opc2 =3D 2,
>        .access =3D PL2_RW, .type =3D ARM_CP_CONST, .resetvalue =3D 0 },=

> @@ -3926,7 +3930,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] =3D {
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 4, .crm =3D 0, .opc2 =3D 1,
>        .access =3D PL2_RW,
>        .fieldoffset =3D offsetof(CPUARMState, elr_el[2]) },
> -    { .name =3D "ESR_EL2", .state =3D ARM_CP_STATE_AA64,
> +    { .name =3D "ESR_EL2", .state =3D ARM_CP_STATE_BOTH,
>        .opc0 =3D 3, .opc1 =3D 4, .crn =3D 5, .crm =3D 2, .opc2 =3D 0,
>        .access =3D PL2_RW, .fieldoffset =3D offsetof(CPUARMState, cp15.=
esr_el[2]) },
>      { .name =3D "FAR_EL2", .state =3D ARM_CP_STATE_BOTH,
>=20


--AopwHDsiapTafFGpOWDxis63yaKWlpbu8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt1QN0ACgkQd8knW3Qn
Tr4dtA//auATy1uk9vkFotcKoKXE7FJ8sLKPvghVxGxYearGIa435seo4hhEU911
or/G9g5jiJyqiF1+ThdVyZ1vMDfyRJVl3NAYgoUkQaX4jMZkkxcSpSGQlnZGuKkk
Ks+yjbER401hDL18Hr3gKTdpjtaNGFY2qKM6sDtFu0qzlf5+uMCdTmyv+6emKaCx
WpMMU+EMWCFsWTH6h+40/wNqZAA9LSMK+EBqmfHdVqAmpAvWgc2OW0CVOhmE9/G8
e2ymJPzEHgVcL0Kg5dQhr2PmThBUeCYD57AIQNEax+mcQF2GECo3r75S/Ss9AmYd
0LDUSHOlgfltE/+fEXGnZgJ+iEv7XHsk7aYufqQQZnDpshqf/SSDRbyVmeSgjdUI
+dhJ0NkuVUfEFtXNZ0wUoIPFvefBYMtLl7dsiSvPnfnekBWevvkpqNaVgNgz9/f2
odT8iKJrk5/5yBlQdGloFV4W6aFt5akc0KtyFAdOwy6M1WlAH8NO2yGRKRhExqt7
FpkZulHoBFjRigT0mP6+ErDzVJRAuB3ebYu62oP6GYCMO+OvWqLwQj0/RwActXUa
I2GCKx2tQxf+B9FWK7EbbaG+V8IGDUq4ZuCRmbnxldtrLEZ6qtY/pjWeV4ameGTx
BVBraglvzi1sVAHfPS1jYL/RkRPmP844d1BewlnAvypntJ0duPA=
=QMwA
-----END PGP SIGNATURE-----

--AopwHDsiapTafFGpOWDxis63yaKWlpbu8--

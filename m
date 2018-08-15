Received: from eggs.gnu.org ([2001:4830:134:3::10]:44674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fpuhS-0005NW-GH
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fpuhR-0007EO-Io
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:14:54 -0400
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-4-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <34cc09b5-a2bf-a79e-9087-60ec7006686b@greensocs.com>
Date: Wed, 15 Aug 2018 14:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180814124254.5229-4-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JGPG30PmuVuXrvSHAzGJVnf7nFfubDN06"
Subject: Re: [Qemu-devel] [PATCH 03/10] target/arm: Implement RAZ/WI HACTLR2
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
--JGPG30PmuVuXrvSHAzGJVnf7nFfubDN06
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, edgari@xilinx.com
Message-ID: <34cc09b5-a2bf-a79e-9087-60ec7006686b@greensocs.com>
Subject: Re: [PATCH 03/10] target/arm: Implement RAZ/WI HACTLR2
References: <20180814124254.5229-1-peter.maydell@linaro.org>
 <20180814124254.5229-4-peter.maydell@linaro.org>
In-Reply-To: <20180814124254.5229-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/14/18 2:42 PM, Peter Maydell wrote:
> The AArch32 HACTLR2 register maps to bits [63:32] of ACTLR_EL2.
> We implement ACTLR_EL2 as RAZ/WI, so make HACTLR2 also RAZ/WI.
> (We put the regdef next to ACTLR_EL2 as a reminder in case we
> ever make ACTLR_EL2 something other than RAZ/WI).
Putting this regdef in the auxcr_reginfo[] array makes it defined when
the ARM_FEATURE_AUXCR is set (starting from ARM1026 ARMv5 I think).
However I believe this register only exists for ARMv8, for AArch32 mode
to be able to access upper bits of ACTLR_EL2. Should not we check for
ARM_FEATURE_ARMV8 being set so we don't define it for ARMv7?

--=20
Luc

>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 466c8ae492e..14fd78f587a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5436,6 +5436,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>                .opc0 =3D 3, .opc1 =3D 4, .crn =3D 1, .crm =3D 0, .opc2 =
=3D 1,
>                .access =3D PL2_RW, .type =3D ARM_CP_CONST,
>                .resetvalue =3D 0 },
> +            /* HACTLR2 maps to ACTLR_EL2[63:32] */
> +            { .name =3D "HACTLR2", .state =3D ARM_CP_STATE_AA32,
> +              .cp =3D 15, .opc1 =3D 4, .crn =3D 1, .crm =3D 0, .opc2 =3D=
 3,
> +              .access =3D PL2_RW, .type =3D ARM_CP_CONST,
> +              .resetvalue =3D 0 },
>              { .name =3D "ACTLR_EL3", .state =3D ARM_CP_STATE_AA64,
>                .opc0 =3D 3, .opc1 =3D 6, .crn =3D 1, .crm =3D 0, .opc2 =
=3D 1,
>                .access =3D PL3_RW, .type =3D ARM_CP_CONST,
>=20


--JGPG30PmuVuXrvSHAzGJVnf7nFfubDN06
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt0GSsACgkQd8knW3Qn
Tr4VoA/+PjWyoHT8W1Jr35O0kiHRvOveDdO7Pq3gNYG6rL5zpCtIEypHPKl3j9Xt
9IEVDNiuaUl4fuThhhquTRdN1ZVyIEqWkRBsGzLfs3y0DwAoel4yIMYC4TDI0EgC
H8Kvnf37lP7Wxypa4vrTiiFCw9NJ8uyUjCOXotxcd8fo0hE9Pd13tLJs4+hnSDFD
e2TJXQKLVX7yqX85Xf8TpPdQDLTbULL0TPAWSqsgm7yDDCEt3QBRepffgLaYuOLa
kVkGfAJFh5AUwWnDl42kObFNPDAR4qDHCILtREAguFjmFhNC4wZpOsL1BrMZFYHr
xVcy4XNNbi9f2UEwqspF3leieRNVXSWxWEYhy+5kM1828YYKIBtUqCDfU9qHJP2h
X6owyWGRs1nTIRWvzdwpHYrpUW3Wc3jQtkb2LzCTWp9qix+3OjjCZTl9CFJ6mHhS
rCyYVKlHfKW4rP7HOwmJJD5l2HcFyzhMdQUczehR4xtShRLHzHFSodmSAgnxy5Bl
xZzD6bOT0YzrMlUx/TZs1PRnFoGuUKHth36SQd3NHnwtPJ+d3dui4sP+XUYLZFC4
PXqXDWSiXK/Vv/Y5xFrUquLJxyiK+IsKzcXKsVcyPjRePq/Gk+l4QDicpk44sI+w
VRvpVYFwAK9kfziwd07zFsw+JPCg/l61UuANqZ1MLJM6BAshD8A=
=0jw7
-----END PGP SIGNATURE-----

--JGPG30PmuVuXrvSHAzGJVnf7nFfubDN06--

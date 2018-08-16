Received: from eggs.gnu.org ([2001:4830:134:3::10]:42064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHMk-0004j3-6H
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fqHMf-0006Mp-GE
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:27:02 -0400
Received: from mail-co1nam05on0713.outbound.protection.outlook.com
	([2a01:111:f400:fe50::713]:7968
	helo=NAM05-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fqHMc-0006KO-1N
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 08:26:56 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 16 Aug 2018 12:26:47 +0000
Message-ID: <BN7PR08MB48688E1ECB3C9F611704EFDAC63E0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1534182832-554-66-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534182832-554-66-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 65/87] target/mips: Add definition of
 nanoMIPS I7200 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Sent: Monday, August 13, 2018 7:53 PM
> To: qemu-devel@nongnu.org
>=20
> Subject: [PATCH v8 65/87] target/mips: Add definition of nanoMIPS I7200 C=
PU
>=20
> From: Stefan Markovic <smarkovic@wavecomp.com>
>=20
> Add definition of the first nanoMIPS processor in QEMU.
>=20
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate_init.inc.c | 39 ++++++++++++++++++++++++++++++++++=
+++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_ini=
t.inc.c
> index c7ba6ee..b3320b9 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -449,6 +449,45 @@ const mips_def_t mips_defs[] =3D
>          .insn_flags =3D CPU_MIPS32R6 | ASE_MICROMIPS,
>          .mmu_type =3D MMU_TYPE_R4000,
>      },
> +    {
> +        .name =3D "I7200",
> +        .CP0_PRid =3D 0x00010000,
> +        .CP0_Config0 =3D MIPS_CONFIG0 | (1 << CP0C0_MM) | (0x2 << CP0C0_=
AR) |
> +                        (MMU_TYPE_R4000 << CP0C0_MT),
> +        .CP0_Config1 =3D (1U << CP0C1_M) | (15 << CP0C1_MMU) | (2 << CP0=
C1_IS) |
> +                       (4 << CP0C1_IL) | (3 << CP0C1_IA) | (2 << CP0C1_D=
S) |
> +                       (4 << CP0C1_DL) | (3 << CP0C1_DA) | (1 << CP0C1_P=
C) |
> +                       (1 << CP0C1_EP),
> +        .CP0_Config2 =3D MIPS_CONFIG2,
> +        .CP0_Config3 =3D MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_CM=
GCR) |
> +                       (1 << CP0C3_BI) | (1 << CP0C3_SC) | (3 << CP0C3_M=
MAR) |
> +                       (1 << CP0C3_ISA_ON_EXC) | (1 << CP0C3_ISA) |
> +                       (1 << CP0C3_ULRI) | (1 << CP0C3_RXI) |
> +                       (1 << CP0C3_DSP2P) | (1 << CP0C3_DSPP) |
> +                       (1 << CP0C3_CTXTC) | (1 << CP0C3_VInt) |
> +                       (1 << CP0C3_CDMM) | (1 << CP0C3_MT) | (1 << CP0C3=
_TL),
> +        .CP0_Config4 =3D MIPS_CONFIG4 | (0xfc << CP0C4_KScrExist) |
> +                       (2 << CP0C4_IE) | (1U << CP0C4_M),
> +        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_MVH) | (1 << CP0C5_L=
LB),
> +        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_SBRI) | (1 << CP0C5_FRE)=
 |
> +                                  (1 << CP0C5_UFE),
> +        .CP0_LLAddr_rw_bitmask =3D 0,
> +        .CP0_LLAddr_shift =3D 0,
> +        .SYNCI_Step =3D 32,
> +        .CCRes =3D 2,
> +        .CP0_Status_rw_bitmask =3D 0x3158FF1F,
> +        .CP0_PageGrain =3D (1 << CP0PG_IEC) | (1 << CP0PG_XIE) |
> +                         (1U << CP0PG_RIE),
> +        .CP0_PageGrain_rw_bitmask =3D 0,
> +        .CP1_fcr0 =3D (1 << FCR0_FREP) | (1 << FCR0_HAS2008) | (1 << FCR=
0_F64) |
> +                    (1 << FCR0_L) | (1 << FCR0_W) | (1 << FCR0_D) |
> +                    (1 << FCR0_S) | (0x02 << FCR0_PRID) | (0x0 << FCR0_R=
EV),
> +        .CP1_fcr31 =3D (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
> +        .SEGBITS =3D 32,
> +        .PABITS =3D 32,
> +        .insn_flags =3D CPU_NANOMIPS32 | ASE_DSP | ASE_DSPR2 | ASE_MT,
> +        .mmu_type =3D MMU_TYPE_R4000,
> +    },
>  #if defined(TARGET_MIPS64)
>      {
>          .name =3D "R4000",
> --
> 2.7.4
>=20
>=20

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>=

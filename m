Received: from eggs.gnu.org ([2001:4830:134:3::10]:34139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fvodk-000771-SH
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fvodi-0001ro-4X
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:59:28 -0400
Received: from mail-by2nam05on070f.outbound.protection.outlook.com
	([2a01:111:f400:fe52::70f]:12256
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fvodh-0001rW-Q7
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:59:26 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 31 Aug 2018 18:59:05 +0000
Message-ID: <BN7PR08MB486827A1560B19B9708D2E3CC60F0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180830193019.20104-1-jancraig@amazon.com>,
	<20180830193019.20104-3-jancraig@amazon.com>
In-Reply-To: <20180830193019.20104-3-jancraig@amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 2/9] target/mips: Add all MXU opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

>=20
> ________________________________________
> From: Craig Janeczek <jancraig@amazon.com>
> Sent: Thursday, August 30, 2018 9:30 PM
> To: qemu-devel@nongnu.org
> Cc: Aleksandar Markovic; aurelien@aurel32.net; Craig Janeczek
> Subject: [PATCH v4 2/9] target/mips: Add all MXU opcodes
>=20
> Adds all MXU opcodes to the opcode enum.
>=20
> Signed-off-by: Craig Janeczek <jancraig@amazon.com>
> ---
>  v1
>     - NA
>  v2
>     - NA
>  v3
>     - Initial patch, split out from prior first patch
>  v4
>     - separate MXU opcodes into their own enum
>=20
>  target/mips/translate.c | 60 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>=20




> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 19b90c8735..a598f45558 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c

Hi, Craig,

There are 56 opcodes defined here. However, there are 114 MXU instructions =
in the MXU doc. Some other bits are used for coding missing instructions. E=
ven in your patches, it seems, you handle some instructions that are not li=
sted here. Is there any way to have here the complete list of opcodes, even=
 if this involves some more complex extraction operations?

Thanks,
Aleksandar


> @@ -368,6 +368,66 @@ enum {
>      OPC_SDBBP    =3D 0x3F | OPC_SPECIAL2,
>  };
> +enum {
> +    /* MXU */
> +    OPC_MXU_S32MADD  =3D 0x00 | OPC_SPECIAL2,
> +    OPC_MXU_S32MADDU =3D 0x01 | OPC_SPECIAL2,
> +    OPC_MXU_D16MAX   =3D 0x03 | OPC_SPECIAL2,
> +    OPC_MXU_S32MSUB  =3D 0x04 | OPC_SPECIAL2,
> +    OPC_MXU_S32MSUBU =3D 0x05 | OPC_SPECIAL2,
> +    OPC_MXU_D16AVG   =3D 0x06 | OPC_SPECIAL2,
> +    OPC_MXU_D16CPS   =3D 0x07 | OPC_SPECIAL2,
> +    OPC_MXU_D16MUL   =3D 0x08 | OPC_SPECIAL2,
> +    OPC_MXU_D16MULF  =3D 0x09 | OPC_SPECIAL2,
> +    OPC_MXU_D16MAC   =3D 0x0A | OPC_SPECIAL2,
> +    OPC_MXU_D16MACF  =3D 0x0B | OPC_SPECIAL2,
> +    OPC_MXU_D16MADL  =3D 0x0C | OPC_SPECIAL2,
> +    OPC_MXU_S16MAD   =3D 0x0D | OPC_SPECIAL2,
> +    OPC_MXU_Q16ADD   =3D 0x0E | OPC_SPECIAL2,
> +    OPC_MXU_D16MACE  =3D 0x0F | OPC_SPECIAL2,
> +    OPC_MXU_S32LDD   =3D 0x10 | OPC_SPECIAL2,
> +    OPC_MXU_S32STD   =3D 0x11 | OPC_SPECIAL2,
> +    OPC_MXU_S32LDDV  =3D 0x12 | OPC_SPECIAL2,
> +    OPC_MXU_S32STDV  =3D 0x13 | OPC_SPECIAL2,
> +    OPC_MXU_S32LDI   =3D 0x14 | OPC_SPECIAL2,
> +    OPC_MXU_S32SDI   =3D 0x15 | OPC_SPECIAL2,
> +    OPC_MXU_S32LDIV  =3D 0x16 | OPC_SPECIAL2,
> +    OPC_MXU_S32SDIV  =3D 0x17 | OPC_SPECIAL2,
> +    OPC_MXU_D32ADD   =3D 0x18 | OPC_SPECIAL2,
> +    OPC_MXU_D32ACC   =3D 0x19 | OPC_SPECIAL2,
> +    OPC_MXU_Q16ACC   =3D 0x1B | OPC_SPECIAL2,
> +    OPC_MXU_Q8ADDE   =3D 0x1C | OPC_SPECIAL2,
> +    OPC_MXU_Q8ACCE   =3D 0x1D | OPC_SPECIAL2,
> +    OPC_MXU_S8LDD    =3D 0x22 | OPC_SPECIAL2,
> +    OPC_MXU_S8STD    =3D 0x23 | OPC_SPECIAL2,
> +    OPC_MXU_S8LDI    =3D 0x24 | OPC_SPECIAL2,
> +    OPC_MXU_S8SDI    =3D 0x25 | OPC_SPECIAL2,
> +    OPC_MXU_S32EXTR  =3D 0x26 | OPC_SPECIAL2,
> +    OPC_MXU_D32SARW  =3D 0x27 | OPC_SPECIAL2,
> +    OPC_MXU_LXB      =3D 0x28 | OPC_SPECIAL2,
> +    OPC_MXU_S16LDD   =3D 0x2A | OPC_SPECIAL2,
> +    OPC_MXU_S16STD   =3D 0x2B | OPC_SPECIAL2,
> +    OPC_MXU_S16LDI   =3D 0x2C | OPC_SPECIAL2,
> +    OPC_MXU_S16SDI   =3D 0x2D | OPC_SPECIAL2,
> +    OPC_MXU_S32M2I   =3D 0x2E | OPC_SPECIAL2,
> +    OPC_MXU_S32I2M   =3D 0x2F | OPC_SPECIAL2,
> +    OPC_MXU_D32SLL   =3D 0x30 | OPC_SPECIAL2,
> +    OPC_MXU_D32SLR   =3D 0x31 | OPC_SPECIAL2,
> +    OPC_MXU_D32SARL  =3D 0x32 | OPC_SPECIAL2,
> +    OPC_MXU_D32SAR   =3D 0x33 | OPC_SPECIAL2,
> +    OPC_MXU_Q16SLL   =3D 0x34 | OPC_SPECIAL2,
> +    OPC_MXU_Q16SLR   =3D 0x35 | OPC_SPECIAL2,
> +    OPC_MXU_D32SLLV  =3D 0x36 | OPC_SPECIAL2,
> +    OPC_MXU_Q16SAR   =3D 0x37 | OPC_SPECIAL2,
> +    OPC_MXU_Q8MUL    =3D 0x38 | OPC_SPECIAL2,
> +    OPC_MXU_Q8MOVZ   =3D 0x39 | OPC_SPECIAL2,
> +    OPC_MXU_Q8MAC    =3D 0x3A | OPC_SPECIAL2,
> +    OPC_MXU_Q16SCOP  =3D 0x3B | OPC_SPECIAL2,
> +    OPC_MXU_Q8MADL   =3D 0x3C | OPC_SPECIAL2,
> +    OPC_MXU_S32SFL   =3D 0x3D | OPC_SPECIAL2,
> +    OPC_MXU_Q8SAD    =3D 0x3E | OPC_SPECIAL2,
> +};
> +
>  /* Special3 opcodes */
>  #define MASK_SPECIAL3(op)  MASK_OP_MAJOR(op) | (op & 0x3F)

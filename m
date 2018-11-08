Received: from eggs.gnu.org ([2001:4830:134:3::10]:42318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gKhXY-0004t2-Ji
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gKhXT-00040W-HI
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:27:56 -0500
Received: from mail-eopbgr700139.outbound.protection.outlook.com
	([40.107.70.139]:43271
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gKhXT-0003zx-9m
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:27:51 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 8 Nov 2018 10:27:48 +0000
Message-ID: <BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1541616663.git.noring@nocrew.org>,
	<e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>
In-Reply-To: <e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/6] target/mips: Fix decoding mechanism
 of special R5900 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

>=20
> From: Fredrik Noring <noring@nocrew.org>
> Subject: [PATCH v2 4/6] target/mips: Fix decoding mechanism of special R5=
900 opcodes
>=20
> MOVN, MOVZ, MFHI, MFLO, MTHI, MTLO, MULT, MULTU, DIV, DIVU, DMULT,
> DMULTU, DDIV, DDIVU and JR are decoded in decode_opc_special_tx79
> instead of the generic decode_opc_special_legacy.
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
>  target/mips/translate.c | 54 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 4 deletions(-)
>=20

> +#if defined(TARGET_MIPS64)
> +    case OPC_DMULT:
> +    case OPC_DMULTU:
> +    case OPC_DDIV:
> +    case OPC_DDIVU:
> +        check_insn_opc_user_only(ctx, INSN_R5900);
> +        gen_muldiv(ctx, op1, 0, rs, rt);
> +        break;
> +#endif

Fredrik, do you know by any chance if a document exists that would justify =
inclusion of non-R5900 DMULT, DMULTU, DDIV, DDIVU in R5900 executables by g=
cc for R5900? Is it included by cross-gcc or by native gcc, or by both?

I think gcc folks must have had a good reason for that, some kind of design=
 - it can't be 'I really like/miss this instruction, let's include it...'

Thanks,
Aleksandar

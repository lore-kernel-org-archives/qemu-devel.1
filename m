Received: from eggs.gnu.org ([2001:4830:134:3::10]:39746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gO2Tn-0003oA-Qa
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gO2Ti-0001Nu-Pn
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:25:51 -0500
Received: from mail-eopbgr760133.outbound.protection.outlook.com
	([40.107.76.133]:20989
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gO2Ti-0001JB-Il
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 10:25:46 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Sat, 17 Nov 2018 15:25:43 +0000
Message-ID: <BN6PR2201MB1251FEE8E7BBD66A97D1E01CC6DE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
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

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

with caveat that this should be resolved in 3.1+.=

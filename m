Received: from eggs.gnu.org ([2001:4830:134:3::10]:60895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fxbUf-0002N2-AB
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fxbUa-0007y8-BE
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:21:29 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com
	([40.107.68.131]:53068
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fxbUZ-0007tx-SI
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:21:24 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 5 Sep 2018 17:21:21 +0000
Message-ID: <BN7PR08MB4868808227C8E6C76152B65BC6020@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180830193019.20104-1-jancraig@amazon.com>,
	<20180830193019.20104-4-jancraig@amazon.com>
	<BN7PR08MB4868D242CAD42AB129B61EB5C60F0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<1a16b26ca5234092b9a5d60082881a15@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <1a16b26ca5234092b9a5d60082881a15@EX13D12UEA003.ant.amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 3/9] target/mips: Split mips instruction
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Janeczek, Craig" <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Richard Henderson <richard.henderson@linaro.org>

> From: Janeczek, Craig <jancraig@amazon.com>
> Sent: Tuesday, September 4, 2018 4:44 PM
>
> Subject: RE: [PATCH v4 3/9] target/mips: Split mips instruction handling
>
> To clarify the OPC_MUL here is not an MXU instruction, this is the origin=
al OPC_MUL that was in the special2 instruction set. The inclusion of this =
instruction in this switch statement is due to the suggested method of spli=
tting up the mxu commands instruction handling switch statement from the or=
iginal special2 commands.

There are five more cases where current SPECIAL2 instructions occupy free s=
lots in  MXU opcode scheme:

    /* Loongson 2F */
    OPC_MODU_G_2F   =3D 0x1e | OPC_SPECIAL2,
    OPC_DMODU_G_2F  =3D 0x1f | OPC_SPECIAL2,
    /* Misc */
    OPC_CLZ      =3D 0x20 | OPC_SPECIAL2,
    OPC_CLO      =3D 0x21 | OPC_SPECIAL2,
    /* Special */
    OPC_SDBBP =3D 0x3F | OPC_SPECIAL2,

What to do with them? Should they be treated like OPC_MUL? Can you do the s=
ame binary check as for OPC_MUL? Is there a confirmation in Ingenic gcc/asm=
 source for all these cases?

Thanks,
Aleksandar=

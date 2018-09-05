Received: from eggs.gnu.org ([2001:4830:134:3::10]:33940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fxbZA-0004Ht-LS
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fxbZ6-0007we-7y
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:26:08 -0400
Received: from mail-eopbgr680135.outbound.protection.outlook.com
	([40.107.68.135]:59871
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fxbZ5-0007mf-UK
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 13:26:04 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 5 Sep 2018 17:25:57 +0000
Message-ID: <BN7PR08MB4868F6D5B21D153D32398919C6020@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180830193019.20104-1-jancraig@amazon.com>,
	<20180830193019.20104-4-jancraig@amazon.com>
	<BN7PR08MB4868D242CAD42AB129B61EB5C60F0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<1a16b26ca5234092b9a5d60082881a15@EX13D12UEA003.ant.amazon.com>,
	<BN7PR08MB4868808227C8E6C76152B65BC6020@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868808227C8E6C76152B65BC6020@BN7PR08MB4868.namprd08.prod.outlook.com>
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

In any case, handling OPC_MUL (and others similar cases if it turns out to =
be needed) in such way should be in a separate patch in this series, and ba=
cked by, at the least, references to the Ingenic source code of gcc/asm or =
similar utilities.

Thanks,
Aleksandar

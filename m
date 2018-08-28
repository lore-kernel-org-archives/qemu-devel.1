Received: from eggs.gnu.org ([2001:4830:134:3::10]:49609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fujC3-0006Y0-5V
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 14:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fujBy-0008NW-Kx
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 14:58:22 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:19456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fujBy-0008L1-8S
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 14:58:18 -0400
From: "Janeczek, Craig" <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 18:54:13 +0000
Message-ID: <a89f839cb02647ae865382f060bc29f0@EX13D12UEA003.ant.amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-3-jancraig@amazon.com>
	<BN7PR08MB48680621D40A0A8800E9AEF6C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<b9eab9396a6e4270b9e536a4fe84a54d@EX13D12UEA003.ant.amazon.com>
	<BN7PR08MB4868B217B1104A75673CE58EC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB4868B217B1104A75673CE58EC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/8] target/mips: Add all MXU opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

I will re-work each of the mxu_gen_<ins> functions to check for MXUEN and j=
ump over the implementation of the instruction if not enabled.

I would like to clarify the structure of the switch statement before implem=
enting it.

I was originally planning on checking if there was a MXU hit and MXUEN was =
set, in that case use the MXU instruction, else use the original switch. Th=
is will not work as MXUEN is in a TCGv and cant be used in an if statement =
at that level. That is why I plan on putting the MXUEN check in each of the=
 mxu_gen_<ins> functions.

What should the re-worked switch statement look like which runs the mxu_gen=
_<ins> functions?=20

-----Original Message-----
From: Aleksandar Markovic <amarkovic@wavecomp.com>=20
Sent: Tuesday, August 28, 2018 12:51 PM
To: Janeczek, Craig <jancraig@amazon.com>; qemu-devel@nongnu.org
Cc: aurelien@aurel32.net
Subject: Re: [PATCH v3 2/8] target/mips: Add all MXU opcodes

> I see that I can check the loongson instructions by checking for INSN_LOO=
NGSON2F. Using MXU if that is not set

One more thing to check is MXUEN bit of MXU control register. This should b=
e done before handling any MXU instructions, except S32M2I/S32I2M.

> What should I check for the mult or misc instructions that were there fir=
st?

It should be is somewhere in LOONGSON docs.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuhDD-0008KG-Ls
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuhD7-0006dm-Ei
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:51:26 -0400
Received: from mail-cys01nam02on0722.outbound.protection.outlook.com
	([2a01:111:f400:fe45::722]:12864
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fuhD1-0006b0-LB
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:51:16 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 28 Aug 2018 16:51:12 +0000
Message-ID: <BN7PR08MB4868B217B1104A75673CE58EC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-3-jancraig@amazon.com>
	<BN7PR08MB48680621D40A0A8800E9AEF6C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<b9eab9396a6e4270b9e536a4fe84a54d@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <b9eab9396a6e4270b9e536a4fe84a54d@EX13D12UEA003.ant.amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
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
To: "Janeczek, Craig" <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

> I see that I can check the loongson instructions by checking for INSN_LOO=
NGSON2F. Using MXU if that is not set

One more thing to check is MXUEN bit of MXU control register. This should b=
e done before handling any MXU instructions, except S32M2I/S32I2M.

> What should I check for the mult or misc instructions that were there fir=
st?

It should be is somewhere in LOONGSON docs.

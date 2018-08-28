Received: from eggs.gnu.org ([2001:4830:134:3::10]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fukkZ-0001t9-8Y
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fukkW-0001x1-0S
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:38:07 -0400
Received: from mail-eopbgr680129.outbound.protection.outlook.com
	([40.107.68.129]:45124
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fukkV-0001vB-FD
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:38:03 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 28 Aug 2018 20:37:56 +0000
Message-ID: <BN7PR08MB486827800AB7F9222E4B08A3C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-3-jancraig@amazon.com>
	<BN7PR08MB48680621D40A0A8800E9AEF6C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<b9eab9396a6e4270b9e536a4fe84a54d@EX13D12UEA003.ant.amazon.com>
	<BN7PR08MB4868B217B1104A75673CE58EC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<a89f839cb02647ae865382f060bc29f0@EX13D12UEA003.ant.amazon.com>
	<BN7PR08MB4868B3C34EB2307D4EAE9722C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<a8a8a9fd52124f56ac3be7e991b3b39a@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <a8a8a9fd52124f56ac3be7e991b3b39a@EX13D12UEA003.ant.amazon.com>
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

> To clarify, if MXU is present (a cpu defined to have MXU instructions is =
selected) we will never run any of the other special2 commands? That would =
actually simplify the implementation.

If presence of "special2_legacy" instructions and presence of MXU instructi=
ons are mutually exclusive (and I believe they are (why would they occupy t=
he same opcode space unless they exclude each other?), but at this time don=
't have enough CPU documentation materials to 100% confirm that), I think t=
his is the way to go.

Thanks,
Aleksandar=

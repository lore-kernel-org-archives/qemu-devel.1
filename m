Received: from eggs.gnu.org ([2001:4830:134:3::10]:56622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuhFB-0004Qk-ED
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fuhF5-0008Jp-Po
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:53:29 -0400
Received: from mail-sn1nam02on0103.outbound.protection.outlook.com
	([104.47.36.103]:45079
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fuhF3-0008GX-IR
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:53:22 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 28 Aug 2018 16:53:16 +0000
Message-ID: <BN7PR08MB48681AB62D0FF0D95B8994A2C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-4-jancraig@amazon.com>
	<BN7PR08MB4868C15DDF3A45B9E4719EEAC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<7e66fdf9299b4908a52ef778a856c41c@EX13D12UEA003.ant.amazon.com>
In-Reply-To: <7e66fdf9299b4908a52ef778a856c41c@EX13D12UEA003.ant.amazon.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/8] target/mips: Add MXU instructions
 S32I2M and S32M2I
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

> > This does not handle the case xra =3D=3D XR16.

> I do not see where the case is un-handled. XR16 maps to index 15 in the m=
xu_gpr array.

But, XR16 has its own rules for read/write, and you are treating it just as=
 a regular register. =

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fui28-00052w-5I
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fuhoD-0003JC-5g
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:29:44 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:18542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=771b48d5d=jancraig@amazon.com>)
	id 1fuhoB-0003IH-4G
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 13:29:39 -0400
From: "Janeczek, Craig" <jancraig@amazon.com>
Date: Tue, 28 Aug 2018 17:29:33 +0000
Message-ID: <c271c73f79a84547ba9c53150122b049@EX13D12UEA003.ant.amazon.com>
References: <20180828130041.26445-1-jancraig@amazon.com>,
	<20180828130041.26445-4-jancraig@amazon.com>
	<BN7PR08MB4868C15DDF3A45B9E4719EEAC60A0@BN7PR08MB4868.namprd08.prod.outlook.com>,
	<7e66fdf9299b4908a52ef778a856c41c@EX13D12UEA003.ant.amazon.com>
	<BN7PR08MB48681AB62D0FF0D95B8994A2C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
In-Reply-To: <BN7PR08MB48681AB62D0FF0D95B8994A2C60A0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>

The only commands that have the 5th bit required to address XR16 are S32M2I=
/S32I2M.

I can split it out into a separate utility function and put a conditional i=
nto the S32M2I/S32I2M functions if you are more comfortable with that.

-----Original Message-----
From: Aleksandar Markovic <amarkovic@wavecomp.com>=20
Sent: Tuesday, August 28, 2018 12:53 PM
To: Janeczek, Craig <jancraig@amazon.com>; qemu-devel@nongnu.org
Cc: aurelien@aurel32.net
Subject: Re: [PATCH v3 3/8] target/mips: Add MXU instructions S32I2M and S3=
2M2I

> > This does not handle the case xra =3D=3D XR16.

> I do not see where the case is un-handled. XR16 maps to index 15 in the m=
xu_gpr array.

But, XR16 has its own rules for read/write, and you are treating it just as=
 a regular register.=20

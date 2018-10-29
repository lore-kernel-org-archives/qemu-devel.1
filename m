Received: from eggs.gnu.org ([2001:4830:134:3::10]:57202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gH958-0006Mh-92
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gH953-0000sv-9D
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:03:54 -0400
Received: from mail-eopbgr710102.outbound.protection.outlook.com
	([40.107.71.102]:6391
	helo=NAM05-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gH94z-0000ou-SL
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:03:47 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 29 Oct 2018 15:03:35 +0000
Message-ID: <BN6PR2201MB1251F9D0D28E1177AF8E6B8DC6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>
	<300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
	<BN6PR2201MB12512B1ED5C412208990CC5FC6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251A375F642CB64E85135EFC6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<20181029145106.GA2294@sx9>
In-Reply-To: <20181029145106.GA2294@sx9>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/mips: Support Toshiba specific
 three-operand MADD and MADDU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>

> From: Fredrik Noring <noring@nocrew.org>
> Subject: Re: [PATCH] target/mips: Support Toshiba specific three-operand =
MADD and MADDU
>=20
> Hi Aleksandar,
>=20
> > Without TARGET_MIPS64, we can't say we emulate R5900 - we are emulating
> > some other CPU that never existed.
> >
> > Convince me that I am wrong.
>=20
> R5900 O32 is usable.

Absolutely not. This kind of emulation infidelity can't be in QEMU upstream=
. Even one step further, this should be forbidden, impossible to build.

Thanks,
Aleksandar=

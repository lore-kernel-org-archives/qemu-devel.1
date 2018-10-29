Received: from eggs.gnu.org ([2001:4830:134:3::10]:53625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gH8su-00072S-HC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gH8sq-000244-FC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:51:16 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:34122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gH8sq-00022t-63
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 10:51:12 -0400
Date: Mon, 29 Oct 2018 15:51:06 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181029145106.GA2294@sx9>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>
	<300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
	<BN6PR2201MB12512B1ED5C412208990CC5FC6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251A375F642CB64E85135EFC6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB1251A375F642CB64E85135EFC6F30@BN6PR2201MB1251.namprd22.prod.outlook.com>
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Aleksandar,

> Without TARGET_MIPS64, we can't say we emulate R5900 - we are emulating
> some other CPU that never existed.
> 
> Convince me that I am wrong.

R5900 O32 is usable. The R5900 toolchain is not yet ready for N32. Regarding
your proposal to rename TX79_MMI to MMI: what other ISAs do you have in mind
and do they also have 128-bit GPRs?

Fredrik

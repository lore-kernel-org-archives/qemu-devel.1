Received: from eggs.gnu.org ([2001:4830:134:3::10]:44524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gDZDP-0003jr-N2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gDZDM-0003K0-72
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:09:39 -0400
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com
	([104.47.33.111]:43904
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gDZDG-00035W-02
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 14:09:31 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Fri, 19 Oct 2018 18:09:22 +0000
Message-ID: <BN6PR2201MB1251B68EE547D58B78372BB5C6F90@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>
	<300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
	<20181016185250.GC2323@sx9>,
	<alpine.LFD.2.21.1810161955490.16498@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1810161955490.16498@eddie.linux-mips.org>
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
To: "Maciej W. Rozycki" <macro@linux-mips.org>, Fredrik Noring <noring@nocrew.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>

> Perhaps a better alternative is to define the MMI registers as 128-bit, s=
imilar to
>
> static TCGv_u128 mmi_gpr[32];
>
> and then copy cpu_gpr to/from mmi_gpr as needed when running the MMIs?

Fredrik, hi.

I think this is fine. In any case, this could be changed, if we hit any obs=
tacle related to this format later on during development.

But you don't have to spend much time on this right now. The definition of =
MMI registers is more 'nice-to-have' than a 'must'.

Regards,
Aleksandar=

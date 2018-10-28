Received: from eggs.gnu.org ([2001:4830:134:3::10]:43243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gGqyL-0006L0-IY
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 15:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gGqyI-0000Xr-E0
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 15:43:41 -0400
Received: from mail-eopbgr680090.outbound.protection.outlook.com
	([40.107.68.90]:6064
	helo=NAM04-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gGqyC-0000VJ-8Q
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 15:43:35 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Sun, 28 Oct 2018 19:43:26 +0000
Message-ID: <BN6PR2201MB12512B1ED5C412208990CC5FC6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>,
	<300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
In-Reply-To: <300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, Fredrik Noring <noring@nocrew.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Tuesday, October 16, 2018 8:37 PM
> Subject: Re: [PATCH] target/mips: Support Toshiba specific three-operand =
MADD and MADDU
>=20
> On 10/16/18 11:19 AM, Fredrik Noring wrote:
> > /* global register indices */
> > static TCGv cpu_gpr[32], cpu_PC;
> > static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
> >=20
> > One option is to create a new array such as
> >=20
> > static TCGv_i64 mmi_gpr[32];
> >=20
> > that represents the upper 64 bits of each GPR. Then cpu_gpr must be of
> > a 64-bit type too, even when QEMU runs in 32-bit user mode. The R5900
> > does not implement CP0.Status.UX in hardware, though, so system mode is
> > 64 bits, regardless.
>=20
> I would not implement r5900 for mips32 in that case,
> I would implement it only for TARGET_MIPS64.
>=20
> r~

Hello, Richard.

I truly need your help here. As you can conclude from the discussion, R5900=
 folks (anybody correct me if I am wrong) have some problems using any ABI =
other than O32. (For example, the standard gcc switch are "-mabi=3D32 -marc=
h=3Dr5900".) Other similar CPUs, for example R4000, are built with TARGET_M=
IPS64, both user and system mode. R5900 would not have TARGET_MIPS64 in suc=
h arrangement. This looks outlandish to me. Given that R5900 is a 64-bit MI=
PS III-like processor, is there any anomaly in this arrangement, or this sh=
ould work and is OK?

Thanks,
Aleksandar =

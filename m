Received: from eggs.gnu.org ([2001:4830:134:3::10]:48361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCUE8-00055J-LE
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gCUE6-0006sy-10
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:37:56 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gCUE5-0006sE-OH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:37:53 -0400
Received: by mail-pl1-x643.google.com with SMTP id e67-v6so2441993plb.6
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 11:37:53 -0700 (PDT)
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
Date: Tue, 16 Oct 2018 11:37:48 -0700
MIME-Version: 1.0
In-Reply-To: <20181016181916.GB2323@sx9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Fredrik Noring <noring@nocrew.org>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?J=c3=bcrgen_Urban?= <JuergenUrban@gmx.de>

On 10/16/18 11:19 AM, Fredrik Noring wrote:
> /* global register indices */
> static TCGv cpu_gpr[32], cpu_PC;
> static TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
> 
> One option is to create a new array such as
> 
> static TCGv_i64 mmi_gpr[32];
> 
> that represents the upper 64 bits of each GPR. Then cpu_gpr must be of
> a 64-bit type too, even when QEMU runs in 32-bit user mode. The R5900
> does not implement CP0.Status.UX in hardware, though, so system mode is
> 64 bits, regardless.

I would not implement r5900 for mips32 in that case,
I would implement it only for TARGET_MIPS64.


r~

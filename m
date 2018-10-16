Received: from eggs.gnu.org ([2001:4830:134:3::10]:54600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gCUVY-0002Yf-UK
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gCUVV-0007IP-Pr
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:55:56 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:44366
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gCUVV-00075G-FQ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 14:55:53 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23992925AbeJPSzpKf7Gh (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Tue, 16 Oct 2018 20:55:45 +0200
Date: Tue, 16 Oct 2018 19:55:45 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181016181916.GB2323@sx9>
Message-ID: <alpine.LFD.2.21.1810161947360.16498@eddie.linux-mips.org>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>

On Tue, 16 Oct 2018, Fredrik Noring wrote:

> One option is to create a new array such as
> 
> static TCGv_i64 mmi_gpr[32];
> 
> that represents the upper 64 bits of each GPR. Then cpu_gpr must be of
> a 64-bit type too, even when QEMU runs in 32-bit user mode. The R5900
> does not implement CP0.Status.UX in hardware, though, so system mode is
> 64 bits, regardless.

 It's more like modern CP0.Status.PX however, as the hardware does not 
implement 64-bit memory segments and only has legacy 32-bit segments 
implemented.

 Due to a hardware quirk however the value recorded in the target register 
(usually $ra) does not get sign-extended with linked jump or branch 
instructions, contrary to what is expected with processors implementing 
32-bit segments only.  This has implications for kernel code running from 
KSEG0/KSEG1/KSEG2 and has to be worked around in software, as experience 
has shown.

  Maciej

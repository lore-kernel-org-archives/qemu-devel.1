Received: from eggs.gnu.org ([2001:4830:134:3::10]:56174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gCUba-0005Xg-8D
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 15:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gCUbX-0007Gw-2n
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 15:02:10 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:44868
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gCUbW-0007DM-NR
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 15:02:06 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23992925AbeJPTCDOUP9h (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Tue, 16 Oct 2018 21:02:03 +0200
Date: Tue, 16 Oct 2018 20:02:03 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181016185250.GC2323@sx9>
Message-ID: <alpine.LFD.2.21.1810161955490.16498@eddie.linux-mips.org>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>
	<300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
	<20181016185250.GC2323@sx9>
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>

On Tue, 16 Oct 2018, Fredrik Noring wrote:

> > I would not implement r5900 for mips32 in that case,
> > I would implement it only for TARGET_MIPS64.
> 
> R5900 Linux implements the O32 ABI, which is why 32-bit QEMU user-mode is
> very useful. Perhaps a better alternative is to define the MMI registers
> as 128-bit, similar to
> 
> static TCGv_u128 mmi_gpr[32];
> 
> and then copy cpu_gpr to/from mmi_gpr as needed when running the MMIs?

 FWIW, I agree as far as the user emulation mode is concerned.  All 64-bit 
MIPS hardware is currently set up by the Linux kernel for 64-bit execution 
by keeping CP0.Status.UX set when running o32 user processes anyway.

 A change to this policy (and also the use of CP0.Status.PX for n32) has 
been discussed, in partictular in the course of investigating address 
space overflows caused by GCC using the indexed addressing modes under the 
assumption that the address space wraps at 32 bits for o32 and n32 
software, where indeed it does not.  No change has been implemented 
though.

  Maciej

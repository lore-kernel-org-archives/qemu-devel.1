Received: from eggs.gnu.org ([2001:4830:134:3::10]:46076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gGrEL-0003mW-7v
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 16:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gGrEI-0001VV-3C
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 16:00:13 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:50274
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gGrEH-0001Qb-Pr
	for qemu-devel@nongnu.org; Sun, 28 Oct 2018 16:00:10 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23994074AbeJ1UAASHP6o (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Sun, 28 Oct 2018 21:00:00 +0100
Date: Sun, 28 Oct 2018 20:00:00 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <BN6PR2201MB12512B1ED5C412208990CC5FC6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
Message-ID: <alpine.LFD.2.21.1810281946540.19280@eddie.linux-mips.org>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
	<20181015170202.GB2364@sx9>
	<BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181016181916.GB2323@sx9>,
	<300f223b-2013-5e31-0dd1-cd9adf0948ba@linaro.org>
	<BN6PR2201MB12512B1ED5C412208990CC5FC6F20@BN6PR2201MB1251.namprd22.prod.outlook.com>
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Fredrik Noring <noring@nocrew.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>

On Sun, 28 Oct 2018, Aleksandar Markovic wrote:

> I truly need your help here. As you can conclude from the discussion, 
> R5900 folks (anybody correct me if I am wrong) have some problems using 
> any ABI other than O32.

 The maximum the R5900 can support is the n32 ABI, owing to 32-bit virtual 
addressing.  And that ABI is even more troublesome due to this processor's 
peculiarities, requiring extra effort in addition to what has to be done 
to support o32 only.  The lack of sign-extension of the link address that 
becomes visible with 64-bit register accesses is just one issue to name.  
Hence the staged approach chosen.  We'll get n32 support eventually as 
well, once o32 has been sorted, but there'll be no n64 support ever.

  Maciej

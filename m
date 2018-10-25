Received: from eggs.gnu.org ([2001:4830:134:3::10]:46012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gFjaV-0006Ee-Fy
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:38:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gFjaJ-0004Bb-Ps
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:38:22 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:51130
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gFjaH-00045i-Kj
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:38:15 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23992735AbeJYRiDYy8kI (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Thu, 25 Oct 2018 19:38:03 +0200
Date: Thu, 25 Oct 2018 18:38:03 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181023191023.GB2244@sx9>
Message-ID: <alpine.LFD.2.21.1810240213290.19280@eddie.linux-mips.org>
References: <cover.1540134918.git.noring@nocrew.org>
	<BN6PR2201MB125165723113459889A6EC59C6F40@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181022172343.GB2331@sx9>
	<alpine.LFD.2.21.1810221901170.19280@eddie.linux-mips.org>
	<20181023191023.GB2244@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Fredrik,

> >  NB all but pipeline 1 instructions of these are also implemented by other 
> > members of the TXx9 family.  They seem to be referred to as just "multiply 
> > and multiply-add instructions" in the TX79 manual (cf Section B.3.1).
> 
> Would
> 
> ASE_TOSHIBA_MMI  -- TX79 128-bit multimedia instructions
> ASE_TOSHIBA_MAC  -- TXx9 multiply and multiply-add instructions (MADD etc.)
> ASE_TOSHIBA_MAC1 -- TX79 pipeline 1 variant of ASE_TOSHIBA_MAC
> ASE_TOSHIBA_FMA  -- R5900 FPU extensions (MADD.s etc.)
> 
> be acceptable for the currently known Toshiba extensions? (Please propose
> better names.) One complication is that it seems only 8 bits are available
> for all vendor ASEs, and Toshiba would then scoop up half of those.

 I'm not sure if every single random vendor-specific instruction (or a 
bunch of) deserves its own ASE designation, be it internal or externally 
exposed.  I think the MMI set being a substantial architectural feature 
makes sense to be shown in /proc/cpuinfo (in Linux), but I don't think 
there's much more about it.  It's limited to 2 implementations only, so 
internally I think it can well be handled with a macro or static inline 
function (as appropriate) which boil down to (CPU_R5900 || CPU_TX79).

 And if you run out of bits for ASEs regardless, then I suggest just to 
expand the field in question.  In QEMU you can rely on the presence of the 
`uint64_t' data type, so with only 8 bits exhausted you're far from 
getting into trouble.

  Maciej

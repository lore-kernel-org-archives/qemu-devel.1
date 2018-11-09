Received: from eggs.gnu.org ([2001:4830:134:3::10]:43669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL9zQ-0008Az-Qp
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL9zL-0000Ev-7M
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:50:36 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:54256
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL9zK-0008Ms-Kb
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:50:31 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23990875AbeKIQt3N-8bv (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Fri, 9 Nov 2018 17:49:29 +0100
Date: Fri, 9 Nov 2018 16:49:29 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <BN6PR2201MB1251A570A76178D7BD66B247C6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
Message-ID: <alpine.LFD.2.21.1811091634470.27920@eddie.linux-mips.org>
References: <cover.1541616663.git.noring@nocrew.org>
	<e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>
	<BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251F9977B0D4B901801275CC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181109132411.GA2303@sx9>
	<BN6PR2201MB12512E2D06C8A6CD54BBEE8EC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>,
	<20181109143529.GA10409@sx9>,
	<BN6PR2201MB12513465BDF12670379AA72DC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251A570A76178D7BD66B247C6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 4/6] target/mips: Fix decoding mechanism
 of special R5900 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, 9 Nov 2018, Aleksandar Markovic wrote:

> > > I think that the best solution that you exclude DDIV, DDIVU, DMULT, DMULTU
> > > in a separate patch - there is no document to support their inclusion.
> >
> > As Maciej noted, the 64-bit MIPS Linux psABI is indivisible, so how could
> > your alternative possibly work?
> 
> Since we are rapidly approaching 3.1 release, we don't have time for 
> prolonged discussions - so please provide the patch that removes 
> emulation of these instructions that don't belong to R5900 set, and, if 
> you find a justification document later on, they can be reintroduced in 
> 3.1+ timeframe.

 You know well enough that nobody was bothered over the years to actually 
document the 64-bit MIPS Linux psABI (there is the 64-bit ELF document 
from SGI, relevant for IRIX, which has been partially implemented by 
Linux) and even when it comes to the 32-bit psABI the only document is 
from SGI from mid 1990s, that has several errors and surely was not 
written with Linux in mind (and FWIW not entirely with IRIX either).

 The psABI has been set by the architecture back in 1991 and what Linux 
has implemented on top of that around 2001, along with common sense.  You 
can't question what was done 17 years ago asking for a backing piece of 
paper (possibly virtual).  You can put anything on paper and if it does 
not match reality, then it is irrelevant.

 If you question what I state, then ask the MIPS/Linux kernel developers 
at the relevant mailing list, i.e. <linux-mips@linux-mips.org>.

  Maciej

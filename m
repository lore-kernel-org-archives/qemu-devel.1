Received: from eggs.gnu.org ([2001:4830:134:3::10]:34749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gKsQg-0003fl-Rx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 17:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gKsMM-0006eZ-Bz
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 17:01:09 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:59658
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gKsML-0006cL-26
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 17:01:06 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23992971AbeKHWA6Zi0Xj (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Thu, 8 Nov 2018 23:00:58 +0100
Date: Thu, 8 Nov 2018 22:00:58 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181108185058.GA21067@sx9>
Message-ID: <alpine.LFD.2.21.1811082136330.7359@eddie.linux-mips.org>
References: <cover.1541616663.git.noring@nocrew.org>
	<e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>
	<BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181108185058.GA21067@sx9>
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
To: Fredrik Noring <noring@nocrew.org>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

On Thu, 8 Nov 2018, Fredrik Noring wrote:

> > Fredrik, do you know by any chance if a document exists that would justify
> > inclusion of non-R5900 DMULT, DMULTU, DDIV, DDIVU in R5900 executables by
> > gcc for R5900? Is it included by cross-gcc or by native gcc, or by both?
> > 
> > I think gcc folks must have had a good reason for that, some kind of
> > design - it can't be 'I really like/miss this instruction, let's include
> > it...'
> 
> The R5900 reports itself as MIPS III and DMULT, DMULTU, DDIV and DDIVU
> are part of the MIPS III ISA. They are emulated in user mode to support
> generic MIPS III programs.

 FAOD, GCC does not emit these instructions if the R5900 architecture has 
been selected for compilation, e.g.:

/* ISA supports instructions DMULT and DMULTU. */
#define ISA_HAS_DMULT		(TARGET_64BIT				\
				 && !TARGET_MIPS5900			\
				 && mips_isa_rev <= 5)

however they are a part of the base 64-bit MIPS Linux user psABI, which is 
the whole of the MIPS III ISA, so the runtime has to support them one way 
or another (just like LL, SC and SYNC are a part of the 32-bit MIPS Linux 
user psABI even though they are not supported by MIPS I hardware).

  Maciej

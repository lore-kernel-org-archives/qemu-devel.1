Received: from eggs.gnu.org ([2001:4830:134:3::10]:39860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL7EM-0000FF-2U
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL7EG-0006je-Na
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:53:49 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:34238
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gL7E9-0006LH-Ib
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:53:39 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23991062AbeKINx1h0uqw (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Fri, 9 Nov 2018 14:53:27 +0100
Date: Fri, 9 Nov 2018 13:53:27 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <BN6PR2201MB1251F9977B0D4B901801275CC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
Message-ID: <alpine.LFD.2.21.1811091341070.27920@eddie.linux-mips.org>
References: <cover.1541616663.git.noring@nocrew.org>,
	<e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>,
	<BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251F9977B0D4B901801275CC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
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

> > ... and DMULT, DMULTU, DDIV and DDIVU
> > are part of the MIPS III ISA. They are emulated in user mode to support
> > generic MIPS III programs.
> 
> Pure MIPS III executables should not be a concern of the R5900 
> emulation, but R5900 executables.

 I repeat: MIPS III is the available instruction set defined with the base 
64-bit MIPS Linux psABI and must not be subsetted.  You have to support it 
in QEMU Linux user emulation mode for any 64-bit MIPS processor and this 
is not debatable, period.  QEMU has no control over the Linux ABI, it has 
to accept it as it is.

  Maciej

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gEFYC-0001Vj-Km
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gEFY9-0004FQ-D1
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:21:56 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:45964
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gEFY9-0004D0-3c
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 11:21:53 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23993961AbeJUPVpNLlsk (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Sun, 21 Oct 2018 17:21:45 +0200
Date: Sun, 21 Oct 2018 16:21:45 +0100 (BST)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181021123423.GA2666@sx9>
Message-ID: <alpine.LFD.2.21.1810211526230.19280@eddie.linux-mips.org>
References: <cover.1537379317.git.noring@nocrew.org>
	<b4a7f8e59ba8f6eaa03e7fe24690df7b39b17e8d.1537379317.git.noring@nocrew.org>
	<f299b045-eac4-9dec-3999-627d9984141f@amsat.org>
	<alpine.LFD.2.21.1809210020490.19067@eddie.linux-mips.org>
	<20181021123423.GA2666@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v5 6/8] target/mips: Define the R5900 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Fredrik,

> >  The C790 is a follow-up to the R5900.  The R5900 has an FPU that is not 
> > compliant to the IEEE 754 standard for floating-point arithmetic.  It 
> > doesn't implement exceptions, infinities, NaNs or denormals.  It doesn't 
> > implement the the double format either, but that is really tangential, 
> > because the same was the case with the IDT R4650, which had a standard 
> > IEEE 754 FPU, but no double format either.  Finally it has some anomalies 
> > in the FP instruction set; not all opcode encodings are standard.
> 
> Do you know where one might find a list of the nonstandard FP instructions?
> 
> The command
> 
> % grep 'FP_.*EE' binutils/opcodes/mips-opc.c
> 
> gives a list of candidates, I suppose?

 Yeah, those that have EE in `membership' are extra and those that have EE 
in `exclusions' are missing.

 See also: <https://sourceware.org/ml/binutils/2012-11/msg00360.html>.

  Maciej

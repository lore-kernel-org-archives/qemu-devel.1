Received: from eggs.gnu.org ([2001:4830:134:3::10]:57960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gJK89-0004bu-Pt
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 10:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gJK2S-0004P8-DW
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 10:10:11 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:59306
	helo=cvs.linux-mips.org) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <macro@linux-mips.org>) id 1gJK2S-0004MC-3e
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 10:10:08 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23990412AbeKDPJcZ2zaB (ORCPT
	<rfc822;qemu-devel@nongnu.org>); Sun, 4 Nov 2018 16:09:32 +0100
Date: Sun, 4 Nov 2018 15:09:32 +0000 (GMT)
Sender: "Maciej W. Rozycki" <macro@linux-mips.org>
From: "Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <20181104131236.GA30862@sx9>
Message-ID: <alpine.LFD.2.21.1811041503590.20378@eddie.linux-mips.org>
References: <cover.1541174426.git.noring@nocrew.org>
	<fa2941ee17c35fba2512ab530bde3a1807d5769e.1541174426.git.noring@nocrew.org>
	<1001e61e-b6c0-1a41-9e9f-e2fd5a51f7b5@linaro.org>
	<20181104131236.GA30862@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: Fix decoding mechanism of
 R5900 MFLO1, MFHI1, MTLO1 and MTHI1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

On Sun, 4 Nov 2018, Fredrik Noring wrote:

> It appears the correct function is tcg_gen_mov_tl because the TX79 manual
> says
> 
> 	MFHI:  GPR[rd]63..0 <- HI63..0
> 	MFLO:  GPR[rd]63..0 <- LO63..0
> 	MTHI:  HI63..0 <- GPR[rs]63..0
> 	MTLO:  LO63..0 <- GPR[rs]63..0
> 	MFHI1: GPR[rd]63..0 <- HI127..64
> 	MFLO1: GPR[rd]63..0 <- LO127..64
> 	MTHI1: HI127..64 <- GPR[rs]63..0
> 	MTLO1: LO127..64 <- GPR[rs]63..0
> 
> so the GPR is copied to/from in full in all cases. This is slightly
> different to how acc = 1 is handled in gen_HILO.

 However `gen_HILO' looks wrong to me as it'll truncate the values of 
$acc3-$acc1 with the 64-bit DSP ASE.

  Maciej

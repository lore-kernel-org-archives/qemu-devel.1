Received: from eggs.gnu.org ([2001:4830:134:3::10]:57407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gJh5t-0004Sf-Gj
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gJgzn-0006Lt-44
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:40:58 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:64501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gJgzm-000665-RZ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:40:55 -0500
Date: Mon, 5 Nov 2018 16:40:46 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181105154046.GA2383@sx9>
References: <cover.1541174426.git.noring@nocrew.org>
	<fa2941ee17c35fba2512ab530bde3a1807d5769e.1541174426.git.noring@nocrew.org>
	<1001e61e-b6c0-1a41-9e9f-e2fd5a51f7b5@linaro.org>
	<20181104131236.GA30862@sx9>
	<alpine.LFD.2.21.1811041503590.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811041503590.20378@eddie.linux-mips.org>
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
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org

Thanks for checking this, Maciej,

[ Cc-ing Jia Liu, who added MIPS ASE DSP support in commit 4133498f8e532f
"Use correct acc value to index cpu_HI/cpu_LO rather than using a fix
number", in case there are known ISA deviations. ]

>  However `gen_HILO' looks wrong to me as it'll truncate the values of 
> $acc3-$acc1 with the 64-bit DSP ASE.

I can post a patch to fix gen_HILO. The best reference I have found so far
is "MIPS Architecture for Programmers Volume IV-e: MIPS DSP Module for
microMIPS64 Architecture"

https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00765-2B-microMIPS64DSP-AFP-03.02.pdf

that says

	MFHI: GPR[rds]63..0 <- HI[ac]63..0
	MFLO: GPR[rdt]63..0 <- LO[ac]63..0
	MTHI: HI[ac]63..0 <- GPR[rs]63..0
	MTLO: LO[ac]63..0 <- GPR[rs]63..0

where ac can range from 0 to 3. Do you have a link to a better reference,
by chance, that isn't tied to microMIPS?

Fredrik

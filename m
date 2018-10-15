Received: from eggs.gnu.org ([2001:4830:134:3::10]:41194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gC6Fs-0006dd-Pb
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gC6Fq-0004Ec-2B
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:02:08 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:34923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gC6Fp-0004Dg-Qb
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:02:05 -0400
Date: Mon, 15 Oct 2018 19:02:02 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181015170202.GB2364@sx9>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>
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
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>

Hi Maciej, Philippe,

>  So results of individual operations are as in the comments with this 
> code:
> 
> 	mthi	$0		# HI <- 0
> 	mtlo	$0		# LO <- 0
> 	addiu	$2, $0, 1	# $2 <- 1
> 	lui	$3, 0x4000	# $3 <- 0x40000000
> 	maddu	$4, $3, $2	# HI <- 0
> 				# LO <- 0x40000000
> 				# $4 <- 0x40000000
> 	maddu	$5, $4, $2	# HI <- 0
> 				# LO <- 0xffffffff80000000
> 				# $5 <- 0xffffffff80000000
> 	maddu	$6, $4, $2	# HI <- 1
> 				# LO <- 0
> 				# $6 <- 0

Adding tests such as the one above to for example tests/tcg/mips/txx9/
would be useful, I think. As previously noted, GCC can produce 32-bit
R5900 programs but 64-bit compilations fail, so full test coverage may
not be easily obtainable at the moment.

Fredrik

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEEfJ-0007vO-7M
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 10:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gEEYT-0007NE-F0
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 10:18:12 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:44656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gEEYT-0007MY-7s
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 10:18:09 -0400
Date: Sun, 21 Oct 2018 16:18:06 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181021141806.GB2666@sx9>
References: <cover.1539428198.git.noring@nocrew.org>
	<BN6PR2201MB125158347C995B4CC764BCDBC6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB125158347C995B4CC764BCDBC6FD0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/7] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Aleksandar,

> Your series is getting better and better with each version, which is very
> good. For a change, I don't have any objection about the title. :)

Good!

> Patch 7 will be integrated shortly in the MIPS queue, you don't need to
> worry about it.

Thanks!

> With this series you are not only supporting your prime use case, but you
> are introducing a new instruction set to QEMU. Try to step back and get
> wider perspective. No matter how limited the support for the new ISA is,
> its introduction to QEMU must have following elements:
> 
> (1) Definition of basic preprocessor constants for the new ISA.
> (2) All opcodes for the ISA.
> (3) Basic decoding engine for new instructions.
> 
> Your patch 1 adresses 1). However, there are no patches for (2) and (3) in
> this series. Let me walk though the details on how to implement (2) and (3).

Thank you for your detailed description, it was helpful.

> (2) All opcodes for the ISA.
> 
> Only if an R5900 instruction has the same name, opcode, and functionality,
> corresponding MIPS III/IV opcode can and must be reused for R5900. For all
> other cases, R5900-specific opcode must be supplied. I'll limit further
> consideration to MMI instructions, but you should consider the whole R5900
> instruction set.

I'm preparing v8 with (2) and (3) and other changes, to be posted shortly.

> Of course, you need to specify functions decode_ee_mmi0(),
> decode_ee_mmi1(), decode_ee_mmi2(), and decode_ee_mmi3() too.

Done.

> You can change format and naming in the code above, but I insist that each
> unimplemeted instuction has its own "TODO" and "generate_exception()".

They have TODOs, but it turns out that having individual generate_exception
calls is somewhat impractical, because instructions are typically grouped
and folded into other functions in various ways. I think this is reasonable
evident when looking at how the v8 patch series develops.

> FPU opcodes need such treatment too. This will affect your overall
> solution, hopefully it will be better after the reorganization.

I'm not sure whether the R5900 FPU opcode anomalies are documented. I will
have to investigate this.

Fredrik

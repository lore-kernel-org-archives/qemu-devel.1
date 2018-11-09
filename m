Received: from eggs.gnu.org ([2001:4830:134:3::10]:56972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gL6ls-0002iE-BO
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gL6lo-0005o4-BF
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:24:24 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:12095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gL6ln-0005lQ-W8
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 08:24:20 -0500
Date: Fri, 9 Nov 2018 14:24:11 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181109132411.GA2303@sx9>
References: <cover.1541616663.git.noring@nocrew.org>
	<e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>
	<BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251F9977B0D4B901801275CC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB1251F9977B0D4B901801275CC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Hi Aleksandar,

> > The R5900 reports itself as MIPS III ...
> 
> This is very unclear. What do you mean by this? How does R5900 do that? I
> can't find any trace of such intentions in R5900 docs.

In QEMU, we have previously defined the R5900 as MIPS III by

#define CPU_R5900 (CPU_MIPS3 | INSN_R5900)

by referring to the "Toshiba TX System RISC TX79 Core Architecture" manual

https://wiki.qemu.org/File:C790.pdf

It says in the introduction, for example, that

	3.1 Introduction

	The C790 supports all MIPS III instructions with the exception of
	64-bit multiply, 64-bit divide, Load Linked and Store Conditional
	instructions. It also supports a limited number of MIPS IV
	instructions and additional C790-specific instructions, such as
	Multiply/Add instructions and multimedia instructions.

The manual mentions MIPS III in several other places, and appendix A-1
"CPU Instruction Set Details" describes the implemented MIPS III subset.

> > ... and DMULT, DMULTU, DDIV and DDIVU
> > are part of the MIPS III ISA. They are emulated in user mode to support
> > generic MIPS III programs.
> 
> Pure MIPS III executables should not be a concern of the R5900 emulation,
> but R5900 executables.

Many Linux distributions rely on precompiled packages, and they are often
made to work with a broad range of hardware. This is done in part by
choosing a common denominator, such as MIPS III. Compatibility with other
implementations means that the R5900 more easily can be part of the MIPS
Linux ecosystem.

In contrast, Gentoo Linux mainly builds its packages locally from source,
often optimised for the hardware, such as the R5900. Even so, Gentoo does
rely on a small set of precompiled "stage 3" packages for the installation,
and so the argument above still applies.

> Could you please provide a document that would justify inclusion of these
> non-R5900 instruction in an R5900 emulation?

Would you accept the TX79 manual mentioned above as such a document?

Fredrik

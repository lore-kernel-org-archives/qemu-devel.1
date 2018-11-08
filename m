Received: from eggs.gnu.org ([2001:4830:134:3::10]:33558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKpOX-0003tE-BD
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKpOV-00007c-9j
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:51:08 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:21423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKpOU-0008Uc-Q3
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:51:07 -0500
Date: Thu, 8 Nov 2018 19:50:58 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181108185058.GA21067@sx9>
References: <cover.1541616663.git.noring@nocrew.org>
	<e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>
	<BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
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

> Fredrik, do you know by any chance if a document exists that would justify
> inclusion of non-R5900 DMULT, DMULTU, DDIV, DDIVU in R5900 executables by
> gcc for R5900? Is it included by cross-gcc or by native gcc, or by both?
> 
> I think gcc folks must have had a good reason for that, some kind of
> design - it can't be 'I really like/miss this instruction, let's include
> it...'

The R5900 reports itself as MIPS III and DMULT, DMULTU, DDIV and DDIVU
are part of the MIPS III ISA. They are emulated in user mode to support
generic MIPS III programs.

I have now obtained an R5900 n32 ABI toolchain. R5900 n32 ABI emulation
support is recognised with

http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg01609.html

and a test of DMULT emulation is available with

http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg01610.html

Fredrik

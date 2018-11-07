Received: from eggs.gnu.org ([2001:4830:134:3::10]:52987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTDy-0007XX-L2
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTDt-0007Ue-Lm
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:10:45 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:50141)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKTDr-0006mS-OZ
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:10:40 -0500
Date: Wed, 7 Nov 2018 20:10:07 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181107191007.GA31580@sx9>
References: <cover.1541093316.git.noring@nocrew.org>
	<23e04ec9f8046c358e12046882e8a98a24ed35e5.1541093316.git.noring@nocrew.org>
	<BN6PR2201MB1251AD33BFB2784F20CCC0C6C6CA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB1251AD33BFB2784F20CCC0C6C6CA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v2 12/12] disas/mips: Disassemble R5900
 DIV[U]1, M{F, T}{LO, HI}1 and MULT[U]1
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

> I am glad that you want to include QEMU disas support for R5900 - this
> area usually gets forgotten.
> 
> But, as you can see, this MIPS feature is partially broken - it doesn't
> handle well overlapping opcodes, and the field "membership" is not taken
> into account at all. I think the feature should be fixed first, and then
> R5900 support added. In fact, the disassembler support in QEMU is almost
> independent on the emulation support (for the corresponding instructions)
> - so, we could add disassembler support for all R5900 instructions in one
> clean sweep, instead dividing that in "million" pieces.
> 
> The key to the successful solution would be detecting what CPU is
> currently being emulated, and making disassembling decision based on that.
> 
> Let's talk about that later.

Yes, the current disassembly table needs to be reworked, so let's postpone
the opcodes for the R5900.

> P.S. Sorry for misspelling your name on several occasions.

No problem!

Fredrik

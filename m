Received: from eggs.gnu.org ([2001:4830:134:3::10]:53515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gL7sm-0007uq-Pc
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gL7sj-0001aO-V7
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:35:36 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:59081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gL7sj-0001YX-Ll
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 09:35:33 -0500
Date: Fri, 9 Nov 2018 15:35:29 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181109143529.GA10409@sx9>
References: <cover.1541616663.git.noring@nocrew.org>
	<e8e6bfd053f051d5195ec030f06749b24f867b13.1541616663.git.noring@nocrew.org>
	<BN6PR2201MB12512C561DAD7AE29946682CC6C50@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<BN6PR2201MB1251F9977B0D4B901801275CC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20181109132411.GA2303@sx9>
	<BN6PR2201MB12512E2D06C8A6CD54BBEE8EC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB12512E2D06C8A6CD54BBEE8EC6C60@BN6PR2201MB1251.namprd22.prod.outlook.com>
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Aleksandar,

> Tx79 mentions the opposite: that DDIV, DDIVU, DMULT, DMULTU are not
> included in R5900 set.
> 
> I think that the best solution that you exclude DDIV, DDIVU, DMULT, DMULTU
> in a separate patch - there is no document to support their inclusion.

As Maciej noted, the 64-bit MIPS Linux psABI is indivisible, so how could
your alternative possibly work?

Fredrik

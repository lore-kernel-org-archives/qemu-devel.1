Received: from eggs.gnu.org ([2001:4830:134:3::10]:36458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCLt4-0002A1-3W
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gCLsz-0002mw-25
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:43:38 -0400
Received: from mail-by2nam01on0092.outbound.protection.outlook.com
	([104.47.34.92]:12567
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gCLsy-0002WR-KQ
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:43:32 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 16 Oct 2018 09:43:15 +0000
Message-ID: <BN6PR2201MB125130DFBDFBBE67B4CD57A9C6FE0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181014142928.2784-1-f4bug@amsat.org> <20181014164140.GB2319@sx9>
	<CAAdtpL5xQYwyR0VxqAhA3dW9ec2KW07n-GKrMCt=UjQqwsuYHQ@mail.gmail.com>
	<alpine.LFD.2.21.1810142320320.16498@eddie.linux-mips.org>,
	<20181015170202.GB2364@sx9>
In-Reply-To: <20181015170202.GB2364@sx9>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Fredrik Noring <noring@nocrew.org>, "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>

> From: Fredrik Noring <noring@nocrew.org>
> Sent: Monday, October 15, 2018 7:02 PM
> To: Maciej W. Rozycki
> Cc: Philippe Mathieu-Daud=E9; Richard Henderson; Aleksandar Markovic; Aur=
elien Jarno; > qemu-devel@nongnu.org Developers; J=FCrgen Urban
> Subject: Re: [PATCH] target/mips: Support Toshiba specific three-operand =
MADD and MADDU
>=20
> Hi Maciej, Philippe,
>=20
> >  So results of individual operations are as in the comments with this
> > code:
> >
> >       mthi    $0              # HI <- 0
> >       mtlo    $0              # LO <- 0
> >       addiu   $2, $0, 1       # $2 <- 1
> >       lui     $3, 0x4000      # $3 <- 0x40000000
> >       maddu   $4, $3, $2      # HI <- 0
> >                               # LO <- 0x40000000
> >                               # $4 <- 0x40000000
> >       maddu   $5, $4, $2      # HI <- 0
> >                               # LO <- 0xffffffff80000000
> >                               # $5 <- 0xffffffff80000000
> >       maddu   $6, $4, $2      # HI <- 1
> >                               # LO <- 0
> >                               # $6 <- 0
>=20
> Adding tests such as the one above to for example tests/tcg/mips/txx9/
> would be useful, I think.

By no means, yes.

A peculiar case of DMULTU would be interesting.

It would be nice to implement just a single instruction from MMI, let's say=
 PAND, and have a test for it.

Thanks,
Aleksandar

> As previously noted, GCC can produce 32-bit
> R5900 programs but 64-bit compilations fail, so full test coverage may
> not be easily obtainable at the moment.
>=20
> Fredrik
> =

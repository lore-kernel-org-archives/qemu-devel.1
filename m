Received: from eggs.gnu.org ([2001:4830:134:3::10]:47146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gJgQz-0002Zf-G3
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gJgQr-0001wF-Or
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:04:57 -0500
Received: from mail-by2nam03on0120.outbound.protection.outlook.com
	([104.47.42.120]:36079
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gJgQq-0001CO-1q
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:04:49 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 5 Nov 2018 15:04:40 +0000
Message-ID: <BN6PR2201MB1251AD33BFB2784F20CCC0C6C6CA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <cover.1541093316.git.noring@nocrew.org>,
	<23e04ec9f8046c358e12046882e8a98a24ed35e5.1541093316.git.noring@nocrew.org>
In-Reply-To: <23e04ec9f8046c358e12046882e8a98a24ed35e5.1541093316.git.noring@nocrew.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?J=FCrgen_Urban?= <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> From: Fredrik Noring <noring@nocrew.org>
>
> Subject: [PATCH v2 12/12] disas/mips: Disassemble R5900 DIV[U]1, M{F,T}{L=
O,HI}1 and MULT[U]1
>
> Disassemble the R5900 instructions DIV1, DIVU1, MFLO1, MTLO1, MFHI1,
> MTHI1, MULT1 and MULTU1. The opcodes for MADD1 and MADDU1 clash with
> the opcodes for CLZ and CLO, resulting in incorrect disassembly. They
> are therefore omitted here.
>=20
> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---

Hi, Fredrik,

I am glad that you want to include QEMU disas support for R5900 - this area=
 usually gets forgotten.

But, as you can see, this MIPS feature is partially broken - it doesn't han=
dle well overlapping opcodes, and the field "membership" is not taken into =
account at all. I think the feature should be fixed first, and then R5900 s=
upport added. In fact, the disassembler support in QEMU is almost independe=
nt on the emulation support (for the corresponding instructions) - so, we c=
ould add disassembler support for all R5900 instructions in one clean sweep=
, instead dividing that in "million" pieces.

The key to the successful solution would be detecting what CPU is currently=
 being emulated, and making disassembling decision based on that.

Let's talk about that later.

Sincerely,
Aleksandar

P.S. Sorry for misspelling your name on several occasions.

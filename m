Received: from eggs.gnu.org ([2001:4830:134:3::10]:45403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gF3fl-0003EC-Vd
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 16:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gF3QQ-0006A5-76
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 16:37:18 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:34382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gF3QP-00067R-LC
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 16:37:13 -0400
Date: Tue, 23 Oct 2018 22:37:10 +0200
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20181023203710.GA2239@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_NxFaMcZ+ZzympigE8OoYxfmbmAQOReJN_OT32ceMWoA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v8 00/38] target/mips: Limited support for
 the R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, qemu-devel@nongnu.org

Hi Peter, Aleksandar,

> Hi: I get compile errors on 32-bit hosts:
>
> /home/petmay01/qemu-for-merges/disas/mips.c:615:35: error: large
> integer implicitly truncated to unsigned type [-Werror=overflow]
>  #define INSN_5900                 0x100000000
>                                    ^
> /home/petmay01/qemu-for-merges/disas/mips.c:1200:17: note: in
> expansion of macro 'INSN_5900'
>  #define EE      INSN_5900    /* Emotion Engine */
>                  ^
> /home/petmay01/qemu-for-merges/disas/mips.c:2326:73: note: in
> expansion of macro 'EE'
>  {"div1",    "z,s,t",  0x7000001a, 0xfc00ffff, RD_s | RD_t | WR_HILO, 0, EE },
>                                                                          ^
>
> (and repeats on other similar uses).
>
> This is because this line is an initializer for "struct mips_opcode",
> and the final field is "unsigned long membership", which may be only
> 32 bits wide, but you're trying to put a number in that's too big for that.

I am sorry about that. We are out of bits.

Option 1: Discard all disassembly parts of the series. I would prefer this
if possible -- they are not essential now in my opinion.

Option 2: Drop all R5900 related changes for now.

Option 3: Extend the mips_opcode::membership field.

Fredrik

Received: from eggs.gnu.org ([209.51.188.92]:60362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gikwc-0001LW-8Q
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 13:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gikwb-0008Kp-Au
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 13:57:14 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:38016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gikwb-0008Jj-4O
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 13:57:13 -0500
Date: Sun, 13 Jan 2019 19:57:08 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <20190113185708.GA27922@sx9>
References: <cover.1541093316.git.noring@nocrew.org>
	<eecae865fc8f7934cc2d51b24cba7d8ac3ec37c6.1541093316.git.noring@nocrew.org>
	<BN6PR2201MB1251DBF84B71346A8B673CA6C6B60@BN6PR2201MB1251.namprd22.prod.outlook.com>
	<20190101182745.GA17022@sx9>
	<BN6PR2201MB1251C334FE66ADF677BAE8D2C68E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB1251C334FE66ADF677BAE8D2C68E0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/12] tests/tcg/mips: Test R5900
 three-operand MADDU1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Hi Aleksandar,

> - Suggestion: The next MIPS pull request is scehuled for Friday,
> Jan 18, 2018. It would be fantastic if you could prepare the
> following by Jan 14:
> 
>   * Add 32 TCGv_i64 registers that would represent higher halves
>   of R5900 general purpose registers.

Done!

>   * Add TCGv_i32 register SA (shift amount).

See notes below.

>   * Perhaps consider adding higher halves of registers HI an LO
>   independently on HI/LO array used by DSP.

For HI1 and LO1 only? I'm asking since HI0 and LO0 are implemented with
the DSP array anyway, for all ISAs.

>   * It is customary to implement R/W access while introducing
>   such registers:
>     * Implement R/W access instructions to higher halves of
>     R5900 GPRs:
>       * LQ

Done, including PCPYUD and PCPYLD for proper testing!

>       * SQ

Done, including testing!

>     * Implement R/W access instructions to SA register:
>       * MFSA

The TX79 manual says that "the sole purpose of this instruction is to
permit the shift amount to be saved during a context switch" and that
"the shift amount is encoded in SA in an implementation-defined manner"
so it seems to make more sense for system mode rather than user mode?

One may want to choose an implementation that matches the actual R5900
hardware, even though the manual says it's arbitrary.

>       * MTSA

Likewise.

>       * MTSAH
>       * MTSAB

These instructions do not appear to be usable unless the corresponding
shift instructions are implemented as well?

I will post an R5900 multimedia instruction patch series shortly.

Fredrik

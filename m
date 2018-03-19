Received: from eggs.gnu.org ([2001:4830:134:3::10]:51161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exsJ0-0004l4-LJ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1exsIz-000374-Rm
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:46:18 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:40739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1exsIz-00036p-L9
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 06:46:17 -0400
Received: by mail-oi0-x231.google.com with SMTP id c12so13878695oic.7
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 03:46:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180315191141.6789-1-andrew.smirnov@gmail.com>
References: <20180315191141.6789-1-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 10:45:56 +0000
Message-ID: <CAFEAcA8D8avtZxney3dRXED_PCq81EAuiaBcMt_BHtLW6pF0Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] char: i.MX: Simplify imx_update()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Bill Paul <wpaul@windriver.com>

On 15 March 2018 at 19:11, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Code of imx_update() is slightly confusing since the "flags" variable
> doesn't really corespond to anything in real hardware and server as a
> kitchensink accumulating events normally reported via USR1 and USR2
> registers.
>
> Change the code to explicitly evaluate state of interrupts reported
> via USR1 and USR2 against corresponding masking bits and use the to
> detemine if IRQ line should be asserted or not.
>
> NOTE: Check for UTS1_TXEMPTY being set has been dropped for two
> reasons:
>
>     1. Emulation code implements a single character FIFO, so this flag
>        will always be set since characters are trasmitted as a part of
>        the code emulating "push" into the FIFO
>
>     2. imx_update() is really just a function doing ORing and maksing
>        of reported events, so checking for UTS1_TXEMPTY should happen,
>        if it's ever really needed should probably happen outside of
>        it.
>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: Bill Paul <wpaul@windriver.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/char/imx_serial.c | 24 ++++++++++++++++--------

Thanks; I've applied this patch and patch 2 to target-arm.next.
As bugfixes they'll go into 2.12.

PS: if you could provide cover letters for patchsets that have
more than one patch in them that would help me in finding and
processing them.

thanks
-- PMM

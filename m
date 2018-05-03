Received: from eggs.gnu.org ([2001:4830:134:3::10]:56606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEATk-0004zP-Gy
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEATj-00073z-Ev
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:24:44 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEATj-00073l-AA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:24:43 -0400
Received: by mail-ot0-x242.google.com with SMTP id y10-v6so19826235otg.10
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:24:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180503090532.3113-1-joel@jms.id.au>
References: <20180503090532.3113-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 10:24:22 +0100
Message-ID: <CAFEAcA_dP5QRrZoX8P67xjNVpv7QssnMP9yd5sXqAEu2tQ5Lww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] arm: Add nRF51 SoC and micro:bit
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>

On 3 May 2018 at 10:05, Joel Stanley <joel@jms.id.au> wrote:
> Hello,
>
> This short series implements a minimal definition of the Nordic
> Semiconductor nRF51, a Cortex-M0 ARM SoC, and the BBC micro:bit, a
> machine that will use this SoC.
>
> This work will serve as the base for our Google Summer of Code and
> Outreachy interns who will work on implementing a number of features on
> top of this base.
>
> I've tested this with a microbit micropython firmware, and checked that
> it starts running by looking at it with gdb.
>
> I chose to keep the nrf51 and the microbit seperate, to not confuse the
> peripherals that are on the microbit but are not part of the nrf51, and
> vice versa.
>
> Please review!

Hi; thanks for this patchset. I've done some quick overview review.
It looks broadly ok but there are some details which don't follow
our current preferences/practices for board and SoC models (we have
a lot of legacy code in the codebase that follows older approaches
or is just buggy, so it can be hard to get those right. The mps2
boards and the iotkit SoC are the most recent I've written so
probably not a bad pattern to look at.)
We should probably not put this into master until we've got at least
the cortex-m0 model, though.

thanks
-- PMM

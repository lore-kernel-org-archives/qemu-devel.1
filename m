Received: from eggs.gnu.org ([2001:4830:134:3::10]:52807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eefn6-0003C1-1B
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eefn5-0005Kz-5S
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:34:00 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:46416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eefn5-0005Kc-01
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:33:59 -0500
Received: by mail-ot0-x22a.google.com with SMTP id t35so6404822otd.13
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 03:33:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123225654.5764-1-linus.walleij@linaro.org>
References: <20180123225654.5764-1-linus.walleij@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 11:33:37 +0000
Message-ID: <CAFEAcA8CHWkHwkXYsfKMwH_UVFGhs+0ZEdvXX_j8JFxSfU4nfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pl110: Implement vertical compare/next
 base interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 23 January 2018 at 22:56, Linus Walleij <linus.walleij@linaro.org> wrote:
> This implements rudimentary support for interrupt generation on the
> PL110. I am working on a new DRI/KMS driver for Linux and since that
> uses the blanking interrupt, we need something to fire here. Without
> any interrupt support Linux waits for a while and then gives ugly
> messages about the vblank not working in the console (it does not
> hang perpetually or anything though, DRI is pretty forgiving).
>
> I solved it for now by setting up a timer to fire at 60Hz and pull
> the interrupts for "vertical compare" and "next memory base"
> at this interval. This works fine and fires roughly the same number
> of IRQs on QEMU as on the hardware and leaves the console clean
> and nice.
>
> People who want to create more accurate emulation can probably work
> on top of this if need be. It is certainly closer to the hardware
> behaviour than what we have today anyway.

Yeah, I think that "fire every 60Hz" is good enough for now.

Applied to target-arm.next (with the long lines checkpatch
complains about folded).

thanks
-- PMM

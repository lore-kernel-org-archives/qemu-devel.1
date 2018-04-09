Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5atu-0002Il-Tk
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5atu-0001vQ-4v
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:48:18 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5att-0001v8-Vn
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:48:18 -0400
Received: by mail-oi0-x241.google.com with SMTP id 188-v6so8474359oih.8
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 10:48:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHP4M8WUd9QKTCETaKNa+VQ6hMLcND8dfdDAZ3QutieDaE1WKQ@mail.gmail.com>
References: <CAHP4M8VVWyNqi4yLS3S0GXaDz3j8QvUiC=aoJ_DfZLtZBaFwqg@mail.gmail.com>
	<CAFEAcA9stTjg3Wpq5x_vj63jm1DrxAQREk4XPeFWb5rff-Uofg@mail.gmail.com>
	<CAHP4M8X-Dus1Z8UegDTaab5LvaiDAgQa8upsx_KdnPO+A-XoTQ@mail.gmail.com>
	<CAFEAcA_1X1AQ6j9pZQ8fEHmQCxRNK7EhGkohuLbTMpoPONe5PA@mail.gmail.com>
	<CAHP4M8WUd9QKTCETaKNa+VQ6hMLcND8dfdDAZ3QutieDaE1WKQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 18:47:56 +0100
Message-ID: <CAFEAcA_WOvTLnyOTWdO-PhoXsOWkUbayutxLr0jthowOfNgaVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] Use of -machine when running via
 qemu-system-arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 9 April 2018 at 18:41, Ajay Garg <ajaygargnsit@gmail.com> wrote:
> Hi Peter.
>
> The link is pretty good, just that I am a complete noob.
>
> Maybe a more concrete example on the following, clearly specifying why
> things work on x86 without the need of -machine flag, will make things
> crystal clear :
>
> Because ARM systems differ so much and in fundamental ways, typically
> operating system or firmware images intended to run on one machine
> will not run at all on any other. This is often surprising for new
> users who are used to the x86 world where every system looks like a
> standard PC. (Once the kernel has booted, most userspace software
> cares much less about the detail of the hardware.)

For instance, on x86 you can always find the UART for serial
output at IO port 0x3f8, and it's always an 8250 or compatible.
On Arm, the memory address where the UART is will be likely
different for every board. And once you know the address of the
UART, each SoC likely may well have its own implementation,
which has different registers that do different things.
And there's no way to probe for what's there -- you have to
know in advance. So you can't even usefully print bootup
messages without knowing what you're running on.

thanks
-- PMM

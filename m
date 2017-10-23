Received: from eggs.gnu.org ([2001:4830:134:3::10]:55335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6cVz-0000V5-Gb
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e6cVv-00086D-Iz
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:11:35 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:54109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e6cVv-00085d-A8
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:11:31 -0400
Received: by mail-wr0-x242.google.com with SMTP id u40so11440996wrf.10
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 06:11:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171023122719.17199-1-Jason@zx2c4.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Oct 2017 14:11:09 +0100
Message-ID: <CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/virt: support 4 serial
 ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 23 October 2017 at 13:27, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The QEMU man page says:
>
>        -serial dev
>            This option can be used several times to
>            simulate up to 4 serial ports.
>
> However, the ARM virt machine erroneously only provides 1 serial port.
> This patch fixes it by populating 4 of them.
>
> But, unfortunately, this patch doesn't actually work. Sending it to the
> list as inspiration for somebody on the ARM team who might be able to do
> this more properly.

This is really the documentation being wrong -- that is actually
a PC specific thing. In QEMU generally, -serial can be used
for as many serial ports as the machine model provides, up
to a maximum of four.

Why do you want more than one serial port in the virt board?
If there's a good reason we can add more, but mostly I only
expected that one would be needed, for the console.
(If you're using the TrustZone/EL3 support then there's
a second UART for the Secure world.)

thanks
-- PMM

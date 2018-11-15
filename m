Received: from eggs.gnu.org ([2001:4830:134:3::10]:49804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNGPD-0006ja-7f
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNGPC-0007eh-B4
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:05:55 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNGP8-0007Wr-LG
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:05:54 -0500
Received: by mail-oi1-x244.google.com with SMTP id a77so10594488oii.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 04:05:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErn8fSCPZ1YKnf0OWq98S3-GFK9-3=uWgwfMO5Hut7PiDpcrw@mail.gmail.com>
References: <CAErn8fSCPZ1YKnf0OWq98S3-GFK9-3=uWgwfMO5Hut7PiDpcrw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 12:05:14 +0000
Message-ID: <CAFEAcA9o0m+Nc3PgbMfM95NczASWjqc8X+=xrJONRuc5d_nydg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Corrected memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seth K <skintigh@gmail.com>
Cc: Alistair Francis <alistair@alistair23.me>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 4 November 2018 at 07:42, Seth K <skintigh@gmail.com> wrote:
> I corrected these 2 memory regions based on specifications from the chip
> manufacturer. The existing ranges seem to overlap and and cause odd
> behavior and/or crashes when trying to set up multiple UARTs,
> I also played with changing MAX_SERIAL_PORTS to 8 to match the hardware,
> but I did not include that in this patch as I never fully tested its
> effects.

Hi; thanks for the patch. As Philippe says, it looks good,
but the one thing we definitely need is a Signed-off-by:
line from you.

A minor note -- there is no "MAX_SERIAL_PORTS" definition
in QEMU any more: we removed that artificial limitation
earlier this year. Maybe you're basing your patch on an
older version of QEMU? It's best to use git master for
development. Our SoC model defines 6 uarts (STM_NUM_USARTS)
in hw/arm/stm32f205_soc.c, which should all now be connectable
on the command line, though I haven't tested that or checked
whether the hardware has 6 or some other number...

thanks
-- PMM

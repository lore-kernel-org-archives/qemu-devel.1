Received: from eggs.gnu.org ([2001:4830:134:3::10]:55304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOh1x-0006oD-OE
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOh1t-0000Tt-P2
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:43:49 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOh1t-0000TM-KM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:43:45 -0500
Received: by mail-yw1-f65.google.com with SMTP id r199so5081751ywe.4
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 02:43:45 -0800 (PST)
MIME-Version: 1.0
References: <CAErn8fSCPZ1YKnf0OWq98S3-GFK9-3=uWgwfMO5Hut7PiDpcrw@mail.gmail.com>
	<CAFEAcA9o0m+Nc3PgbMfM95NczASWjqc8X+=xrJONRuc5d_nydg@mail.gmail.com>
	<CAErn8fSyzGLaywOf3qGXD7pUtKnH+ZxG3W1ocXPMwcsmpoC-yQ@mail.gmail.com>
In-Reply-To: <CAErn8fSyzGLaywOf3qGXD7pUtKnH+ZxG3W1ocXPMwcsmpoC-yQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 19 Nov 2018 11:43:32 +0100
Message-ID: <CAAdtpL4p=FWoAZ5vBmd7Lq2eSgGGTyUci-fm3hkj_-L7-ubY-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/stm32f205: Fix the UART and Timer
 region size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seth K <skintigh@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi Seth,

On Mon, Nov 19, 2018 at 4:17 AM Seth K <skintigh@gmail.com> wrote:
>
> From: Seth Kintigh <skintigh@gmail.com>
>
> I corrected these 2 memory regions based on specifications from the chip
> manufacturer. The existing ranges seem to overlap and and cause odd
> behavior and/or crashes when trying to set up multiple UARTs,
>
> Signed-off-by: Seth Kintigh <skintigh@gmail.com>
> ---
> Phil, I hope this is the right format.

Better but still incorrect.

This is the 2nd version of your patch, if you add "v2" in the patch
subject, it helps reviewers to see this is not the same as your
previous patch.
I think your next revision should have "v3" in the subject line.

You should not send new patches in-reply to previous one, it is
clearer to start a new thread directly. (same than previous point,
reviewers get confuse in the thread to see which patch they are
referring to).

I tried to apply your patch but get an error:

$ git am seth_stm32f2xx_regsize.mbox
Applying: hw/arm/stm32f205: Fix the UART and Timer region size
error: patch failed: hw/timer/stm32f2xx_timer.c:308
error: hw/timer/stm32f2xx_timer.c: patch does not apply
Patch failed at 0001 hw/arm/stm32f205: Fix the UART and Timer region size
Use 'git am --show-current-patch' to see the failed patch

I suppose the problem is you inserted your patch in the middle of a
mail, or you appended the review comments to your patch.
Please have a look at the "Submit a patch" wiki:
https://wiki.qemu.org/Contribute/SubmitAPatch#Use_git_format-patch
"Use the right diff format. git format-patch will produce patch emails
in the right format"

If you plan to contribute again (for which you are welcome!) I
recommend you to correctly setup git using the previous link, and for
GMail you can also refer to:
https://git-scm.com/docs/git-send-email#_examples
(don't forget to generate an app-specific password).

Regards,

Phil.

>
> PMM, my original changes were made on an old version, but I made the patch
> from the latest version per the instructions. I'm glad to hear that serial
> port limit is gone!
>
>  hw/char/stm32f2xx_usart.c  | 2 +-
>  hw/timer/stm32f2xx_timer.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index 032b5fda13..f3363a2952 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -202,7 +202,7 @@ static void stm32f2xx_usart_init(Object *obj)
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
>
>      memory_region_init_io(&s->mmio, obj, &stm32f2xx_usart_ops, s,
> -                          TYPE_STM32F2XX_USART, 0x2000);
> +                          TYPE_STM32F2XX_USART, 0x400);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>  }
>
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index 58fc7b1188..ae744d1642 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -308,7 +308,7 @@ static void stm32f2xx_timer_init(Object *obj)
>      sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
>
>      memory_region_init_io(&s->iomem, obj, &stm32f2xx_timer_ops, s,
> -                          "stm32f2xx_timer", 0x4000);
> +                          "stm32f2xx_timer", 0x400);
>      sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
>
>      s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_interrupt,
> s);
>
>
> On Thu, Nov 15, 2018 at 7:05 AM Peter Maydell <peter.maydell@linaro.org>
> wrote:
>
> > On 4 November 2018 at 07:42, Seth K <skintigh@gmail.com> wrote:
> > > I corrected these 2 memory regions based on specifications from the chip
> > > manufacturer. The existing ranges seem to overlap and and cause odd
> > > behavior and/or crashes when trying to set up multiple UARTs,
> > > I also played with changing MAX_SERIAL_PORTS to 8 to match the hardware,
> > > but I did not include that in this patch as I never fully tested its
> > > effects.
> >
> > Hi; thanks for the patch. As Philippe says, it looks good,
> > but the one thing we definitely need is a Signed-off-by:
> > line from you.
> >
> > A minor note -- there is no "MAX_SERIAL_PORTS" definition
> > in QEMU any more: we removed that artificial limitation
> > earlier this year. Maybe you're basing your patch on an
> > older version of QEMU? It's best to use git master for
> > development. Our SoC model defines 6 uarts (STM_NUM_USARTS)
> > in hw/arm/stm32f205_soc.c, which should all now be connectable
> > on the command line, though I haven't tested that or checked
> > whether the hardware has 6 or some other number...
> >
> > thanks
> > -- PMM
> >

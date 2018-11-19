Received: from eggs.gnu.org ([2001:4830:134:3::10]:40080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOhpp-00011C-HI
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOhpl-00028a-FO
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:35:21 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOhpk-00027s-RB
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:35:16 -0500
Received: by mail-yw1-f68.google.com with SMTP id k6-v6so12751607ywa.11
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 03:35:16 -0800 (PST)
MIME-Version: 1.0
References: <CAErn8fSCPZ1YKnf0OWq98S3-GFK9-3=uWgwfMO5Hut7PiDpcrw@mail.gmail.com>
	<CAFEAcA9o0m+Nc3PgbMfM95NczASWjqc8X+=xrJONRuc5d_nydg@mail.gmail.com>
	<CAErn8fSyzGLaywOf3qGXD7pUtKnH+ZxG3W1ocXPMwcsmpoC-yQ@mail.gmail.com>
	<CAAdtpL4p=FWoAZ5vBmd7Lq2eSgGGTyUci-fm3hkj_-L7-ubY-g@mail.gmail.com>
	<CAFEAcA9saixs9BScF8dz5r=+WQ3=+5dZ=8j6emT4a+mtWPe=aw@mail.gmail.com>
In-Reply-To: <CAFEAcA9saixs9BScF8dz5r=+WQ3=+5dZ=8j6emT4a+mtWPe=aw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 19 Nov 2018 12:35:04 +0100
Message-ID: <CAAdtpL4o5sQ7-D27u9KL5+Vm8uYdrZ_aCCSCiEyf=BydEJfRGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Seth K <skintigh@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Nov 19, 2018 at 12:08 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 19 November 2018 at 10:43, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> > Hi Seth,
> >
> > On Mon, Nov 19, 2018 at 4:17 AM Seth K <skintigh@gmail.com> wrote:
> >>
> >> From: Seth Kintigh <skintigh@gmail.com>
> >>
> >> I corrected these 2 memory regions based on specifications from the ch=
ip
> >> manufacturer. The existing ranges seem to overlap and and cause odd
> >> behavior and/or crashes when trying to set up multiple UARTs,
> >>
> >> Signed-off-by: Seth Kintigh <skintigh@gmail.com>
> >> ---
> >> Phil, I hope this is the right format.
> >
> > Better but still incorrect.
>
> What Phil says below is true, but since this is a simple
> patch I have applied it by hand to my target-arm.next branch,
> so it will go into the next release of QEMU. Thanks for your
> contribution! (I rewrote the commit message a bit to make
> it fit in with the usual style we use for our commit messages;
> I hope that's OK.)

Thanks Peter!

You can also add:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Regards,

Phil.

>
> > I tried to apply your patch but get an error:
> >
> > $ git am seth_stm32f2xx_regsize.mbox
>
> I suspect this is because the email is in dual text/HTML format.
>
> thanks
> -- PMM

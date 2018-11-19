Received: from eggs.gnu.org ([2001:4830:134:3::10]:33213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOhPm-0001PC-DM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gOhPl-0006tg-RJ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:08:26 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gOhPl-0006sn-GR
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:08:25 -0500
Received: by mail-ot1-x344.google.com with SMTP id k98so27259133otk.3
	for <qemu-devel@nongnu.org>; Mon, 19 Nov 2018 03:08:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4p=FWoAZ5vBmd7Lq2eSgGGTyUci-fm3hkj_-L7-ubY-g@mail.gmail.com>
References: <CAErn8fSCPZ1YKnf0OWq98S3-GFK9-3=uWgwfMO5Hut7PiDpcrw@mail.gmail.com>
	<CAFEAcA9o0m+Nc3PgbMfM95NczASWjqc8X+=xrJONRuc5d_nydg@mail.gmail.com>
	<CAErn8fSyzGLaywOf3qGXD7pUtKnH+ZxG3W1ocXPMwcsmpoC-yQ@mail.gmail.com>
	<CAAdtpL4p=FWoAZ5vBmd7Lq2eSgGGTyUci-fm3hkj_-L7-ubY-g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 11:08:04 +0000
Message-ID: <CAFEAcA9saixs9BScF8dz5r=+WQ3=+5dZ=8j6emT4a+mtWPe=aw@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Seth K <skintigh@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 19 November 2018 at 10:43, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Hi Seth,
>
> On Mon, Nov 19, 2018 at 4:17 AM Seth K <skintigh@gmail.com> wrote:
>>
>> From: Seth Kintigh <skintigh@gmail.com>
>>
>> I corrected these 2 memory regions based on specifications from the chip
>> manufacturer. The existing ranges seem to overlap and and cause odd
>> behavior and/or crashes when trying to set up multiple UARTs,
>>
>> Signed-off-by: Seth Kintigh <skintigh@gmail.com>
>> ---
>> Phil, I hope this is the right format.
>
> Better but still incorrect.

What Phil says below is true, but since this is a simple
patch I have applied it by hand to my target-arm.next branch,
so it will go into the next release of QEMU. Thanks for your
contribution! (I rewrote the commit message a bit to make
it fit in with the usual style we use for our commit messages;
I hope that's OK.)

> I tried to apply your patch but get an error:
>
> $ git am seth_stm32f2xx_regsize.mbox

I suspect this is because the email is in dual text/HTML format.

thanks
-- PMM

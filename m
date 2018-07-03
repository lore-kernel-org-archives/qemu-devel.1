Received: from eggs.gnu.org ([2001:4830:134:3::10]:34065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faRbH-0000gM-9z
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faRbG-0004HV-GQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:08:35 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faRbG-0004HC-CE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:08:34 -0400
Received: by mail-oi0-x242.google.com with SMTP id n84-v6so6302973oib.9
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 13:08:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703184922.GA14422@roeck-us.net>
References: <20180626200008.GA680@roeck-us.net>
	<CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
	<20180702162733.GB32333@roeck-us.net>
	<CAFEAcA8+ZxcRLBgonZaqpAfumKFvhk7yDhX=Fe0KjoeTxWsczg@mail.gmail.com>
	<20180702170522.GA9885@roeck-us.net>
	<CAFEAcA97xX72WabGwn7GAQJxMcpzYzyV9yDBg1qF0zLuSDZwSA@mail.gmail.com>
	<20180702175740.GA14904@roeck-us.net>
	<CAFEAcA8noUOGt_9LpfRTRX52n4Z66XzudYFfW=180c92vzPH-g@mail.gmail.com>
	<20180702183717.GA22482@roeck-us.net>
	<CAFEAcA_p8vOs_1_4sAf1SvvPb44z885doU0821eh=-e0K5B3_A@mail.gmail.com>
	<20180703184922.GA14422@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 21:08:13 +0100
Message-ID: <CAFEAcA9pa7YTLnHYD0c7GvkkmiwD+Yyk9qr6G_EC2JeWdMB26Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-timer: Correctly
 identify and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2018 at 19:49, Guenter Roeck <linux@roeck-us.net> wrote:
> Oddly enough, I now seem to be unable to reproduce the problem either.
> Weird, when I wrote the patch it was absolutely necessary.
>
> The only other change I can think of would be the code to set the
> serial baud rate in the boot loader, which I did not have initially.
> Is it possible that the hangup could have been caused by that ?

Seems unlikely -- unless you're actually connecting the emulated
serial port to a real host serial port, we don't do anything with
the baudrate in the cmsdk uart model except complain if the
guest hasn't set it to something valid.

> Is it worth tracking it down, or are we ok ?

It does worry me a little, but if neither you nor I can repro
it at the moment there's not a lot we can do about it I think.
Looking at the ptimer and cmsdk timer code I think it *should*
now implement what the hardware does...

If you see the problem again in future let me know and we
can have another go at figuring out what's going on.

> The series WFM as well. I'll send out a Tested-by: in a minute.

Thanks for the testing.

-- PMM

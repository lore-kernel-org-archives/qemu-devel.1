Received: from eggs.gnu.org ([2001:4830:134:3::10]:40058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etwtC-0005kZ-3a
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etwtB-0001W1-9n
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:51:26 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etwtB-0001Vo-4e
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:51:25 -0500
Received: by mail-ot0-x241.google.com with SMTP id 95so5614706ote.5
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 06:51:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1cb9cc42-c7c9-5124-a615-27914d23b05c@roeck-us.net>
References: <1520444223-8389-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA8iFYGhzmLm6pyZi6tg=Di1P=vi_Enyw_ia1M34B3t8aw@mail.gmail.com>
	<1cb9cc42-c7c9-5124-a615-27914d23b05c@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 14:51:04 +0000
Message-ID: <CAFEAcA-+J7MUSssjPZ5BTNzGx_4h0YANdCegGfWNzYmoNatcqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fsl-imx6: Swap Ethernet interrupt defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Jason Wang <jasowang@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Bill Paul <wpaul@windriver.com>

On 8 March 2018 at 14:47, Guenter Roeck <linux@roeck-us.net> wrote:
> On 03/08/2018 02:50 AM, Peter Maydell wrote:
>> So do the works-by-accident kernels fail on QEMU because
>> we don't emulate some bit of the ethernet device ?
>> Ideally we could fix that so we could boot newer kernels
>> without breaking the old ones...

>
> I don't know if a fix working for all versions of Linux is even possible.
> Creating both interrupts might be an option, but would likely cause
> other problems since some versions of Linux would handle the same
> interrupt twice, while others expect the second interrupt
> to be associated with the timer.

Did the older Linux kernels work on the real hardware? (I
would guess so, but sometimes these things only get tested
on emulation...) If so, then in theory "make QEMU work like
the hardware" should allow all the kernels to work on QEMU.

thanks
-- PMM

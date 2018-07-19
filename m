Received: from eggs.gnu.org ([2001:4830:134:3::10]:38432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fg6Ki-0004WB-Gu
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 06:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fg6Kh-0007mk-I4
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 06:38:52 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fg6Kh-0007mM-CC
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 06:38:51 -0400
Received: by mail-oi0-x242.google.com with SMTP id n84-v6so14601212oib.9
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 03:38:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531779837-20557-1-git-send-email-linux@roeck-us.net>
References: <1531779837-20557-1-git-send-email-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 11:38:30 +0100
Message-ID: <CAFEAcA9dtWypzcQK-5Sw1=Fz_MCu8VOTzJgmd+cXCTuJW7fJDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/sd/bcm2835_sdhost: Fix PIO mode writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16 July 2018 at 23:23, Guenter Roeck <linux@roeck-us.net> wrote:
> Writes in PIO mode have two requirements:
>
> - A data interrupt must be generated after a write command has been
>   issued to indicate that the chip is ready to receive data.
> - A block interrupt must be generated after each block to indicate
>   that the chip is ready to receive the next data block.
>
> Rearrange the code to make this happen. Tested on raspi3 (in PIO mode)
> and raspi2 (in DMA mode).
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

As you say, all still a bit guesswork, but this doesn't break
my previously-working raspi3 kernel and it looks plausible
(especially the separation of "is_read" and "is_write" rather
than assuming everything not a read is a write). Applied
to target-arm.next for the next 3.0 rc.

thanks
-- PMM

Received: from eggs.gnu.org ([209.51.188.92]:43894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1gzMQV-0008WA-Fd
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1gzMQU-0002Qj-IC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:12:43 -0500
MIME-Version: 1.0
In-Reply-To: <BN6PR21MB0785CB5DAEB34BB0F1C465E09E740@BN6PR21MB0785.namprd21.prod.outlook.com>
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9G73yrRvj3AdyxAi2uUBH9GPPerwi7y38oMDKw8F0B=A@mail.gmail.com>
	<CADYoBw2pm=j8QejJyC17MNye==gcyM1TgG=jN+0nGjgYJ0qkFQ@mail.gmail.com>
	<BN6PR21MB0785CB5DAEB34BB0F1C465E09E740@BN6PR21MB0785.namprd21.prod.outlook.com>
From: bzt <bztemail@gmail.com>
Date: Thu, 28 Feb 2019 15:12:37 +0100
Message-ID: <CADYoBw2C0roYiv4nLrYPJuO43atL+s=7X+6jOwZoE9KpYdJhAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Added periodic IRQ support for
 bcm2836_control local timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Andrew,

That's great news, I'll then bring those drivers up to the modern qemu API!

Maybe that's a Linux kernel module configuration issue as well, but
with the BCM System Timer small delays depend on polling the counter.
Without the qemu support that counter register remains zero, causing
an endless loop. TBH it was years ago when I last checked raspbian,
but I know for sure that many bare metal applications and libraries
(like https://github.com/rsta2/circle) fails to boot because of this,
and the community is very excited to have the BCM ST emulation in
qemu. The PM thing is mostly for me, I'd like to reboot and shut down
the vm gracefully from the guest without the semihosting hack :-)

Thank you again, I'll get to work!

Best wishes,
bzt


On 2/27/19, Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:
>> From: bzt <bztemail@gmail.com>
>> Sent: Wednesday, 27 February 2019 03:54
>>
>> I'd like to add more drivers for the bcm283[567] too, and this question
>> goes to
>> Andrew Baumann mostly. I've seen implemented those missing drivers in his
>> repo, which aren't in the qemu mainline yet. I don't want to reinvent the
>> wheel,
>> so I'm willing to fix those classes to get them right, but I'd like to
>> know what's
>> wrong with them in the first place.
>
> Nothing's wrong with them per se, but when I was working on upstreaming the
> raspi board I prioritised the device support needed to boot Linux and
> Windows on raspi2. The remaining devices were always planned for eventual
> inclusion, but just fell off the end of my TODO list. They never went
> through code review on qemu-devel, so would probably need some work to bring
> them up to modern qemu APIs and standards.
>
>> I'm interested in fixing the
>> TYPE_BCM2835_POWER and TYPE_BCM2835_ST drivers, which I know many
>> hoppy OS developers lack and would improve the raspi emulation experience
>> remarkably.
>
> Sounds good to me!
>
>> It would be still a long way to boot a raspbian image, but still, a
>> small step towards that goal at least.
>
> That's interesting. Raspbian did seem to be working (on pi2) when I last
> worked on this. Perhaps it now depends on these devices, but didn't before?
>
> Cheers,
> Andrew
>

Received: from eggs.gnu.org ([209.51.188.92]:51072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1gyzUp-00053S-Gf
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1gyzIx-0003x5-3i
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:31:25 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9G73yrRvj3AdyxAi2uUBH9GPPerwi7y38oMDKw8F0B=A@mail.gmail.com>
References: <CADYoBw1HTzqTjfyDgDbP042AH1EkS1DD7Sf4um8eO7d22t4CDA@mail.gmail.com>
	<CAFEAcA9G73yrRvj3AdyxAi2uUBH9GPPerwi7y38oMDKw8F0B=A@mail.gmail.com>
From: bzt <bztemail@gmail.com>
Date: Wed, 27 Feb 2019 12:54:26 +0100
Message-ID: <CADYoBw2pm=j8QejJyC17MNye==gcyM1TgG=jN+0nGjgYJ0qkFQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

Thank you very much! Let me know if I need to modify anything! Btw you
should update the maintainer's list, currently it does not list you as
a reviewer :-)

I'd like to add more drivers for the bcm283[567] too, and this
question goes to Andrew Baumann mostly. I've seen implemented those
missing drivers in his repo, which aren't in the qemu mainline yet. I
don't want to reinvent the wheel, so I'm willing to fix those classes
to get them right, but I'd like to know what's wrong with them in the
first place. I'm interested in fixing the TYPE_BCM2835_POWER and
TYPE_BCM2835_ST drivers, which I know many hoppy OS developers lack
and would improve the raspi emulation experience remarkably. It would
be still a long way to boot a raspbian image, but still, a small step
towards that goal at least.

Thanks,
bzt

On 2/26/19, Peter Maydell <peter.maydell@linaro.org> wrote:
> On Tue, 26 Feb 2019 at 11:38, bzt <bztemail@gmail.com> wrote:
>>
>> Dear qemu developers,
>>
>> Honestly SubmitAPatch is a bit complicated for me, so I'm hoping I've
>> done everything right. To be sure, you can find my patch here:
>> https://github.com/bztsrc/qemu-local-timer and diff against the latest
>> github repo here:
>> https://github.com/bztsrc/qemu-local-timer/blob/patches/3.1.50.diff
>
> Thanks for the patch. You've got the most important things
> right -- patch sent as an email, and with a Signed-off-by:
> line from you. I've put this on my to-review queue, and I
> should be able to get to it within a week or so.
>
> thanks
> -- PMM
>

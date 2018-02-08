Received: from eggs.gnu.org ([2001:4830:134:3::10]:50058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ejpt8-0002Nx-Gt
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ejpt7-0006Kq-HE
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:21:34 -0500
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:46874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ejpt7-0006KP-8k
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:21:33 -0500
Received: by mail-lf0-x22f.google.com with SMTP id q194so7443256lfe.13
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 09:21:33 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <CAFEAcA8Fo5gVsjVB5PdU6sKWZAZ2ZscUzEhiDMwZY-LiDGtqOA@mail.gmail.com>
References: <cover.1516746211.git.alistair.francis@xilinx.com>
	<29c39a6f9ce3734bf693581348ed78f4bff3e0ef.1516746211.git.alistair.francis@xilinx.com>
	<CAFEAcA-eOMvYYv--wjs+i1wGG3AN1VueqZjtnE5vpBH=UavkfQ@mail.gmail.com>
	<CAKmqyKPAmzwFkY5MAiPA-epY-HCbBfBpHGWdanvEef2keaSXew@mail.gmail.com>
	<CAFEAcA8Fo5gVsjVB5PdU6sKWZAZ2ZscUzEhiDMwZY-LiDGtqOA@mail.gmail.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 8 Feb 2018 09:21:01 -0800
Message-ID: <CAKmqyKM7bO2dwPVkUSz5Mc=CrBWvFFAYY1vD4Q4bMht4=dVoww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/3] xlnx-zynqmp-rtc: Add basic time
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Thu, Feb 8, 2018 at 7:42 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 26 January 2018 at 01:09, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> On Thu, Jan 25, 2018 at 3:36 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> I'm still not sure about having the current_tm struct fields
>>> here rather than whatever the hardware's natural representation
>>> of the current time is. Can you explain why you think this
>>> is the best approach?
>>
>> This means that the only thing we have to track is the time that the
>> user set, either through the QEMU command line arguments as an
>> override or the original starting time. Then from there we can always
>> calculate the correct offset based on our current time.
>>
>> I don't see a nicer way, otherwise we need to recalculate the natural
>> representation before and after migration using something more
>> complex. This way it's always the same logic, we just run it at init
>> and after migration.
>
> Doing it this way round means that it gets complicated when the
> guest writes to the RTC, though. At the moment I can't see anywhere
> that sets the current_tm fields except for reset and post-migration.
> Isn't something missing here? I'm wondering if this choice of
> migration state is going to paint us into a corner for handling
> guest-writes-to-rtc.

I don't have guest write support. The main focus was just allowing
users to set the time when they boot QEMU. We haven't seen any request
to allow guests to set the time, so I didn't bother.

Wouldn't adding guest write support just be as simple as converting
the value written to a current_tm field?

Alistair

>
> thanks
> -- PMM
>

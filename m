Received: from eggs.gnu.org ([2001:4830:134:3::10]:38685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ajaygargnsit@gmail.com>) id 1f5b8A-0000nF-Fk
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 14:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ajaygargnsit@gmail.com>) id 1f5b89-0002S3-RC
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 14:03:02 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WOvTLnyOTWdO-PhoXsOWkUbayutxLr0jthowOfNgaVw@mail.gmail.com>
References: <CAHP4M8VVWyNqi4yLS3S0GXaDz3j8QvUiC=aoJ_DfZLtZBaFwqg@mail.gmail.com>
	<CAFEAcA9stTjg3Wpq5x_vj63jm1DrxAQREk4XPeFWb5rff-Uofg@mail.gmail.com>
	<CAHP4M8X-Dus1Z8UegDTaab5LvaiDAgQa8upsx_KdnPO+A-XoTQ@mail.gmail.com>
	<CAFEAcA_1X1AQ6j9pZQ8fEHmQCxRNK7EhGkohuLbTMpoPONe5PA@mail.gmail.com>
	<CAHP4M8WUd9QKTCETaKNa+VQ6hMLcND8dfdDAZ3QutieDaE1WKQ@mail.gmail.com>
	<CAFEAcA_WOvTLnyOTWdO-PhoXsOWkUbayutxLr0jthowOfNgaVw@mail.gmail.com>
From: Ajay Garg <ajaygargnsit@gmail.com>
Date: Mon, 9 Apr 2018 23:32:57 +0530
Message-ID: <CAHP4M8WLXqvCVGxVyaTiCQbwcJVXEPCnRL1DTzzNZq1Cbu0v1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] Use of -machine when running via
 qemu-system-arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Thanks a ton Peter, that cleared things up a great deal !!!
Thanks again for the quick help !!


Thanks and Regards,
Ajay

On Mon, Apr 9, 2018 at 11:17 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 April 2018 at 18:41, Ajay Garg <ajaygargnsit@gmail.com> wrote:
>> Hi Peter.
>>
>> The link is pretty good, just that I am a complete noob.
>>
>> Maybe a more concrete example on the following, clearly specifying why
>> things work on x86 without the need of -machine flag, will make things
>> crystal clear :
>>
>> Because ARM systems differ so much and in fundamental ways, typically
>> operating system or firmware images intended to run on one machine
>> will not run at all on any other. This is often surprising for new
>> users who are used to the x86 world where every system looks like a
>> standard PC. (Once the kernel has booted, most userspace software
>> cares much less about the detail of the hardware.)
>
> For instance, on x86 you can always find the UART for serial
> output at IO port 0x3f8, and it's always an 8250 or compatible.
> On Arm, the memory address where the UART is will be likely
> different for every board. And once you know the address of the
> UART, each SoC likely may well have its own implementation,
> which has different registers that do different things.
> And there's no way to probe for what's there -- you have to
> know in advance. So you can't even usefully print bootup
> messages without knowing what you're running on.
>
> thanks
> -- PMM

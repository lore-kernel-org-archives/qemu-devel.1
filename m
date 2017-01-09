Received: from eggs.gnu.org ([2001:4830:134:3::10]:45815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cQiQE-0002fg-8j
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cQiQ9-00043k-AW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:28:10 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cQiQ9-00043a-3p
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:28:05 -0500
References: <20170104220624.26557-1-jcd@tribudubois.net>
	<CAFEAcA8dwhoSZTWS9JJ6-vSUs1Asw8ymktmD+oOqx0DNpCV2XQ@mail.gmail.com>
	<1be7123c-acee-7d16-8a10-c8965d5805ff@gmail.com>
	<CAFEAcA9cUEGL=rSrq2cstParBYHMWdkDy_acu7mTW754+G_Y6Q@mail.gmail.com>
	<fb9b6b0a-62b5-2421-2826-d3f853b5d5b3@tribudubois.net>
	<f6ddf63f-78b8-935b-9075-838a0ca0aa7d@tribudubois.net>
	<CAFEAcA_3saBFbSX+e7P9X9n1wXV2=FjCMXML31MDq2xf+HdJmQ@mail.gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <f3c873b5-1ccb-0cd4-e9fd-2f41fbdf0cca@tribudubois.net>
Date: Mon, 9 Jan 2017 23:27:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3saBFbSX+e7P9X9n1wXV2=FjCMXML31MDq2xf+HdJmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] [i.MX] fix CS handling during SPI
 access.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "mar.krzeminski" <mar.krzeminski@gmail.com>

Le 09/01/2017 à 22:45, Peter Maydell a écrit :
> On 9 January 2017 at 21:19, Jean-Christophe DUBOIS <jcd@tribudubois.net> wrote:
>> Hum, ... I think I have a problem.
>>
>> With the default register value (that I get a reset) the CS line is
>> deselected when the CS is high.
>>
>> So at reset I would need to set my 4 CS lines to high in order to be able to
>> drive them low later.
>>
>> So during the "reset" I need to set my 4 CS line to 1 but according to you
>> feedback I should not do it with qemu_set_irq()...
>>
>> Is there another way than qemu_set_irq() to do set my lines to high level ?
> "Line should be asserted at device reset" is an awkward case
> that we can't really handle cleanly at the moment,
> unfortunately. Assuming that the device at the other end
> comes out of reset as "not selected" it should still work,
> though -- there is no state stored in a qemu_set_irq(),
> so if both ends believe that the reset state of the line
> is 1 then there's no need to call qemu_set_irq().

I might be wrong but I think they are coming out of reset with their CS 
line set to low (so they are selected by default) because this is the 
default level at reset.

If I have 4 devices on the same SPI bus/controller (attached to 
different CS line) they would all be selected by default I think.

JC

>
> thanks
> -- PMM
>
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cRNvo-0003PT-1B
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cRNvk-0006cR-Tb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:47:32 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cRNvk-0006bX-KN
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 13:47:28 -0500
References: <20170104220624.26557-1-jcd@tribudubois.net>
	<CAFEAcA8dwhoSZTWS9JJ6-vSUs1Asw8ymktmD+oOqx0DNpCV2XQ@mail.gmail.com>
	<1be7123c-acee-7d16-8a10-c8965d5805ff@gmail.com>
	<CAFEAcA9cUEGL=rSrq2cstParBYHMWdkDy_acu7mTW754+G_Y6Q@mail.gmail.com>
	<fb9b6b0a-62b5-2421-2826-d3f853b5d5b3@tribudubois.net>
	<f6ddf63f-78b8-935b-9075-838a0ca0aa7d@tribudubois.net>
	<CAFEAcA_3saBFbSX+e7P9X9n1wXV2=FjCMXML31MDq2xf+HdJmQ@mail.gmail.com>
	<f3c873b5-1ccb-0cd4-e9fd-2f41fbdf0cca@tribudubois.net>
	<CAFEAcA-v8RJNLSjT4ALoBNUhZQSxHPupd5rg6t44ui5h4h8BuA@mail.gmail.com>
	<1d0d2afc-8b59-17a7-be5d-7f9113d9d57f@tribudubois.net>
	<5ef5d8cd-169f-a54d-69b4-caa572892ef5@gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <cbd3fee7-31fd-f5b2-a64b-84e7d3b6e00f@tribudubois.net>
Date: Wed, 11 Jan 2017 19:47:24 +0100
MIME-Version: 1.0
In-Reply-To: <5ef5d8cd-169f-a54d-69b4-caa572892ef5@gmail.com>
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
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Le 11/01/2017 à 19:08, mar.krzeminski a écrit :
> W dniu 11.01.2017 o 17:12, Jean-Christophe DUBOIS pisze:
>> Le 10/01/2017 à 00:02, Peter Maydell a écrit :
>>> On 9 January 2017 at 22:27, Jean-Christophe DUBOIS 
>>> <jcd@tribudubois.net> wrote:
>>>> I might be wrong but I think they are coming out of reset with
>>>> their CS line set to low (so they are selected by default)
>>>> because this is the default level at reset.
>>> If that's true then you're in difficulties, because
>>> there's no guarantee about device reset order. So
>>> even if your SPI controller calls qemu_set_irq in
>>> its reset function, if the devices on the other
>>> end happen to have their reset called after the
>>> controller then they'll still reset into selected...
> I think the simplest solution in this case is to go back what you had 
> before:
> set each CS line state at the beginning of each new transfer - then at 
> first transfer
> you will properly set all CS line before transfer begin. After 
> transfer end just negate
> active CS line.

OK, let's do this then ...

JC

>
>> How does it work for platforms that would have pull-up resistors on 
>> some signals? Is it something we cannot model in QEMU?
>>
>> On a related note, it seems quite a few SPI controller emulator are 
>> actually calling qemu_set_irq() in their reset handler.
> I also have the same problem.
>
> Thanks,
> Marcin
>>
>> JC
>>
>>>
>>> thanks
>>> -- PMM
>>>
>>
>>
>

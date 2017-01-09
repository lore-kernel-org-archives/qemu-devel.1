Received: from eggs.gnu.org ([2001:4830:134:3::10]:52509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQfHk-0007Od-5w
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:07:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQfHj-0003xl-Ay
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:07:12 -0500
Received: from mail-vk0-x22b.google.com ([2607:f8b0:400c:c05::22b]:35725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQfHj-0003xQ-50
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 14:07:11 -0500
Received: by mail-vk0-x22b.google.com with SMTP id x75so22360530vke.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 11:07:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1be7123c-acee-7d16-8a10-c8965d5805ff@gmail.com>
References: <20170104220624.26557-1-jcd@tribudubois.net>
	<CAFEAcA8dwhoSZTWS9JJ6-vSUs1Asw8ymktmD+oOqx0DNpCV2XQ@mail.gmail.com>
	<1be7123c-acee-7d16-8a10-c8965d5805ff@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 19:06:50 +0000
Message-ID: <CAFEAcA9cUEGL=rSrq2cstParBYHMWdkDy_acu7mTW754+G_Y6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: "mar.krzeminski" <mar.krzeminski@gmail.com>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, QEMU Developers <qemu-devel@nongnu.org>

On 9 January 2017 at 19:04, mar.krzeminski <mar.krzeminski@gmail.com> wrote:
>
>
> W dniu 09.01.2017 o 11:46, Peter Maydell pisze:
>> Calling qemu_set_irq() in a device reset function is a bit
>> tricky, because in a full system reset the device at the other
>> end might have already reset or might not, and calling into
>> its handler function for the irq line change might provoke
>> an unwanted change of its state. We don't really have a coherent
>> model here but for the moment we just try to avoid calling
>> set_irq in a reset method.
>
> JC, if you remove qemu_set_irq() call from reset, at least m25p80 behavior
> should not change since m25p80 reset handler will reset it's whole internal
> state.

I noticed the reset function is also called from within the
register emulation too, so it's maybe not quite that simple...

thanks
-- PMM

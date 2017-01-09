Received: from eggs.gnu.org ([2001:4830:134:3::10]:36360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQhku-00049r-RM
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQhku-0003Eb-49
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:45:28 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:33635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQhku-0003EU-04
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:45:28 -0500
Received: by mail-ua0-x236.google.com with SMTP id i68so369240830uad.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 13:45:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f6ddf63f-78b8-935b-9075-838a0ca0aa7d@tribudubois.net>
References: <20170104220624.26557-1-jcd@tribudubois.net>
	<CAFEAcA8dwhoSZTWS9JJ6-vSUs1Asw8ymktmD+oOqx0DNpCV2XQ@mail.gmail.com>
	<1be7123c-acee-7d16-8a10-c8965d5805ff@gmail.com>
	<CAFEAcA9cUEGL=rSrq2cstParBYHMWdkDy_acu7mTW754+G_Y6Q@mail.gmail.com>
	<fb9b6b0a-62b5-2421-2826-d3f853b5d5b3@tribudubois.net>
	<f6ddf63f-78b8-935b-9075-838a0ca0aa7d@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 21:45:06 +0000
Message-ID: <CAFEAcA_3saBFbSX+e7P9X9n1wXV2=FjCMXML31MDq2xf+HdJmQ@mail.gmail.com>
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
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Cc: "mar.krzeminski" <mar.krzeminski@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 9 January 2017 at 21:19, Jean-Christophe DUBOIS <jcd@tribudubois.net> wrote:
> Hum, ... I think I have a problem.
>
> With the default register value (that I get a reset) the CS line is
> deselected when the CS is high.
>
> So at reset I would need to set my 4 CS lines to high in order to be able to
> drive them low later.
>
> So during the "reset" I need to set my 4 CS line to 1 but according to you
> feedback I should not do it with qemu_set_irq()...
>
> Is there another way than qemu_set_irq() to do set my lines to high level ?

"Line should be asserted at device reset" is an awkward case
that we can't really handle cleanly at the moment,
unfortunately. Assuming that the device at the other end
comes out of reset as "not selected" it should still work,
though -- there is no state stored in a qemu_set_irq(),
so if both ends believe that the reset state of the line
is 1 then there's no need to call qemu_set_irq().

thanks
-- PMM

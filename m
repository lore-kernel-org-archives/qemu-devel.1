Received: from eggs.gnu.org ([2001:4830:134:3::10]:52584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQiy2-00085v-4I
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 18:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQiy1-00077O-9R
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 18:03:06 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:34800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQiy1-00077F-58
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 18:03:05 -0500
Received: by mail-ua0-x22a.google.com with SMTP id 35so40802824uak.1
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 15:03:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f3c873b5-1ccb-0cd4-e9fd-2f41fbdf0cca@tribudubois.net>
References: <20170104220624.26557-1-jcd@tribudubois.net>
	<CAFEAcA8dwhoSZTWS9JJ6-vSUs1Asw8ymktmD+oOqx0DNpCV2XQ@mail.gmail.com>
	<1be7123c-acee-7d16-8a10-c8965d5805ff@gmail.com>
	<CAFEAcA9cUEGL=rSrq2cstParBYHMWdkDy_acu7mTW754+G_Y6Q@mail.gmail.com>
	<fb9b6b0a-62b5-2421-2826-d3f853b5d5b3@tribudubois.net>
	<f6ddf63f-78b8-935b-9075-838a0ca0aa7d@tribudubois.net>
	<CAFEAcA_3saBFbSX+e7P9X9n1wXV2=FjCMXML31MDq2xf+HdJmQ@mail.gmail.com>
	<f3c873b5-1ccb-0cd4-e9fd-2f41fbdf0cca@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 23:02:43 +0000
Message-ID: <CAFEAcA-v8RJNLSjT4ALoBNUhZQSxHPupd5rg6t44ui5h4h8BuA@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, "mar.krzeminski" <mar.krzeminski@gmail.com>

On 9 January 2017 at 22:27, Jean-Christophe DUBOIS <jcd@tribudubois.net> wrote:
> I might be wrong but I think they are coming out of reset with
> their CS line set to low (so they are selected by default)
> because this is the default level at reset.

If that's true then you're in difficulties, because
there's no guarantee about device reset order. So
even if your SPI controller calls qemu_set_irq in
its reset function, if the devices on the other
end happen to have their reset called after the
controller then they'll still reset into selected...

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPABu-0005wi-8c
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPABt-0001By-5d
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:42:58 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:32899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPABs-0001Bl-Vs
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 10:42:57 -0500
Received: by mail-vk0-x230.google.com with SMTP id 137so302312809vkl.0
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 07:42:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482269164-14642-1-git-send-email-minyard@acm.org>
References: <CAFEAcA84Ab393fUB=UKDqtJYpZhHUEsZp6wEV3PpdjqCAfvuew@mail.gmail.com>
	<1482269164-14642-1-git-send-email-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 15:42:35 +0000
Message-ID: <CAFEAcA_dYWidb9Td=1Of76pK+jieYxCSSze3o5GCFgfzcyZg6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] i2c: Allow I2C devices to NAK start events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: Alastair D'Silva <alastair@au1.ibm.com>, Fabio Urquiza <flus@cesar.org.br>, QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>

On 20 December 2016 at 21:26,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Add a return value to the event handler.  Some I2C devices will
> NAK if they have no data, so allow them to do this.  This required
> the following changes:
>
> Go through all the event handlers and change them to return int
> and return 0.
>
> Modify i2c_start_transfer to terminate the transaction on a NAK.
>
> Modify smbus handing to not assert if a NAK occurs on a second
> operation, and terminate the transaction and return -1 instead.
>
> Add some information on semantics to I2CSlaveClass.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Thanks; added to target-arm.next.

-- PMM

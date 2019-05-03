Received: from eggs.gnu.org ([209.51.188.92]:34610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYMS-0003f6-RB
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYMS-0004lu-0s
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:36:24 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYMR-0004l3-Sq
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:36:23 -0400
Received: by mail-oi1-x241.google.com with SMTP id v10so4441806oib.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190430044036.1144-1-joel@jms.id.au>
In-Reply-To: <20190430044036.1144-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:36:11 +0100
Message-ID: <CAFEAcA9qyzHiEY-OudwBUDzCia-jSQ7CkY_L7oC0t4Nu_665uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] arm: aspeed: Add RTC Model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 30 Apr 2019 at 05:40, Joel Stanley <joel@jms.id.au> wrote:
>
> v3: Add some commit messages, resend as v2 didn't send properly
> v2: Minor fixes, added vmstate and reset, and rebased on C=C3=A9dric's se=
ries
>
> Based-on: 20190411161013.4514-4-clg@kaod.org
> [PATCH 3/3] aspeed: use sysbus_init_child_obj() to initialize children
>
> A model for the ASPEED BMC real time clock (RTC). The model is sufficient
> for running the guest Linux kernel driver, and ticks in time with the
> host when programmed.
>
> It does not implement the alarm functionality, which includes the
> interrupt.

Hi -- I've reviewed this series, but can't apply it yet as
it's based on Cedric's patchset which needs a respin. If
I forget to apply this when I apply the respin of that one,
please ping me...

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa1yg-0006ee-4Z
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa1yf-0002sS-Bn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:47:02 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fa1yf-0002s0-4i
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:47:01 -0400
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so17586481oie.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:47:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702162733.GB32333@roeck-us.net>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
	<20180626175900.GA4307@roeck-us.net>
	<CAFEAcA8PPF1mDWMGSm0r6NtYijwQQG7QnNEJ3iwaaEZU8GTu7g@mail.gmail.com>
	<20180626200008.GA680@roeck-us.net>
	<CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
	<20180702162733.GB32333@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 17:46:39 +0100
Message-ID: <CAFEAcA8+ZxcRLBgonZaqpAfumKFvhk7yDhX=Fe0KjoeTxWsczg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-timer: Correctly
 identify and set one-shot mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 July 2018 at 17:27, Guenter Roeck <linux@roeck-us.net> wrote:
> Again, in my observation the boot sometimes stalls without my
> patch. Maybe there is a better fix, but the code as-is doesn't
> work for me. All I can say is that the current code does not set
> one-shot mode when it should, and that seems wrong.
>
> You could of course take out the zero delta warning. Personally
> I would caution against that - whenever I have seen that warning,
> it suggested that something is wrong with the emulation, and it
> helped me track down the problem. Your call, of course. Also,
> I don't think taking out the warning would fix my stall problem.

Can you provide me with something I can reproduce with, then,
please? My kernel + buildroot don't repro the problem: it always
seems to boot fine. I had a look at your testbuild git repo
but couldn't manage to figure out how to build a binary
from it. I'm ok with building a QEMU from your branch for
testing this, but I'd rather not try to figure out how to
reproduce your kernel and root filesystem setup.

thanks
-- PMM

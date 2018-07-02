Received: from eggs.gnu.org ([2001:4830:134:3::10]:41207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa3Dk-0005FX-8j
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fa3Dj-0006qa-C3
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:06:40 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fa3Dj-0006q1-3Q
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 14:06:39 -0400
Received: by mail-oi0-x244.google.com with SMTP id 13-v6so5644116ois.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 11:06:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180702175740.GA14904@roeck-us.net>
References: <1529374119-27015-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA_8TAWdkgTzPPE7eggP4UAHjVPmcXiEa_-RCxDBphJ4HA@mail.gmail.com>
	<20180626175900.GA4307@roeck-us.net>
	<CAFEAcA8PPF1mDWMGSm0r6NtYijwQQG7QnNEJ3iwaaEZU8GTu7g@mail.gmail.com>
	<20180626200008.GA680@roeck-us.net>
	<CAFEAcA_non89OR_-W3Fhr6gG0v0kkgg-ffJx-9K_h=U-Hz_wbg@mail.gmail.com>
	<20180702162733.GB32333@roeck-us.net>
	<CAFEAcA8+ZxcRLBgonZaqpAfumKFvhk7yDhX=Fe0KjoeTxWsczg@mail.gmail.com>
	<20180702170522.GA9885@roeck-us.net>
	<CAFEAcA97xX72WabGwn7GAQJxMcpzYzyV9yDBg1qF0zLuSDZwSA@mail.gmail.com>
	<20180702175740.GA14904@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 19:06:17 +0100
Message-ID: <CAFEAcA8noUOGt_9LpfRTRX52n4Z66XzudYFfW=180c92vzPH-g@mail.gmail.com>
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

On 2 July 2018 at 18:57, Guenter Roeck <linux@roeck-us.net> wrote:
> On Mon, Jul 02, 2018 at 06:10:36PM +0100, Peter Maydell wrote:
>> On 2 July 2018 at 18:05, Guenter Roeck <linux@roeck-us.net> wrote:
>> > I don't think I'll have more time available to spend on this
>> > anytime soon. If it works for you, just drop the patch. I can
>> > keep it local in my branch. My version of qemu is different anyway,
>> > after all.
>>
>> I'd kind of like to fix the bug, though. I'd just like you
>> to provide the image you're testing with...
>>
>
> Ah, but that won't help. We are dealing with a heisenbug, and me using
> a different host than you (or even a different gcc version) may be
> sufficient to make the problem disappear on your system.

True, but we can at least rule out some differences between
your setup and mine. (For instance, your kernel config and
version and rootfs are all going to be different from what
I've been testing.)

> The mps2 images use high resolution timers, which is likely what is
> triggering here. My working assumption is that those timers trigger at
> the wrong time because the timer is set up in periodic instead of one-time
> mode. With that, behavior is more or less random. On some systems it will
> work, on some systems it won't. Since we can not agree that setting the
> timer in periodic mode instead of one-shot mode is a problem, I don't
> really see how we can proceed. I would somehow have to prove to you that
> there is an observable problem in the first place, well beyond of what
> I already did. That might take a lot of time - much more than I would
> be able to spend on it.

I certainly believe you that there's an observable problem.
I just disagree about your proposed fix, because I don't see
from the code why it would make any difference. So I want to
get to a point where I can run exactly the same thing you're
running on my system to have a look at what's happening.

thanks
-- PMM

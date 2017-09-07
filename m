Received: from eggs.gnu.org ([2001:4830:134:3::10]:53991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpzom-0004NB-IE
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpzoh-0007Z0-Pa
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:38:16 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:37754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpzoh-0007Yk-J1
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 12:38:11 -0400
Received: by mail-wr0-x22b.google.com with SMTP id k20so459123wre.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 09:38:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <59B17425.1050701@ispras.ru>
References: <59B17425.1050701@ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 17:37:49 +0100
Message-ID: <CAFEAcA-QP7J_Rjre_RmwuYFnBU84gPFXuH4efeSddwgXhgq5Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] emulation cycle number implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergey Smolov <smolov@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 September 2017 at 17:30, Sergey Smolov <smolov@ispras.ru> wrote:
> I'm running MIPS assembler programs on QEMU. I need to log some events that
> happen through emulation (writes to some registers, for example). When an
> event happens, I need to print not only the event-related information, but
> an "emulation cycle number" also. This number should be an integer
> increasing value that is similar to real hardware clock.
>
> How to implement this in QEMU? May QEMU timers be helpful in solving such a
> problem?

You can use cpu_get_ticks(), though if we're not in icount mode
you may find it doesn't behave quite as helpfully as you might like
(in that case it roughly tracks host hardware cycles.)

thanks
-- PMM

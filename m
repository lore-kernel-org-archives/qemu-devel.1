Received: from eggs.gnu.org ([209.51.188.92]:34269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggwbh-0006fv-Dl
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggwbc-0004FQ-UA
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:00:07 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggwbc-0003zI-Lr
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:00:04 -0500
Received: by mail-ot1-x343.google.com with SMTP id t5so4480086otk.1
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 10:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20180908182205.GB409@mornington.dcs.gla.ac.uk>
	<CAFEAcA83dVVyQLsADoNBN7feFxnWcVr5r0SPA8PffaG2140yPw@mail.gmail.com>
In-Reply-To: <CAFEAcA83dVVyQLsADoNBN7feFxnWcVr5r0SPA8PffaG2140yPw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 18:59:46 +0000
Message-ID: <CAFEAcA-CWxOufmf-UF8m=nH-kUXDym-yPr1y1VU5Dp_jQ71yrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: write(fd, NULL,
 0) parity with linux's treatment of same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Garnock-Jones <tony.garnock-jones@glasgow.ac.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-stable <qemu-stable@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On Thu, 3 Jan 2019 at 18:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> Hi; following up on this, we've just had
> https://bugs.launchpad.net/qemu/+bug/1810433 which is
> a report of the same NULL/0 bug for pwrite64. Looking at the
> kernel code I see that both the write and pwrite64 syscalls
> go through the same vfs_write() common function, so their
> behaviour for NULL/0 should be identical. Experimentally,
> stracing the 1810433 test program gives
>  pwrite64(3, NULL, 0, 0)                 = 0
> so we do indeed need to special case NULL/0 there as well
> as in write().
>
> The extra fix should be straightforward -- does anybody
> feel like writing up a patch for it?

I've just sent a patch:
https://patchwork.ozlabs.org/patch/1022092/

thanks
-- PMM

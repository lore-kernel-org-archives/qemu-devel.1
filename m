Received: from eggs.gnu.org ([2001:4830:134:3::10]:36299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPRgZ-0003nt-L0
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 05:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPRgY-0006Fv-IH
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 05:23:47 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:34055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPRgY-0006FB-EF
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 05:23:46 -0500
Received: by mail-ua0-x22b.google.com with SMTP id 34so362906348uac.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 02:23:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170105225210.GA5235@octofox.metropolis>
References: <20170105225210.GA5235@octofox.metropolis>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 10:23:25 +0000
Message-ID: <CAFEAcA-mQPT=pSNTfLqrvuBNX9QYggiMwyoHitV1c5LCVZv-2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-softmmu aborted with "Bad ram pointer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 January 2017 at 22:52, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hello,
>
> debugging XIP kernel running directly from CFI FLASH I've got to a point
> where QEMU aborts with the message "Bad ram pointer 0xbb4".
>
> It turns out that that happens when QEMU tries to translate code from FLASH
> immediately after the kernel has written to the FLASH address range:
> writing to FLASH address range turns off romd_mode of its memory region:

This sounds like
https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg03273.html

It's a bug that we fail with this unhelpful message and abort,
but the fix to the bug would only cause us to print the more
useful "can't execute from a device" instead. You can't
execute from a ROM that's not in ROMD mode, I'm afraid.

thanks
-- PMM

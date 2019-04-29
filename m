Received: from eggs.gnu.org ([209.51.188.92]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5s3-0003LZ-QL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5s2-00018h-KQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:58:59 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL5s1-00018J-VK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:58:58 -0400
Received: by mail-oi1-x244.google.com with SMTP id t81so8153681oig.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CAFEAcA8OVKO087uiNvwDGObiaxHAPYHwoXLEN1t5Y4v9B43r9A@mail.gmail.com>
	<20190429122819.GB7587@stefanha-x1.localdomain>
In-Reply-To: <20190429122819.GB7587@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:58:46 +0100
Message-ID: <CAFEAcA9_=a72BAmyb0eJhLF_nYLhRb_O7e=__MPazQ0nLC9Tmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, 29 Apr 2019 at 13:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Apr 26, 2019 at 12:45:37PM +0100, Peter Maydell wrote:
> I was going to add a function to check kernel_filename and the presence
> of -device loader.  Then each machine type init function would call the
> function with flags indicating which modes are allowed:
>
>   /* Allow both -kernel and -device loader */
>   check_kernel_loaded(KERNEL_CMDLINE | KERNEL_LOADER);
>
>   /* Allow only -kernel */
>   check_kernel_loaded(KERNEL_CMDLINE);
>
>   /* Allow only -device loader */
>   check_kernel_loaded(KERNEL_LOADER);

Every machine should permit -device loader: the point
of it is that it is entirely generic and works the same
way on every machine.

thanks
-- PMM

Received: from eggs.gnu.org ([209.51.188.92]:39713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEVnP-0003zE-Ca
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEVnO-0001Z6-3V
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:14:59 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:40046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEVnN-0001YH-97
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:14:58 -0400
Received: by mail-ot1-x32d.google.com with SMTP id t8so4585661otp.7
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <201904110044.38853.randrianasulu@gmail.com>
In-Reply-To: <201904110044.38853.randrianasulu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 10:14:45 +0100
Message-ID: <CAFEAcA9NN=wyVz5t+See_1dgvDM1xJ=_OPd1QWwiFMUASzoLaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc3 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 10 Apr 2019 at 22:51, Andrew Randrianasulu
<randrianasulu@gmail.com> wrote:
>
> Please also include this patch in next -rc or final, it fixes 32-bit compilation:
>
> https://patchew.org/QEMU/20190402073018.17747-1-kraxel%40redhat.com/
> ([Qemu-devel] [PATCH] curses: fix wchar_t printf warning)
>
> without it I get
>
> ui/curses.c: In function 'get_ucs':
> ui/curses.c:456:25: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'wchar_t {aka long int}' [-Werror=format=]
>          fprintf(stderr, "Could not convert 0x%02x from WCHAR_T to UCS-2: %s\n",
>

Rats, I'd forgotten about that one. What platform does it fail
to compile on, though? I test on 32-bit Linux and Windows compiles,
and they work OK.

Also, this will be only a warning, not a compile error, in the
release build, so we could get away with releasing without
the patch applied. We'll see if any other rc4 issues come up.

thanks
-- PMM

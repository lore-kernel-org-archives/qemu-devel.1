Received: from eggs.gnu.org ([209.51.188.92]:54726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXhk-0000yT-2P
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXhi-0002ds-TW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMXhi-0002d1-N9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:18 -0400
Received: by mail-oi1-x241.google.com with SMTP id t189so4237001oih.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
In-Reply-To: <4EAA64FC-AA22-4B01-8BC4-49DAC694963B@me.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 13:54:06 +0100
Message-ID: <CAFEAcA_BvMq08k5s+aFFXdsf_Hy88zH_C=riC_4R3nDJyMYKjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RESEND 0/2] ui/cocoa: Fix absolute and
 relative input issues on Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Zhang <tgfbeta@me.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Sun, 28 Apr 2019 at 04:30, Chen Zhang <tgfbeta@me.com> wrote:
>
> The following patches fixed absolute and relative input device issues on macOS Mojave.
>
> Chen Zhang (2):
>   ui/cocoa: Fix absolute input device grabbing issue on Mojave
>   ui/cocoa: Fix mouse grabbing in fullscreen mode for relative input
>     device
>
>  ui/cocoa.m | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)

Hi -- unfortunately your email client seems to have sent
these patches in a way that has confused our patch
handling systems (eg
https://patchwork.kernel.org/patch/10920623/ has
only half of the patch as actual patch, so it doesn't
apply properly, and the 'patches' program has been confused too.

Looking at the headers, your mail client is trying to send the
patches as multipart/alternative with a combined text and HTML
version. You could try configuring it to just send plain text,
which is definitely the preferred format for public mailing lists.
Or alternatively you could try using git-send-email instead.

thanks
-- PMM

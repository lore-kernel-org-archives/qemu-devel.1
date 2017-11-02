Received: from eggs.gnu.org ([2001:4830:134:3::10]:42611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAEqB-0008Dx-N9
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAEq6-0001gq-05
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:43:23 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:46757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAEq5-0001gZ-Oe
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:43:17 -0400
Received: by mail-wm0-x244.google.com with SMTP id m72so10854400wmc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 05:43:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005190449.15591-1-programmingkidx@gmail.com>
References: <20171005190449.15591-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 12:42:55 +0000
Message-ID: <CAFEAcA8Ac00n8ajF7FBojWs==_5+dfaaOYTG=R6w0-wfOutx2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: Fix console selection keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 October 2017 at 20:04, John Arbuckle <programmingkidx@gmail.com> wrote:
> Fix console selection keys so that the right console is selected.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 93e56d0518..2794f60b27 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -631,7 +631,7 @@ - (void) handleEvent:(NSEvent *)event
>
>                      // enable graphic console
>                      case Q_KEY_CODE_1 ... Q_KEY_CODE_9: // '1' to '9' keys
> -                        console_select(keycode - 11);
> +                        console_select(keycode - Q_KEY_CODE_1);
>                          break;
>                  }

Applied to master, thanks.

-- PMM

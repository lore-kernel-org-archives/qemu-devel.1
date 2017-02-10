Received: from eggs.gnu.org ([2001:4830:134:3::10]:50177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cc78h-0001S7-Jg
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cc78c-0001PX-Sk
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:05:11 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cc78c-0001P7-NL
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:05:06 -0500
Received: by mail-wm0-x236.google.com with SMTP id v186so104112897wmd.0
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 01:05:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170210061200.15373-1-vapier@gentoo.org>
References: <20170210061200.15373-1-vapier@gentoo.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 09:04:45 +0000
Message-ID: <CAFEAcA9rYHgR39tbmvJtQ+m01eok1QT7+K-Wpk_ykFDyqfFNNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] osdep.h: pull in sys/sysmacros.h for
 major/minor/makedev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Frysinger <vapier@gentoo.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 February 2017 at 06:12, Mike Frysinger <vapier@gentoo.org> wrote:
> Linux C libs are moving away from implicit header pollution with
> sys/types.h
>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  include/qemu/osdep.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 56c9e22405ec..6aaace6cf37f 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -85,6 +85,10 @@ extern int daemon(int, int);
>  #include <setjmp.h>
>  #include <signal.h>
>
> +#ifdef __linux__
> +#include <sys/sysmacros.h>
> +#endif
> +
>  #ifdef __OpenBSD__
>  #include <sys/signal.h>
>  #endif

I think there's already a patch on list for this that
does this (with a proper configure test).

I still think that it's a shame that glibc is breaking
compatibility with where these macros have always been
kept on every OS that's implemented them back to 2BSD...

thanks
-- PMM

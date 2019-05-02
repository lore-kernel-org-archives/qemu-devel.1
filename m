Received: from eggs.gnu.org ([209.51.188.92]:40954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1hM8jk-00075e-4p
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1hM8jj-0005vx-Bh
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:14:44 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:52029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1hM8jj-0005uf-4U
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:14:43 -0400
Received: by mail-it1-x141.google.com with SMTP id s3so2347565itk.1
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 03:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190502092728.32727-1-alex.bennee@linaro.org>
In-Reply-To: <20190502092728.32727-1-alex.bennee@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 2 May 2019 12:14:27 +0200
Message-ID: <CABoDooPLQAGi+gtYX+jPaZk9=OgGOLwpJdwfJML-aKMiHu3Azw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix GPROF build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Hello,

On Thu, May 2, 2019 at 11:31 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> When linux-user/exit was introduced we failed to move the gprof
> include at the same time. The CI didn't notice because it only builds
> system emulation. Fix it for those that still find gprof useful.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>  linux-user/exit.c    | 3 +++
>  linux-user/syscall.c | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index 14e94e28fa..bdda720553 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -18,6 +18,9 @@
>   */
>  #include "qemu/osdep.h"
>  #include "qemu.h"
> +#ifdef TARGET_GPROF
> +#include <sys/gmon.h>
> +#endif
>
>  #ifdef CONFIG_GCOV
>  extern void __gcov_dump(void);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 96cd4bf86d..f2d9883aef 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -59,9 +59,6 @@
>  #ifdef CONFIG_TIMERFD
>  #include <sys/timerfd.h>
>  #endif
> -#ifdef TARGET_GPROF
> -#include <sys/gmon.h>
> -#endif
>  #ifdef CONFIG_EVENTFD
>  #include <sys/eventfd.h>
>  #endif
> --
> 2.20.1
>
>

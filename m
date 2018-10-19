Received: from eggs.gnu.org ([2001:4830:134:3::10]:56456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDTRY-0004zf-Gu
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDTRX-0004eD-Bf
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:59:52 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDTRX-0004dh-1c
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:59:51 -0400
Received: by mail-oi1-x241.google.com with SMTP id 22-v6so26610553oiz.2
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 04:59:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539944335-19556-1-git-send-email-hongbo.zhang@linaro.org>
References: <1539944335-19556-1-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 12:59:29 +0100
Message-ID: <CAFEAcA-MD7aE1phES3RPEH2mk5USfKv0j1tGtbrOnid3hLQmXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: remove unused header files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 19 October 2018 at 11:18, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> Remove the unused herder files, 'virt' can be compiled and run without
> including them.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  hw/arm/virt.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9f67782..f0066cb 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -30,9 +30,6 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> -#include "hw/sysbus.h"
> -#include "hw/arm/arm.h"
> -#include "hw/arm/primecell.h"

Dropping primecell.h makes sense, we don't use what it provides.
But I suspect the others are "unused" only because some other
header we include drags them in implicitly. I think it's better
to explicitly include what we need, in case that other header
changes in future.

How did you determine which #includes to drop here?

thanks
-- PMM

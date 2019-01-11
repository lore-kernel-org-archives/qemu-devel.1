Received: from eggs.gnu.org ([209.51.188.92]:48125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1ghxe3-0005cP-9Y
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1ghxVx-0002rL-9Z
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:10:27 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:34452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1ghxVt-0002TS-GZ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:10:22 -0500
Received: by mail-wm1-f52.google.com with SMTP id y185so2101732wmd.1
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 06:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20190110084752.30510-1-kraxel@redhat.com>
	<20190110084752.30510-9-kraxel@redhat.com>
In-Reply-To: <20190110084752.30510-9-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 11 Jan 2019 15:10:06 +0100
Message-ID: <CAP+75-XBrc38Hrmw+C8pCD8ZO0UVCrYPp523jQ-f3wEtddpmXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 8/8] spice: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Frediano Ziglio <fziglio@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 10, 2019 at 9:52 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> From: Frediano Ziglio <fziglio@redhat.com>
>
> The definitions in the header are not  used.
> Also this fixes porting SPICE to Windows where the header is not
> available.
>

Oh this misses "Since e16f4c8770b". Not a big deal.

> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-id: 20190107184404.31993-1-fziglio@redhat.com
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/spice-core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index fc850b3f50..a40fb2c00d 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -18,7 +18,6 @@
>  #include "qemu/osdep.h"
>  #include <spice.h>
>
> -#include <netdb.h>
>  #include "sysemu/sysemu.h"
>
>  #include "ui/qemu-spice.h"
> --
> 2.9.3
>
>

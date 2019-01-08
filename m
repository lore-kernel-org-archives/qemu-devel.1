Received: from eggs.gnu.org ([209.51.188.92]:39171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggtlx-00085G-7N
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:58:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggtlv-0007QJ-Cs
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:58:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggtlv-0007O9-6n
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:58:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so4528225wrt.13
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 07:58:30 -0800 (PST)
References: <20190107184404.31993-1-fziglio@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2ce5aafa-a486-9f3a-20b7-2842094132e0@redhat.com>
Date: Tue, 8 Jan 2019 16:58:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190107184404.31993-1-fziglio@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] spice: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On 1/7/19 7:44 PM, Frediano Ziglio wrote:
> The definitions in the header are not  used.

Indeed, since e16f4c8770b.

> Also this fixes porting SPICE to Windows where the header is not
> available.
> 
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

(I might resend your patch in another series of mine)

> ---
>  ui/spice-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index 525e0929b9..fb87944a24 100644
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
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdfo-0007MC-GS
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdfl-0002VC-Fx
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:35:08 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:38459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdfl-0002Um-CA
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:35:05 -0400
Received: by mail-qk0-x22f.google.com with SMTP id b39so17065006qkb.5
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:35:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-15-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a3d2d7e8-2815-50d3-7ff6-daccdd6d796c@amsat.org>
Date: Fri, 4 May 2018 13:35:01 -0300
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-15-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/67] sd: fix up include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Michael Walle <michael@walle.cc>, peter.maydell@linaro.org

On 05/03/2018 04:50 PM, Michael S. Tsirkin wrote:
> include files shouldn't have the "include/" part,
> that is implied.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sd/milkymist-memcard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 5570c1e..fe1cccc 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -27,7 +27,7 @@
>  #include "hw/sysbus.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> -#include "include/qapi/error.h"
> +#include "qapi/error.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "hw/sd/sd.h"
> 

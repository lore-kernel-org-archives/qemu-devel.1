Received: from eggs.gnu.org ([2001:4830:134:3::10]:37583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdeB-0005wo-65
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEde8-0001Ib-1A
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:33:27 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:42361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEde7-0001IN-Tf
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:33:23 -0400
Received: by mail-qt0-x243.google.com with SMTP id c2-v6so28087015qtn.9
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:33:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-8-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cb831739-eebb-a0a3-7a61-09d39a125d57@amsat.org>
Date: Fri, 4 May 2018 13:33:19 -0300
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-8-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/67] display: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org

On 05/03/2018 04:50 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/bcm2835_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
> index 7eab927..3355f4c 100644
> --- a/hw/display/bcm2835_fb.c
> +++ b/hw/display/bcm2835_fb.c
> @@ -26,7 +26,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/display/bcm2835_fb.h"
> -#include "hw/display/framebuffer.h"
> +#include "framebuffer.h"
>  #include "ui/pixel_ops.h"
>  #include "hw/misc/bcm2835_mbox_defs.h"
>  #include "qemu/log.h"
> 

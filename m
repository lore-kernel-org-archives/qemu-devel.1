Received: from eggs.gnu.org ([2001:4830:134:3::10]:53163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKO8-0007VO-2B
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKO4-0000wm-V4
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:36:40 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKO4-0000vy-Qa
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:36:36 -0400
Received: by mail-qt0-x243.google.com with SMTP id f1-v6so8305713qtj.6
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 14:36:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-10-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <14df756f-2914-3471-5680-91d555119a18@amsat.org>
Date: Fri, 25 May 2018 18:36:32 -0300
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-10-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/20] e1000e: use local path for local
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
Cc: peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

On 05/25/2018 01:47 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/net/e1000e.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 16a9417..cda8d48 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -41,7 +41,7 @@
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
>  
> -#include "hw/net/e1000_regs.h"
> +#include "e1000_regs.h"
>  

Can you remove this extra newline while here?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  #include "e1000x_common.h"
>  #include "e1000e_core.h"
> 

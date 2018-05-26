Received: from eggs.gnu.org ([2001:4830:134:3::10]:56548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMQrY-00058F-6e
	for qemu-devel@nongnu.org; Sat, 26 May 2018 00:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMQrV-000334-26
	for qemu-devel@nongnu.org; Sat, 26 May 2018 00:31:28 -0400
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:41015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMQrU-00032a-U5
	for qemu-devel@nongnu.org; Sat, 26 May 2018 00:31:24 -0400
Received: by mail-qk0-x234.google.com with SMTP id d125-v6so5622892qkb.8
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 21:31:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-17-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b6e690f9-9b39-8edb-f73b-f850a00afc0c@amsat.org>
Date: Sat, 26 May 2018 01:31:20 -0300
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-17-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 16/20] colo: use local path for local
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
Cc: peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>

On 05/25/2018 01:48 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory.
> 
> Reviewed-by: Zhang Chen <zhangckid@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  net/colo-compare.c    | 2 +-
>  net/colo.c            | 2 +-
>  net/filter-rewriter.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 23b2d2c..c3a2be4 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -25,7 +25,7 @@
>  #include "net/queue.h"
>  #include "chardev/char-fe.h"
>  #include "qemu/sockets.h"
> -#include "net/colo.h"
> +#include "colo.h"
>  #include "sysemu/iothread.h"
>  
>  #define TYPE_COLO_COMPARE "colo-compare"
> diff --git a/net/colo.c b/net/colo.c
> index 8426265..6dda4ed 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -14,7 +14,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "trace.h"
> -#include "net/colo.h"
> +#include "colo.h"
>  
>  uint32_t connection_key_hash(const void *opaque)
>  {
> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
> index 62dad2d..f584e4e 100644
> --- a/net/filter-rewriter.c
> +++ b/net/filter-rewriter.c
> @@ -11,7 +11,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "trace.h"
> -#include "net/colo.h"
> +#include "colo.h"
>  #include "net/filter.h"
>  #include "net/net.h"
>  #include "qemu-common.h"
> 

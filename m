Received: from eggs.gnu.org ([2001:4830:134:3::10]:51987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fESFl-0006ba-46
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fESFk-0008Is-49
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:23:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fESFj-0008IQ-QL
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:23:28 -0400
Received: by mail-wr0-x243.google.com with SMTP id q3-v6so19612262wrj.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 21:23:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-18-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-18-git-send-email-mst@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 4 May 2018 12:23:25 +0800
Message-ID: <CAK3tnvKNa=FAKWOrO+8QVjt7KQxJ5aFPThadsZ-hPKcb6jFN+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 17/67] colo: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, berrange@redhat.com, Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

On Fri, May 4, 2018 at 3:50 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Reviewed-by: Zhang Chen <zhangckid@gmail.com>


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
> --
> MST
>
>

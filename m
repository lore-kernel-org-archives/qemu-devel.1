Received: from eggs.gnu.org ([2001:4830:134:3::10]:57579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eswAg-0005Dh-OS
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eswAg-0006aA-0e
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:53:18 -0500
References: <20180302185448.6314-1-kwolf@redhat.com>
	<20180302185448.6314-28-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e9d5bf02-f940-ff39-4306-7ce918b714f9@redhat.com>
Date: Mon, 5 Mar 2018 13:53:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180302185448.6314-28-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 27/37] block: extract AIO_WAIT_WHILE() from
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

On 03/02/2018 12:54 PM, Kevin Wolf wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> BlockDriverState has the BDRV_POLL_WHILE() macro to wait on event loop
> activity while a condition evaluates to true.  This is used to implement
> synchronous operations where it acts as a condvar between the IOThread
> running the operation and the main loop waiting for the operation.  It
> can also be called from the thread that owns the AioContext and in that
> case it's just a nested event loop.
> 
> BlockBackend needs this behavior but doesn't always have a

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/include/block/block.h
> @@ -2,6 +2,7 @@
>   #define BLOCK_H
>   
>   #include "block/aio.h"
> +#include "block/aio-wait.h"
>   #include "qapi-types.h"

Will need a minor rebase now that commit 9af23989 has renamed qapi-types.h.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

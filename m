Received: from eggs.gnu.org ([209.51.188.92]:32861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfmK-0002A5-OO
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEfmJ-0005uh-S4
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:54:32 -0400
References: <20190327095634.53038-1-sgarzare@redhat.com>
	<20190327095634.53038-2-sgarzare@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9e0618f0-e889-5e37-fc4c-b44ada5fe509@vivier.eu>
Date: Thu, 11 Apr 2019 21:54:20 +0200
MIME-Version: 1.0
In-Reply-To: <20190327095634.53038-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 1/2] block/vhdx: Remove
 redundant IEC binary prefixes definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Jeff Cody <codyprime@gmail.com>, John Snow <jsnow@redhat.com>

On 27/03/2019 10:56, Stefano Garzarella wrote:
> IEC binary prefixes are already defined in "qemu/units.h",
> so we can remove redundant definitions in "block/vhdx.h".
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/vhdx.c | 3 ++-
>  block/vhdx.h | 6 +-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index b785aef4b7..7cd1fc3731 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1889,7 +1889,8 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>          return -EINVAL;
>      }
>      if (block_size > VHDX_BLOCK_SIZE_MAX) {
> -        error_setg(errp, "Block size must not exceed %d", VHDX_BLOCK_SIZE_MAX);
> +        error_setg(errp, "Block size must not exceed %" PRId64,
> +                   VHDX_BLOCK_SIZE_MAX);
>          return -EINVAL;
>      }
>  
> diff --git a/block/vhdx.h b/block/vhdx.h
> index 1bfb4e4f73..bf72090c8f 100644
> --- a/block/vhdx.h
> +++ b/block/vhdx.h
> @@ -17,11 +17,7 @@
>  
>  #ifndef BLOCK_VHDX_H
>  #define BLOCK_VHDX_H
> -
> -#define KiB              (1 * 1024)
> -#define MiB            (KiB * 1024)
> -#define GiB            (MiB * 1024)
> -#define TiB ((uint64_t) GiB * 1024)
> +#include "qemu/units.h"
>  
>  #define DEFAULT_LOG_SIZE 1048576 /* 1MiB */
>  /* Structures and fields present in the VHDX file */
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1du4IG-0007uB-Or
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1du4IF-0007cv-Sy
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 18:13:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170918214649.17550-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dfe4dc28-4011-e7a7-aa1f-54e340f091d2@amsat.org>
Date: Mon, 18 Sep 2017 19:13:21 -0300
MIME-Version: 1.0
In-Reply-To: <20170918214649.17550-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] nbd-client: Use correct
 macro parenthesization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi Eric,

On 09/18/2017 06:46 PM, Eric Blake wrote:
> If 'bs' is a complex expression, we were only casting the front half
> rather than the full expression.  Luckily, none of the callers were
> passing bad arguments, but it's better to be robust up front.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Any magic cocci script to verify there aren't no more?

> ---
> 
> I plan to take this through my NBD queue, unless it is picked up
> by qemu-trivial first...
> 
>   block/nbd-client.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index 5f241ecc22..2a528dd217 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -31,8 +31,8 @@
>   #include "qapi/error.h"
>   #include "nbd-client.h"
> 
> -#define HANDLE_TO_INDEX(bs, handle) ((handle) ^ ((uint64_t)(intptr_t)bs))
> -#define INDEX_TO_HANDLE(bs, index)  ((index)  ^ ((uint64_t)(intptr_t)bs))
> +#define HANDLE_TO_INDEX(bs, handle) ((handle) ^ (uint64_t)(intptr_t)(bs))
> +#define INDEX_TO_HANDLE(bs, index)  ((index)  ^ (uint64_t)(intptr_t)(bs))
> 
>   static void nbd_recv_coroutines_wake_all(NBDClientSession *s)
>   {
> 

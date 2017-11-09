Received: from eggs.gnu.org ([2001:4830:134:3::10]:41595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCifl-0006XL-LL
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eCifk-0006oJ-OF
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:58:53 -0500
References: <20171108215703.9295-1-eblake@redhat.com>
	<20171108215703.9295-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f00244d8-93c9-7434-884d-318ba8f67b4f@virtuozzo.com>
Date: Thu, 9 Nov 2017 11:58:33 +0300
MIME-Version: 1.0
In-Reply-To: <20171108215703.9295-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/7] nbd-client: Fix error message typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, kwolf@redhat.com, Max Reitz <mreitz@redhat.com>

09.11.2017 00:56, Eric Blake wrote:
> Provide missing spaces that are required when using string
> concatenation to break error messages across source lines.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


> ---
>   block/nbd-client.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index b44d4d4a01..de6c153328 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -248,7 +248,7 @@ static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
>
>       error = nbd_errno_to_system_errno(payload_advance32(&payload));
>       if (error == 0) {
> -        error_setg(errp, "Protocol error: server sent structured error chunk"
> +        error_setg(errp, "Protocol error: server sent structured error chunk "
>                            "with error = 0");
>           return -EINVAL;
>       }
> @@ -257,7 +257,7 @@ static int nbd_parse_error_payload(NBDStructuredReplyChunk *chunk,
>       message_size = payload_advance16(&payload);
>
>       if (message_size > chunk->length - sizeof(error) - sizeof(message_size)) {
> -        error_setg(errp, "Protocol error: server sent structured error chunk"
> +        error_setg(errp, "Protocol error: server sent structured error chunk "
>                            "with incorrect message size");
>           return -EINVAL;
>       }
> @@ -408,7 +408,7 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
>       if (chunk->type == NBD_REPLY_TYPE_NONE) {
>           if (!(chunk->flags & NBD_REPLY_FLAG_DONE)) {
>               error_setg(errp, "Protocol error: NBD_REPLY_TYPE_NONE chunk without"
> -                             "NBD_REPLY_FLAG_DONE flag set");
> +                       " NBD_REPLY_FLAG_DONE flag set");

I think it's better not to change indentation here, as it is done so in 
other places.
You don't like this way of indenting splitted strings?

>               return -EINVAL;
>           }
>           return 0;


-- 
Best regards,
Vladimir

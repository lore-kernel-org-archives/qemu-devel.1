Received: from eggs.gnu.org ([2001:4830:134:3::10]:37520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9EO1-0005sM-RE
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9EO1-0007rM-1z
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:02:09 -0400
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104546.8582-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b96e9fb7-3aa9-ecbb-53ee-a324662c799e@virtuozzo.com>
Date: Mon, 30 Oct 2017 21:01:51 +0300
MIME-Version: 1.0
In-Reply-To: <20171027104546.8582-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC PATCH v6 13/12] tweak test 83 verbosity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

27.10.2017 13:45, Eric Blake wrote:
> Commenting these two lines is enough to avoid the change to 083.out
> in 12/12.  That is evidence that we may want these two lines to be
> trace points rather than error messages; or maybe we really do like
> the extra verbosity in the case of an unexpected communication break.
>
> This patch does not meet coding guidelines, and I'm not proud enough
> of it to give S-o-b, but I'm posting it for conversation.

I think more verbosity on fail is not bad, it's rare case. In previous patch
the corresponding change looks big, but in real case it would be just one
more line in log.

However, if you unsure about it, people who want more verbosity may always
enable this particular trace, so tracing is ok too and more flexible.

>
> ---
>   block/nbd-client.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/nbd-client.c b/block/nbd-client.c
> index b44d4d4a01..e063b3fbc0 100644
> --- a/block/nbd-client.c
> +++ b/block/nbd-client.c
> @@ -654,7 +654,8 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
>
>       ret = nbd_co_receive_return_code(client, request->handle, &local_err);
>       if (local_err) {
> -        error_report_err(local_err);
> +        assert(ret < 0);
> +//        error_report_err(local_err);
>       }
>       return ret;
>   }
> @@ -682,7 +683,7 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
>       ret = nbd_co_receive_cmdread_reply(client, request.handle, offset, qiov,
>                                          &local_err);
>       if (ret < 0) {
> -        error_report_err(local_err);
> +        //error_report_err(local_err);
>       }
>       return ret;
>   }


-- 
Best regards,
Vladimir

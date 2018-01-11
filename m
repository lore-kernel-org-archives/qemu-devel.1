Received: from eggs.gnu.org ([2001:4830:134:3::10]:53986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZgky-00063g-Eq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZgkx-0000Iw-AY
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:35:12 -0500
References: <20180110230825.18321-1-eblake@redhat.com>
	<20180110230825.18321-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <21d61f05-bbd1-e2b5-fbc1-53cc052dd9b6@virtuozzo.com>
Date: Thu, 11 Jan 2018 20:34:55 +0300
MIME-Version: 1.0
In-Reply-To: <20180110230825.18321-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/6] nbd/server: Better error for
 NBD_OPT_EXPORT_NAME failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

11.01.2018 02:08, Eric Blake wrote:
> When a client abruptly disconnects before we've finished reading
> the name sent with NBD_OPT_EXPORT_NAME, we are better off logging
> the failure as EIO (we can't communicate with the client), rather
> than EINVAL (the client sent bogus data).
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> ---
>   nbd/server.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/nbd/server.c b/nbd/server.c
> index 08a24b56f4..9943a911c3 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -299,7 +299,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *client,
>       }
>       if (nbd_read(client->ioc, name, client->optlen, errp) < 0) {
>           error_prepend(errp, "read failed: ");
> -        return -EINVAL;
> +        return -EIO;
>       }
>       name[client->optlen] = '\0';
>       client->optlen = 0;


-- 
Best regards,
Vladimir

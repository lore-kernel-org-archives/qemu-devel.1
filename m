Received: from eggs.gnu.org ([2001:4830:134:3::10]:48255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csTvC-0007JU-5m
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csTvB-00055S-DB
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:38:54 -0400
References: <20170327123223.1199-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fda0f7d7-b86f-98d8-a22a-4c38fecb3f43@redhat.com>
Date: Mon, 27 Mar 2017 14:38:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170327123223.1199-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd: drop unused NBDClientSession.is_unix
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org



On 27/03/2017 14:32, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nbd-client.h | 2 --
>  block/nbd.c        | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/block/nbd-client.h b/block/nbd-client.h
> index 8cdfc92..891ba44 100644
> --- a/block/nbd-client.h
> +++ b/block/nbd-client.h
> @@ -30,8 +30,6 @@ typedef struct NBDClientSession {
>  
>      Coroutine *recv_coroutine[MAX_NBD_REQUESTS];
>      NBDReply reply;
> -
> -    bool is_unix;
>  } NBDClientSession;
>  
>  NBDClientSession *nbd_get_client_session(BlockDriverState *bs);
> diff --git a/block/nbd.c b/block/nbd.c
> index f478f80..1b832c2 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -285,8 +285,6 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options, Error **errp)
>          goto done;
>      }
>  
> -    s->client.is_unix = saddr->type == SOCKET_ADDRESS_KIND_UNIX;
> -
>  done:
>      QDECREF(addr);
>      qobject_decref(crumpled_addr);
> 

Queued for 2.9, thanks.

Paolo

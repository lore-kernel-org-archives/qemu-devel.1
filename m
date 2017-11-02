Received: from eggs.gnu.org ([2001:4830:134:3::10]:38985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eA92C-0000Ld-8W
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 02:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eA928-0002Zo-A1
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 02:31:24 -0400
References: <20170126153837.25597-1-stefanha@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3ca6376a-ae3e-1e5c-503f-239e4e62799c@redhat.com>
Date: Thu, 2 Nov 2017 07:31:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170126153837.25597-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] aio-posix: drop QEMU_AIO_POLL_MAX_NS env
 var
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 26.01.2017 16:38, Stefan Hajnoczi wrote:
> This hunk should not have been merged but I forgot to remove it.  Let's
> remove it before it slips into a QEMU release.

Too late - looks like this patch has never been committed :-(

> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  aio-posix.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/aio-posix.c b/aio-posix.c
> index 9453d83..9a6348b 100644
> --- a/aio-posix.c
> +++ b/aio-posix.c
> @@ -723,13 +723,6 @@ bool aio_poll(AioContext *ctx, bool blocking)
>  
>  void aio_context_setup(AioContext *ctx)
>  {
> -    /* TODO remove this in final patch submission */
> -    if (getenv("QEMU_AIO_POLL_MAX_NS")) {
> -        fprintf(stderr, "The QEMU_AIO_POLL_MAX_NS environment variable has "
> -                "been replaced with -object iothread,poll-max-ns=NUM\n");
> -        exit(1);
> -    }
> -
>  #ifdef CONFIG_EPOLL_CREATE1
>      assert(!ctx->epollfd);
>      ctx->epollfd = epoll_create1(EPOLL_CLOEXEC);
> 

Could we get this at least added for QEMU 2.11 ?

Reviewed-by: Thomas Huth <thuth@redhat.com>

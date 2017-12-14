Received: from eggs.gnu.org ([2001:4830:134:3::10]:33581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePPDy-0007bu-Sr
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePPDy-0004tv-5y
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:50:38 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-7-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f964304c-9383-635a-5a55-cad92b01fa45@redhat.com>
Date: Thu, 14 Dec 2017 09:50:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171214005953.8898-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] block/stream: use block_job_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On 14/12/2017 01:59, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/stream.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/stream.c b/block/stream.c
> index e85af18c54..3ad3190387 100644
> --- a/block/stream.c
> +++ b/block/stream.c
> @@ -139,7 +139,7 @@ static void coroutine_fn stream_run(void *opaque)
>          /* Note that even when no rate limit is applied we need to yield
>           * with no pending I/O here so that bdrv_drain_all() returns.
>           */
> -        block_job_sleep_ns(&s->common, delay_ns);
> +        block_job_throttle(&s->common, delay_ns);
>          if (block_job_is_cancelled(&s->common)) {
>              break;
>          }
> 

Nit, the previous patch is adding a blank line here, but this one isn't.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

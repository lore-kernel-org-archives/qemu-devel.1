Received: from eggs.gnu.org ([2001:4830:134:3::10]:39371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dBMvD-00019X-JE
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dBMvB-0006tU-9g
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:00:59 -0400
References: <20170518103334.8808-1-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <b502c8a2-56b5-a526-aa82-0f64ba1d7981@redhat.com>
Date: Thu, 18 May 2017 17:00:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170518103334.8808-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] altera_timer: fix incorrect
 memset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 18/05/2017 12:33, Paolo Bonzini wrote:
> Use sizeof instead of ARRAY_SIZE, fixing -Wmemset-elt-size with recent
> GCC versions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/timer/altera_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
> index 6d4862661d..c9a0fc5dca 100644
> --- a/hw/timer/altera_timer.c
> +++ b/hw/timer/altera_timer.c
> @@ -204,7 +204,7 @@ static void altera_timer_reset(DeviceState *dev)
>  
>      ptimer_stop(t->ptimer);
>      ptimer_set_limit(t->ptimer, 0xffffffff, 1);
> -    memset(t->regs, 0, ARRAY_SIZE(t->regs));
> +    memset(t->regs, 0, sizeof(t->regs));
>  }
>  
>  static Property altera_timer_properties[] = {
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>

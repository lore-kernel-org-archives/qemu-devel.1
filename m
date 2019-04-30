Received: from eggs.gnu.org ([209.51.188.92]:40973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLYN8-0003W9-UT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLYDR-0006EO-3c
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:14:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hLYDQ-0006Do-Ri
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:14:57 -0400
References: <20190426020927.25470-1-richardw.yang@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03168011-cd29-5812-8d5b-8d911e22b330@redhat.com>
Date: Tue, 30 Apr 2019 21:14:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190426020927.25470-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: correct the comment to
 DIRTY_MEMORY_MIGRATION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org

On 26/04/19 04:09, Wei Yang wrote:
> The dirty bit is DIRTY_MEMORY_MIGRATION. Correct the comment.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index e49369d85d..9d015bfe4c 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2576,7 +2576,7 @@ void memory_global_dirty_log_start(void)
>  
>      MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);
>  
> -    /* Refresh DIRTY_LOG_MIGRATION bit.  */
> +    /* Refresh DIRTY_MEMORY_MIGRATION bit.  */
>      memory_region_transaction_begin();
>      memory_region_update_pending = true;
>      memory_region_transaction_commit();
> @@ -2586,7 +2586,7 @@ static void memory_global_dirty_log_do_stop(void)
>  {
>      global_dirty_log = false;
>  
> -    /* Refresh DIRTY_LOG_MIGRATION bit.  */
> +    /* Refresh DIRTY_MEMORY_MIGRATION bit.  */
>      memory_region_transaction_begin();
>      memory_region_update_pending = true;
>      memory_region_transaction_commit();
> 

Queued, thanks.

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d87vh-0008B8-Nt
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d87vh-0003vH-0g
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:24:05 -0400
Date: Tue, 9 May 2017 12:23:54 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170509162354.GC16494@localhost.localdomain>
References: <20170508141310.8674-1-pbonzini@redhat.com>
	<20170508141310.8674-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170508141310.8674-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/11] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com

On Mon, May 08, 2017 at 04:13:00PM +0200, Paolo Bonzini wrote:
> !job is always checked prior to the call, drop it from here.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 6e489327ff..23022b3331 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -480,7 +480,7 @@ static bool block_job_should_pause(BlockJob *job)
>  
>  bool block_job_user_paused(BlockJob *job)
>  {
> -    return job ? job->user_paused : 0;
> +    return job->user_paused;
>  }
>  
>  void coroutine_fn block_job_pause_point(BlockJob *job)
> -- 
> 2.12.2
> 
>
Reviewed-by: Jeff Cody <jcody@redhat.com>

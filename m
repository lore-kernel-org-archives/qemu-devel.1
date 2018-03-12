Received: from eggs.gnu.org ([2001:4830:134:3::10]:39800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evRxl-0008Sk-1Y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1evRxk-0003rr-8M
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:14:21 -0400
Date: Mon, 12 Mar 2018 14:13:58 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180312181357.GD12302@localhost.localdomain>
References: <20180310082746.24198-1-jsnow@redhat.com>
	<20180310082746.24198-2-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310082746.24198-2-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 01/21] blockjobs: fix set-speed kick
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

On Sat, Mar 10, 2018 at 03:27:26AM -0500, John Snow wrote:
> If speed is '0' it's not actually "less than" the previous speed.
> Kick the job in this case too.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  blockjob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 801d29d849..afd92db01f 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -499,7 +499,7 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
>      }
>  
>      job->speed = speed;
> -    if (speed <= old_speed) {
> +    if (speed && speed <= old_speed) {
>          return;
>      }
>  
> -- 
> 2.14.3
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>

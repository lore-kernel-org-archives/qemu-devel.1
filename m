Received: from eggs.gnu.org ([2001:4830:134:3::10]:56651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxcc-0000Ph-G1
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fxxcb-00008V-RR
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:59:10 -0400
Date: Thu, 6 Sep 2018 12:58:56 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180906165856.GH22117@localhost.localdomain>
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-11-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906130225.5118-11-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 10/16] tests/test-blockjob-txn: move
 .exit to .clean
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Sep 06, 2018 at 09:02:19AM -0400, John Snow wrote:
> The exit callback in this test actually only performs cleanup.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Jeff Cody <jcody@redhat.com>

> ---
>  tests/test-blockjob-txn.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
> index ef29f35e44..86606f92b3 100644
> --- a/tests/test-blockjob-txn.c
> +++ b/tests/test-blockjob-txn.c
> @@ -24,7 +24,7 @@ typedef struct {
>      int *result;
>  } TestBlockJob;
>  
> -static void test_block_job_exit(Job *job)
> +static void test_block_job_clean(Job *job)
>  {
>      BlockJob *bjob = container_of(job, BlockJob, job);
>      BlockDriverState *bs = blk_bs(bjob->blk);
> @@ -73,7 +73,7 @@ static const BlockJobDriver test_block_job_driver = {
>          .user_resume   = block_job_user_resume,
>          .drain         = block_job_drain,
>          .run           = test_block_job_run,
> -        .exit          = test_block_job_exit,
> +        .clean         = test_block_job_clean,
>      },
>  };
>  
> -- 
> 2.14.4
> 

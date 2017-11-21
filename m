Received: from eggs.gnu.org ([2001:4830:134:3::10]:55082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eH8Zx-0003S2-97
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eH8Zw-0006qG-BK
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:27:09 -0500
Date: Tue, 21 Nov 2017 08:26:54 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171121132654.GK5399@localhost.localdomain>
References: <cover.1511230683.git.jcody@redhat.com>
	<d21a7bb5d13a8d8db55bea05e46f5f4e18ed481e.1511230683.git.jcody@redhat.com>
	<20171121104946.GA25265@stefanha-x1.localdomain>
	<072692b7-3b3e-b44d-02c8-9d8f4e745b67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <072692b7-3b3e-b44d-02c8-9d8f4e745b67@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 1/4] blockjob: do not allow
 coroutine double entry or entry-after-completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, kwolf@redhat.com

On Tue, Nov 21, 2017 at 02:12:32PM +0100, Paolo Bonzini wrote:
> On 21/11/2017 11:49, Stefan Hajnoczi wrote:
> > On Mon, Nov 20, 2017 at 09:23:23PM -0500, Jeff Cody wrote:
> >> @@ -291,10 +291,10 @@ void block_job_start(BlockJob *job)
> >>  {
> >>      assert(job && !block_job_started(job) && job->paused &&
> >>             job->driver && job->driver->start);
> >> -    job->co = qemu_coroutine_create(block_job_co_entry, job);
> >>      job->pause_count--;
> >>      job->busy = true;
> >>      job->paused = false;
> >> +    job->co = qemu_coroutine_create(block_job_co_entry, job);
> >>      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
> >>  }
> > 
> > Please see discussion on v1 about this hunk.
> > 
> > The rest looks good.
> 
> I'm okay with this hunk, but I would appreciate that the commit message
> said why it's okay to delay block job cancellation after
> block_job_sleep_ns returns.
> 

Stefan is right in his reply to my v1, so I'll go ahead and drop this hunk
for v3.  I'll also add the info you requested to the commit message.

Jeff

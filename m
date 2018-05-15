Received: from eggs.gnu.org ([2001:4830:134:3::10]:44321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIVv8-0007mu-W6
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIVv8-0003zs-0P
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:06:58 -0400
Date: Tue, 15 May 2018 11:06:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180515090647.GA4442@localhost.localdomain>
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-15-kwolf@redhat.com>
	<88a073ed-4dce-f102-0a93-4810abdcf01b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a073ed-4dce-f102-0a93-4810abdcf01b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/42] job: Add reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jcody@redhat.com, armbru@redhat.com, mreitz@redhat.com

Am 14.05.2018 um 23:34 hat John Snow geschrieben:
> 
> 
> On 05/09/2018 12:26 PM, Kevin Wolf wrote:
> > This moves reference counting from BlockJob to Job.
> > 
> > In order to keep calling the BlockJob cleanup code when the job is
> > deleted via job_unref(), introduce a new JobDriver.free callback. Every
> > block job must use block_job_free() for this callback, this is asserted
> > in block_job_create().
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> So far so good, though it does look a little silly that presently every
> last job has the exact same free callback.
> 
> Also, I forgot to reply to #13 with this, but I suppose that the
> approach you're taking -- of a fairly straightforward mechanical
> refactor -- means we don't really have the opportunity to change any of
> the pretty dumb names or existing peculiarities of design we've evolved.
> 
> I had hoped we'd be able to change a few things, but certainly keeping
> them as-is makes the whole re-factoring process an awful lot simpler...
> 
> ...Or maybe I'm getting ahead of myself, there's a lot of series left
> to go.

No, I think you're right. My approach was that we'd separate the generic
and the block-specific parts in this series without changing much in the
structure or the names, to keep the conversion as obvious as possible
(the series is long enough already).

However, I intentionally kept the QMP interface minimal where I wasn't
quite sure that we want to keep the old one. If you see anything in the
QMP interface that you'd like to see changed, please do comment.
Anything else is an implementation detail and can still be changed on
top of this series.

Kevin

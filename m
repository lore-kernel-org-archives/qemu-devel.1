Received: from eggs.gnu.org ([2001:4830:134:3::10]:55988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fq3Np-0006JO-I2
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fq3Nj-0007jX-Q1
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:31:09 -0400
Date: Wed, 15 Aug 2018 17:30:54 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180815213054.GF3254@localhost.localdomain>
References: <c449263bbcaffbd3db25d833fb57867fda8e3199.1534348766.git.jcody@redhat.com>
	<79de10c5-28fb-5be2-3141-f09fb4bb5f09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79de10c5-28fb-5be2-3141-f09fb4bb5f09@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: for jobs,
 do not clear user_paused until after the resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, qemu-block@nongnu.org

On Wed, Aug 15, 2018 at 04:25:16PM -0500, Eric Blake wrote:
> On 08/15/2018 10:59 AM, Jeff Cody wrote:
> >The function job_cancel_async() will always cause an assert for blockjob
> >user resume.  We set job->user_paused to false, and then call
> >job->driver->user_resume().  In the case of blockjobs, this is the
> >block_job_user_resume() function.
> >
> >In that function, we assert that job.user_paused is set to true.
> >Unfortunately, right before calling this function, it has explicitly
> >been set to false.
> >
> >The fix is pretty simple: set job->user_paused to false only after the
> >job user_resume() function has been called.
> >
> >Signed-off-by: Jeff Cody <jcody@redhat.com>
> >---
> >  job.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> Does this need to CC qemu-stable?
> 

Good point, yes.  I'm going to do a v2 with an iotest, and I'll CC
qemu-stable on that one.

> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks


-Jeff

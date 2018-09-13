Received: from eggs.gnu.org ([2001:4830:134:3::10]:46871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0Vev-0006sR-M5
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g0Vel-0003Ni-5b
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:43:59 -0400
Date: Thu, 13 Sep 2018 19:39:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180913173926.GE5172@localhost.localdomain>
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-7-kwolf@redhat.com>
	<387dce30-0a62-ad0a-e955-56ca714323b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <387dce30-0a62-ad0a-e955-56ca714323b4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/17] job: Use AIO_WAIT_WHILE() in
 job_finish_sync()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

Am 13.09.2018 um 17:15 hat Paolo Bonzini geschrieben:
> On 13/09/2018 14:52, Kevin Wolf wrote:
> > Also, job_drain() without aio_poll() isn't necessarily enough to make
> > progress on a job, it could depend on bottom halves to be executed.
> 
> This is not changed by the patch though; AIO_WAIT_WHILE does not do the
> bottom halves part anymore, bdrv_drain_poll_top_level does it instead.
> 
> What is it that needs bottom halves to be executed?  Could it delay
> switching the job state until after that?

AIO_WAIT_WHILE() does still execute bottom halves if the condition is
true, which is all that is needed to make progress. It only doesn't
execute them unconditionally any more.

Kevin

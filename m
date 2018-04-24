Received: from eggs.gnu.org ([2001:4830:134:3::10]:45270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAtm8-0008QP-Jd
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fAtm7-0004yx-Ur
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:58:12 -0400
Date: Tue, 24 Apr 2018 10:58:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180424085802.GA4080@localhost.localdomain>
References: <20180424085240.5798-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424085240.5798-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blockjob: drop block_job_pause/resume_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 24.04.2018 um 10:52 hat Stefan Hajnoczi geschrieben:
> Commit 8119334918e86f45877cfc139192d54f2449a239 ("block: Don't
> block_job_pause_all() in bdrv_drain_all()") removed the only callers of
> block_job_pause/resume_all().
> 
> Pausing and resuming now happens in child_job_drained_begin/end() so
> it's no longer necessary to globally pause/resume jobs.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Yes, the same is part of my upcoming huge (non-)block job series. I
think git should resolve the conflict fine, so feel free to apply this
already while I finish my series.

Kevin

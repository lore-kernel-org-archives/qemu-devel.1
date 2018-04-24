Received: from eggs.gnu.org ([2001:4830:134:3::10]:54389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB1Vh-00038g-Mq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fB1Vg-0000BB-S2
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 13:13:45 -0400
Date: Tue, 24 Apr 2018 19:13:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180424171327.GG4080@localhost.localdomain>
References: <20180424123527.19168-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424123527.19168-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/mirror: honor ratelimit again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Liang Li <liliang.opensource@gmail.com>, qemu-stable@nongnu.org

Am 24.04.2018 um 14:35 hat Stefan Hajnoczi geschrieben:
> Commit b76e4458b1eb3c32e9824fe6aa51f67d2b251748 ("block/mirror: change
> the semantic of 'force' of block-job-cancel") accidentally removed the
> ratelimit in the mirror job.
> 
> Reintroduce the ratelimit but keep the block-job-cancel force=true
> behavior that was added in commit
> b76e4458b1eb3c32e9824fe6aa51f67d2b251748.
> 
> Note that block_job_sleep_ns() returns immediately when the job is
> cancelled.  Therefore it's safe to unconditionally call
> block_job_sleep_ns() - a cancelled job does not sleep.
> 
> This commit fixes the non-deterministic qemu-iotests 185 output.  The
> test relies on the ratelimit to make the job sleep until the 'quit'
> command is processed.  Previously the job could complete before the
> 'quit' command was received since there was no ratelimit.
> 
> Cc: Liang Li <liliang.opensource@gmail.com>
> Cc: Jeff Cody <jcody@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Cc: qemu-stable@nongnu.org
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzdhc-0003LF-5X
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzdZf-0006vH-Mj
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:59:04 -0400
Date: Tue, 11 Sep 2018 15:58:54 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911075854.GB19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-2-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/14] blockjob: Wake up BDS when job
 becomes idle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, slp@redhat.com, qemu-devel@nongnu.org

On Fri, 09/07 18:15, Kevin Wolf wrote:
> In the context of draining a BDS, the .drained_poll callback of block
> jobs is called. If this returns true (i.e. there is still some activity
> pending), the drain operation may call aio_poll() with blocking=true to
> wait for completion.
> 
> As soon as the pending activity is completed and the job finally arrives
> in a quiescent state (i.e. its coroutine either yields with busy=false
> or terminates), the block job must notify the aio_poll() loop to wake
> up, otherwise we get a deadlock if both are running in different
> threads.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>

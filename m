Received: from eggs.gnu.org ([2001:4830:134:3::10]:41610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze9S-00014v-6D
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fze9R-0005AN-Fk
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:36:02 -0400
Date: Tue, 11 Sep 2018 16:35:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911083552.GN19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-14-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-14-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/14] block: Remove aio_poll() in
 bdrv_drain_poll variants
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
> bdrv_drain_poll_top_level() was buggy because it didn't release the
> AioContext lock of the node to be drained before calling aio_poll().
> This way, callbacks called by aio_poll() would possibly take the lock a
> second time and run into a deadlock with a nested AIO_WAIT_WHILE() call.
> 
> However, it turns out that the aio_poll() call isn't actually needed any
> more. It was introduced in commit 91af091f923, which is effectively
> reverted by this patch. The cases it was supposed to fix are now covered
> by bdrv_drain_poll(), which waits for block jobs to reach a quiescent
> state.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>

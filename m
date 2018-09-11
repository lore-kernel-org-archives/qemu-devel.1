Received: from eggs.gnu.org ([2001:4830:134:3::10]:42011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzeB2-0003R4-LX
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:37:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzeB2-00064Y-1x
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:37:40 -0400
Date: Tue, 11 Sep 2018 16:37:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180911083730.GO19292@lemon.usersys.redhat.com>
References: <20180907161520.26349-1-kwolf@redhat.com>
	<20180907161520.26349-15-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907161520.26349-15-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/14] test-bdrv-drain: Test nested poll in
 bdrv_drain_poll_top_level()
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
> This is a regression test for a deadlock that could occur in callbacks
> called from the aio_poll() in bdrv_drain_poll_top_level(). The
> AioContext lock wasn't released and therefore would be taken a second
> time in the callback. This would cause a possible AIO_WAIT_WHILE() in
> the callback to hang.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eP4TV-0007V0-1Q
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eP4TU-000465-CM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:41:17 -0500
Date: Wed, 13 Dec 2017 11:41:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171213104105.GA3950@localhost.localdomain>
References: <20171212134800.21836-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212134800.21836-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Don't acquire AioContext in
 hmp_qemu_io()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

Am 12.12.2017 um 14:48 hat Kevin Wolf geschrieben:
> Commit 15afd94a047 added code to acquire and release the AioContext in
> qemuio_command(). This means that the lock is taken twice now in the
> call path from hmp_qemu_io(). This causes BDRV_POLL_WHILE() to hang for
> any requests issued to nodes in a non-mainloop AioContext.
> 
> Dropping the first locking from hmp_qemu_io() fixes the problem.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Applied to block-next.

Kevin

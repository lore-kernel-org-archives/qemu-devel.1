Received: from eggs.gnu.org ([2001:4830:134:3::10]:39311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Mh3-0003Kq-7J
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3Mh2-0002OC-FL
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 10:13:49 -0400
Date: Tue, 3 Apr 2018 16:13:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180403141336.GE11070@localhost.localdomain>
References: <20180403140314.8795-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403140314.8795-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: update 185 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>

Am 03.04.2018 um 16:03 hat Stefan Hajnoczi geschrieben:
> Commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce
> vm_shutdown()") added a bdrv_drain_all() call.  As a side-effect of the
> drain operation the block job iterates one more time than before.  The
> 185 output no longer matches and the test is failing now.
> 
> It may be possible to avoid the superfluous block job iteration, but
> that type of patch is not suitable late in the QEMU 2.12 release cycle.
> 
> This patch simply updates the 185 output file.  The new behavior is
> correct, just not optimal, so make the test pass again.
> 
> Fixes: 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce vm_shutdown()")
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Do you want to update the comment in the 185 test case code that
explains which values we expect?

Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxrhf-0003BK-Ko
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxrhe-00086p-Nx
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:03:11 -0400
Date: Tue, 11 Apr 2017 11:02:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411090258.GE4516@noname.str.redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410150542.30376-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 02/10] block: Quiesce old aio
 context during bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 10.04.2017 um 17:05 hat Fam Zheng geschrieben:
> The fact that the bs->aio_context is changing can confuse the dataplane
> iothread, because of the now fine granularity aio context lock.
> bdrv_drain should rather be a bdrv_drained_begin/end pair, but since
> bs->aio_context is changing, we can just use aio_disable_external and
> bdrv_parent_drained_begin.
> 
> Reported-by: Ed Swierk <eswierk@skyportsystems.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

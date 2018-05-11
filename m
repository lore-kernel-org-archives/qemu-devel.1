Received: from eggs.gnu.org ([2001:4830:134:3::10]:45318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fHBqw-0006UV-OG
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fHBqw-0007H9-02
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:29:10 -0400
Date: Fri, 11 May 2018 19:29:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180511172901.GC5016@localhost.localdomain>
References: <1526053004-12268-1-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526053004-12268-1-git-send-email-ivanren@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3] qcow2: fix preallocation with metadata
 on bare block device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ivan Ren <renyime@gmail.com>
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Am 11.05.2018 um 17:36 hat Ivan Ren geschrieben:
> Create a qcow2 directly on bare block device with
> "-o preallocation=metadata" option. When read this qcow2, it will
> return pre-existing data on block device. This patch add
> QCOW_OFLAG_ZERO flag (supported in qcow_version >= 3) for
> preallocated l2 entry to avoid this problem.
> 
> Signed-off-by: Ivan Ren <ivanren@tencent.com>

Doesn't this defeat the purpose of preallocation? Usually, the idea with
preallocation is that you don't need to update any metadata on the first
write, but if you set QCOW_OFLAG_ZERO, we do need a metadata update
again.

So what's the advantage compared to not preallocating at all?

Kevin

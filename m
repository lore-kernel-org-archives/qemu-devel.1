Received: from eggs.gnu.org ([2001:4830:134:3::10]:59494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXPho-0005jH-0K
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:03:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXPhj-0006FC-0b
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:03:03 -0500
Date: Thu, 13 Dec 2018 13:02:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181213120237.GB5427@linux.fritz.box>
References: <20181213112434.20039-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213112434.20039-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/mirror: add missing coroutine_fn
 annotations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

Am 13.12.2018 um 12:24 hat Stefan Hajnoczi geschrieben:
> Marking a function coroutine_fn currently has no effect on the compiler,
> but it documents that this function must be called from coroutine
> context and it may yield.  This is important information for the
> programmer.
> 
> Also, if we ever transition to a stackless coroutine implementation,
> then it's likely that the annotation will become mandatory so the
> compiler can use the correct calling convention for coroutine functions.
> 
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to the block branch.

Kevin

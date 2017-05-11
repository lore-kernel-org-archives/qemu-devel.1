Received: from eggs.gnu.org ([2001:4830:134:3::10]:36350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8kMz-0000gJ-5f
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8kMy-0000N6-8u
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:26:49 -0400
Date: Thu, 11 May 2017 11:26:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170511092626.GA4235@noname.str.redhat.com>
References: <20170510173945.11819-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510173945.11819-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blockdev: use drained_begin/end for
 qmp_block_resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

Am 10.05.2017 um 19:39 hat John Snow geschrieben:
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1447551
> 
> If one tries to issue a block_resize while a guest is busy
> accessing the disk, it is possible that qemu may deadlock
> when invoking aio_poll from both the main loop and the iothread.
> 
> Replace another instance of bdrv_drain_all that doesn't
> quite belong.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Thanks, applied to the block branch.

Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLuvt-0005VY-7e
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dLuvs-0008OX-GZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:21:17 -0400
Date: Fri, 16 Jun 2017 19:21:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170616172108.GE4366@noname.fritz.box>
References: <20170613211612.9368-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613211612.9368-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] throttle: Update throttle-groups.c
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>

Am 13.06.2017 um 23:16 hat Alberto Garcia geschrieben:
> There used to be throttle_timers_{detach,attach}_aio_context() calls
> in bdrv_set_aio_context(), but since 7ca7f0f6db1fedd28d490795d778cf239
> they are now in blk_set_aio_context().
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin

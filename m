Received: from eggs.gnu.org ([209.51.188.92]:44368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEZlj-0007ih-3g
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEZli-0001kz-6Z
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:29:31 -0400
Date: Thu, 11 Apr 2019 15:29:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190411132921.GC5694@linux.fritz.box>
References: <20190410162918.9343-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410162918.9343-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Let 245 pass on tmpfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>

Am 10.04.2019 um 18:29 hat Max Reitz geschrieben:
> tmpfs does not support O_DIRECT.  Detect this case, and skip flipping
> @direct if the filesystem does not support it.
> 
> Fixes: bf3e50f6239090e63a8ffaaec971671e66d88e07
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin

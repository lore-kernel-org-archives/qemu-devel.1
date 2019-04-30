Received: from eggs.gnu.org ([209.51.188.92]:38301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQ2y-0003Oi-Ao
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQ2x-0002k0-H5
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:31:36 -0400
Date: Tue, 30 Apr 2019 12:31:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190430103130.GC5607@linux.fritz.box>
References: <20190430100802.15368-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430100802.15368-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Fix error handling in the
 compression code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>

Am 30.04.2019 um 12:08 hat Alberto Garcia geschrieben:
> This patch fixes a few things in the way error codes are handled in
> the qcow2 compression code:
> 
> a) qcow2_co_pwritev_compressed() expects qcow2_co_compress() to only
>    return -1 or -2 on failure, but this is not correct. Since the
>    change from qcow2_compress() to qcow2_co_compress() in commit
>    ceb029cd6feccf9f7607 the new code can also return -EINVAL (although
>    there does not seem to exist any code path that would cause that
>    error in the current implementation).
> 
> b) -1 and -2 are ad-hoc error codes defined in qcow2_compress().
>    This patch replaces them with standard constants from errno.h.
> 
> c) Both qcow2_compress() and qcow2_co_do_compress() return a negative
>    value on failure, but qcow2_co_pwritev_compressed() stores the
>    value in an unsigned data type.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin

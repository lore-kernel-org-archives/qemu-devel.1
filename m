Received: from eggs.gnu.org ([2001:4830:134:3::10]:45669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0UUL-0005UB-9H
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d0UUK-0008GE-K6
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:52:17 -0400
Date: Tue, 18 Apr 2017 10:51:59 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170418145159.GI5704@localhost.localdomain>
References: <20170418143044.12187-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170418143044.12187-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9-rc5 v4 0/2] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Apr 18, 2017 at 10:30:42PM +0800, Fam Zheng wrote:
> v4: Split patch, and fix the unsafe bdrv_unref. [Paolo]
> 
> Fam Zheng (2):
>   block: Walk bs->children carefully in bdrv_drain_recurse
>   block: Drain BH in bdrv_drained_begin
> 
>  block/io.c            | 23 ++++++++++++++++++++---
>  include/block/block.h | 22 ++++++++++++++--------
>  2 files changed, 34 insertions(+), 11 deletions(-)
> 
> -- 
> 2.9.3
>

Reviewed-by: Jeff Cody <jcody@redhat.com>

(also Tested-by)

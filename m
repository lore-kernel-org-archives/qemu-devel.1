Received: from eggs.gnu.org ([2001:4830:134:3::10]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpB6C-0004aK-5z
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpB67-0007gL-I7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:28:52 -0400
Date: Tue, 5 Sep 2017 11:28:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170905102844.GJ17449@stefanha-x1.localdomain>
References: <20170830100605.22694-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830100605.22694-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Cleanup BMDS in
 bdrv_close_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, peterx@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Aug 30, 2017 at 06:06:05PM +0800, Fam Zheng wrote:
> This fixes the assertion due to op blockers added by BMDS:
> 
> block.c:3248: bdrv_delete: Assertion `bdrv_op_blocker_is_empty(bs)' failed.
> 
> Reproducer: simply start block migration and quit QEMU before it ends.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c                 | 2 ++
>  migration/block.c       | 2 +-
>  migration/block.h       | 1 +
>  stubs/Makefile.objs     | 1 +
>  stubs/block-migration.c | 6 ++++++
>  5 files changed, 11 insertions(+), 1 deletion(-)
>  create mode 100644 stubs/block-migration.c

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

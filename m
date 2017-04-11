Received: from eggs.gnu.org ([2001:4830:134:3::10]:47533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxtcU-0000e6-KX
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cxtcT-0002O5-GE
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:05:58 -0400
Date: Tue, 11 Apr 2017 13:05:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170411110542.GI4516@noname.str.redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410150542.30376-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 00/10] block: Fixes regarding
 dataplane and management operations
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
> v3: Respin the unmerged changes from v2 and include one new fix:
> 
>     (Yes, it is a big series for the last -rc, and I personally prefer the v2
>     approach for the 4-9 part of the problem, which is much more mechanical.)
> 
>     - 1, 2 are redoing previous patch 4, using bdrv_parent_drained_begin/end.
>       [Kevin]
>       Also fix the ordering against aio_context_release. [Stefan]
>     - 3 is unchanged from patch 6 in v2.
>     - 4-9 are reworking of patch 5 following Paolo's suggestion, which allowed
>       better patch split.
>     - 10 is finding of a latent bug, which is revealed by patch 9.
> 
> v2: - Drop patch 4 in v1. A second thought made me feel neither it nor Kevin's
>       suggestion to move the BH process to bdrv_drain_recurse/BDRV_POLL_WHILE
>       is a complete fix. So leave it for a separate patch.
>     - Add rev-by to patches 1, 3, 4.
>     - Split from patch 1 in v1 and add patch 2, for the new assertions. [Kevin]
>     - Rewrite patch 5. Fix block job's co when a BDS is moved to a different
>       aio context. [Kevin]
>     - Add patch 6.
> 
> Crashes are reported on dataplane devices when doing snapshot and commit under
> guest I/O.
> 
> With this series, Ed's test case '176' now passes:
> 
>     https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.9

I had only two points for this series. The first is that it adds unused
functions, which doesn't hurt (but I might just send a PATCH 11/10 to
remove them again). The second one is that some sheepdog code is
suspicious, but if anything it just means that this series is incomplete,
so not a show stopper either.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

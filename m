Received: from eggs.gnu.org ([2001:4830:134:3::10]:53109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwTH3-0002ce-Br
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwTH2-00008f-EH
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 08:45:57 -0400
Date: Fri, 7 Apr 2017 14:45:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170407124543.GD4716@noname.redhat.com>
References: <20170407065414.9143-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407065414.9143-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] block: Fixes regarding dataplane
 and management operations
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

Am 07.04.2017 um 08:54 hat Fam Zheng geschrieben:
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
> With this series, Ed's test case '176' now passes (reran 10+ times):
> 
>     https://github.com/skyportsystems/qemu-1/commits/eswierk-iotests-2.9
> 
> The biggest fix for this is patch 5, which fixes a race condition between main
> thread and iothread.

Thanks, applied patch 1-3 for now. I feel the other patches still need
closer review and potentially discussion.

Kevin

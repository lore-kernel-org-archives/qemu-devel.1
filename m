Received: from eggs.gnu.org ([2001:4830:134:3::10]:52252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTVkc-0006jP-Uw
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTVkb-0002ez-Vs
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:05:02 -0400
Date: Fri, 7 Jul 2017 18:04:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170707160451.GD5027@noname.redhat.com>
References: <20170707124459.10269-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707124459.10269-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/21] make bdrv_is_allocated[_above]
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org

Am 07.07.2017 um 14:44 hat Eric Blake geschrieben:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
> 
> The overall conversion currently looks like:
> part 1: bdrv_is_allocated (this series, v4 was at [1])
> part 2: dirty-bitmap (v4 is posted [2]; needs reviews)
> part 3: bdrv_get_block_status (v2 is posted [3] and is mostly reviewed)
> part 4: upcoming series, for .bdrv_co_block_status (second half of v1 [4])
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-allocated-v5
> 
> Depends on Max's block branch (which in turn includes Kevin's)
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01151.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00269.html
> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg00427.html
> [4] https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg02642.html
> 
> Changes since v4:
> - patches 8, 11: formatting tweak [Kevin], R-b kept
> - patches 12, 19, 21: fix/add assertions [Kevin], R-b dropped
> - patch 16: tweak parameter naming [Kevin], R-b kept
> - patch 20: kill confusing comment [Kevin], R-b kept

Thanks, applied to the block branch.

Kevin

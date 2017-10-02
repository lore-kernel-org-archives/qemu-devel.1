Received: from eggs.gnu.org ([2001:4830:134:3::10]:59601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz3Uo-0002Mt-Fa
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dz3Uk-0005kR-JF
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:23:06 -0400
Date: Mon, 2 Oct 2017 18:22:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171002162244.GH4362@localhost.localdomain>
References: <20170925145526.32690-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925145526.32690-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 00/20] make dirty-bitmap byte-based
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Am 25.09.2017 um 16:55 hat Eric Blake geschrieben:
> There are patches floating around to add NBD_CMD_BLOCK_STATUS,
> but NBD wants to report status on byte granularity (even if the
> reporting will probably be naturally aligned to sectors or even
> much higher levels).  I've therefore started the task of
> converting our block status code to report at a byte granularity
> rather than sectors.
> 
> Now that 2.11 is open, I'm rebasing/reposting the remaining patches.
> 
> The overall conversion currently looks like:
> part 1: bdrv_is_allocated (merged in 2.10, commit 51b0a488)
> part 2: dirty-bitmap (this series, v9 was here [1])
> part 3: bdrv_get_block_status (v4 is posted [2] and is mostly reviewed)
> part 4: .bdrv_co_block_status (v3 is posted [3], but needs review)
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-dirty-v10

Thanks, applied to the block branch.

Kevin

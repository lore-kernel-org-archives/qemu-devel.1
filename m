Received: from eggs.gnu.org ([2001:4830:134:3::10]:56496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5aQN-0001pr-KO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e5aQM-0002Kw-MW
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:45:31 -0400
Date: Fri, 20 Oct 2017 18:45:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171020164515.GC31112@localhost.localdomain>
References: <20171012034720.11947-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012034720.11947-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/24] make bdrv_get_block_status
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, jsnow@redhat.com

Am 12.10.2017 um 05:46 hat Eric Blake geschrieben:
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
> part 1: bdrv_is_allocated (merged, commit 51b0a488)
> part 2: dirty-bitmap (merged, commit ca759622)
> part 3: bdrv_get_block_status (this series, v5 at [1])
> part 4: .bdrv_co_block_status (v3 is posted [2], mostly reviewed, but needs rebase)

Thanks, applied to the block branch.

Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1u80-0005JX-RH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1u80-0007Lj-4o
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 08:59:20 -0400
Date: Tue, 10 Oct 2017 14:58:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010125858.GI4177@dhcp-200-186.str.redhat.com>
References: <20171004020048.26379-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004020048.26379-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/23] make bdrv_get_block_status
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
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org

Am 04.10.2017 um 04:00 hat Eric Blake geschrieben:
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
> part 2: dirty-bitmap (v10 is queued [1])
> part 3: bdrv_get_block_status (this series, v4 at [2])
> part 4: .bdrv_co_block_status (v3 is posted [4], mostly reviewed)
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-byte-status-v4
> 
> Based-on: <20170925145526.32690-1-eblake@redhat.com>
> ([PATCH v10 00/20] make dirty-bitmap byte-based)
> Based-on: <20171004014347.25099-1-eblake@redhat.com>
> ([PATCH v2 0/5] block: Avoid copy-on-read assertions)

We merged v3 of that series, which causes merge conflicts in this one.
I can try to give the patches a look without applying them, but can you
rebase, please?

Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIDSb-0003Zu-Qu
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dIDSb-0005wW-16
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 08:19:45 -0400
Date: Tue, 6 Jun 2017 14:19:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170606121939.GB5448@noname.redhat.com>
References: <20170605190824.25184-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605190824.25184-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/4] more blkdebug tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Am 05.06.2017 um 21:08 hat Eric Blake geschrieben:
> I found a crasher and some odd behavior while rebasing my
> bdrv_get_block_status series, so I figured I'd get these things
> fixed first.  This is based on top of Max's block branch.
> 
> Available as a tag at:
> git fetch git://repo.or.cz/qemu/ericb.git nbd-blkdebug-status-v3
> 
> Since v2:
> - defer the original patch 3 to a later series
> - rebase to make sure test 177 passes at all times (I didn't
> pinpoint which recent merge caused it, but the test now produces
> json:{...} instead of blkdebug:... during patch 2)
> - add more documentation of BDRV_BLOCK_RAW
> - add R-b where appropriate
> 
> 001/4:[----] [--] 'qemu-io: Don't die on second open'
> 002/4:[0002] [FC] 'block: Guarantee that *file is set on bdrv_get_block_status()'
> 003/4:[0006] [FC] 'block: Simplify use of BDRV_BLOCK_RAW'
> 004/4:[0002] [FC] 'blkdebug: Support .bdrv_co_get_block_status'

Patches 2-4:
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

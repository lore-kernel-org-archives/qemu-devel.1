Received: from eggs.gnu.org ([2001:4830:134:3::10]:51522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSPkL-0003LV-Kl
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dSPkK-0007J0-PJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:28:13 -0400
Date: Tue, 4 Jul 2017 17:28:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170704152800.GJ4253@noname.str.redhat.com>
References: <20170627192458.15519-1-eblake@redhat.com>
	<20170627192458.15519-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192458.15519-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/20] blockjob: Track job ratelimits
 via bytes, not sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 27.06.2017 um 21:24 hat Eric Blake geschrieben:
> The user interface specifies job rate limits in bytes/second.
> It's pointless to have our internal representation track things
> in sectors/second, particularly since we want to move away from
> sector-based interfaces.
> 
> Fix up a doc typo found while verifying that the ratelimit
> code handles the scaling difference.
> 
> Repetition of expressions like 'n * BDRV_SECTOR_SIZE' will be
> cleaned up later when functions are converted to iterate over
> images by bytes rather than by sectors.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

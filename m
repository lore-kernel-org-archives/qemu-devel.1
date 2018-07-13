Received: from eggs.gnu.org ([2001:4830:134:3::10]:49601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fduA3-0004rG-Cu
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 05:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fduA2-0007Kj-GF
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 05:14:47 -0400
Date: Fri, 13 Jul 2018 11:14:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180713091438.GE3896@localhost.localdomain>
References: <1531466139-2758-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531466139-2758-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: avoid overflow of min_sparse
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, qemu-stable@nongnu.org

Am 13.07.2018 um 09:15 hat Peter Lieven geschrieben:
> the min_sparse convert parameter can overflow (e.g. -S 1024G)
> in the conversion from int64_t to int resulting in a negative
> min_sparse parameter. Avoid this by limiting the valid parameters
> to sane values. In fact anything exceeding the convert buffer size
> is also pointless. While at it also forbid values that are non
> multiple of 512 to avoid undesired behaviour. For instance, values
> between 1 and 511 were legal, but resulted in full allocation.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
> V1->V2: - use correct check for sval mod 512 == 0
>         - use BDRV_SECTOR_SIZE macro instead of hardcoded 512

Thanks, applied to the block branch.

Kevin

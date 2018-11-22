Received: from eggs.gnu.org ([2001:4830:134:3::10]:45413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPq2H-0004Mc-NI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPq2G-0003kh-KO
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:32:53 -0500
Date: Thu, 22 Nov 2018 15:32:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181122143243.GC31879@linux.fritz.box>
References: <1541506615-30202-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541506615-30202-1-git-send-email-igor.druzhinin@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] block/nvme: call blk_drain in NVMe reset
 code to avoid lockups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: keith.busch@intel.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 06.11.2018 um 13:16 hat Igor Druzhinin geschrieben:
> When blk_flush called in NVMe reset path S/C queues are already freed
> which means that re-entering AIO handling loop having some IO requests
> unfinished will lockup or crash as their SG structures being potentially
> reused. Call blk_drain before freeing the queues to avoid this nasty
> scenario.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Thanks, applied to the block branch.

Kevin

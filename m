Received: from eggs.gnu.org ([2001:4830:134:3::10]:50602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=653480f21=anthony.perard@citrix.com>)
	id 1fDu9D-00059r-0a
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=653480f21=anthony.perard@citrix.com>)
	id 1fDu97-0007lD-6A
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:58:27 -0400
Date: Wed, 2 May 2018 16:58:16 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180502155816.GD14376@perard>
References: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] block/xen_disk: legacy code removal
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 30, 2018 at 01:01:35PM +0100, Paul Durrant wrote:
> The grant copy operation was added to libxengnttab in Xen 4.8.0 (released
> nearly 18 months ago) but the xen_disk PV backend QEMU is still carrying
> a significant amount of code purely to remain compatible with older
> versions of Xen.
> 
> As can be inferred from the diff stats below, removing this support for
> older versions of Xen from QEMU reduces the size of the xen_disk source by
> more than 350 lines (~25%). The majority of this is done in patches #1
> and #2. Further simplifications are made in patch #3 and then some cosmetic
> work is done in patch #4.

FIY, I don't like this patch series. We've been checking that QEMU
builds against older version. I've check that it builds against 4.5 and
newer.

Also the fact that FreeBSD doesn't have support for grant copy probably
mean that it is too soon to remove the compatibility code from qemu.

Regards,

-- 
Anthony PERARD

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=837fd5125=anthony.perard@citrix.com>)
	id 1gIZtK-0008KD-VG
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=837fd5125=anthony.perard@citrix.com>)
	id 1gIZtG-0005Oa-1r
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:53:38 -0400
Date: Fri, 2 Nov 2018 13:53:15 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181102135315.GG6481@perard.uk.xensource.com>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<154115285942.11300.11718576813181760505.stgit@dhcp-3-135.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <154115285942.11300.11718576813181760505.stgit@dhcp-3-135.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] Improve xen_disk batching behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tim Smith <tim.smith@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>

On Fri, Nov 02, 2018 at 10:00:59AM +0000, Tim Smith wrote:
> When I/O consists of many small requests, performance is improved by
> batching them together in a single io_submit() call. When there are
> relatively few requests, the extra overhead is not worth it. This
> introduces a check to start batching I/O requests via blk_io_plug()/
> blk_io_unplug() in an amount proportional to the number which were
> already in flight at the time we started reading the ring.
> 
> Signed-off-by: Tim Smith <tim.smith@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD

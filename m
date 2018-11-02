Received: from eggs.gnu.org ([2001:4830:134:3::10]:36388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=837fd5125=anthony.perard@citrix.com>)
	id 1gIZtZ-0008UH-KJ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=837fd5125=anthony.perard@citrix.com>)
	id 1gIZtU-0005We-Or
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 09:53:53 -0400
Date: Fri, 2 Nov 2018 13:53:40 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181102135340.GI6481@perard.uk.xensource.com>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<154115286959.11300.498371710893672725.stgit@dhcp-3-135.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <154115286959.11300.498371710893672725.stgit@dhcp-3-135.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] Avoid repeated memory allocation in
 xen_disk
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

On Fri, Nov 02, 2018 at 10:01:09AM +0000, Tim Smith wrote:
> xen_disk currently allocates memory to hold the data for each ioreq
> as that ioreq is used, and frees it afterwards. Because it requires
> page-aligned blocks, this interacts poorly with non-page-aligned
> allocations and balloons the heap.
> 
> Instead, allocate the maximum possible requirement, which is
> BLKIF_MAX_SEGMENTS_PER_REQUEST pages (currently 11 pages) when
> the ioreq is created, and keep that allocation until it is destroyed.
> Since the ioreqs themselves are re-used via a free list, this
> should actually improve memory usage.
> 
> Signed-off-by: Tim Smith <tim.smith@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD

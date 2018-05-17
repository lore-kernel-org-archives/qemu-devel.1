Received: from eggs.gnu.org ([2001:4830:134:3::10]:59066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6682a862c=anthony.perard@citrix.com>)
	id 1fJGcx-0007D2-GB
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6682a862c=anthony.perard@citrix.com>)
	id 1fJGcs-0007Ry-PH
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:59:19 -0400
Date: Thu, 17 May 2018 11:59:05 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180517105905.GL2057@perard.uk.xensource.com>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-8-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1525461967-32174-8-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/8] xen_disk: use a single entry iovec
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

On Fri, May 04, 2018 at 08:26:06PM +0100, Paul Durrant wrote:
> Since xen_disk now always copies data to and from a guest there is no need
> to maintain a vector entry corresponding to every page of a request.
> This means there is less per-request state to maintain so the ioreq
> structure can shrink significantly.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD

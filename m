Received: from eggs.gnu.org ([209.51.188.92]:54501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9271d7743=anthony.perard@citrix.com>)
	id 1gpEgD-00047q-TN
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9271d7743=anthony.perard@citrix.com>)
	id 1gpEgA-0005Nh-8w
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:55:05 -0500
Date: Thu, 31 Jan 2019 15:47:55 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190131154755.GH2306@perard.uk.xensource.com>
References: <20190131153316.21233-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190131153316.21233-1-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3] xen-block: handle resize callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Jan 31, 2019 at 03:33:16PM +0000, Paul Durrant wrote:
> Some frontend drivers will handle dynamic resizing of PV disks, so set up
> the BlockDevOps resize_cb() method during xen_block_realize() to allow
> this to be done.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

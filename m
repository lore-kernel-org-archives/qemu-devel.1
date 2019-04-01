Received: from eggs.gnu.org ([209.51.188.92]:51774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=98749c841=anthony.perard@citrix.com>)
	id 1hB0D1-0000D4-QH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=98749c841=anthony.perard@citrix.com>)
	id 1hB0D0-0003xp-UF
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 12:54:55 -0400
Date: Mon, 1 Apr 2019 17:54:44 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190401165444.GI1420@perard.uk.xensource.com>
References: <20190401121719.27208-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190401121719.27208-1-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3] xen-block: scale sector based
 quantities correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 01, 2019 at 01:17:19PM +0100, Paul Durrant wrote:
> The Xen blkif protocol requires that sector based quantities should be
> interpreted strictly as multiples of 512 bytes. Specifically:
> 
> "first_sect and last_sect in blkif_request_segment, as well as
> sector_number in blkif_request, are always expressed in 512-byte units."
> 
> Commit fcab2b464e06 "xen: add header and build dataplane/xen-block.c"
> incorrectly modified behaviour to use the block device logical_block_size
> property as the scale, instead of correctly shifting values by the
> hardcoded BDRV_SECTOR_BITS (and hence scaling them to 512 byte units).
> This patch undoes that change and restores compliance with the spec.
> 
> Furthermore, this patch also restores the original xen_disk behaviour
> of advertizing a hardcoded 'sector-size' value of 512 in xenstore and
> scaling 'sectors' accordingly. The realize() method is also modified to
> fail if logical_block_size is set to anything other than 512.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=423eedb09=anthony.perard@citrix.com>)
	id 1dsWw1-0002m1-5x
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=423eedb09=anthony.perard@citrix.com>)
	id 1dsWvy-00072b-0X
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:24:13 -0400
Received: from smtp.citrix.com ([66.165.176.89]:19797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=423eedb09=anthony.perard@citrix.com>)
	id 1dsWvx-0006y1-NX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:24:09 -0400
Date: Thu, 14 Sep 2017 17:23:43 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170914162343.GI1544@perard.uk.xensource.com>
References: <59B80A35020000780017A344@prv-mh.provo.novell.com>
	<59B80A35020000780017A344@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <59B80A35020000780017A344@prv-mh.provo.novell.com>
Subject: Re: [Qemu-devel] [PATCH] xen_disk: avoid use of g_malloc0_n()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>
Cc: qemu-devel@nongnu.org, xen-devel <xen-devel@lists.xenproject.org>, Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>

On Tue, Sep 12, 2017 at 08:24:21AM -0600, Jan Beulich wrote:
> Prefer g_new() / g_new0() to be farther backwards compatible with older
> glib versions. As there's no point in zeroing the allocation here (the
> loop right afterwards fully initializes the memory), use the former.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice
>          return -1;
>      }
>  
> -    domids = g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
> +    domids = g_new(uint32_t, blkdev->nr_ring_ref);
>      for (i = 0; i < blkdev->nr_ring_ref; i++) {
>          domids[i] = blkdev->xendev.dom;
>      }
> 
> 
> 
> 

-- 
Anthony PERARD

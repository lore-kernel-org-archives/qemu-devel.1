Received: from eggs.gnu.org ([2001:4830:134:3::10]:45402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW46J-00026R-1G
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW46F-00071y-4n
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:37:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cW46E-00071U-Uv
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:37:39 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E82BDC04BD30
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 16:37:38 +0000 (UTC)
Date: Tue, 24 Jan 2017 18:37:36 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170124183634-mutt-send-email-mst@kernel.org>
References: <20170120170757.30308-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170120170757.30308-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] virtio: use MemoryRegionCache for
 descriptors and rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Fri, Jan 20, 2017 at 06:07:50PM +0100, Paolo Bonzini wrote:
> Patch posted during 2.8 hard freeze.  Quick measurements give a 10%
> performance improvement on various virtio-blk benchmarks, but the machine
> I used seems to love my patches particularly today!
> 
> Paolo

Looks nice to me. I'll apply patch 1 as you are
still tweaking the rest of the series.

> Paolo Bonzini (7):
>   virtio: make virtio_should_notify static
>   virtio: add virtio_*_phys_cached
>   virtio: use address_space_map/unmap to access descriptors
>   virtio: use MemoryRegionCache to access descriptors
>   virtio: add MemoryListener to cache ring translations
>   virtio: use VRingMemoryRegionCaches for descriptor ring
>   virtio: use VRingMemoryRegionCaches for avail and used rings
> 
>  hw/net/virtio-net.c               |  14 +-
>  hw/virtio/virtio.c                | 322 ++++++++++++++++++++++++++++++--------
>  include/hw/virtio/virtio-access.h |  52 ++++++
>  include/hw/virtio/virtio.h        |   2 +-
>  4 files changed, 322 insertions(+), 68 deletions(-)
> 
> -- 
> 2.9.3

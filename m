Received: from eggs.gnu.org ([209.51.188.92]:37506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gzLuL-0002nM-O7
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gzLuK-0002r5-89
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:39:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gzLuJ-0002oh-VS
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:39:28 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so23439988qtp.8
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 05:39:25 -0800 (PST)
Date: Thu, 28 Feb 2019 08:39:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190228083821-mutt-send-email-mst@kernel.org>
References: <20190214043916.22128-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214043916.22128-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH 0/5] Improve balloon handling of pagesizes
 other than 4kiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Thu, Feb 14, 2019 at 03:39:11PM +1100, David Gibson wrote:
> I posted some RFCs for this back in December, but didn't wrap it up in
> time for 3.1.  Posting again for inclusion in 4.0.
> 
> The virtio-balloon devices was never really thought out for cases
> other than 4kiB pagesize on both guest and host.  It works in some
> cases, but in others can be ineffectual or even cause guest memory
> corruption.
> 
> This series makes a handful of preliminary cleanups, then makes a
> change to safely, though not perfectly, handle cases with non 4kiB
> pagesizes.

I'd like to see a version of this that does not depend on patch 1 which
is not a cleanup nor a bugfix. Could you look into this please?
We can then debate merits of patch 1 separately.


> Changes since RFC:
>  * Further refinement of when to issue warnings in 5/5
> 
> David Gibson (5):
>   virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate
>   virtio-balloon: Corrections to address verification
>   virtio-balloon: Rework ballon_page() interface
>   virtio-balloon: Use ram_block_discard_range() instead of raw madvise()
>   virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size
> 
>  hw/virtio/virtio-balloon.c         | 102 ++++++++++++++++++++++++-----
>  include/hw/virtio/virtio-balloon.h |   3 +
>  2 files changed, 89 insertions(+), 16 deletions(-)
> 
> -- 
> 2.20.1

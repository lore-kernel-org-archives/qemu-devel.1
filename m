Received: from eggs.gnu.org ([2001:4830:134:3::10]:56187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFDqt-0008Tt-9K
	for qemu-devel@nongnu.org; Mon, 29 May 2017 02:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFDqq-0007Ow-4h
	for qemu-devel@nongnu.org; Mon, 29 May 2017 02:08:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dFDqp-0007OW-Us
	for qemu-devel@nongnu.org; Mon, 29 May 2017 02:08:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0468627D8
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 06:08:22 +0000 (UTC)
Date: Mon, 29 May 2017 14:08:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170529060813.GF22816@pxdev.xzpeter.org>
References: <1494854073-19898-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1494854073-19898-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, May 15, 2017 at 09:14:33PM +0800, Peter Xu wrote:
> MSI should be supported by all interrupt controllers. Switching the old
> check for msi_nonbroken into assertion. Do similar thing to
> pci_add_capability2() below that. Then time to remove *errp.
> 
> Since msi_init() won't fail now, touch up all the callers to avoid
> checks against it. One side effect is that we fixed a possible leak in
> current edu device.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/audio/intel-hda.c               | 18 +-----------------
>  hw/i386/amd_iommu.c                |  2 +-
>  hw/ide/ich.c                       |  6 +-----
>  hw/misc/edu.c                      |  4 +---
>  hw/net/e1000e.c                    |  6 +-----
>  hw/net/trace-events                |  1 -
>  hw/net/vmxnet3.c                   |  8 ++------
>  hw/pci-bridge/ioh3420.c            | 17 ++++-------------
>  hw/pci-bridge/pci_bridge_dev.c     | 19 +------------------
>  hw/pci-bridge/xio3130_downstream.c | 11 +++--------
>  hw/pci-bridge/xio3130_upstream.c   | 11 +++--------
>  hw/pci/msi.c                       | 25 ++++++-------------------
>  hw/scsi/megasas.c                  | 18 +-----------------
>  hw/scsi/mptsas.c                   | 20 ++------------------
>  hw/scsi/trace-events               |  1 -
>  hw/scsi/vmw_pvscsi.c               | 12 +++---------
>  hw/usb/hcd-xhci.c                  | 16 +---------------
>  hw/vfio/pci.c                      | 13 ++-----------
>  include/hw/pci/msi.h               |  6 +++---
>  19 files changed, 36 insertions(+), 178 deletions(-)

Ping?

Just to mention in case missed - this is also a bug fix for edu
device.

Also CC Markus since he's the reporter and I forgot to CC him in
previous post. Sorry.

Thanks,

-- 
Peter Xu

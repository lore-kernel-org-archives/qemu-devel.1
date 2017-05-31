Received: from eggs.gnu.org ([2001:4830:134:3::10]:43625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dG0H2-0008PH-Lg
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dG0Gy-0004I7-Px
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dG0Gy-0004Hr-Gb
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:50:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BCC04E4F3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 09:50:35 +0000 (UTC)
Date: Wed, 31 May 2017 17:50:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170531095023.GL14845@pxdev.xzpeter.org>
References: <1496223756-24929-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1496223756-24929-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Edu leak fix series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, May 31, 2017 at 05:42:34PM +0800, Peter Xu wrote:
> A whitelist for it does not really makes sense. Let's remove it and
> then we can introduce a blacklist when really needed, with msi_broken.
> That's patch 1.

Ok this paragraph does not make sense if not mentioning what's "it"...

Please just read the commit messages of patch 1. It should be much
better.

Sorry for such a bad cover letter.

> 
> Then, I let the msi_init() always success in patch 2, along with it I
> removed caller checks around it.
> 
> The goal of this series is to fix the edu device leak. Yeah it's
> slightly weird, but it's the truth...
> 
> Please review. Thanks.
> 
> Peter Xu (2):
>   msi: remove msi_nonbroken
>   msi: remove return code for msi_init()
> 
>  hw/audio/intel-hda.c               | 18 +----------------
>  hw/i386/amd_iommu.c                |  2 +-
>  hw/i386/kvm/apic.c                 |  4 ----
>  hw/i386/xen/xen_apic.c             |  1 -
>  hw/ide/ich.c                       |  6 +-----
>  hw/intc/apic.c                     |  2 --
>  hw/intc/arm_gicv2m.c               |  1 -
>  hw/intc/arm_gicv3_its_common.c     |  2 --
>  hw/intc/openpic.c                  |  1 -
>  hw/intc/openpic_kvm.c              |  1 -
>  hw/misc/edu.c                      |  4 +---
>  hw/net/e1000e.c                    |  6 +-----
>  hw/net/trace-events                |  1 -
>  hw/net/vmxnet3.c                   |  8 ++------
>  hw/pci-bridge/ioh3420.c            | 17 ++++------------
>  hw/pci-bridge/pci_bridge_dev.c     | 19 +-----------------
>  hw/pci-bridge/xio3130_downstream.c | 11 +++-------
>  hw/pci-bridge/xio3130_upstream.c   | 11 +++-------
>  hw/pci/msi.c                       | 41 +++++---------------------------------
>  hw/pci/msix.c                      |  6 ------
>  hw/ppc/spapr.c                     |  6 +-----
>  hw/ppc/spapr_pci.c                 | 12 +++++------
>  hw/s390x/s390-pci-bus.c            |  1 -
>  hw/scsi/megasas.c                  | 18 +----------------
>  hw/scsi/mptsas.c                   | 20 ++-----------------
>  hw/scsi/trace-events               |  1 -
>  hw/scsi/vmw_pvscsi.c               | 12 +++--------
>  hw/usb/hcd-xhci.c                  | 16 +--------------
>  hw/vfio/pci.c                      | 13 ++----------
>  include/hw/pci/msi.h               |  8 +++-----
>  30 files changed, 41 insertions(+), 228 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Peter Xu

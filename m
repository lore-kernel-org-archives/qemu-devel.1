Received: from eggs.gnu.org ([2001:4830:134:3::10]:39019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fntqy-0004JC-Ih
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fntqv-0003DT-HX
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:56:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fntqv-0003D8-CU
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86B3940216F3
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 22:56:20 +0000 (UTC)
Date: Fri, 10 Aug 2018 01:56:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180810015411-mutt-send-email-mst@kernel.org>
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-10-quintela@redhat.com>
	<20180809190303.GF2618@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809190303.GF2618@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 09/22] virtio: Remove unneeded includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

On Thu, Aug 09, 2018 at 08:03:03PM +0100, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > They are all already included in virtio_pci.h.

All I see in virtio_pci.h is:

#include "standard-headers/linux/types.h"

Weird.

BTW what's the point of this patch?  Generally it's best not to depend
on headers including each other, it makes refactoring harder.


> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> 
> cc'ing in mst for virtio goodness.
> 
> 
> > ---
> >  hw/virtio/virtio-pci.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 3a01fe90f0..cb2ddd3f41 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -18,24 +18,11 @@
> >  #include "qemu/osdep.h"
> >  
> >  #include "standard-headers/linux/virtio_pci.h"
> > -#include "hw/virtio/virtio.h"
> > -#include "hw/virtio/virtio-blk.h"
> > -#include "hw/virtio/virtio-net.h"
> > -#include "hw/virtio/virtio-serial.h"
> > -#include "hw/virtio/virtio-scsi.h"
> > -#include "hw/virtio/virtio-balloon.h"
> > -#include "hw/virtio/virtio-input.h"
> > -#include "hw/pci/pci.h"
> > +#include "virtio-pci.h"
> >  #include "qapi/error.h"
> > -#include "qemu/error-report.h"
> > -#include "hw/pci/msi.h"
> >  #include "hw/pci/msix.h"
> > -#include "hw/loader.h"
> >  #include "sysemu/kvm.h"
> > -#include "virtio-pci.h"
> >  #include "qemu/range.h"
> > -#include "hw/virtio/virtio-bus.h"
> > -#include "qapi/visitor.h"
> >  
> >  #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
> >  
> > -- 
> > 2.17.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

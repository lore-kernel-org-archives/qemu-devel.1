Received: from eggs.gnu.org ([2001:4830:134:3::10]:51068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewaB2-0001uC-OS
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewaAz-0000HL-K6
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:12:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ewaAz-0000Gz-EL
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:12:41 -0400
Date: Thu, 15 Mar 2018 15:12:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180315151233.2460c612@w520.home>
In-Reply-To: <20180307055644.GI17720@xz-mi>
References: <20180228195504.25283.45666.stgit@gimli.home>
	<20180228201520.25283.97532.stgit@gimli.home>
	<20180307055644.GI17720@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] vfio/pci: Add ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, eric.auger@redhat.com, aik@ozlabs.ru

On Wed, 7 Mar 2018 13:56:44 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Feb 28, 2018 at 01:15:20PM -0700, Alex Williamson wrote:
> 
> [...]
> 
> > @@ -1174,6 +1206,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
> >  	mutex_init(&vdev->igate);
> >  	spin_lock_init(&vdev->irqlock);
> > +	mutex_init(&vdev->ioeventfds_lock);  
> 
> Do we better need to destroy the mutex in vfio_pci_remove?
> 
> I see that vfio_pci_device.igate is also without a destructor.  I'm
> not sure on both.

Yeah, mutex_destroy() is purely for debugging and I must have missed it
when implementing vfio.  I'll add it in the remove function and try to
cleanup the others in a separate patch, at some point.  Thanks,

Alex

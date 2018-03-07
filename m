Received: from eggs.gnu.org ([2001:4830:134:3::10]:51387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etS4X-0005De-9G
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 00:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etS4U-00040D-7h
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 00:57:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etS4U-0003zJ-2k
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 00:57:02 -0500
Date: Wed, 7 Mar 2018 13:56:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307055644.GI17720@xz-mi>
References: <20180228195504.25283.45666.stgit@gimli.home>
	<20180228201520.25283.97532.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228201520.25283.97532.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH 3/3] vfio/pci: Add ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, eric.auger@redhat.com, aik@ozlabs.ru

On Wed, Feb 28, 2018 at 01:15:20PM -0700, Alex Williamson wrote:

[...]

> @@ -1174,6 +1206,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
>  	mutex_init(&vdev->igate);
>  	spin_lock_init(&vdev->irqlock);
> +	mutex_init(&vdev->ioeventfds_lock);

Do we better need to destroy the mutex in vfio_pci_remove?

I see that vfio_pci_device.igate is also without a destructor.  I'm
not sure on both.

Thanks,

> +	INIT_LIST_HEAD(&vdev->ioeventfds_list);
>  
>  	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
>  	if (ret) {

-- 
Peter Xu

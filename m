Received: from eggs.gnu.org ([2001:4830:134:3::10]:32944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esnb0-0001lK-JR
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1esnaz-0001YW-Rv
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:43:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1esnaz-0001YC-Nu
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:43:53 -0500
Date: Mon, 5 Mar 2018 18:43:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180305104346.GD7584@xz-mi>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
	<f06bee8b-646d-e9e8-d2e6-78cdddb76ab1@redhat.com>
	<20180305084309.GF2482@sky-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305084309.GF2482@sky-dev>
Subject: Re: [Qemu-devel] [PATCH v3 08/12] hw/pci: introduce
 pci_device_notify_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, kevin.tian@intel.com, jasowang@redhat.com

On Mon, Mar 05, 2018 at 04:43:09PM +0800, Liu, Yi L wrote:
> On Fri, Mar 02, 2018 at 05:06:56PM +0100, Paolo Bonzini wrote:
> > On 01/03/2018 11:33, Liu, Yi L wrote:
> > > +    pci_device_notify_iommu(pdev, PCI_NTY_DEV_ADD);
> > > +
> > >      pci_setup_sva_ops(pdev, &vfio_pci_sva_ops);
> > >  
> > >      return;
> > > @@ -3134,6 +3136,7 @@ static void vfio_exitfn(PCIDevice *pdev)
> > >  {
> > >      VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> > >  
> > > +    pci_device_notify_iommu(pdev, PCI_NTY_DEV_DEL);
> > 
> > Please make the names longer: PCI_IOMMU_NOTIFY_DEVICE_ADDED and
> > PCI_IOMMU_NOTIFY_DEVICE_REMOVED.  (This is independent of my other
> > remark, about doing this in generic PCI code for all devices that
> > register SVA ops).
> 
> Thanks for the suggestion, will appply.

Isn't the name too generic if it's tailored for VFIO only? Would
something like PCI_IOMMU_NOTIFY_VFIO_ADD be a bit better?

-- 
Peter Xu

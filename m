Received: from eggs.gnu.org ([2001:4830:134:3::10]:41065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d0L9f-0004Gz-KY
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d0L9c-00067U-JZ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d0L9c-000673-Dw
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 00:54:16 -0400
Date: Tue, 18 Apr 2017 12:54:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170418045400.GC22226@pxdev.xzpeter.org>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-8-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439054049@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439054049@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Apr 18, 2017 at 04:30:40AM +0000, Liu, Yi L wrote:

[...]

> > +static void vtd_switch_address_space(VTDAddressSpace *as) {
> > +    bool use_iommu;
> > +
> > +    assert(as);
> > +
> > +    use_iommu = as->iommu_state->dmar_enabled;
> > +    if (use_iommu) {
> > +        /* Further checks per-device configuration */
> > +        use_iommu &= !vtd_dev_pt_enabled(as);
> > +    }
> > +
> > +    trace_vtd_switch_address_space(pci_bus_num(as->bus),
> > +                                   VTD_PCI_SLOT(as->devfn),
> > +                                   VTD_PCI_FUNC(as->devfn),
> > +                                   use_iommu);
> 
> Hi Peter,
> 
> Skip address space switching is a good idea to support Passthru mode.
> However, without the address space, the vfio notifier would not be
> registered, thus vIOMMU emulator has no way to connect to host. It is
> no harm if there is only map/unmap notifier. But if we have more notifiers
> other than map/unmap, it may be a problem.
> 
> I think we need to reconsider it here. 

For now I think as switching is good to us in general. Could I know
more context about this? Would it be okay to work on top of this in
the future?

Thanks,

-- 
Peter Xu

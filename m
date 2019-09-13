Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA6CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD5D2081B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD5D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8np7-000742-4T
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1i8nnh-0005v3-OL
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1i8nnf-0000J7-LJ
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:47:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1i8nnf-0000IV-Dh
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:47:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91A5710C0922;
 Fri, 13 Sep 2019 15:47:53 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9F64450C;
 Fri, 13 Sep 2019 15:47:50 +0000 (UTC)
Date: Fri, 13 Sep 2019 09:47:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Message-ID: <20190913094750.03759a4d@x1.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D572135@SHSMSX104.ccr.corp.intel.com>
References: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
 <1566845753-18993-2-git-send-email-kwankhede@nvidia.com>
 <20190828145045.20f2a7b3@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553133@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553184@SHSMSX104.ccr.corp.intel.com>
 <20190830103252.2b427144@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D560D74@SHSMSX104.ccr.corp.intel.com>
 <20190912154106.4e784906@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D572135@SHSMSX104.ccr.corp.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 13 Sep 2019 15:47:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 01/13] vfio: KABI for migration interface
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 23:00:03 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Thursday, September 12, 2019 10:41 PM
> > 
> > On Tue, 3 Sep 2019 06:57:27 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > > Sent: Saturday, August 31, 2019 12:33 AM
> > > >
> > > > On Fri, 30 Aug 2019 08:06:32 +0000
> > > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > >  
> > > > > > From: Tian, Kevin
> > > > > > Sent: Friday, August 30, 2019 3:26 PM
> > > > > >  
> > > > > [...]  
> > > > > > > How does QEMU handle the fact that IOVAs are potentially  
> > dynamic  
> > > > while  
> > > > > > > performing the live portion of a migration?  For example, each  
> > time a  
> > > > > > > guest driver calls dma_map_page() or dma_unmap_page(), a
> > > > > > > MemoryRegionSection pops in or out of the AddressSpace for the  
> > device  
> > > > > > > (I'm assuming a vIOMMU where the device AddressSpace is not
> > > > > > > system_memory).  I don't see any QEMU code that intercepts that  
> > > > change  
> > > > > > > in the AddressSpace such that the IOVA dirty pfns could be  
> > recorded and  
> > > > > > > translated to GFNs.  The vendor driver can't track these beyond  
> > getting  
> > > > > > > an unmap notification since it only knows the IOVA pfns, which  
> > can be  
> > > > > > > re-used with different GFN backing.  Once the DMA mapping is  
> > torn  
> > > > down,  
> > > > > > > it seems those dirty pfns are lost in the ether.  If this works in  
> > QEMU,  
> > > > > > > please help me find the code that handles it.  
> > > > > >
> > > > > > I'm curious about this part too. Interestingly, I didn't find any  
> > log_sync  
> > > > > > callback registered by emulated devices in Qemu. Looks dirty pages
> > > > > > by emulated DMAs are recorded in some implicit way. But KVM  
> > always  
> > > > > > reports dirty page in GFN instead of IOVA, regardless of the  
> > presence of  
> > > > > > vIOMMU. If Qemu also tracks dirty pages in GFN for emulated DMAs
> > > > > >  (translation can be done when DMA happens), then we don't need
> > > > > > worry about transient mapping from IOVA to GFN. Along this way  
> > we  
> > > > > > also want GFN-based dirty bitmap being reported through VFIO,
> > > > > > similar to what KVM does. For vendor drivers, it needs to translate
> > > > > > from IOVA to HVA to GFN when tracking DMA activities on VFIO
> > > > > > devices. IOVA->HVA is provided by VFIO. for HVA->GFN, it can be
> > > > > > provided by KVM but I'm not sure whether it's exposed now.
> > > > > >  
> > > > >
> > > > > HVA->GFN can be done through hva_to_gfn_memslot in kvm_host.h.  
> > > >
> > > > I thought it was bad enough that we have vendor drivers that depend  
> > on  
> > > > KVM, but designing a vfio interface that only supports a KVM interface
> > > > is more undesirable.  I also note without comment that  
> > gfn_to_memslot()  
> > > > is a GPL symbol.  Thanks,  
> > >
> > > yes it is bad, but sometimes inevitable. If you recall our discussions
> > > back to 3yrs (when discussing the 1st mdev framework), there were  
> > similar  
> > > hypervisor dependencies in GVT-g, e.g. querying gpa->hpa when
> > > creating some shadow structures. gpa->hpa is definitely hypervisor
> > > specific knowledge, which is easy in KVM (gpa->hva->hpa), but needs
> > > hypercall in Xen. but VFIO already makes assumption based on KVM-
> > > only flavor when implementing vfio_{un}pin_page_external.  
> > 
> > Where's the KVM assumption there?  The MAP_DMA ioctl takes an IOVA
> > and
> > HVA.  When an mdev vendor driver calls vfio_pin_pages(), we GUP the HVA
> > to get an HPA and provide an array of HPA pfns back to the caller.  The
> > other vGPU mdev vendor manages to make use of this without KVM... the
> > KVM interface used by GVT-g is GPL-only.  
> 
> To be clear it's the assumption on the host-based hypervisors e.g. KVM.
> GUP is a perfect example, which doesn't work for Xen since DomU's
> memory doesn't belong to Dom0. VFIO in Dom0 has to find the HPA
> through Xen specific hypercalls.

VFIO does not assume a hypervisor at all.  Yes, it happens to work well
with a host-based hypervisor like KVM were we can simply use GUP, but
I'd hardly call using the standard mechanism to pin a user page and get
the pfn within the Linux kernel a KVM assumption.  The fact that Dom0
Xen requires work here while KVM does not does is not an equivalency to
VFIO assuming KVM.  Thanks,

Alex
 
> > > So GVT-g
> > > has to maintain an internal abstraction layer to support both Xen and
> > > KVM. Maybe someday we will re-consider introducing some hypervisor
> > > abstraction layer in VFIO, if this issue starts to hurt other devices and
> > > Xen guys are willing to support VFIO.  
> > 
> > Once upon a time, we had a KVM specific device assignment interface,
> > ie. legacy KVM devie assignment.  We developed VFIO specifically to get
> > KVM out of the business of being a (bad) device driver.  We do have
> > some awareness and interaction between VFIO and KVM in the vfio-kvm
> > pseudo device, but we still try to keep those interfaces generic.  In
> > some cases we're not very successful at that, see vfio_group_set_kvm(),
> > but that's largely just a mechanism to associate a cookie with a group
> > to be consumed by the mdev vendor driver such that it can work with kvm
> > external to vfio.  I don't intend to add further hypervisor awareness
> > to vfio.
> >   
> > > Back to this IOVA issue, I discussed with Yan and we found another
> > > hypervisor-agnostic alternative, by learning from vhost. vhost is very
> > > similar to VFIO - DMA also happens in the kernel, while it already
> > > supports vIOMMU.
> > >
> > > Generally speaking, there are three paths of dirty page collection
> > > in Qemu so far (as previously noted, Qemu always tracks the dirty
> > > bitmap in GFN):  
> > 
> > GFNs or simply PFNs within an AddressSpace?
> >   
> > > 1) Qemu-tracked memory writes (e.g. emulated DMAs). Dirty bitmaps
> > > are updated directly when the guest memory is being updated. For
> > > example, PCI writes are completed through pci_dma_write, which
> > > goes through vIOMMU to translate IOVA into GPA and then update
> > > the bitmap through cpu_physical_memory_set_dirty_range.  
> > 
> > Right, so the IOVA to GPA (GFN) occurs through an explicit translation
> > on the IOMMU AddressSpace.
> >   
> > > 2) Memory writes that are not tracked by Qemu are collected by
> > > registering .log_sync() callback, which is invoked in the dirty logging
> > > process. Now there are two users: kvm and vhost.
> > >
> > >   2.1) KVM tracks CPU-side memory writes, through write-protection
> > > or EPT A/D bits (+PML). This part is always based on GFN and returned
> > > to Qemu when kvm_log_sync is invoked;
> > >
> > >   2.2) vhost tracks kernel-side DMA writes, by interpreting vring
> > > data structure. It maintains an internal iotlb which is synced with
> > > Qemu vIOMMU through a specific interface:
> > > 	- new vhost message type (VHOST_IOTLB_UPDATE/INVALIDATE)
> > > for Qemu to keep vhost iotlb in sync
> > > 	- new VHOST_IOTLB_MISS message to notify Qemu in case of
> > > a miss in vhost iotlb.
> > > 	- Qemu registers a log buffer to kernel vhost driver. The latter
> > > update the buffer (using internal iotlb to get GFN) when serving vring
> > > descriptor.
> > >
> > > VFIO could also implement an internal iotlb, so vendor drivers can
> > > utilize the iotlb to update the GFN-based dirty bitmap. Ideally we
> > > don't need re-invent another iotlb protocol as vhost does. vIOMMU
> > > already sends map/unmap ioctl cmds upon any change of IOVA
> > > mapping. We may introduce a v2 map/unmap interface, allowing
> > > Qemu to pass both {iova, gpa, hva} together to keep internal iotlb
> > > in-sync. But we may also need a iotlb_miss_upcall interface, if VFIO
> > > doesn't want to cache full-size vIOMMU mappings.
> > >
> > > Definitely this alternative needs more work and possibly less
> > > performant (if maintaining a small size iotlb) than straightforward
> > > calling into KVM interface. But the gain is also obvious, since it
> > > is fully constrained with VFIO.
> > >
> > > Thoughts? :-)  
> > 
> > So vhost must then be configuring a listener across system memory
> > rather than only against the device AddressSpace like we do in vfio,
> > such that it get's log_sync() callbacks for the actual GPA space rather
> > than only the IOVA space.  OTOH, QEMU could understand that the device
> > AddressSpace has a translate function and apply the IOVA dirty bits to
> > the system memory AddressSpace.  Wouldn't it make more sense for
> > QEMU
> > to perform a log_sync() prior to removing a MemoryRegionSection within
> > an AddressSpace and update the GPA rather than pushing GPA awareness
> > and potentially large tracking structures into the host kernel?  Thanks,
> >   
> 
> It is an interesting idea.  One drawback is that log_sync might be
> frequently invoked in IOVA case, but I guess the overhead is not much 
> compared to the total overhead of emulating the IOTLB invalidation. 
> Maybe other folks can better comment why this model was not 
> considered before, e.g. when vhost iotlb was introduced.
> 
> Thanks
> Kevin



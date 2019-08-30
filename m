Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CA9C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86152342C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 16:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86152342C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3jsN-0001il-C8
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 12:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1i3jpg-0008MC-CN
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1i3jpa-000106-Lo
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:32:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1i3jpa-0000sD-DV
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 12:32:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9C47189DAD0;
 Fri, 30 Aug 2019 16:32:55 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5A546012C;
 Fri, 30 Aug 2019 16:32:53 +0000 (UTC)
Date: Fri, 30 Aug 2019 10:32:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Message-ID: <20190830103252.2b427144@x1.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D553184@SHSMSX104.ccr.corp.intel.com>
References: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
 <1566845753-18993-2-git-send-email-kwankhede@nvidia.com>
 <20190828145045.20f2a7b3@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553133@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D553184@SHSMSX104.ccr.corp.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 30 Aug 2019 16:32:56 +0000 (UTC)
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

On Fri, 30 Aug 2019 08:06:32 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Tian, Kevin
> > Sent: Friday, August 30, 2019 3:26 PM
> >   
> [...]
> > > How does QEMU handle the fact that IOVAs are potentially dynamic while
> > > performing the live portion of a migration?  For example, each time a
> > > guest driver calls dma_map_page() or dma_unmap_page(), a
> > > MemoryRegionSection pops in or out of the AddressSpace for the device
> > > (I'm assuming a vIOMMU where the device AddressSpace is not
> > > system_memory).  I don't see any QEMU code that intercepts that change
> > > in the AddressSpace such that the IOVA dirty pfns could be recorded and
> > > translated to GFNs.  The vendor driver can't track these beyond getting
> > > an unmap notification since it only knows the IOVA pfns, which can be
> > > re-used with different GFN backing.  Once the DMA mapping is torn down,
> > > it seems those dirty pfns are lost in the ether.  If this works in QEMU,
> > > please help me find the code that handles it.  
> > 
> > I'm curious about this part too. Interestingly, I didn't find any log_sync
> > callback registered by emulated devices in Qemu. Looks dirty pages
> > by emulated DMAs are recorded in some implicit way. But KVM always
> > reports dirty page in GFN instead of IOVA, regardless of the presence of
> > vIOMMU. If Qemu also tracks dirty pages in GFN for emulated DMAs
> >  (translation can be done when DMA happens), then we don't need
> > worry about transient mapping from IOVA to GFN. Along this way we
> > also want GFN-based dirty bitmap being reported through VFIO,
> > similar to what KVM does. For vendor drivers, it needs to translate
> > from IOVA to HVA to GFN when tracking DMA activities on VFIO
> > devices. IOVA->HVA is provided by VFIO. for HVA->GFN, it can be
> > provided by KVM but I'm not sure whether it's exposed now.
> >   
> 
> HVA->GFN can be done through hva_to_gfn_memslot in kvm_host.h.

I thought it was bad enough that we have vendor drivers that depend on
KVM, but designing a vfio interface that only supports a KVM interface
is more undesirable.  I also note without comment that gfn_to_memslot()
is a GPL symbol.  Thanks,

Alex

> Above flow works for software-tracked dirty mechanism, e.g. in
> KVMGT, where GFN-based 'dirty' is marked when a guest page is 
> mapped into device mmu. IOVA->HPA->GFN translation is done 
> at that time, thus immune from further IOVA->GFN changes.
> 
> When hardware IOMMU supports D-bit in 2nd level translation (e.g.
> VT-d rev3.0), there are two scenarios:
> 
> 1) nested translation: guest manages 1st-level translation (IOVA->GPA)
> and host manages 2nd-level translation (GPA->HPA). The 2nd-level
> is not affected by guest mapping operations. So it's OK for IOMMU
> driver to retrieve GFN-based dirty pages by directly scanning the 2nd-
> level structure, upon request from user space. 
> 
> 2) shadowed translation (IOVA->HPA) in 2nd level: in such case the dirty
> information is tied to IOVA. the IOMMU driver is expected to maintain
> an internal dirty bitmap. Upon any change of IOVA->GPA notification
> from VFIO, the IOMMU driver should flush dirty status of affected 2nd-level
> entries to the internal GFN-based bitmap. At this time, again IOVA->HVA
> ->GPA translation required for GFN-based recording. When userspace   
> queries dirty bitmap, the IOMMU driver needs to flush latest 2nd-level 
> dirty status to internal bitmap, which is then copied to user space.
> 
> Given the trickiness of 2), we aim to enable 1) on intel-iommu driver.
> 
> Thanks
> Kevin



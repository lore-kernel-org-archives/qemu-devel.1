Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE8C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 18:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320BB20675
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 18:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPW6H5MP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320BB20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icZVr-0002G8-Cn
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 13:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1icZUW-0001Nj-EH
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 13:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1icZUS-0004Cu-Vv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 13:35:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47159
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1icZUS-0004Cc-LV
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 13:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575484507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/nsvebpyF2p865iJnrIKFt8DMxlT7kOiXgF6p2enjs=;
 b=IPW6H5MPPMYhX1BkUkqml3BJoAXyHDOIDOGtA4a2CIS3idJMz8Jo6qE0Qo6KRNWeVE3xK0
 vH7pyasB8N3VxWY5Lci5JyQ8b7w30yj9nKrXJc4jv4s139oh4mJgXx4KaAI8ogqBKvj8Zm
 wCwb/qhOdGYtyAWpMFUiuvnMtnXf0sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-IisY0m9nMt2xVY8rki43Ig-1; Wed, 04 Dec 2019 13:35:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26C71DB2F;
 Wed,  4 Dec 2019 18:35:01 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38C4519C68;
 Wed,  4 Dec 2019 18:34:59 +0000 (UTC)
Date: Wed, 4 Dec 2019 11:34:57 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 Kernel 2/5] vfio iommu: Add ioctl defination to get
 dirty pages bitmap.
Message-ID: <20191204113457.16c1316d@x1.home>
In-Reply-To: <cce08ca5-79df-2839-16cd-15723b995c07@nvidia.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-3-git-send-email-kwankhede@nvidia.com>
 <20191112153020.71406c44@x1.home>
 <324ce4f8-d655-ee37-036c-fc9ef9045bef@nvidia.com>
 <20191113130705.32c6b663@x1.home>
 <7f74a2a1-ba1c-9d4c-dc5e-343ecdd7d6d6@nvidia.com>
 <20191114140625.213e8a99@x1.home>
 <20191126005739.GA31144@joy-OptiPlex-7040>
 <20191203110412.055c38df@x1.home>
 <cce08ca5-79df-2839-16cd-15723b995c07@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: IisY0m9nMt2xVY8rki43Ig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 Yan Zhao <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Dec 2019 23:40:25 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 12/3/2019 11:34 PM, Alex Williamson wrote:
> > On Mon, 25 Nov 2019 19:57:39 -0500
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >   
> >> On Fri, Nov 15, 2019 at 05:06:25AM +0800, Alex Williamson wrote:  
> >>> On Fri, 15 Nov 2019 00:26:07 +0530
> >>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>      
> >>>> On 11/14/2019 1:37 AM, Alex Williamson wrote:  
> >>>>> On Thu, 14 Nov 2019 01:07:21 +0530
> >>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>        
> >>>>>> On 11/13/2019 4:00 AM, Alex Williamson wrote:  
> >>>>>>> On Tue, 12 Nov 2019 22:33:37 +0530
> >>>>>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>>>>>>           
> >>>>>>>> All pages pinned by vendor driver through vfio_pin_pages API should be
> >>>>>>>> considered as dirty during migration. IOMMU container maintains a list of
> >>>>>>>> all such pinned pages. Added an ioctl defination to get bitmap of such  
> >>>>>>>
> >>>>>>> definition
> >>>>>>>           
> >>>>>>>> pinned pages for requested IO virtual address range.  
> >>>>>>>
> >>>>>>> Additionally, all mapped pages are considered dirty when physically
> >>>>>>> mapped through to an IOMMU, modulo we discussed devices opting in to
> >>>>>>> per page pinning to indicate finer granularity with a TBD mechanism to
> >>>>>>> figure out if any non-opt-in devices remain.
> >>>>>>>           
> >>>>>>
> >>>>>> You mean, in case of device direct assignment (device pass through)?  
> >>>>>
> >>>>> Yes, or IOMMU backed mdevs.  If vfio_dmas in the container are fully
> >>>>> pinned and mapped, then the correct dirty page set is all mapped pages.
> >>>>> We discussed using the vpfn list as a mechanism for vendor drivers to
> >>>>> reduce their migration footprint, but we also discussed that we would
> >>>>> need a way to determine that all participants in the container have
> >>>>> explicitly pinned their working pages or else we must consider the
> >>>>> entire potential working set as dirty.
> >>>>>        
> >>>>
> >>>> How can vendor driver tell this capability to iommu module? Any suggestions?  
> >>>
> >>> I think it does so by pinning pages.  Is it acceptable that if the
> >>> vendor driver pins any pages, then from that point forward we consider
> >>> the IOMMU group dirty page scope to be limited to pinned pages?  There  
> >> we should also be aware of that dirty page scope is pinned pages + unpinned pages,
> >> which means ever since a page is pinned, it should be regarded as dirty
> >> no matter whether it's unpinned later. only after log_sync is called and
> >> dirty info retrieved, its dirty state should be cleared.  
> > 
> > Yes, good point.  We can't just remove a vpfn when a page is unpinned
> > or else we'd lose information that the page potentially had been
> > dirtied while it was pinned.  Maybe that vpfn needs to move to a dirty
> > list and both the currently pinned vpfns and the dirty vpfns are walked
> > on a log_sync.  The dirty vpfns list would be cleared after a log_sync.
> > The container would need to know that dirty tracking is enabled and
> > only manage the dirty vpfns list when necessary.  Thanks,
> >   
> 
> If page is unpinned, then that page is available in free page pool for 
> others to use, then how can we say that unpinned page has valid data?
> 
> If suppose, one driver A unpins a page and when driver B of some other 
> device gets that page and he pins it, uses it, and then unpins it, then 
> how can we say that page has valid data for driver A?
> 
> Can you give one example where unpinned page data is considered reliable 
> and valid?

We can only pin pages that the user has already allocated* and mapped
through the vfio DMA API.  The pinning of the page simply locks the
page for the vendor driver to access it and unpinning that page only
indicates that access is complete.  Pages are not freed when a vendor
driver unpins them, they still exist and at this point we're now
assuming the device dirtied the page while it was pinned.  Thanks,

Alex

* An exception here is that the page might be demand allocated and the
  act of pinning the page could actually allocate the backing page for
  the user if they have not faulted the page to trigger that allocation
  previously.  That page remains mapped for the user's virtual address
  space even after the unpinning though.



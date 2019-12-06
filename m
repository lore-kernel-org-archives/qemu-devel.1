Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6349C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7BE24670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7BE24670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idF56-0006uM-BV
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1idETg-0006Xs-Oi
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1idETf-0000r6-9z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:21:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:37384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1idETd-0000nX-CR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:21:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Dec 2019 21:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,283,1571727600"; d="scan'208";a="413229029"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.9])
 by fmsmga006.fm.intel.com with ESMTP; 05 Dec 2019 21:59:06 -0800
Date: Fri, 6 Dec 2019 00:50:57 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 3/9] vfio/pci: register a default migration region
Message-ID: <20191206055057.GE31791@joy-OptiPlex-7040>
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
 <20191205032638.29747-1-yan.y.zhao@intel.com>
 <20191205165515.3a9ac7b6@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205165515.3a9ac7b6@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "He,
 Shaopeng" <shaopeng.he@intel.com>, "Wang, Zhi A" <zhi.a.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 06, 2019 at 07:55:15AM +0800, Alex Williamson wrote:
> On Wed,  4 Dec 2019 22:26:38 -0500
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > Vendor driver specifies when to support a migration region through cap
> > VFIO_PCI_DEVICE_CAP_MIGRATION in vfio_pci_mediate_ops->open().
> > 
> > If vfio-pci detects this cap, it creates a default migration region on
> > behalf of vendor driver with region len=0 and region->ops=null.
> > Vendor driver should override this region's len, flags, rw, mmap in
> > its vfio_pci_mediate_ops.
> > 
> > This migration region definition is aligned to QEMU vfio migration code v8:
> > (https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05542.html)
> > 
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > 
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  drivers/vfio/pci/vfio_pci.c |  15 ++++
> >  include/linux/vfio.h        |   1 +
> >  include/uapi/linux/vfio.h   | 149 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 165 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index f3730252ee82..059660328be2 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -115,6 +115,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> >  	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
> >  }
> >  
> > +/**
> > + * init a region to hold migration ctl & data
> > + */
> > +void init_migration_region(struct vfio_pci_device *vdev)
> > +{
> > +	vfio_pci_register_dev_region(vdev, VFIO_REGION_TYPE_MIGRATION,
> > +		VFIO_REGION_SUBTYPE_MIGRATION,
> > +		NULL, 0,
> > +		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE,
> > +		NULL);
> > +}
> > +
> >  static void vfio_pci_probe_mmaps(struct vfio_pci_device *vdev)
> >  {
> >  	struct resource *res;
> > @@ -523,6 +535,9 @@ static int vfio_pci_open(void *device_data)
> >  				vdev->mediate_ops = mentry->ops;
> >  				vdev->mediate_handle = handle;
> >  
> > +				if (caps & VFIO_PCI_DEVICE_CAP_MIGRATION)
> > +					init_migration_region(vdev);
> 
> No.  We're not going to add a cap flag for every region the mediation
> driver wants to add.  The mediation driver should have the ability to
> add regions and irqs to the device itself.  Thanks,
> 
> Alex
>
ok. got it. will do it.

Thanks
Yan

> > +
> >  				pr_info("vfio pci found mediate_ops %s, caps=%llx, handle=%x for %x:%x\n",
> >  						vdev->mediate_ops->name, caps,
> >  						handle, vdev->pdev->vendor,
> 


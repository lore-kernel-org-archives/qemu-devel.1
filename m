Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949E7C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 01:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A06F20724
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 01:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A06F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGuVP-0007aN-Ch
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 21:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jGuUq-0007Bw-D7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 21:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jGuUo-0003AU-6j
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 21:06:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:18284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jGuUn-000377-Uz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 21:06:14 -0400
IronPort-SDR: hjWb5P/xsL3IP5uDKLfEYgeZmKjm5xhToeHxAy9wR2c2x4FHUZ5US6DBuJ9MUoP1pQTot5x3wh
 A6ayCW8yIs7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2020 18:06:09 -0700
IronPort-SDR: z5R6lpjG8+2Oc1MM89RRMHOBYnTW4DVLrjfbD/wS/e2JrgHpwwTPP0nHfUphaKQqI2BmxmGIG/
 bf8OkxO1AWWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; d="scan'208";a="246951513"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga003.jf.intel.com with ESMTP; 24 Mar 2020 18:06:03 -0700
Date: Tue, 24 Mar 2020 20:56:32 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v4 0/2] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200325005631.GA20109@joy-OptiPlex-7040>
References: <20190531004438.24528-1-yan.y.zhao@intel.com>
 <20190603132932.1b5dc7fe@x1.home>
 <20190604003422.GA30229@joy-OptiPlex-7040>
 <20200323152959.1c39e9a7@w520.home>
 <20200324035316.GE5456@joy-OptiPlex-7040>
 <20200324092331.GA2645@work-vm> <20200324084954.0dd835e2@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324084954.0dd835e2@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Yang, Ziye" <ziye.yang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
 "He, Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 24, 2020 at 10:49:54PM +0800, Alex Williamson wrote:
> On Tue, 24 Mar 2020 09:23:31 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Yan Zhao (yan.y.zhao@intel.com) wrote:
> > > On Tue, Mar 24, 2020 at 05:29:59AM +0800, Alex Williamson wrote:  
> > > > On Mon, 3 Jun 2019 20:34:22 -0400
> > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > >   
> > > > > On Tue, Jun 04, 2019 at 03:29:32AM +0800, Alex Williamson wrote:  
> > > > > > On Thu, 30 May 2019 20:44:38 -0400
> > > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > > >     
> > > > > > > This patchset introduces a migration_version attribute under sysfs of VFIO
> > > > > > > Mediated devices.
> > > > > > > 
> > > > > > > This migration_version attribute is used to check migration compatibility
> > > > > > > between two mdev devices of the same mdev type.
> > > > > > > 
> > > > > > > Patch 1 defines migration_version attribute in
> > > > > > > Documentation/vfio-mediated-device.txt
> > > > > > > 
> > > > > > > Patch 2 uses GVT as an example to show how to expose migration_version
> > > > > > > attribute and check migration compatibility in vendor driver.    
> > > > > > 
> > > > > > Thanks for iterating through this, it looks like we've settled on
> > > > > > something reasonable, but now what?  This is one piece of the puzzle to
> > > > > > supporting mdev migration, but I don't think it makes sense to commit
> > > > > > this upstream on its own without also defining the remainder of how we
> > > > > > actually do migration, preferably with more than one working
> > > > > > implementation and at least prototyped, if not final, QEMU support.  I
> > > > > > hope that was the intent, and maybe it's now time to look at the next
> > > > > > piece of the puzzle.  Thanks,
> > > > > > 
> > > > > > Alex    
> > > > > 
> > > > > Got it. 
> > > > > Also thank you and all for discussing and guiding all along:)
> > > > > We'll move to the next episode now.  
> > > > 
> > > > Hi Yan,
> > > > 
> > > > As we're hopefully moving towards a migration API, would it make sense
> > > > to refresh this series at the same time?  I think we're still expecting
> > > > a vendor driver implementing Kirti's migration API to also implement
> > > > this sysfs interface for compatibility verification.  Thanks,
> > > >  
> > > Hi Alex
> > > Got it!
> > > Thanks for reminding of this. And as now we have vfio-pci implementing
> > > vendor ops to allow live migration of pass-through devices, is it
> > > necessary to implement similar sysfs node for those devices?
> > > or do you think just PCI IDs of those devices are enough for libvirt to
> > > know device compatibility ?  
> > 
> > Wasn't the problem that we'd have to know how to check for things like:
> >   a) Whether different firmware versions in the device were actually
> > compatible
> >   b) Whether minor hardware differences were compatible - e.g. some
> > hardware might let you migrate to the next version of hardware up.
> 
> Yes, minor changes in hardware or firmware that may not be represented
> in the device ID or hardware revision.  Also the version is as much for
> indicating the compatibility of the vendor defined migration protocol
> as it is for the hardware itself.  I certainly wouldn't be so bold as
> to create a protocol that is guaranteed compatible forever.  We'll need
> to expose the same sysfs attribute in some standard location for
> non-mdev devices.  I assume vfio-pci would provide the vendor ops some
> mechanism to expose these in a standard namespace of sysfs attributes
> under the device itself.  Perhaps that indicates we need to link the
> mdev type version under the mdev device as well to make this
> transparent to userspace tools like libvirt.  Thanks,
>
Got it. will do it.
Thanks!

Yan


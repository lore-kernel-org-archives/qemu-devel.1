Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA33C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 01:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31CEA206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 01:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CEA206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQLLZ-0005IJ-An
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 21:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38726 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jQLKq-0004s1-S1
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 21:34:57 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jQLKp-0000up-Vc
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 21:34:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:58910)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jQLKp-0000SB-FG
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 21:34:55 -0400
IronPort-SDR: 036MwlCjKzO6P+z28hF1uL3robfZsMTbU52uh0YXRYe5ROtdMPMJJaXYEBRdqZ8BFK5aNB9Czv
 BJiX6fmuul4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 18:34:44 -0700
IronPort-SDR: mm9uYTLuqw3ULYhWUSIwaiLjiK6ca7daOboSjHKj+5Z0IuEY/WGDFtohzFWgugijJkXpwe1AdE
 F3ggOZbj3jVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; d="scan'208";a="428940295"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga005.jf.intel.com with ESMTP; 19 Apr 2020 18:34:37 -0700
Date: Sun, 19 Apr 2020 21:24:57 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200420012457.GE16688@joy-OptiPlex-7040>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
 <20200417104450.2d2f2fa9.cohuck@redhat.com>
 <20200417095202.GD16688@joy-OptiPlex-7040>
 <20200417132457.45d91fe3.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417132457.45d91fe3.cohuck@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.31; envelope-from=yan.y.zhao@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs1p.gnu.org: FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.31
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
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
 Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 07:24:57PM +0800, Cornelia Huck wrote:
> On Fri, 17 Apr 2020 05:52:02 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Fri, Apr 17, 2020 at 04:44:50PM +0800, Cornelia Huck wrote:
> > > On Mon, 13 Apr 2020 01:52:01 -0400
> > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > >   
> > > > This patchset introduces a migration_version attribute under sysfs of VFIO
> > > > Mediated devices.
> > > > 
> > > > This migration_version attribute is used to check migration compatibility
> > > > between two mdev devices.
> > > > 
> > > > Currently, it has two locations:
> > > > (1) under mdev_type node,
> > > >     which can be used even before device creation, but only for mdev
> > > >     devices of the same mdev type.
> > > > (2) under mdev device node,
> > > >     which can only be used after the mdev devices are created, but the src
> > > >     and target mdev devices are not necessarily be of the same mdev type
> > > > (The second location is newly added in v5, in order to keep consistent
> > > > with the migration_version node for migratable pass-though devices)  
> > > 
> > > What is the relationship between those two attributes?
> > >   
> > (1) is for mdev devices specifically, and (2) is provided to keep the same
> > sysfs interface as with non-mdev cases. so (2) is for both mdev devices and
> > non-mdev devices.
> > 
> > in future, if we enable vfio-pci vendor ops, (i.e. a non-mdev device
> > is binding to vfio-pci, but is able to register migration region and do
> > migration transactions from a vendor provided affiliate driver),
> > the vendor driver would export (2) directly, under device node.
> > It is not able to provide (1) as there're no mdev devices involved.
> 
> Ok, creating an alternate attribute for non-mdev devices makes sense.
> However, wouldn't that rather be a case (3)? The change here only
> refers to mdev devices.
>
as you pointed below, (3) and (2) serve the same purpose. 
and I think a possible usage is to migrate between a non-mdev device and
an mdev device. so I think it's better for them both to use (2) rather
than creating (3).
> > 
> > > Is existence (and compatibility) of (1) a pre-req for possible
> > > existence (and compatibility) of (2)?
> > >  
> > no. (2) does not reply on (1).
> 
> Hm. Non-existence of (1) seems to imply "this type does not support
> migration". If an mdev created for such a type suddenly does support
> migration, it feels a bit odd.
> 
yes. but I think if the condition happens, it should be reported a bug
to vendor driver.
should I add a line in the doc like "vendor driver should ensure that the
migration compatibility from migration_version under mdev_type should be
consistent with that from migration_version under device node" ?

> (It obviously cannot be a prereq for what I called (3) above.)
> 
> > 
> > > Does userspace need to check (1) or can it completely rely on (2), if
> > > it so chooses?
> > >  
> > I think it can completely reply on (2) if compatibility check before
> > mdev creation is not required.
> > 
> > > If devices with a different mdev type are indeed compatible, it seems
> > > userspace can only find out after the devices have actually been
> > > created, as (1) does not apply?  
> > yes, I think so. 
> 
> How useful would it be for userspace to even look at (1) in that case?
> It only knows if things have a chance of working if it actually goes
> ahead and creates devices.
>
hmm, is it useful for userspace to test the migration_version under mdev
type before it knows what mdev device to generate ?
like when the userspace wants to migrate an mdev device in src vm,
but it has not created target vm and the target mdev device.

> > 
> > > One of my worries is that the existence of an attribute with the same
> > > name in two similar locations might lead to confusion. But maybe it
> > > isn't a problem.
> > >  
> > Yes, I have the same feeling. but as (2) is for sysfs interface
> > consistency, to make it transparent to userspace tools like libvirt,
> > I guess the same name is necessary?
> 
> What do we actually need here, I wonder? (1) and (2) seem to serve
> slightly different purposes, while (2) and what I called (3) have the
> same purpose. Is it important to userspace that (1) and (2) have the
> same name?
so change (1) to migration_type_version and (2) to
migration_instance_version?
But as they are under different locations, could that location imply
enough information?


Thanks
Yan




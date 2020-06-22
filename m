Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E704C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 02:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E898C25378
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 02:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E898C25378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnCMx-00022N-3f
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 22:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jnCM9-0001b9-GU
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 22:38:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:12103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jnCM6-0000QP-Tj
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 22:38:44 -0400
IronPort-SDR: skm1HFZZajnBPlyCnfo3FsZTXyloTVktCxGwuvCu1jUawIdauhhcuLi46cl+/A6ASW8eVpWEoR
 cpKQBi29MUrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="228319709"
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; d="scan'208";a="228319709"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2020 19:38:37 -0700
IronPort-SDR: kLI/D8Q8tZxkRPPFuiYPaE98ZUv1IOQQhFqpjbEvK2nvhnQsDpBIUcqoVcKllluunqSdvOAhbn
 t3Z8I20xo8XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,265,1589266800"; d="scan'208";a="422482828"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga004.jf.intel.com with ESMTP; 21 Jun 2020 19:38:31 -0700
Date: Sun, 21 Jun 2020 22:28:28 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200622022827.GA18338@joy-OptiPlex-7040>
References: <20200602165527.34137955@x1.home>
 <20200603031948.GB12300@joy-OptiPlex-7040>
 <20200602215528.7a1008f0@x1.home>
 <20200603052443.GC12300@joy-OptiPlex-7040>
 <20200603102628.017e2896@x1.home> <20200605102224.GB2936@work-vm>
 <20200605083149.1809e783@x1.home> <20200605143950.GG2897@work-vm>
 <20200610003731.GA13961@joy-OptiPlex-7040>
 <20200619164046.2bdc2f67@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619164046.2bdc2f67@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.43; envelope-from=yan.y.zhao@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 22:38:38
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Cornelia Huck <cohuck@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Yang, Ziye" <ziye.yang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
 "He, Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 04:40:46PM -0600, Alex Williamson wrote:
> On Tue, 9 Jun 2020 20:37:31 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Fri, Jun 05, 2020 at 03:39:50PM +0100, Dr. David Alan Gilbert wrote:
> > > > > > I tried to simplify the problem a bit, but we keep going backwards.  If
> > > > > > the requirement is that potentially any source device can migrate to any
> > > > > > target device and we cannot provide any means other than writing an
> > > > > > opaque source string into a version attribute on the target and
> > > > > > evaluating the result to determine compatibility, then we're requiring
> > > > > > userspace to do an exhaustive search to find a potential match.  That
> > > > > > sucks.     
> > > > >  
> > hi Alex and Dave,
> > do you think it's good for us to put aside physical devices and mdev aggregation
> > for the moment, and use Alex's original idea that
> > 
> > +  Userspace should regard two mdev devices compatible when ALL of below
> > +  conditions are met:
> > +  (0) The mdev devices are of the same type
> > +  (1) success when reading from migration_version attribute of one mdev device.
> > +  (2) success when writing migration_version string of one mdev device to
> > +  migration_version attribute of the other mdev device.
> 
> I think Pandora's box is already opened, if we can't articulate how
> this solution would evolve to support features that we know are coming,
> why should we proceed with this approach?  We've already seen interest
> in breaking rule (0) in this thread, so we can't focus the solution on
> mdev devices.
> 
> Maybe the best we can do is to compare one instance of a device to
> another instance of a device, without any capability to predict
> compatibility prior to creating devices, in the case on mdev.  The
> string would need to include not only the device and vendor driver
> compatibility, but also anything that has modified the state of the
> device, such as creation time or post-creation time configuration.  The
> user is left on their own for creating a compatible device, or
> filtering devices to determine which might be, or which might generate,
> compatible devices.  It's not much of a solution, I wonder if anyone
> would even use it.
> 
> > and what about adding another sysfs attribute for vendors to put
> > recommended migration compatible device type. e.g.
> > #cat /sys/bus/pci/devices/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_8/migration_compatible_devices
> > parent id: 8086 591d
> > mdev_type: i915-GVTg_V5_8
> > 
> > vendors are free to define the format and conent of this migration_compatible_devices
> > and it's even not to be a full list.
> > 
> > before libvirt or user to do live migration, they have to read and test
> > migration_version attributes of src/target devices to check migration compatibility.
> 
> AFAICT, free-form, vendor defined attributes are useless to libvirt.
> Vendors could already put this information in the description attribute
> and have it ignored by userspace tools due to the lack of defined
> format.  It's also not clear what value this provides when it's
> necessarily incomplete, a driver written today cannot know what future
> drivers might be compatible with its migration data.  Thanks,
>
hi Alex
maybe the problem can be divided into two pieces:
(1) how to create/locate two migration compatible devices. For normal
users, the most common and safest way to do it is to find a exact duplication
of the source device. so for mdev, it's probably to create a target mdev
of the same parent pci id, mdev type and creation parameters as the
source mdev; and for physical devices, it's to locate a target device of the
same pci id as the source device, plus some extra constraints (e.g. the
target NVMe device is configured to the same remote device as the source
NVMe device; or the target QAT device is supporting equal encryption
algorithm set as the source QAT device...).
I think a possible solution for this piece is to let vendor drivers provide a
creating/locating script to find such exact duplication of source device.
Then before libvirt is about to do live migration, it can use this script to
create a target vm of exactly duplicated configuration of the source vm.

(2) how to identify two devices are migration compatible after they are
created and even they are not exactly identical (e.g. their parent
devices are of minor difference in hardware SKUs). This identification is
necessary even after in step (1) when libvirt has created/located two
identical devices and are about to start live migration.
Also, users are free to create/configure target devices and use the
read-and-test interfaces defined in this series to check if they are
live migration compatible.
The read and test behavior in this patch set can grant vendor drivers the
freedom to decide whether to support migration between only exact identical
devices or able to support migration between devices of minor
difference. 

So, do you think we can let this series focus on the second piece of
problem and leave the first piece to other future series.

Thanks
Yan























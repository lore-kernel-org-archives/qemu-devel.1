Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A55AC352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D62121D95
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D62121D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPNpu-0003eP-Ku
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jPNou-0002o5-0s
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1jPNon-00004z-Kw
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:01:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:10317)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1jPNon-0008Gw-4h
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:01:53 -0400
IronPort-SDR: me3L/3DFxg2w2VdJquedRHIkN2eThDQWXoqj02qR3vstppmJ9MgTVeepdVZheibC6NTKbfWf2I
 8vvF1a3YSciw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2020 03:01:48 -0700
IronPort-SDR: RRMDjiqrvQ2P/0gurYOYvUWAJrG/sp/kx652ixtBwkFyqw2s4kkhPO4KjOMYq+gVZJLivZFFld
 11a36OM2x6Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,394,1580803200"; d="scan'208";a="454679512"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 17 Apr 2020 03:01:41 -0700
Date: Fri, 17 Apr 2020 05:52:02 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200417095202.GD16688@joy-OptiPlex-7040>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
 <20200417104450.2d2f2fa9.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417104450.2d2f2fa9.cohuck@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.93
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

On Fri, Apr 17, 2020 at 04:44:50PM +0800, Cornelia Huck wrote:
> On Mon, 13 Apr 2020 01:52:01 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > This patchset introduces a migration_version attribute under sysfs of VFIO
> > Mediated devices.
> > 
> > This migration_version attribute is used to check migration compatibility
> > between two mdev devices.
> > 
> > Currently, it has two locations:
> > (1) under mdev_type node,
> >     which can be used even before device creation, but only for mdev
> >     devices of the same mdev type.
> > (2) under mdev device node,
> >     which can only be used after the mdev devices are created, but the src
> >     and target mdev devices are not necessarily be of the same mdev type
> > (The second location is newly added in v5, in order to keep consistent
> > with the migration_version node for migratable pass-though devices)
> 
> What is the relationship between those two attributes?
> 
(1) is for mdev devices specifically, and (2) is provided to keep the same
sysfs interface as with non-mdev cases. so (2) is for both mdev devices and
non-mdev devices.

in future, if we enable vfio-pci vendor ops, (i.e. a non-mdev device
is binding to vfio-pci, but is able to register migration region and do
migration transactions from a vendor provided affiliate driver),
the vendor driver would export (2) directly, under device node.
It is not able to provide (1) as there're no mdev devices involved.

> Is existence (and compatibility) of (1) a pre-req for possible
> existence (and compatibility) of (2)?
>
no. (2) does not reply on (1).

> Does userspace need to check (1) or can it completely rely on (2), if
> it so chooses?
>
I think it can completely reply on (2) if compatibility check before
mdev creation is not required.

> If devices with a different mdev type are indeed compatible, it seems
> userspace can only find out after the devices have actually been
> created, as (1) does not apply?
yes, I think so. 

> One of my worries is that the existence of an attribute with the same
> name in two similar locations might lead to confusion. But maybe it
> isn't a problem.
>
Yes, I have the same feeling. but as (2) is for sysfs interface
consistency, to make it transparent to userspace tools like libvirt,
I guess the same name is necessary?

Thanks
Yan
> > 
> > Patch 1 defines migration_version attribute for the first location in
> > Documentation/vfio-mediated-device.txt
> > 
> > Patch 2 uses GVT as an example for patch 1 to show how to expose
> > migration_version attribute and check migration compatibility in vendor
> > driver.
> > 
> > Patch 3 defines migration_version attribute for the second location in
> > Documentation/vfio-mediated-device.txt
> > 
> > Patch 4 uses GVT as an example for patch 3 to show how to expose
> > migration_version attribute and check migration compatibility in vendor
> > driver.
> > 
> > (The previous "Reviewed-by" and "Acked-by" for patch 1 and patch 2 are
> > kept in v5, as there are only small changes to commit messages of the two
> > patches.)
> > 
> > v5:
> > added patch 2 and 4 for mdev device part of migration_version attribute.
> > 
> > v4:
> > 1. fixed indentation/spell errors, reworded several error messages
> > 2. added a missing memory free for error handling in patch 2
> > 
> > v3:
> > 1. renamed version to migration_version
> > 2. let errno to be freely defined by vendor driver
> > 3. let checking mdev_type be prerequisite of migration compatibility check
> > 4. reworded most part of patch 1
> > 5. print detailed error log in patch 2 and generate migration_version
> > string at init time
> > 
> > v2:
> > 1. renamed patched 1
> > 2. made definition of device version string completely private to vendor
> > driver
> > 3. reverted changes to sample mdev drivers
> > 4. described intent and usage of version attribute more clearly.
> > 
> > 
> > Yan Zhao (4):
> >   vfio/mdev: add migration_version attribute for mdev (under mdev_type
> >     node)
> >   drm/i915/gvt: export migration_version to mdev sysfs (under mdev_type
> >     node)
> >   vfio/mdev: add migration_version attribute for mdev (under mdev device
> >     node)
> >   drm/i915/gvt: export migration_version to mdev sysfs (under mdev
> >     device node)
> > 
> >  .../driver-api/vfio-mediated-device.rst       | 183 ++++++++++++++++++
> >  drivers/gpu/drm/i915/gvt/Makefile             |   2 +-
> >  drivers/gpu/drm/i915/gvt/gvt.c                |  39 ++++
> >  drivers/gpu/drm/i915/gvt/gvt.h                |   7 +
> >  drivers/gpu/drm/i915/gvt/kvmgt.c              |  55 ++++++
> >  drivers/gpu/drm/i915/gvt/migration_version.c  | 170 ++++++++++++++++
> >  drivers/gpu/drm/i915/gvt/vgpu.c               |  13 +-
> >  7 files changed, 466 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/gpu/drm/i915/gvt/migration_version.c
> > 
> 


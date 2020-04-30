Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BBCC83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 00:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351D120787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 00:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351D120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTxRy-0003YV-8I
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 20:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jTxRH-00035W-98
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 20:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jTxOc-0004ac-Fr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 20:52:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:27485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jTxOb-0004aG-S2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 20:49:46 -0400
IronPort-SDR: GONGGW81PPj96/slvP3suMaK7C1m1aBzWe7Oj5QQRAjC6IyiomtsGMk2AZ6gj5t4MoZ60ZulP6
 Q/svuxg6BfDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 17:49:40 -0700
IronPort-SDR: Gu7bxkV3d6H5AxKhC9r67Y2KEW0N8wqsuKw2oF4WCoqXWvNAJmrGHv4u1xQk576m6AsU4UZ89Q
 Nogm238Tg/Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; d="scan'208";a="459385009"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2020 17:49:33 -0700
Date: Wed, 29 Apr 2020 20:39:50 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200430003949.GN12879@joy-OptiPlex-7040>
References: <20200422073628.GA12879@joy-OptiPlex-7040>
 <20200424191049.GU3106@work-vm>
 <20200426013628.GC12879@joy-OptiPlex-7040>
 <20200427153743.GK2923@work-vm>
 <20200428005429.GJ12879@joy-OptiPlex-7040>
 <20200428141437.GG2794@work-vm>
 <20200429072616.GL12879@joy-OptiPlex-7040>
 <20200429082201.GA2834@work-vm>
 <20200429093555.GM12879@joy-OptiPlex-7040>
 <20200429094844.GE2834@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429094844.GE2834@work-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.120; envelope-from=yan.y.zhao@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 20:49:40
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.120
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
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
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

On Wed, Apr 29, 2020 at 05:48:44PM +0800, Dr. David Alan Gilbert wrote:
<snip>
> > > > > > > > > > > > > An mdev type is meant to define a software compatible interface, so in
> > > > > > > > > > > > > the case of mdev->mdev migration, doesn't migrating to a different type
> > > > > > > > > > > > > fail the most basic of compatibility tests that we expect userspace to
> > > > > > > > > > > > > perform?  IOW, if two mdev types are migration compatible, it seems a
> > > > > > > > > > > > > prerequisite to that is that they provide the same software interface,
> > > > > > > > > > > > > which means they should be the same mdev type.
> > > > > > > > > > > > >
> > > > > > > > > > > > > In the hybrid cases of mdev->phys or phys->mdev, how does a
> > > > > > > > > > > > management
> > > > > > > > > > > > > tool begin to even guess what might be compatible?  Are we expecting
> > > > > > > > > > > > > libvirt to probe ever device with this attribute in the system?  Is
> > > > > > > > > > > > > there going to be a new class hierarchy created to enumerate all
> > > > > > > > > > > > > possible migrate-able devices?
> > > > > > > > > > > > >
> > > > > > > > > > > > yes, management tool needs to guess and test migration compatible
> > > > > > > > > > > > between two devices. But I think it's not the problem only for
> > > > > > > > > > > > mdev->phys or phys->mdev. even for mdev->mdev, management tool needs
> > > > > > > > > > > > to
> > > > > > > > > > > > first assume that the two mdevs have the same type of parent devices
> > > > > > > > > > > > (e.g.their pciids are equal). otherwise, it's still enumerating
> > > > > > > > > > > > possibilities.
> > > > > > > > > > > > 
> > > > > > > > > > > > on the other hand, for two mdevs,
> > > > > > > > > > > > mdev1 from pdev1, its mdev_type is 1/2 of pdev1;
> > > > > > > > > > > > mdev2 from pdev2, its mdev_type is 1/4 of pdev2;
> > > > > > > > > > > > if pdev2 is exactly 2 times of pdev1, why not allow migration between
> > > > > > > > > > > > mdev1 <-> mdev2.
> > > > > > > > > > > 
> > > > > > > > > > > How could the manage tool figure out that 1/2 of pdev1 is equivalent 
> > > > > > > > > > > to 1/4 of pdev2? If we really want to allow such thing happen, the best
> > > > > > > > > > > choice is to report the same mdev type on both pdev1 and pdev2.
> > > > > > > > > > I think that's exactly the value of this migration_version interface.
> > > > > > > > > > the management tool can take advantage of this interface to know if two
> > > > > > > > > > devices are migration compatible, no matter they are mdevs, non-mdevs,
> > > > > > > > > > or mix.
> > > > > > > > > > 
> > > > > > > > > > as I know, (please correct me if not right), current libvirt still
> > > > > > > > > > requires manually generating mdev devices, and it just duplicates src vm
> > > > > > > > > > configuration to the target vm.
> > > > > > > > > > for libvirt, currently it's always phys->phys and mdev->mdev (and of the
> > > > > > > > > > same mdev type).
> > > > > > > > > > But it does not justify that hybrid cases should not be allowed. otherwise,
> > > > > > > > > > why do we need to introduce this migration_version interface and leave
> > > > > > > > > > the judgement of migration compatibility to vendor driver? why not simply
> > > > > > > > > > set the criteria to something like "pciids of parent devices are equal,
> > > > > > > > > > and mdev types are equal" ?
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > btw mdev<->phys just brings trouble to upper stack as Alex pointed out. 
> > > > > > > > > > could you help me understand why it will bring trouble to upper stack?
> > > > > > > > > > 
> > > > > > > > > > I think it just needs to read src migration_version under src dev node,
> > > > > > > > > > and test it in target migration version under target dev node. 
> > > > > > > > > > 
> > > > > > > > > > after all, through this interface we just help the upper layer
> > > > > > > > > > knowing available options through reading and testing, and they decide
> > > > > > > > > > to use it or not.
> > > > > > > > > > 
> > > > > > > > > > > Can we simplify the requirement by allowing only mdev<->mdev and 
> > > > > > > > > > > phys<->phys migration? If an customer does want to migrate between a 
> > > > > > > > > > > mdev and phys, he could wrap physical device into a wrapped mdev 
> > > > > > > > > > > instance (with the same type as the source mdev) instead of using vendor 
> > > > > > > > > > > ops. Doing so does add some burden but if mdev<->phys is not dominant 
> > > > > > > > > > > usage then such tradeoff might be worthywhile...
> > > > > > > > > > >
> > > > > > > > > > If the interfaces for phys<->phys and mdev<->mdev are consistent, it makes no
> > > > > > > > > > difference to phys<->mdev, right?
> > > > > > > > > > I think the vendor string for a mdev device is something like:
> > > > > > > > > > "Parent PCIID + mdev type + software version", and
> > > > > > > > > > that for a phys device is something like:
> > > > > > > > > > "PCIID + software version".
> > > > > > > > > > as long as we don't migrate between devices from different vendors, it's
> > > > > > > > > > easy for vendor driver to tell if a phys device is migration compatible
> > > > > > > > > > to a mdev device according it supports it or not.
> > > > > > > > > 
> > > > > > > > > It surprises me that the PCIID matching is a requirement; I'd assumed
> > > > > > > > > with this clever mdev name setup that you could migrate between two
> > > > > > > > > different models in a series, or to a newer model, as long as they
> > > > > > > > > both supported the same mdev view.
> > > > > > > > > 
> > > > > > > > hi Dave
> > > > > > > > the migration_version string is transparent to userspace, and is
> > > > > > > > completely defined by vendor driver.
> > > > > > > > I put it there just as an example of how vendor driver may implement it.
> > > > > > > > e.g.
> > > > > > > > the src migration_version string is "src PCIID + src software version", 
> > > > > > > > then when this string is write to target migration_version node,
> > > > > > > > the vendor driver in the target device will compare it with its own
> > > > > > > > device info and software version.
> > > > > > > > If different models are allowed, the write just succeeds even
> > > > > > > > PCIIDs in src and target are different.
> > > > > > > > 
> > > > > > > > so, it is the vendor driver to define whether two devices are able to
> > > > > > > > migrate, no matter their PCIIDs, mdev types, software versions..., which
> > > > > > > > provides vendor driver full flexibility.
> > > > > > > > 
> > > > > > > > do you think it's good?
> > > > > > > 
> > > > > > > Yeh that's OK; I guess it's going to need to have a big table in their
> > > > > > > with all the PCIIDs in.
> > > > > > > The alternative would be to abstract it a little; e.g. to say it's
> > > > > > > an Intel-gpu-core-v4  and then it would be less worried about the exact
> > > > > > > clock speed etc - but yes you might be right htat PCIIDs might be best
> > > > > > > for checking for quirks.
> > > > > > >
> > > > > > glad that you are agreed with it:)
> > > > > > I think the vendor driver still can choose a way to abstract a little
> > > > > > (e.g. Intel-gpu-core-v4...) if they think it's better. In that case, the
> > > > > > migration_string would be something like "Intel-gpu-core-v4 + instance
> > > > > > number + software version".
> > > > > > IOW, they can choose anything they think appropriate to identify migration
> > > > > > compatibility of a device.
> > > > > > But Alex is right, we have to prevent namespace overlapping. So I think
> > > > > > we need to ensure src and target devices are from the same vendors.
> > > > > > or, any other ideas?
> > > > > 
> > > > > That's why I kept the 'Intel' in that example; or PCI vendor ID; I was
> > > > Yes, it's a good idea!
> > > > could we add a line in the doc saying that
> > > > it is the vendor driver to add a unique string to avoid namespace
> > > > collision?
> > > 
> > > So why don't we split the difference; lets say that it should start with
> > > the hex PCI Vendor ID.
> > >
> > The problem is for mdev devices, if the parent devices are not PCI devices, 
> > they don't have PCI vendor IDs.
> 
> Hmm it would be best not to invent a whole new way of giving unique
> idenitifiers for vendors if we can.
> 
what about leveraging the flags in vfio device info ?

#define VFIO_DEVICE_FLAGS_RESET (1 << 0)        /* Device supports reset */
#define VFIO_DEVICE_FLAGS_PCI   (1 << 1)        /* vfio-pci device */
#define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)     /* vfio-platform device */
#define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)        /* vfio-amba device */
#define VFIO_DEVICE_FLAGS_CCW   (1 << 4)        /* vfio-ccw device */
#define VFIO_DEVICE_FLAGS_AP    (1 << 5)        /* vfio-ap device */

Then for migration_version string,
The first 64 bits are for device type, the second 64 bits are for device id.
e.g.
for PCI devices, it could be
VFIO_DEVICE_FLAGS_PCI + PCI ID.

Currently in the doc, we only define PCI devices to use PCI ID as the second
64 bits. In future, if other types of devices want to support migration,
they can define their own parts of device id. e.g. use ACPI ID as the
second 64-bit...

sounds good?

Thanks
Yan

> > 
> > 
> > > > > only really trying to say that within one vendors range there are often
> > > > > a lot of PCI-IDs that have really minor variations.
> > > > Yes. I also prefer to include PCI-IDs.
> > > > BTW, sometimes even the same PCI-ID does not guarantee two devices are of no
> > > > difference or are migration compatible. for example, two local NVMe
> > > > devices may have the same PCI-ID but are configured to two different remote NVMe
> > > > devices. the vendor driver needs to add extra info besides PCI-IDs then.
> > > 
> > > Ah, yes that's an interesting example.
> > > 
> > > Dave
> > > 
> > > > 
> > > > > 
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > > I agree that there was a gap in the previous proposal for non-mdev
> > > > > > > > > > > > > devices, but I think this bring a lot of questions that we need to
> > > > > > > > > > > > > puzzle through and libvirt will need to re-evaluate how they might
> > > > > > > > > > > > > decide to pick a migration target device.  For example, I'm sure
> > > > > > > > > > > > > libvirt would reject any policy decisions regarding picking a physical
> > > > > > > > > > > > > device versus an mdev device.  Had we previously left it that only a
> > > > > > > > > > > > > layer above libvirt would select a target device and libvirt only tests
> > > > > > > > > > > > > compatibility to that target device?
> > > > > > > > > > > > I'm not sure if there's a layer above libvirt would select a target
> > > > > > > > > > > > device. but if there is such a layer (even it's human), we need to
> > > > > > > > > > > > provide an interface for them to know whether their decision is suitable
> > > > > > > > > > > > for migration. The migration_version interface provides a potential to
> > > > > > > > > > > > allow mdev->phys migration, even libvirt may currently reject it.
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > > We also need to consider that this expands the namespace.  If we no
> > > > > > > > > > > > > longer require matching types as the first level of comparison, then
> > > > > > > > > > > > > vendor migration strings can theoretically collide.  How do we
> > > > > > > > > > > > > coordinate that can't happen?  Thanks,
> > > > > > > > > > > > yes, it's indeed a problem.
> > > > > > > > > > > > could only allowing migration beteen devices from the same vendor be a
> > > > > > > > > > > > good
> > > > > > > > > > > > prerequisite?
> > > > > > > > > > > > 
> > > > > > > > > > > > Thanks
> > > > > > > > > > > > Yan
> > > > > > > > > > > > >
<snip>


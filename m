Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7168C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E92E20753
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E92E20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQrjv-00037p-Qi
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1jQrjH-0002bf-1x
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1jQrjF-0000n3-FE
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:10:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:34603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin.tian@intel.com>)
 id 1jQrjE-0000bI-Uf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:10:17 -0400
IronPort-SDR: eW5qxF9BcxdG38wUQ8ySXawh90n2b1a0pjbSH0S2/bmIXl78ECJWzZXM7MW7jSfvZFCBiD41CF
 EHKt7xtgUwrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2020 05:10:09 -0700
IronPort-SDR: 8VxAIGwySK5prjvHeIPeC8fZRtUkDn5qBKFzwHsR72++3pK9BIM1nETFu7DTcPjbGlQJJnkkMy
 eruHb2hIDYBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; d="scan'208";a="429510291"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga005.jf.intel.com with ESMTP; 21 Apr 2020 05:10:08 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Apr 2020 05:08:53 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Apr 2020 05:08:53 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Tue, 21 Apr 2020 20:08:49 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Thread-Topic: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Thread-Index: AQHWEVkQX2D3KsUjJk2k1DZCtXaM5qh8gBsAgAASxgCAABn2gIAED1uAgAFotwCAAD3VAIABIlKw
Date: Tue, 21 Apr 2020 12:08:49 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D86DF06@SHSMSX104.ccr.corp.intel.com>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
 <20200417104450.2d2f2fa9.cohuck@redhat.com>
 <20200417095202.GD16688@joy-OptiPlex-7040>
 <20200417132457.45d91fe3.cohuck@redhat.com>
 <20200420012457.GE16688@joy-OptiPlex-7040>
 <20200420165600.4951ae82@w520.home>
 <20200421023718.GA12111@joy-OptiPlex-7040>
In-Reply-To: <20200421023718.GA12111@joy-OptiPlex-7040>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.31; envelope-from=kevin.tian@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:10:09
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
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
 "Zeng, Xin" <xin.zeng@intel.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
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

> From: Yan Zhao
> Sent: Tuesday, April 21, 2020 10:37 AM
>=20
> On Tue, Apr 21, 2020 at 06:56:00AM +0800, Alex Williamson wrote:
> > On Sun, 19 Apr 2020 21:24:57 -0400
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >
> > > On Fri, Apr 17, 2020 at 07:24:57PM +0800, Cornelia Huck wrote:
> > > > On Fri, 17 Apr 2020 05:52:02 -0400
> > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > >
> > > > > On Fri, Apr 17, 2020 at 04:44:50PM +0800, Cornelia Huck wrote:
> > > > > > On Mon, 13 Apr 2020 01:52:01 -0400
> > > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > > >
> > > > > > > This patchset introduces a migration_version attribute under =
sysfs
> of VFIO
> > > > > > > Mediated devices.
> > > > > > >
> > > > > > > This migration_version attribute is used to check migration
> compatibility
> > > > > > > between two mdev devices.
> > > > > > >
> > > > > > > Currently, it has two locations:
> > > > > > > (1) under mdev_type node,
> > > > > > >     which can be used even before device creation, but only f=
or
> mdev
> > > > > > >     devices of the same mdev type.
> > > > > > > (2) under mdev device node,
> > > > > > >     which can only be used after the mdev devices are created=
, but
> the src
> > > > > > >     and target mdev devices are not necessarily be of the sam=
e
> mdev type
> > > > > > > (The second location is newly added in v5, in order to keep
> consistent
> > > > > > > with the migration_version node for migratable pass-though
> devices)
> > > > > >
> > > > > > What is the relationship between those two attributes?
> > > > > >
> > > > > (1) is for mdev devices specifically, and (2) is provided to keep=
 the
> same
> > > > > sysfs interface as with non-mdev cases. so (2) is for both mdev
> devices and
> > > > > non-mdev devices.
> > > > >
> > > > > in future, if we enable vfio-pci vendor ops, (i.e. a non-mdev dev=
ice
> > > > > is binding to vfio-pci, but is able to register migration region =
and do
> > > > > migration transactions from a vendor provided affiliate driver),
> > > > > the vendor driver would export (2) directly, under device node.
> > > > > It is not able to provide (1) as there're no mdev devices involve=
d.
> > > >
> > > > Ok, creating an alternate attribute for non-mdev devices makes sens=
e.
> > > > However, wouldn't that rather be a case (3)? The change here only
> > > > refers to mdev devices.
> > > >
> > > as you pointed below, (3) and (2) serve the same purpose.
> > > and I think a possible usage is to migrate between a non-mdev device =
and
> > > an mdev device. so I think it's better for them both to use (2) rathe=
r
> > > than creating (3).
> >
> > An mdev type is meant to define a software compatible interface, so in
> > the case of mdev->mdev migration, doesn't migrating to a different type
> > fail the most basic of compatibility tests that we expect userspace to
> > perform?  IOW, if two mdev types are migration compatible, it seems a
> > prerequisite to that is that they provide the same software interface,
> > which means they should be the same mdev type.
> >
> > In the hybrid cases of mdev->phys or phys->mdev, how does a
> management
> > tool begin to even guess what might be compatible?  Are we expecting
> > libvirt to probe ever device with this attribute in the system?  Is
> > there going to be a new class hierarchy created to enumerate all
> > possible migrate-able devices?
> >
> yes, management tool needs to guess and test migration compatible
> between two devices. But I think it's not the problem only for
> mdev->phys or phys->mdev. even for mdev->mdev, management tool needs
> to
> first assume that the two mdevs have the same type of parent devices
> (e.g.their pciids are equal). otherwise, it's still enumerating
> possibilities.
>=20
> on the other hand, for two mdevs,
> mdev1 from pdev1, its mdev_type is 1/2 of pdev1;
> mdev2 from pdev2, its mdev_type is 1/4 of pdev2;
> if pdev2 is exactly 2 times of pdev1, why not allow migration between
> mdev1 <-> mdev2.

How could the manage tool figure out that 1/2 of pdev1 is equivalent=20
to 1/4 of pdev2? If we really want to allow such thing happen, the best
choice is to report the same mdev type on both pdev1 and pdev2.

btw mdev<->phys just brings trouble to upper stack as Alex pointed out.=20
Can we simplify the requirement by allowing only mdev<->mdev and=20
phys<->phys migration? If an customer does want to migrate between a=20
mdev and phys, he could wrap physical device into a wrapped mdev=20
instance (with the same type as the source mdev) instead of using vendor=20
ops. Doing so does add some burden but if mdev<->phys is not dominant=20
usage then such tradeoff might be worthywhile...

Thanks
Kevin

>=20
>=20
> > I agree that there was a gap in the previous proposal for non-mdev
> > devices, but I think this bring a lot of questions that we need to
> > puzzle through and libvirt will need to re-evaluate how they might
> > decide to pick a migration target device.  For example, I'm sure
> > libvirt would reject any policy decisions regarding picking a physical
> > device versus an mdev device.  Had we previously left it that only a
> > layer above libvirt would select a target device and libvirt only tests
> > compatibility to that target device?
> I'm not sure if there's a layer above libvirt would select a target
> device. but if there is such a layer (even it's human), we need to
> provide an interface for them to know whether their decision is suitable
> for migration. The migration_version interface provides a potential to
> allow mdev->phys migration, even libvirt may currently reject it.
>=20
>=20
> > We also need to consider that this expands the namespace.  If we no
> > longer require matching types as the first level of comparison, then
> > vendor migration strings can theoretically collide.  How do we
> > coordinate that can't happen?  Thanks,
> yes, it's indeed a problem.
> could only allowing migration beteen devices from the same vendor be a
> good
> prerequisite?
>=20
> Thanks
> Yan
> >
> > > > > > Is existence (and compatibility) of (1) a pre-req for possible
> > > > > > existence (and compatibility) of (2)?
> > > > > >
> > > > > no. (2) does not reply on (1).
> > > >
> > > > Hm. Non-existence of (1) seems to imply "this type does not support
> > > > migration". If an mdev created for such a type suddenly does suppor=
t
> > > > migration, it feels a bit odd.
> > > >
> > > yes. but I think if the condition happens, it should be reported a bu=
g
> > > to vendor driver.
> > > should I add a line in the doc like "vendor driver should ensure that=
 the
> > > migration compatibility from migration_version under mdev_type should
> be
> > > consistent with that from migration_version under device node" ?
> > >
> > > > (It obviously cannot be a prereq for what I called (3) above.)
> > > >
> > > > >
> > > > > > Does userspace need to check (1) or can it completely rely on (=
2), if
> > > > > > it so chooses?
> > > > > >
> > > > > I think it can completely reply on (2) if compatibility check bef=
ore
> > > > > mdev creation is not required.
> > > > >
> > > > > > If devices with a different mdev type are indeed compatible, it
> seems
> > > > > > userspace can only find out after the devices have actually bee=
n
> > > > > > created, as (1) does not apply?
> > > > > yes, I think so.
> > > >
> > > > How useful would it be for userspace to even look at (1) in that ca=
se?
> > > > It only knows if things have a chance of working if it actually goe=
s
> > > > ahead and creates devices.
> > > >
> > > hmm, is it useful for userspace to test the migration_version under m=
dev
> > > type before it knows what mdev device to generate ?
> > > like when the userspace wants to migrate an mdev device in src vm,
> > > but it has not created target vm and the target mdev device.
> > >
> > > > >
> > > > > > One of my worries is that the existence of an attribute with th=
e
> same
> > > > > > name in two similar locations might lead to confusion. But mayb=
e it
> > > > > > isn't a problem.
> > > > > >
> > > > > Yes, I have the same feeling. but as (2) is for sysfs interface
> > > > > consistency, to make it transparent to userspace tools like libvi=
rt,
> > > > > I guess the same name is necessary?
> > > >
> > > > What do we actually need here, I wonder? (1) and (2) seem to serve
> > > > slightly different purposes, while (2) and what I called (3) have t=
he
> > > > same purpose. Is it important to userspace that (1) and (2) have th=
e
> > > > same name?
> > > so change (1) to migration_type_version and (2) to
> > > migration_instance_version?
> > > But as they are under different locations, could that location imply
> > > enough information?
> > >
> > >
> > > Thanks
> > > Yan
> > >
> > >
> >
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev


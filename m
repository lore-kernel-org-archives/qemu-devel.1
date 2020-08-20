Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E91DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339A020724
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339A020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8bFM-0004LH-FB
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 23:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k8bEr-0003wN-4V
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 23:27:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:24025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k8bEo-00043S-IA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 23:27:40 -0400
IronPort-SDR: z0FbM5GOuu816ZWT1CGkzCRWNIxXluG94DCNuMzdEtTJMXOhAcu3CvCnA13G3w325mFHazZWPo
 7W+RDbhcTfgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152646686"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="152646686"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 20:27:35 -0700
IronPort-SDR: UqP0IOWieCFyHRnd1vZQD2aXoRbEIKc+/gr6oUyySSR3mhwyApXJ6ijvH5c/4s3hX8nJNnHCRQ
 2wmgSpyXPOOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="327281681"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga008.jf.intel.com with ESMTP; 19 Aug 2020 20:27:28 -0700
Date: Thu, 20 Aug 2020 11:09:51 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200820030951.GA24121@joy-OptiPlex-7040>
References: <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <BY5PR12MB4322C9D1A66C4657776A1383DC5C0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20200819033035.GA21172@joy-OptiPlex-7040>
 <20200819115021.004427a3@x1.home>
 <20200820001810.GD21172@joy-OptiPlex-7040>
 <20200819211345.0d9daf03@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819211345.0d9daf03@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.120; envelope-from=yan.y.zhao@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 23:27:35
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "xin-ran.wang@intel.com" <xin-ran.wang@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "openstack-discuss@lists.openstack.org"
 <openstack-discuss@lists.openstack.org>,
 "shaohe.feng@intel.com" <shaohe.feng@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 Parav Pandit <parav@mellanox.com>,
 "jian-feng.ding@intel.com" <jian-feng.ding@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "hejie.xu@intel.com" <hejie.xu@intel.com>,
 "bao.yumeng@zte.com.cn" <bao.yumeng@zte.com.cn>,
 Jiri Pirko <jiri@mellanox.com>, "eskultet@redhat.com" <eskultet@redhat.com>,
 Parav Pandit <parav@nvidia.com>, "smooney@redhat.com" <smooney@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
 "devel@ovirt.org" <devel@ovirt.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 09:13:45PM -0600, Alex Williamson wrote:
> On Thu, 20 Aug 2020 08:18:10 +0800
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Wed, Aug 19, 2020 at 11:50:21AM -0600, Alex Williamson wrote:
> > <...>
> > > > > > > What I care about is that we have a *standard* userspace API for
> > > > > > > performing device compatibility checking / state migration, for use by
> > > > > > > QEMU/libvirt/ OpenStack, such that we can write code without countless
> > > > > > > vendor specific code paths.
> > > > > > >
> > > > > > > If there is vendor specific stuff on the side, that's fine as we can
> > > > > > > ignore that, but the core functionality for device compat / migration
> > > > > > > needs to be standardized.    
> > > > > > 
> > > > > > To summarize:
> > > > > > - choose one of sysfs or devlink
> > > > > > - have a common interface, with a standardized way to add
> > > > > >   vendor-specific attributes
> > > > > > ?    
> > > > > 
> > > > > Please refer to my previous email which has more example and details.    
> > > > hi Parav,
> > > > the example is based on a new vdpa tool running over netlink, not based
> > > > on devlink, right?
> > > > For vfio migration compatibility, we have to deal with both mdev and physical
> > > > pci devices, I don't think it's a good idea to write a new tool for it, given
> > > > we are able to retrieve the same info from sysfs and there's already an
> > > > mdevctl from Alex (https://github.com/mdevctl/mdevctl).
> > > > 
> > > > hi All,
> > > > could we decide that sysfs is the interface that every VFIO vendor driver
> > > > needs to provide in order to support vfio live migration, otherwise the
> > > > userspace management tool would not list the device into the compatible
> > > > list?
> > > > 
> > > > if that's true, let's move to the standardizing of the sysfs interface.
> > > > (1) content
> > > > common part: (must)
> > > >    - software_version: (in major.minor.bugfix scheme)
> > > >    - device_api: vfio-pci or vfio-ccw ...
> > > >    - type: mdev type for mdev device or
> > > >            a signature for physical device which is a counterpart for
> > > > 	   mdev type.
> > > > 
> > > > device api specific part: (must)
> > > >   - pci id: pci id of mdev parent device or pci id of physical pci
> > > >     device (device_api is vfio-pci)  
> > > 
> > > As noted previously, the parent PCI ID should not matter for an mdev
> > > device, if a vendor has a dependency on matching the parent device PCI
> > > ID, that's a vendor specific restriction.  An mdev device can also
> > > expose a vfio-pci device API without the parent device being PCI.  For
> > > a physical PCI device, shouldn't the PCI ID be encompassed in the
> > > signature?  Thanks,
> > >   
> > you are right. I need to put the PCI ID as a vendor specific field.
> > I didn't do that because I wanted all fields in vendor specific to be
> > configurable by management tools, so they can configure the target device
> > according to the value of a vendor specific field even they don't know
> > the meaning of the field.
> > But maybe they can just ignore the field when they can't find a matching
> > writable field to configure the target.
> 
> 
> If fields can be ignored, what's the point of reporting them?  Seems
> it's no longer a requirement.  Thanks,
> 
sorry about the confusion. I mean this condition:
about to migrate, openstack searches if there are existing matching
MDEVs,
if yes, i.e. all common/vendor specific fields match, then just create
a VM with the matching target MDEV. (in this condition, the PCI ID field
is not ignored);
if not, openstack tries to create one MDEV according to mdev_type, and
configures MDEV according to the vendor specific attributes.
as PCI ID is not a configurable field, it just ignore the field.

Thanks
Yan

 
 


Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87459C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA2820709
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA2820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8F5u-0004KU-LO
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 23:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k8F5M-0003vF-K4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:48:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:48984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k8F5J-0008UO-Ch
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:48:24 -0400
IronPort-SDR: m8SmOuARPCrmG2O8ds901B05m239SxOWWJmP99yW0KWO5HeNLUzyBTFhAWclte9VWkK8rvTxqT
 2It0ccfJ9yRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="154306670"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; d="scan'208";a="154306670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 20:48:18 -0700
IronPort-SDR: gW+H1ML9Tmx47WL96J93dFo0ciNYOhkpFuZAl4nqL2XtlJ8DRNolmJwbwuEc4rcpbF72lKn+om
 M9Zzu2iLeBFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; d="scan'208";a="326943564"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 20:48:12 -0700
Date: Wed, 19 Aug 2020 11:30:35 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200819033035.GA21172@joy-OptiPlex-7040>
References: <20200805105319.GF2177@nanopsycho>
 <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <BY5PR12MB4322C9D1A66C4657776A1383DC5C0@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR12MB4322C9D1A66C4657776A1383DC5C0@BY5PR12MB4322.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.115; envelope-from=yan.y.zhao@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:48:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
 Alex Williamson <alex.williamson@redhat.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>,
 "smooney@redhat.com" <smooney@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Jiri Pirko <jiri@mellanox.com>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "devel@ovirt.org" <devel@ovirt.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 09:39:24AM +0000, Parav Pandit wrote:
> Hi Cornelia,
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Tuesday, August 18, 2020 3:07 PM
> > To: Daniel P. Berrangé <berrange@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>; Yan Zhao
> > <yan.y.zhao@intel.com>; kvm@vger.kernel.org; libvir-list@redhat.com;
> > qemu-devel@nongnu.org; Kirti Wankhede <kwankhede@nvidia.com>;
> > eauger@redhat.com; xin-ran.wang@intel.com; corbet@lwn.net; openstack-
> > discuss@lists.openstack.org; shaohe.feng@intel.com; kevin.tian@intel.com;
> > Parav Pandit <parav@mellanox.com>; jian-feng.ding@intel.com;
> > dgilbert@redhat.com; zhenyuw@linux.intel.com; hejie.xu@intel.com;
> > bao.yumeng@zte.com.cn; Alex Williamson <alex.williamson@redhat.com>;
> > eskultet@redhat.com; smooney@redhat.com; intel-gvt-
> > dev@lists.freedesktop.org; Jiri Pirko <jiri@mellanox.com>;
> > dinechin@redhat.com; devel@ovirt.org
> > Subject: Re: device compatibility interface for live migration with assigned
> > devices
> > 
> > On Tue, 18 Aug 2020 10:16:28 +0100
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > > On Tue, Aug 18, 2020 at 05:01:51PM +0800, Jason Wang wrote:
> > > >    On 2020/8/18 下午4:55, Daniel P. Berrangé wrote:
> > > >
> > > >  On Tue, Aug 18, 2020 at 11:24:30AM +0800, Jason Wang wrote:
> > > >
> > > >  On 2020/8/14 下午1:16, Yan Zhao wrote:
> > > >
> > > >  On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
> > > >
> > > >  On 2020/8/10 下午3:46, Yan Zhao wrote:
> > >
> > > >  we actually can also retrieve the same information through sysfs,
> > > > .e.g
> > > >
> > > >  |- [path to device]
> > > >     |--- migration
> > > >     |     |--- self
> > > >     |     |   |---device_api
> > > >     |    |   |---mdev_type
> > > >     |    |   |---software_version
> > > >     |    |   |---device_id
> > > >     |    |   |---aggregator
> > > >     |     |--- compatible
> > > >     |     |   |---device_api
> > > >     |    |   |---mdev_type
> > > >     |    |   |---software_version
> > > >     |    |   |---device_id
> > > >     |    |   |---aggregator
> > > >
> > > >
> > > >  Yes but:
> > > >
> > > >  - You need one file per attribute (one syscall for one attribute)
> > > >  - Attribute is coupled with kobject
> > 
> > Is that really that bad? You have the device with an embedded kobject
> > anyway, and you can just put things into an attribute group?
> > 
> > [Also, I think that self/compatible split in the example makes things
> > needlessly complex. Shouldn't semantic versioning and matching already
> > cover nearly everything? I would expect very few cases that are more
> > complex than that. Maybe the aggregation stuff, but I don't think we need
> > that self/compatible split for that, either.]
> > 
> > > >
> > > >  All of above seems unnecessary.
> > > >
> > > >  Another point, as we discussed in another thread, it's really hard
> > > > to make  sure the above API work for all types of devices and
> > > > frameworks. So having a  vendor specific API looks much better.
> > > >
> > > >  From the POV of userspace mgmt apps doing device compat checking /
> > > > migration,  we certainly do NOT want to use different vendor
> > > > specific APIs. We want to  have an API that can be used / controlled in a
> > standard manner across vendors.
> > > >
> > > >    Yes, but it could be hard. E.g vDPA will chose to use devlink (there's a
> > > >    long debate on sysfs vs devlink). So if we go with sysfs, at least two
> > > >    APIs needs to be supported ...
> > >
> > > NB, I was not questioning devlink vs sysfs directly. If devlink is
> > > related to netlink, I can't say I'm enthusiastic as IMKE sysfs is
> > > easier to deal with. I don't know enough about devlink to have much of an
> > opinion though.
> > > The key point was that I don't want the userspace APIs we need to deal
> > > with to be vendor specific.
> > 
> > From what I've seen of devlink, it seems quite nice; but I understand why
> > sysfs might be easier to deal with (especially as there's likely already a lot of
> > code using it.)
> > 
> > I understand that some users would like devlink because it is already widely
> > used for network drivers (and some others), but I don't think the majority of
> > devices used with vfio are network (although certainly a lot of them are.)
> > 
> > >
> > > What I care about is that we have a *standard* userspace API for
> > > performing device compatibility checking / state migration, for use by
> > > QEMU/libvirt/ OpenStack, such that we can write code without countless
> > > vendor specific code paths.
> > >
> > > If there is vendor specific stuff on the side, that's fine as we can
> > > ignore that, but the core functionality for device compat / migration
> > > needs to be standardized.
> > 
> > To summarize:
> > - choose one of sysfs or devlink
> > - have a common interface, with a standardized way to add
> >   vendor-specific attributes
> > ?
> 
> Please refer to my previous email which has more example and details.
hi Parav,
the example is based on a new vdpa tool running over netlink, not based
on devlink, right?
For vfio migration compatibility, we have to deal with both mdev and physical
pci devices, I don't think it's a good idea to write a new tool for it, given
we are able to retrieve the same info from sysfs and there's already an
mdevctl from Alex (https://github.com/mdevctl/mdevctl).

hi All,
could we decide that sysfs is the interface that every VFIO vendor driver
needs to provide in order to support vfio live migration, otherwise the
userspace management tool would not list the device into the compatible
list?

if that's true, let's move to the standardizing of the sysfs interface.
(1) content
common part: (must)
   - software_version: (in major.minor.bugfix scheme)
   - device_api: vfio-pci or vfio-ccw ...
   - type: mdev type for mdev device or
           a signature for physical device which is a counterpart for
	   mdev type.

device api specific part: (must)
  - pci id: pci id of mdev parent device or pci id of physical pci
    device (device_api is vfio-pci)
  - subchannel_type (device_api is vfio-ccw) 
 
vendor driver specific part: (optional)
  - aggregator
  - chpid_type
  - remote_url

NOTE: vendors are free to add attributes in this part with a
restriction that this attribute is able to be configured with the same
name in sysfs too. e.g.
for aggregator, there must be a sysfs attribute in device node
/sys/devices/pci0000:00/0000:00:02.0/882cc4da-dede-11e7-9180-078a62063ab1/intel_vgpu/aggregator,
so that the userspace tool is able to configure the target device
according to source device's aggregator attribute.


(2) where and structure
proposal 1:
|- [path to device]
  |--- migration
  |     |--- self
  |     |    |-software_version
  |     |    |-device_api
  |     |    |-type
  |     |    |-[pci_id or subchannel_type]
  |     |    |-<aggregator or chpid_type>
  |     |--- compatible
  |     |    |-software_version
  |     |    |-device_api
  |     |    |-type
  |     |    |-[pci_id or subchannel_type]
  |     |    |-<aggregator or chpid_type>
multiple compatible is allowed.
attributes should be ASCII text files, preferably with only one value
per file.


proposal 2: use bin_attribute.
|- [path to device]
  |--- migration
  |     |--- self
  |     |--- compatible

so we can continue use multiline format. e.g.
cat compatible
  software_version=0.1.0
  device_api=vfio_pci
  type=i915-GVTg_V5_{val1:int:1,2,4,8}
  pci_id=80865963
  aggregator={val1}/2

Thanks
Yan


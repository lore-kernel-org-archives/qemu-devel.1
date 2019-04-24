Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 03:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1976E2148D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 03:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1976E2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ91P-0001jz-9Z
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 23:56:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hJ8ze-0000HD-3q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 23:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hJ8kt-0008Tb-LK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 23:39:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:1800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1hJ8ks-0008Iu-Cx
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 23:39:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Apr 2019 20:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,388,1549958400"; d="scan'208";a="164506938"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
	([10.239.13.9])
	by fmsmga004.fm.intel.com with ESMTP; 23 Apr 2019 20:39:19 -0700
Date: Tue, 23 Apr 2019 23:33:46 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190424033346.GC26247@joy-OptiPlex-7040>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190422083950.25eb9e7c@x1.home>
	<20190423010152.GC32217@joy-OptiPlex-7040>
	<20190422192100.4d577e4b@x1.home>
	<20190423054157.GA26190@joy-OptiPlex-7040>
	<20190423102419.GE6022@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190423102419.GE6022@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio/mdev: add version field as
 mandatory attribute for mdev device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
	"shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"kwankhede@nvidia.com" <kwankhede@nvidia.com>,
	"eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
	Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	"arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
	"felipe@nutanix.com" <felipe@nutanix.com>,
	"Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"dgilbert@redhat.com" <dgilbert@redhat.com>,
	"zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wang, Zhi A" <zhi.a.wang@intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
	Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424033346.fKRKE5-3TTwCzl1h8VZY0kVLolZmuVL9geCq4QqDKGE@z>

On Tue, Apr 23, 2019 at 06:24:19PM +0800, Daniel P. Berrangé wrote:
> On Tue, Apr 23, 2019 at 01:41:57AM -0400, Yan Zhao wrote:
> > On Tue, Apr 23, 2019 at 09:21:00AM +0800, Alex Williamson wrote:
> > > On Mon, 22 Apr 2019 21:01:52 -0400
> > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > >
> > > > On Mon, Apr 22, 2019 at 10:39:50PM +0800, Alex Williamson wrote:
> > > > > On Fri, 19 Apr 2019 04:35:04 -0400
> > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > >
> > > > > > device version attribute in mdev sysfs is used by user space software
> > > > > > (e.g. libvirt) to query device compatibility for live migration of VFIO
> > > > > > mdev devices. This attribute is mandatory if a mdev device supports live
> > > > > > migration.
> > > > >
> > > > > The Subject: doesn't quite match what's being proposed here.
> > > > >
> > > > > > It consists of two parts: common part and vendor proprietary part.
> > > > > > common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
> > > > > >              identifies device type. e.g., for pci device, it is
> > > > > >              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).
> > > > >
> > > > > What purpose does this serve?  If it's intended as some sort of
> > > > > namespace feature, shouldn't we first assume that we can only support
> > > > > migration to devices of the same type?  Therefore each type would
> > > > > already have its own namespace.  Also that would make the trailing bit
> > > > > of the version string listed below in the example redundant.  A vendor
> > > > > is still welcome to include this in their version string if they wish,
> > > > > but I think the string should be entirely vendor defined.
> > > > >
> > > > hi Alex,
> > > > This common part is a kind of namespace.
> > > > Because if version string is entirely defined by vendors, I'm worried about
> > > > if there is a case that one vendor's version string happens to deceive and
> > > > interfere with another vendor's version checking?
> > > > e.g.
> > > > vendor A has a version string like: vendor id + device id + mdev type
> > > > vendor B has a version string like: device id + vendor id + mdev type
> > > > but vendor A's vendor id is 0x8086, device id is 0x1217
> > > > vendor B's vendor id is 0x1217, device id is 0x8086.
> > > >
> > > > In this corner case, the two vendors may regard the two device is
> > > > migratable but actually they are not.
> > > >
> > > > That's the reason for this common part that serve as a kind of namespace
> > > > that all vendors will comply with to avoid overlap.
> > >
> > > If we assume that migration can only occur between matching mdev types,
> > > this is redundant, each type already has their own namespace.
> > >
> > hi Alex,
> > do you mean user space software like libvirt needs to first check whether
> > mdev type is matching and then check whether version is matching?
> 
> I would expect that libvirt (or other mgmt apps) will always first
> check that the vendor id, device id, mdev type all match. So for the
> version string it should suffice to be a "normal" numeric value.
> 
> Essentially version string just needs to be there to distinguish
> revisions of the same mdev type over time.
>
hi Daniel,
The way that user space software checks that the vendor id, device id, mdev
type all match and version string is just revisions is somewhat restrictive?
user space software could not have so much detailed information regarding to
which devices are compatible, especially when vendor id, device id,
revision id, and mdev types are not enough or no need to be exactly the same.
By moving decision making for compatibility from user space to vendor
driver, user space software can be more change-resistant.
Agree?

Thanks
Yan

> 
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


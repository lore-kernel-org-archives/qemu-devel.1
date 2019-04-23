Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C89C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 09:47:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1581920843
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 09:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1581920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50849 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIs16-0001gf-9g
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 05:47:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIs0B-0001Nv-7Y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIs09-0000SO-Td
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:46:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hIs09-0000SA-Kg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:46:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40D583007C43;
	Tue, 23 Apr 2019 09:46:08 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE6761A919;
	Tue, 23 Apr 2019 09:45:58 +0000 (UTC)
Date: Tue, 23 Apr 2019 11:45:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190423114556.1ef69f47.cohuck@redhat.com>
In-Reply-To: <20190423054157.GA26190@joy-OptiPlex-7040>
References: <20190419083258.19580-1-yan.y.zhao@intel.com>
	<20190419083505.19654-1-yan.y.zhao@intel.com>
	<20190422083950.25eb9e7c@x1.home>
	<20190423010152.GC32217@joy-OptiPlex-7040>
	<20190422192100.4d577e4b@x1.home>
	<20190423054157.GA26190@joy-OptiPlex-7040>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 23 Apr 2019 09:46:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wang, Zhi A" <zhi.a.wang@intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
	Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423094556.3hAuF4WYsNzXLZAWFJCACkZ29FpfNMcFPtqMwrmA6mE@z>

On Tue, 23 Apr 2019 01:41:57 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Tue, Apr 23, 2019 at 09:21:00AM +0800, Alex Williamson wrote:
> > On Mon, 22 Apr 2019 21:01:52 -0400
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >   
> > > On Mon, Apr 22, 2019 at 10:39:50PM +0800, Alex Williamson wrote:  
> > > > On Fri, 19 Apr 2019 04:35:04 -0400
> > > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > >     
> > > > > device version attribute in mdev sysfs is used by user space software
> > > > > (e.g. libvirt) to query device compatibility for live migration of VFIO
> > > > > mdev devices. This attribute is mandatory if a mdev device supports live
> > > > > migration.    
> > > > 
> > > > The Subject: doesn't quite match what's being proposed here.
> > > >      
> > > > > It consists of two parts: common part and vendor proprietary part.
> > > > > common part: 32 bit. lower 16 bits is vendor id and higher 16 bits
> > > > >              identifies device type. e.g., for pci device, it is
> > > > >              "pci vendor id" | (VFIO_DEVICE_FLAGS_PCI << 16).    
> > > > 
> > > > What purpose does this serve?  If it's intended as some sort of
> > > > namespace feature, shouldn't we first assume that we can only support
> > > > migration to devices of the same type?  Therefore each type would
> > > > already have its own namespace.  Also that would make the trailing bit
> > > > of the version string listed below in the example redundant.  A vendor
> > > > is still welcome to include this in their version string if they wish,
> > > > but I think the string should be entirely vendor defined.
> > > >    
> > > hi Alex,
> > > This common part is a kind of namespace.
> > > Because if version string is entirely defined by vendors, I'm worried about
> > > if there is a case that one vendor's version string happens to deceive and
> > > interfere with another vendor's version checking?
> > > e.g.
> > > vendor A has a version string like: vendor id + device id + mdev type
> > > vendor B has a version string like: device id + vendor id + mdev type
> > > but vendor A's vendor id is 0x8086, device id is 0x1217
> > > vendor B's vendor id is 0x1217, device id is 0x8086.
> > > 
> > > In this corner case, the two vendors may regard the two device is
> > > migratable but actually they are not.
> > > 
> > > That's the reason for this common part that serve as a kind of namespace
> > > that all vendors will comply with to avoid overlap.  
> > 
> > If we assume that migration can only occur between matching mdev types,
> > this is redundant, each type already has their own namespace.
> >  
> hi Alex,
> do you mean user space software like libvirt needs to first check whether
> mdev type is matching and then check whether version is matching?
> 
> if user space software only checks version for migration, it means vendor
> driver has to include mdev type in their vendor proprietary part string,
> right?

Can't userspace simply check for the driver in use and only then check
the version attribute?

> Another thing is that could there be any future mdev parent driver that
> applies to all mdev devices, just like vfio-pci? like Yi's vfio-pci-mdev
> driver (https://lkml.org/lkml/2019/3/13/114)?

Hm, I think that the vfio-pci-mdev driver then needs to expose
information regarding compatibility (and not the core).


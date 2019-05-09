Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463DDC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD352089E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD352089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56481 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkvt-00008F-Al
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:26:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hOkv7-0007z3-Iq
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hOkv6-00012h-0t
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:25:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hOkv5-0000v9-Oh
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:25:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD6A081F35;
	Thu,  9 May 2019 15:25:04 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C11C5DE78;
	Thu,  9 May 2019 15:24:51 +0000 (UTC)
Date: Thu, 9 May 2019 17:24:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190509172449.723a048b.cohuck@redhat.com>
In-Reply-To: <20190508115704.GB24397@joy-OptiPlex-7040>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506014904.3621-1-yan.y.zhao@intel.com>
	<20190507111954.43d477c3.cohuck@redhat.com>
	<20190508115704.GB24397@joy-OptiPlex-7040>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 09 May 2019 15:25:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vfio/mdev: add version attribute
 for mdev device
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
	"eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi
	L" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>,
	"Yang, Ziye" <ziye.yang@intel.com>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	"arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
	"felipe@nutanix.com" <felipe@nutanix.com>,
	"Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"dgilbert@redhat.com" <dgilbert@redhat.com>,
	"zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang, Zhi
	A" <zhi.a.wang@intel.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
	"He, Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 07:57:05 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Tue, May 07, 2019 at 05:19:54PM +0800, Cornelia Huck wrote:
> > On Sun,  5 May 2019 21:49:04 -0400
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >   
> > > version attribute is used to check two mdev devices' compatibility.
> > > 
> > > The key point of this version attribute is that it's rw.
> > > User space has no need to understand internal of device version and no
> > > need to compare versions by itself.
> > > Compared to reading version strings from both two mdev devices being
> > > checked, user space only reads from one mdev device's version attribute.
> > > After getting its version string, user space writes this string into the
> > > other mdev device's version attribute. Vendor driver of mdev device
> > > whose version attribute being written will check device compatibility of
> > > the two mdev devices for user space and return success for compatibility
> > > or errno for incompatibility.  
> > 
> > I'm still missing a bit _what_ is actually supposed to be
> > compatible/incompatible. I'd assume some internal state descriptions
> > (even if this is not actually limited to migration).
> >  
> right.
> originally, I thought this attribute should only contain a device's hardware
> compatibility info. But seems also including vendor specific software migration
> version is more reasonable, because general VFIO migration code cannot know
> version of vendor specific software migration code until migration data is
> transferring to the target vm. Then renaming it to migration_version is more
> appropriate.
> :)

Nod.

(...)

> > > @@ -246,6 +249,143 @@ Directories and files under the sysfs for Each Physical Device
> > >    This attribute should show the number of devices of type <type-id> that can be
> > >    created.
> > >  
> > > +* version
> > > +
> > > +  This attribute is rw, and is optional.
> > > +  It is used to check device compatibility between two mdev devices and is
> > > +  accessed in pairs between the two mdev devices being checked.
> > > +  The intent of this attribute is to make an mdev device's version opaque to
> > > +  user space, so instead of reading two mdev devices' version strings and
> > > +  comparing in userspace, user space should only read one mdev device's version
> > > +  attribute, and writes this version string into the other mdev device's version
> > > +  attribute. Then vendor driver of mdev device whose version attribute being
> > > +  written would check the incoming version string and tell user space whether
> > > +  the two mdev devices are compatible via return value. That's why this
> > > +  attribute is writable.  
> > 
> > I would reword this a bit:
> > 
> > "This attribute provides a way to check device compatibility between
> > two mdev devices from userspace. The intended usage is for userspace to
> > read the version attribute from one mdev device and then writing that
> > value to the version attribute of the other mdev device. The second
> > mdev device indicates compatibility via the return code of the write
> > operation. This makes compatibility between mdev devices completely
> > vendor-defined and opaque to userspace."
> > 
> > We still should explain _what_ compatibility we're talking about here,
> > though.
> >   
> Thanks. It's much better than mine:) 
> Then I'll change compatibility --> migration compatibility.

Ok, with that it should be clear enough.

> 
> > > +
> > > +  when reading this attribute, it should show device version string of
> > > +  the device of type <type-id>.
> > > +
> > > +  This string is private to vendor driver itself. Vendor driver is able to
> > > +  freely define format and length of device version string.
> > > +  e.g. It can use a combination of pciid of parent device + mdev type.
> > > +
> > > +  When writing a string to this attribute, vendor driver should analyze this
> > > +  string and check whether the mdev device being identified by this string is
> > > +  compatible with the mdev device for this attribute. vendor driver should then
> > > +  return written string's length if it regards the two mdev devices are
> > > +  compatible; vendor driver should return negative errno if it regards the two
> > > +  mdev devices are not compatible.
> > > +
> > > +  User space should treat ANY of below conditions as two mdev devices not
> > > +  compatible:
> > > +  (1) any one of the two mdev devices does not have a version attribute
> > > +  (2) error when read from one mdev device's version attribute  
> > 
> > s/read/reading/
> >   
> > > +  (3) error when write one mdev device's version string to the other mdev  
> > 
> > s/write/writing/
> >   
> > > +  device's version attribute
> > > +
> > > +  User space should regard two mdev devices compatible when ALL of below
> > > +  conditions are met:
> > > +  (1) success when read from one mdev device's version attribute.  
> > 
> > s/read/reading/
> >   
> > > +  (2) success when write one mdev device's version string to the other mdev  
> > 
> > s/write/writing/  
> got it. thanks for pointing them out:)
> >   
> > > +  device's version attribute
> > > +
> > > +  Errno:
> > > +  If vendor driver wants to claim a mdev device incompatible to all other mdev  
> > 
> > "If the vendor driver wants to designate a mdev device..."
> >   
> ok. thanks:)
> > > +  devices, it should not register version attribute for this mdev device. But if
> > > +  a vendor driver has already registered version attribute and it wants to claim
> > > +  a mdev device incompatible to all other mdev devices, it needs to return
> > > +  -ENODEV on access to this mdev device's version attribute.
> > > +  If a mdev device is only incompatible to certain mdev devices, write of
> > > +  incompatible mdev devices's version strings to its version attribute should
> > > +  return -EINVAL;  
> > 
> > 
> > Maybe put the defined return code into a bulleted list instead? But
> > this looks reasonable as well.
> >   
> as user space have no idea of those errno and only gets 0/1 as return code from
> read/write. maybe I can move this description of errno to patch 2/2 as an
> example?

Confused. They should get -EINVAL/-ENODEV/... all right, shouldn't they?

> 
> > > +
> > > +  This attribute can be taken advantage of by live migration.
> > > +  If user space detects two mdev devices are compatible through version
> > > +  attribute, it can start migration between the two mdev devices, otherwise it
> > > +  should abort its migration attempts between the two mdev devices.  
> > 
> > (...)
> > _______________________________________________
> > intel-gvt-dev mailing list
> > intel-gvt-dev@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev  



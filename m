Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBFCC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B2E20818
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B2E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45618 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVDI-0001D0-DN
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:03:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQVCH-0000sn-2a
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hQVCC-00051x-Vy
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hQVCC-00051T-Mz
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:02:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FF6489C3E;
	Tue, 14 May 2019 11:02:02 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E57D61995;
	Tue, 14 May 2019 11:01:48 +0000 (UTC)
Date: Tue, 14 May 2019 12:01:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190514110143.GD2753@work-vm>
References: <20190510110838.2df4c4d0.cohuck@redhat.com>
	<20190510093608.GD2854@work-vm>
	<20190510114838.7e16c3d6.cohuck@redhat.com>
	<20190513132804.GD11139@beluga.usersys.redhat.com>
	<20190514061235.GC20407@joy-OptiPlex-7040>
	<20190514072039.GA2089@beluga.usersys.redhat.com>
	<20190514073219.GD20407@joy-OptiPlex-7040>
	<20190514074344.GB2089@beluga.usersys.redhat.com>
	<20190514074736.GE20407@joy-OptiPlex-7040>
	<20190514115135.078bbaf7.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514115135.078bbaf7.cohuck@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 14 May 2019 11:02:02 +0000 (UTC)
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
	"eauger@redhat.com" <eauger@redhat.com>, "Liu,
	Yi L" <yi.l.liu@intel.com>, Erik Skultety <eskultet@redhat.com>,
	"Yang, Ziye" <ziye.yang@intel.com>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	"arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
	"felipe@nutanix.com" <felipe@nutanix.com>,
	"Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
	"zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>,
	"berrange@redhat.com" <berrange@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wang, Zhi A" <zhi.a.wang@intel.com>,
	"dinechin@redhat.com" <dinechin@redhat.com>, "He,
	Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Cornelia Huck (cohuck@redhat.com) wrote:
> On Tue, 14 May 2019 03:47:36 -0400
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Tue, May 14, 2019 at 03:43:44PM +0800, Erik Skultety wrote:
> > > On Tue, May 14, 2019 at 03:32:19AM -0400, Yan Zhao wrote:  
> > > > On Tue, May 14, 2019 at 03:20:40PM +0800, Erik Skultety wrote:  
> 
> > > > > That said, from libvirt POV as a consumer, I'd expect there to be truly only 2
> > > > > errors (I believe Alex has mentioned something similar in one of his responses
> > > > > in one of the threads):
> > > > >     a) read error indicating that an mdev type doesn't support migration
> > > > >         - I assume if one type doesn't support migration, none of the other
> > > > >           types exposed on the parent device do, is that a fair assumption?
> 
> Probably; but there might be cases where the migratability depends not
> on the device type, but how the partitioning has been done... or is
> that too contrived?
> 
> > > > >     b) write error indicating that the mdev types are incompatible for
> > > > >     migration
> > > > >
> > > > > Regards,
> > > > > Erik  
> > > > Thanks for this explanation.
> > > > so, can we arrive at below agreements?
> > > >
> > > > 1. "not to define the specific errno returned for a specific situation,
> > > > let the vendor driver decide, userspace simply needs to know that an errno on
> > > > read indicates the device does not support migration version comparison and
> > > > that an errno on write indicates the devices are incompatible or the target
> > > > doesn't support migration versions. "
> > > > 2. vendor driver should log detailed error reasons in kernel log.  
> > > 
> > > That would be my take on this, yes, but I open to hear any other suggestions and
> > > ideas I couldn't think of as well.
> 
> So, read to find out whether migration is supported at all, write to
> find out whether it is supported for that concrete pairing is
> reasonable for libvirt?
> 
> > > 
> > > Erik  
> > got it. thanks a lot!
> > 
> > hi Cornelia and Dave,
> > do you also agree on:
> > 1. "not to define the specific errno returned for a specific situation,
> > let the vendor driver decide, userspace simply needs to know that an errno on
> > read indicates the device does not support migration version comparison and
> > that an errno on write indicates the devices are incompatible or the target
> > doesn't support migration versions. "
> > 2. vendor driver should log detailed error reasons in kernel log.
> 
> Two questions:
> - How reasonable is it to refer to the system log in order to find out
>   what exactly went wrong?
> - If detailed error reporting is basically done to the syslog, do
>   different error codes still provide useful information? Or should the
>   vendor driver decide what it wants to do?

I don't see error codes as being that helpful; if we can't actually get
an error message back up the stack (which was my preference), then I guess
syslog is as good as it will get.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


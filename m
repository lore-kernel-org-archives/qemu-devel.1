Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7A8C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E66A238CE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E66A238CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55177 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVzHd-0005GL-Bh
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 10:10:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hVzGK-0004Ve-JS
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hVzGI-0000op-KR
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:09:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hVzGG-0000mj-KC
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:09:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C629130044C9;
	Wed, 29 May 2019 14:08:47 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B9C560FAF;
	Wed, 29 May 2019 14:08:36 +0000 (UTC)
Date: Wed, 29 May 2019 08:08:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Boris Fiuczynski <fiuczy@linux.ibm.com>
Message-ID: <20190529080836.007b8755@x1.home>
In-Reply-To: <0c1f5f03-1895-b9a2-999f-f611dd295732@linux.ibm.com>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506014904.3621-1-yan.y.zhao@intel.com>
	<20190507151826.502be009@x1.home>
	<20190508112740.GA24397@joy-OptiPlex-7040>
	<20190508152242.4b54a5e7@x1.home>
	<5eac912c-e753-b5f6-83a4-b646f991d858@linux.ibm.com>
	<20190514093140.68cc6f7a@x1.home>
	<0c1f5f03-1895-b9a2-999f-f611dd295732@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 29 May 2019 14:08:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH v2 1/2] vfio/mdev: add version
 attribute for mdev device
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
	Halil Pasic <pasic@linux.ibm.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	"arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
	"felipe@nutanix.com" <felipe@nutanix.com>,
	"Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian,
	Kevin" <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
	"dgilbert@redhat.com" <dgilbert@redhat.com>,
	"zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
	"dinechin@redhat.com" <dinechin@redhat.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>, Krowiak <akrowiak@linux.ibm.com>,
	Pierre Morel <pmorel@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang, Zhi
	A" <zhi.a.wang@intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
	Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 22:57:15 +0200
Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:

> On 5/14/19 5:31 PM, Alex Williamson wrote:
> > On Wed, 8 May 2019 17:27:47 +0200
> > Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:
> >   
> >> On 5/8/19 11:22 PM, Alex Williamson wrote:  
> >>>>> I thought there was a request to make this more specific to migration
> >>>>> by renaming it to something like migration_version.  Also, as an
> >>>>>        
> >>>> so this attribute may not only include a mdev device's parent device info and
> >>>> mdev type, but also include numeric software version of vendor specific
> >>>> migration code, right?  
> >>> It's a vendor defined string, it should be considered opaque to the
> >>> user, the vendor can include whatever they feel is relevant.
> >>>      
> >> Would a vendor also be allowed to provide a string expressing required
> >> features as well as containing backend resource requirements which need
> >> to be compatible for a successful migration? Somehow a bit like a cpu
> >> model... maybe even as json or xml...
> >> I am asking this with vfio-ap in mind. In that context checking
> >> compatibility of two vfio-ap mdev devices is not as simple as checking
> >> if version A is smaller or equal to version B.  
> > 
> > Two pieces to this, the first is that the string is opaque exactly so
> > that the vendor driver can express whatever they need in it.  The user
> > should never infer that two devices are compatible.  The second is that  
> I agree.
> 
> > this is not a resource availability or reservation interface.  The fact  
> I also agree. The migration_version (version in this case is not really 
> a good fit) is a summary of requirements the source mdev has which a 
> target mdev needs to be able to fulfill in order to allow migration.
> The target mdev already exists and was already configured by other means 
> not involved in the migration check process.

Just a nit here (I hope), the target mdev does not necessarily exist at
the time we're testing migration version compatibility.  The intention
is that this feature can be used to select a target host system which
can possibly generate a compatible target mdev device before committing
to create that device.  For instance a management tool might test for
migration compatibility across a data center, narrowing the set of
potential target hosts, then proceed to select a best choice based on
factors including the ability to actually instantiate such a device on
the host.

> Using the migrations_version as some kind of configuration transport 
> and/or reservation mechanism wasn't my intention and IMHO would both be 
> wrong.

Sounds good.  Thanks,

Alex

> > that a target device would be compatible for migration should not take
> > into account whether the target has the resources to actually create
> > such a device.  Doing so would imply some sort of resource reservation
> > support that does not exist.  Matrix devices are clearly a bit
> > complicated here since maybe the source is expressing a component of
> > the device that doesn't exist on the target.  In such a "resource not
> > available at all" case, it might be fair to nak the compatibility test,
> > but a "ok, but resource not currently available" case should pass,
> > imo.  Thanks,
> > 
> > Alex
> > 
> > --
> > libvir-list mailing list
> > libvir-list@redhat.com
> > https://www.redhat.com/mailman/listinfo/libvir-list
> >   
> 
> 



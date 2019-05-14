Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954E1C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B51A20862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B51A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49935 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZQF-0006k9-Bs
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:32:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hQZPC-0006Ni-CD
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hQZPB-0001dS-BG
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:31:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hQZPB-0001cE-3D
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:31:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBF47307D962;
	Tue, 14 May 2019 15:31:47 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B2F695C542;
	Tue, 14 May 2019 15:31:40 +0000 (UTC)
Date: Tue, 14 May 2019 09:31:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Boris Fiuczynski <fiuczy@linux.ibm.com>
Message-ID: <20190514093140.68cc6f7a@x1.home>
In-Reply-To: <5eac912c-e753-b5f6-83a4-b646f991d858@linux.ibm.com>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506014904.3621-1-yan.y.zhao@intel.com>
	<20190507151826.502be009@x1.home>
	<20190508112740.GA24397@joy-OptiPlex-7040>
	<20190508152242.4b54a5e7@x1.home>
	<5eac912c-e753-b5f6-83a4-b646f991d858@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 14 May 2019 15:31:48 +0000 (UTC)
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
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>,
	Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang, Zhi
	A" <zhi.a.wang@intel.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
	"He, Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 17:27:47 +0200
Boris Fiuczynski <fiuczy@linux.ibm.com> wrote:

> On 5/8/19 11:22 PM, Alex Williamson wrote:
> >>> I thought there was a request to make this more specific to migration
> >>> by renaming it to something like migration_version.  Also, as an
> >>>     
> >> so this attribute may not only include a mdev device's parent device info and
> >> mdev type, but also include numeric software version of vendor specific
> >> migration code, right?  
> > It's a vendor defined string, it should be considered opaque to the
> > user, the vendor can include whatever they feel is relevant.
> >   
> Would a vendor also be allowed to provide a string expressing required 
> features as well as containing backend resource requirements which need 
> to be compatible for a successful migration? Somehow a bit like a cpu 
> model... maybe even as json or xml...
> I am asking this with vfio-ap in mind. In that context checking 
> compatibility of two vfio-ap mdev devices is not as simple as checking 
> if version A is smaller or equal to version B.

Two pieces to this, the first is that the string is opaque exactly so
that the vendor driver can express whatever they need in it.  The user
should never infer that two devices are compatible.  The second is that
this is not a resource availability or reservation interface.  The fact
that a target device would be compatible for migration should not take
into account whether the target has the resources to actually create
such a device.  Doing so would imply some sort of resource reservation
support that does not exist.  Matrix devices are clearly a bit
complicated here since maybe the source is expressing a component of
the device that doesn't exist on the target.  In such a "resource not
available at all" case, it might be fair to nak the compatibility test,
but a "ok, but resource not currently available" case should pass,
imo.  Thanks,

Alex


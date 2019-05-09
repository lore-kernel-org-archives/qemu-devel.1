Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA27AC04AB3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808ED2177E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 15:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808ED2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56927 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOlOb-0005mQ-Ql
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 11:55:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hOlNU-0005Fc-KG
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hOlNT-0001SO-3u
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:54:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hOlNS-0001S6-Pd
	for qemu-devel@nongnu.org; Thu, 09 May 2019 11:54:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22D1599C1D;
	Thu,  9 May 2019 15:54:28 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B360F1001E65;
	Thu,  9 May 2019 15:54:06 +0000 (UTC)
Date: Thu, 9 May 2019 17:54:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190509175404.512ae7aa.cohuck@redhat.com>
In-Reply-To: <20190509154857.GF2868@work-vm>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506014904.3621-1-yan.y.zhao@intel.com>
	<20190507151826.502be009@x1.home>
	<20190509173839.2b9b2b46.cohuck@redhat.com>
	<20190509154857.GF2868@work-vm>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 09 May 2019 15:54:33 +0000 (UTC)
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
	Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
	qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com,
	yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
	mlevitsk@redhat.com, pasic@linux.ibm.com, libvir-list@redhat.com,
	arei.gonglei@huawei.com, felipe@nutanix.com, Ken.Xue@amd.com,
	kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>,
	zhenyuw@linux.intel.com, dinechin@redhat.com,
	Alex Williamson <alex.williamson@redhat.com>,
	intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com,
	linux-kernel@vger.kernel.org, zhi.a.wang@intel.com,
	jonathan.davies@nutanix.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 16:48:57 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Cornelia Huck (cohuck@redhat.com) wrote:
> > On Tue, 7 May 2019 15:18:26 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > On Sun,  5 May 2019 21:49:04 -0400
> > > Yan Zhao <yan.y.zhao@intel.com> wrote:  
> >   
> > > > +  Errno:
> > > > +  If vendor driver wants to claim a mdev device incompatible to all other mdev
> > > > +  devices, it should not register version attribute for this mdev device. But if
> > > > +  a vendor driver has already registered version attribute and it wants to claim
> > > > +  a mdev device incompatible to all other mdev devices, it needs to return
> > > > +  -ENODEV on access to this mdev device's version attribute.
> > > > +  If a mdev device is only incompatible to certain mdev devices, write of
> > > > +  incompatible mdev devices's version strings to its version attribute should
> > > > +  return -EINVAL;    
> > > 
> > > I think it's best not to define the specific errno returned for a
> > > specific situation, let the vendor driver decide, userspace simply
> > > needs to know that an errno on read indicates the device does not
> > > support migration version comparison and that an errno on write
> > > indicates the devices are incompatible or the target doesn't support
> > > migration versions.  
> > 
> > I think I have to disagree here: It's probably valuable to have an
> > agreed error for 'cannot migrate at all' vs 'cannot migrate between
> > those two particular devices'. Userspace might want to do different
> > things (e.g. trying with different device pairs).  
> 
> Trying to stuff these things down an errno seems a bad idea; we can't
> get much information that way.

So, what would be a reasonable approach? Userspace should first read
the version attributes on both devices (to find out whether migration
is supported at all), and only then figure out via writing whether they
are compatible?

(Or just go ahead and try, if it does not care about the reason.)


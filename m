Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB53DC352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B4A208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGtXg/Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B4A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPPAC-0007v2-Qm
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jPP9a-0007W1-Q2
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jPP9Y-00068k-RR
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:27:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55817
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jPP9Y-000685-KI
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587122843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vr7BOIbO9qakvttMKiL/rWtwPVentFYT4peua3moyXg=;
 b=FGtXg/BfIeVUcUgJm7b4x1m+EyvkxAEy0Ybg6O7O7cujyo5jDZg7ZgHJEGU5B5YeWmAwhe
 h5wX/4CVtEtoOjHorOJgrMWADX5nKe3hseRhazYPaUDLOfsZbRPX38lsrwV4sqN7mGFnL1
 MBDy0UeGPxgQ4j29J931fc6z1LITVSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-fiee8RQFNc2mMhyoQXOhVA-1; Fri, 17 Apr 2020 07:27:19 -0400
X-MC-Unique: fiee8RQFNc2mMhyoQXOhVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3B72107ACCA;
 Fri, 17 Apr 2020 11:27:16 +0000 (UTC)
Received: from gondolin (ovpn-112-200.ams2.redhat.com [10.36.112.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 330F75C1C5;
 Fri, 17 Apr 2020 11:27:02 +0000 (UTC)
Date: Fri, 17 Apr 2020 13:24:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200417132457.45d91fe3.cohuck@redhat.com>
In-Reply-To: <20200417095202.GD16688@joy-OptiPlex-7040>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
 <20200417104450.2d2f2fa9.cohuck@redhat.com>
 <20200417095202.GD16688@joy-OptiPlex-7040>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
 Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 05:52:02 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Fri, Apr 17, 2020 at 04:44:50PM +0800, Cornelia Huck wrote:
> > On Mon, 13 Apr 2020 01:52:01 -0400
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >   
> > > This patchset introduces a migration_version attribute under sysfs of VFIO
> > > Mediated devices.
> > > 
> > > This migration_version attribute is used to check migration compatibility
> > > between two mdev devices.
> > > 
> > > Currently, it has two locations:
> > > (1) under mdev_type node,
> > >     which can be used even before device creation, but only for mdev
> > >     devices of the same mdev type.
> > > (2) under mdev device node,
> > >     which can only be used after the mdev devices are created, but the src
> > >     and target mdev devices are not necessarily be of the same mdev type
> > > (The second location is newly added in v5, in order to keep consistent
> > > with the migration_version node for migratable pass-though devices)  
> > 
> > What is the relationship between those two attributes?
> >   
> (1) is for mdev devices specifically, and (2) is provided to keep the same
> sysfs interface as with non-mdev cases. so (2) is for both mdev devices and
> non-mdev devices.
> 
> in future, if we enable vfio-pci vendor ops, (i.e. a non-mdev device
> is binding to vfio-pci, but is able to register migration region and do
> migration transactions from a vendor provided affiliate driver),
> the vendor driver would export (2) directly, under device node.
> It is not able to provide (1) as there're no mdev devices involved.

Ok, creating an alternate attribute for non-mdev devices makes sense.
However, wouldn't that rather be a case (3)? The change here only
refers to mdev devices.

> 
> > Is existence (and compatibility) of (1) a pre-req for possible
> > existence (and compatibility) of (2)?
> >  
> no. (2) does not reply on (1).

Hm. Non-existence of (1) seems to imply "this type does not support
migration". If an mdev created for such a type suddenly does support
migration, it feels a bit odd.

(It obviously cannot be a prereq for what I called (3) above.)

> 
> > Does userspace need to check (1) or can it completely rely on (2), if
> > it so chooses?
> >  
> I think it can completely reply on (2) if compatibility check before
> mdev creation is not required.
> 
> > If devices with a different mdev type are indeed compatible, it seems
> > userspace can only find out after the devices have actually been
> > created, as (1) does not apply?  
> yes, I think so. 

How useful would it be for userspace to even look at (1) in that case?
It only knows if things have a chance of working if it actually goes
ahead and creates devices.

> 
> > One of my worries is that the existence of an attribute with the same
> > name in two similar locations might lead to confusion. But maybe it
> > isn't a problem.
> >  
> Yes, I have the same feeling. but as (2) is for sysfs interface
> consistency, to make it transparent to userspace tools like libvirt,
> I guess the same name is necessary?

What do we actually need here, I wonder? (1) and (2) seem to serve
slightly different purposes, while (2) and what I called (3) have the
same purpose. Is it important to userspace that (1) and (2) have the
same name?



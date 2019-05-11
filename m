Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC31CC04A6B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 01:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19382184C
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 01:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19382184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPGkH-0002kV-3h
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 21:24:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hPGjS-0002RY-DT
	for qemu-devel@nongnu.org; Fri, 10 May 2019 21:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hPGjR-0006gB-D4
	for qemu-devel@nongnu.org; Fri, 10 May 2019 21:23:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hPGjR-0006fa-5N
	for qemu-devel@nongnu.org; Fri, 10 May 2019 21:23:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 217C2308FC4E;
	Sat, 11 May 2019 01:23:19 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E0D66100E9FF;
	Sat, 11 May 2019 01:23:18 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 676DA18089CA;
	Sat, 11 May 2019 01:23:18 +0000 (UTC)
Date: Fri, 10 May 2019 21:23:17 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <2003480558.28042237.1557537797923.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gL3ODfOr52Ztgq7BM4gVf1cih6cj0271gcpVvpi9aFSA@mail.gmail.com>
References: <20190510155202.14737-1-pagupta@redhat.com>
	<20190510155202.14737-4-pagupta@redhat.com>
	<CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
	<864186878.28040999.1557535549792.JavaMail.zimbra@redhat.com>
	<CAPcyv4gL3ODfOr52Ztgq7BM4gVf1cih6cj0271gcpVvpi9aFSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.28, 10.4.195.22]
Thread-Topic: libnvdimm: add dax_dev sync flag
Thread-Index: ptJfczfofLn7Sapjrtn0VT/vVA1TgQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Sat, 11 May 2019 01:23:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 3/6] libnvdimm: add dax_dev sync flag
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
Cc: Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	virtualization@lists.linux-foundation.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>, jstaron@google.com,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, Adam Borowski <kilobyte@angband.pl>,
	Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>, cohuck@redhat.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> > > >
> > > > This patch adds 'DAXDEV_SYNC' flag which is set
> > > > for nd_region doing synchronous flush. This later
> > > > is used to disable MAP_SYNC functionality for
> > > > ext4 & xfs filesystem for devices don't support
> > > > synchronous flush.
> > > >
> > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > > ---
> > > >  drivers/dax/bus.c            |  2 +-
> > > >  drivers/dax/super.c          | 13 ++++++++++++-
> > > >  drivers/md/dm.c              |  3 ++-
> > > >  drivers/nvdimm/pmem.c        |  5 ++++-
> > > >  drivers/nvdimm/region_devs.c |  7 +++++++
> > > >  include/linux/dax.h          |  8 ++++++--
> > > >  include/linux/libnvdimm.h    |  1 +
> > > >  7 files changed, 33 insertions(+), 6 deletions(-)
> > > [..]
> > > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > > index 043f0761e4a0..ee007b75d9fd 100644
> > > > --- a/drivers/md/dm.c
> > > > +++ b/drivers/md/dm.c
> > > > @@ -1969,7 +1969,8 @@ static struct mapped_device *alloc_dev(int minor)
> > > >         sprintf(md->disk->disk_name, "dm-%d", minor);
> > > >
> > > >         if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
> > > > -               dax_dev = alloc_dax(md, md->disk->disk_name,
> > > > &dm_dax_ops);
> > > > +               dax_dev = alloc_dax(md, md->disk->disk_name,
> > > > &dm_dax_ops,
> > > > +
> > > > DAXDEV_F_SYNC);
> > >
> > > Apologies for not realizing this until now, but this is broken.
> > > Imaging a device-mapper configuration composed of both 'async'
> > > virtio-pmem and 'sync' pmem. The 'sync' flag needs to be unified
> > > across all members. I would change this argument to '0' and then
> > > arrange for it to be set at dm_table_supports_dax() time after
> > > validating that all components support synchronous dax.
> >
> > o.k. Need to set 'DAXDEV_F_SYNC' flag after verifying all the target
> > components support synchronous DAX.
> >
> > Just a question, If device mapper configuration have composed of both
> > virtio-pmem or pmem devices, we want to configure device mapper for async
> > flush?
> 
> If it's composed of both then, yes, it needs to be async flush at the
> device-mapper level. Otherwise MAP_SYNC will succeed and fail to
> trigger fsync on the host file when necessary for the virtio-pmem
> backed portion of the device-mapper device.

o.k. Agree.

Thanks you,
Pankaj
> 
> 


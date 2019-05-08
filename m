Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84D0C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6C421655
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6C421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59789 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFU7-0005Zu-R4
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 01:51:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hOFRz-0003eS-R4
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hOFRy-00073M-Sr
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:49:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hOFRy-000733-Kh
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2318C05D3FD;
	Wed,  8 May 2019 05:49:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 94A901001E60;
	Wed,  8 May 2019 05:49:05 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5054918089C8;
	Wed,  8 May 2019 05:49:05 +0000 (UTC)
Date: Wed, 8 May 2019 01:49:04 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID: <7976014.27184867.1557294544901.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190507161736.GV5207@magnolia>
References: <20190426050039.17460-1-pagupta@redhat.com>
	<20190426050039.17460-7-pagupta@redhat.com>
	<CAPcyv4hCP4E4xPkQx25tqhznon6ADwrYJB1yujkrO-A7LUnsmg@mail.gmail.com>
	<20190507161736.GV5207@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.19, 10.4.195.7]
Thread-Topic: disable map_sync for async flush
Thread-Index: JBzJaF62TCLP+9MfvU9kbFR+Dq73zQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 08 May 2019 05:49:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 6/6] xfs: disable map_sync for async
 flush
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
	Dave Jiang <dave.jiang@intel.com>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, kilobyte@angband.pl,
	Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>, cohuck@redhat.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> 
> On Tue, May 07, 2019 at 08:37:01AM -0700, Dan Williams wrote:
> > On Thu, Apr 25, 2019 at 10:03 PM Pankaj Gupta <pagupta@redhat.com> wrote:
> > >
> > > Dont support 'MAP_SYNC' with non-DAX files and DAX files
> > > with asynchronous dax_device. Virtio pmem provides
> > > asynchronous host page cache flush mechanism. We don't
> > > support 'MAP_SYNC' with virtio pmem and xfs.
> > >
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > Darrick, does this look ok to take through the nvdimm tree?
> 
> <urk> forgot about this, sorry. :/
> 
> > >
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index a7ceae90110e..f17652cca5ff 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1203,11 +1203,14 @@ xfs_file_mmap(
> > >         struct file     *filp,
> > >         struct vm_area_struct *vma)
> > >  {
> > > +       struct dax_device       *dax_dev;
> > > +
> > > +       dax_dev = xfs_find_daxdev_for_inode(file_inode(filp));
> > >         /*
> > > -        * We don't support synchronous mappings for non-DAX files. At
> > > least
> > > -        * until someone comes with a sensible use case.
> > > +        * We don't support synchronous mappings for non-DAX files and
> > > +        * for DAX files if underneath dax_device is not synchronous.
> > >          */
> > > -       if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> > > +       if (!daxdev_mapping_supported(vma, dax_dev))
> > >                 return -EOPNOTSUPP;
> 
> LGTM, and I'm fine with it going through nvdimm.  Nothing in
> xfs-5.2-merge touches that function so it should be clean.
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thank you for the review.

Pankaj

> 
> --D
> 
> > >
> > >         file_accessed(filp);
> > > --
> > > 2.20.1
> > >
> 
> 


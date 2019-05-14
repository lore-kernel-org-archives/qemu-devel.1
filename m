Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F37C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70332086A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70332086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQPzG-0006Y1-Iz
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 01:28:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hQPyO-0006Dn-7q
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hQPyM-00039f-Uq
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hQPyH-0002xt-Nq
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:27:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09F663092670;
	Tue, 14 May 2019 05:27:21 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F3478600C6;
	Tue, 14 May 2019 05:27:19 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
	(zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9997218089C8;
	Tue, 14 May 2019 05:27:18 +0000 (UTC)
Date: Tue, 14 May 2019 01:27:17 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <676644679.28490825.1557811637861.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4genJtCt6dp6N07_6RfPTwC6xXMhLp-dr0GWQy5q52YoA@mail.gmail.com>
References: <20190510155202.14737-1-pagupta@redhat.com>
	<20190510155202.14737-4-pagupta@redhat.com>
	<CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
	<864186878.28040999.1557535549792.JavaMail.zimbra@redhat.com>
	<CAPcyv4gL3ODfOr52Ztgq7BM4gVf1cih6cj0271gcpVvpi9aFSA@mail.gmail.com>
	<2003480558.28042237.1557537797923.JavaMail.zimbra@redhat.com>
	<116369545.28425569.1557768748009.JavaMail.zimbra@redhat.com>
	<CAPcyv4genJtCt6dp6N07_6RfPTwC6xXMhLp-dr0GWQy5q52YoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.16.148, 10.4.195.17]
Thread-Topic: libnvdimm: add dax_dev sync flag
Thread-Index: wQqDJDTh4d6BDzUQZjrFKazK6E2QhQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 14 May 2019 05:27:21 +0000 (UTC)
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
	Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>, cohuck@redhat.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> >
> >
> > Hi Dan,
> >
> > While testing device mapper with DAX, I faced a bug with the commit:
> >
> > commit ad428cdb525a97d15c0349fdc80f3d58befb50df
> > Author: Dan Williams <dan.j.williams@intel.com>
> > Date:   Wed Feb 20 21:12:50 2019 -0800
> >
> > When I reverted the condition to old code[1] it worked for me. I
> > am thinking when we map two different devices (e.g with device mapper),
> > will
> > start & end pfn still point to same pgmap? Or there is something else which
> > I am missing here.
> >
> > Note: I tested only EXT4.
> >
> > [1]
> >
> > -               if (pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX)
> > +               end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
> > +               if (pgmap && pgmap == end_pgmap && pgmap->type ==
> > MEMORY_DEVICE_FS_DAX
> > +                               && pfn_t_to_page(pfn)->pgmap == pgmap
> > +                               && pfn_t_to_page(end_pfn)->pgmap == pgmap
> > +                               && pfn_t_to_pfn(pfn) ==
> > PHYS_PFN(__pa(kaddr))
> > +                               && pfn_t_to_pfn(end_pfn) ==
> > PHYS_PFN(__pa(end_kaddr)))
> 
> Ugh, yes, device-mapper continues to be an awkward fit for dax (or
> vice versa). We would either need a way to have a multi-level pfn to
> pagemap lookup for composite devices, or a way to discern that even
> though the pagemap is different that the result is still valid / not
> an indication that we have leaked into an unassociated address range.
> Perhaps a per-daxdev callback for ->dax_supported() so that
> device-mapper internals can be used for this validation.

Yes, Will look at it.

> 
> We need to get that fixed up, but I don't see it as a blocker /
> pre-requisite for virtio-pmem.

Agree. Will send virtio-pmem patch series.

Thank you,
Pankaj
> 
> 


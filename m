Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3210C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC0020866
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC0020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60798 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajdC-0005Xc-3w
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40356)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hajGR-0003jH-HX
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hajGQ-0003Gn-Ei
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:04:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hajGQ-0003DW-2B
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 12:04:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5E7847FDFE;
 Tue, 11 Jun 2019 16:04:32 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10197611DA;
 Tue, 11 Jun 2019 16:04:25 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id D31A018363C0;
 Tue, 11 Jun 2019 16:04:21 +0000 (UTC)
Date: Tue, 11 Jun 2019 12:04:21 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>
Message-ID: <1006124881.34430329.1560269061491.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190611150427.GA29288@redhat.com>
References: <20190610090730.8589-1-pagupta@redhat.com>
 <20190610090730.8589-5-pagupta@redhat.com>
 <20190610192803.GA29002@redhat.com>
 <1206355816.34396746.1560258658768.JavaMail.zimbra@redhat.com>
 <20190611150427.GA29288@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.60, 10.4.195.3]
Thread-Topic: enable synchronous dax
Thread-Index: H4DObhswv6RiIzHdNTVFv9g9Hzvnew==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 11 Jun 2019 16:04:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v11 4/7] dm: enable synchronous dax
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
 aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, jstaron@google.com,
 linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>,
 david@redhat.com, willy@infradead.org, hch@infradead.org,
 linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org,
 lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com,
 yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, pbonzini@redhat.com,
 dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com,
 kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, rdunlap@infradead.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, imammedo@redhat.com,
 darrick wong <darrick.wong@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> 
> > Hi Mike,
> > 
> > Thanks for the review Please find my reply inline.
> > 
> > > 
> > > dm_table_supports_dax() is called multiple times (from
> > > dm_table_set_restrictions and dm_table_determine_type).  It is strange
> > > to have a getter have a side-effect of being a setter too.  Overloading
> > > like this could get you in trouble in the future.
> > > 
> > > Are you certain this is what you want?
> > 
> > I agree with you.
> > 
> > > 
> > > Or would it be better to refactor dm_table_supports_dax() to take an
> > > iterate_devices_fn arg and have callers pass the appropriate function?
> > > Then have dm_table_set_restrictions() caller do:
> > > 
> > >      if (dm_table_supports_dax(t, device_synchronous, NULL))
> > >                set_dax_synchronous(t->md->dax_dev);
> > > 
> > > (NULL arg implies dm_table_supports_dax() refactoring would take a int
> > > *data pointer rather than int type).
> > > 
> > > Mike
> > > 
> > 
> > I am sending below patch as per your suggestion. Does it look
> > near to what you have in mind?
> 
> Yes, it does.. just one nit I noticed inlined below.
> 
> > diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> > index 350cf0451456..8d89acc8b8c2 100644
> > --- a/drivers/md/dm-table.c
> > +++ b/drivers/md/dm-table.c
> 
> ...
> 
> > @@ -1910,8 +1919,13 @@ void dm_table_set_restrictions(struct dm_table *t,
> > struct request_queue *q,
> >         }
> >         blk_queue_write_cache(q, wc, fua);
> > 
> > -       if (dm_table_supports_dax(t, PAGE_SIZE))
> > +       if (dm_table_supports_dax(t, device_supports_dax, &page_size)) {
> > +
> 
> No need for an empty newline here ^

Sure. Will remove this and send official v12 patchset with the updated patch 4.

Thanks,
Pankaj

> 
> >                 blk_queue_flag_set(QUEUE_FLAG_DAX, q);
> > +               if (dm_table_supports_dax(t, device_synchronous, NULL))
> > +                       set_dax_synchronous(t->md->dax_dev);
> > +       }
> >         else
> >                 blk_queue_flag_clear(QUEUE_FLAG_DAX, q);
> > 
> 
> Thanks,
> Mike
> 
> 


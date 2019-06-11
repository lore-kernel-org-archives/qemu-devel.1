Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EDCC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3453206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3453206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60018 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haiOX-00051v-7U
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 11:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50580)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <msnitzer@redhat.com>) id 1haiLD-0003BR-8m
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msnitzer@redhat.com>) id 1haiLC-0007qH-4f
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:05:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <msnitzer@redhat.com>) id 1haiLB-0007ds-Rn
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:05:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F49930BBE98;
 Tue, 11 Jun 2019 15:04:52 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08DB05DA2E;
 Tue, 11 Jun 2019 15:04:28 +0000 (UTC)
Date: Tue, 11 Jun 2019 11:04:27 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190611150427.GA29288@redhat.com>
References: <20190610090730.8589-1-pagupta@redhat.com>
 <20190610090730.8589-5-pagupta@redhat.com>
 <20190610192803.GA29002@redhat.com>
 <1206355816.34396746.1560258658768.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1206355816.34396746.1560258658768.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 11 Jun 2019 15:05:18 +0000 (UTC)
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
Cc: rdunlap@infradead.org, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org,
 aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, jstaron@google.com,
 linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>,
 david@redhat.com, willy@infradead.org, hch@infradead.org,
 linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org,
 lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com,
 yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, imammedo@redhat.com,
 dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com,
 kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, cohuck@redhat.com,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, pbonzini@redhat.com,
 darrick wong <darrick.wong@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 11 2019 at  9:10am -0400,
Pankaj Gupta <pagupta@redhat.com> wrote:

> Hi Mike,
> 
> Thanks for the review Please find my reply inline.
> 
> > 
> > dm_table_supports_dax() is called multiple times (from
> > dm_table_set_restrictions and dm_table_determine_type).  It is strange
> > to have a getter have a side-effect of being a setter too.  Overloading
> > like this could get you in trouble in the future.
> > 
> > Are you certain this is what you want?
> 
> I agree with you.
> 
> > 
> > Or would it be better to refactor dm_table_supports_dax() to take an
> > iterate_devices_fn arg and have callers pass the appropriate function?
> > Then have dm_table_set_restrictions() caller do:
> > 
> >      if (dm_table_supports_dax(t, device_synchronous, NULL))
> >                set_dax_synchronous(t->md->dax_dev);
> > 
> > (NULL arg implies dm_table_supports_dax() refactoring would take a int
> > *data pointer rather than int type).
> > 
> > Mike
> > 
> 
> I am sending below patch as per your suggestion. Does it look
> near to what you have in mind?

Yes, it does.. just one nit I noticed inlined below.

> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 350cf0451456..8d89acc8b8c2 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c

...

> @@ -1910,8 +1919,13 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>         }
>         blk_queue_write_cache(q, wc, fua);
> 
> -       if (dm_table_supports_dax(t, PAGE_SIZE))
> +       if (dm_table_supports_dax(t, device_supports_dax, &page_size)) {
> +

No need for an empty newline here ^

>                 blk_queue_flag_set(QUEUE_FLAG_DAX, q);
> +               if (dm_table_supports_dax(t, device_synchronous, NULL))
> +                       set_dax_synchronous(t->md->dax_dev);
> +       }
>         else
>                 blk_queue_flag_clear(QUEUE_FLAG_DAX, q);
> 

Thanks,
Mike


Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922D2C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988D2206CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988D2206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5rlB-0002d7-Fh
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 09:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i5rkW-0001xI-05
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i5rkU-0004jr-Uv
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:24:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i5rkR-0004iU-Cv; Thu, 05 Sep 2019 09:24:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2BBFC875221;
 Thu,  5 Sep 2019 13:24:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA47B5C1D4;
 Thu,  5 Sep 2019 13:24:20 +0000 (UTC)
Message-ID: <58a0f856b958bcb90df6d5f778c8ca0eaefaf8f9.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 05 Sep 2019 16:24:19 +0300
In-Reply-To: <798ede8632285382a9d54dc9e3a75be046387b7d.camel@redhat.com>
References: <20190825071541.10389-1-mlevitsk@redhat.com>
 <20190825071541.10389-3-mlevitsk@redhat.com>
 <0618bc5b-6c0b-d154-dc7c-77398a7eb031@redhat.com>
 <798ede8632285382a9d54dc9e3a75be046387b7d.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Thu, 05 Sep 2019 13:24:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] block/nvme: add support for discard
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Ferlan <jferlan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-28 at 12:03 +0300, Maxim Levitsky wrote:
> On Tue, 2019-08-27 at 18:29 -0400, John Snow wrote:
> > 
> > On 8/25/19 3:15 AM, Maxim Levitsky wrote:
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  block/nvme.c       | 83 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  block/trace-events |  2 ++
> > >  2 files changed, 85 insertions(+)
> > > 
> > > diff --git a/block/nvme.c b/block/nvme.c
> > > index f8bd11e19a..dd041f39c9 100644
> > > --- a/block/nvme.c
> > > +++ b/block/nvme.c
> > > @@ -112,6 +112,7 @@ typedef struct {
> > >      bool plugged;
> > >  
> > >      bool supports_write_zeros;
> > > +    bool supports_discard;
> > >  
> > >      CoMutex dma_map_lock;
> > >      CoQueue dma_flush_queue;
> > > @@ -463,6 +464,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
> > >  
> > >      oncs = le16_to_cpu(idctrl->oncs);
> > >      s->supports_write_zeros = (oncs & NVME_ONCS_WRITE_ZEROS) != 0;
> > > +    s->supports_discard = (oncs & NVME_ONCS_DSM) != 0;
> > 
> > Same comment -- checking !!(register & FIELD) is nicer than the
> > negative. (I'm actually not sure even the !! is needed, but it seems to
> > be a QEMU-ism and I've caught myself using it...)
> 
> All right, no problem to use !!
> 
> > 
> > Rest looks good to me on a skim, but I'm not very well-versed in NVME.
> 
> Thanks!
> 

Kind ping about this patch series.

Apart from using !!, do you think that this patch series
can be merged, or should I do anything else?
Which tree do you think this should be committed to?

I kind of want to see that merged before the freeze
starts, if there are no objections,
to reduce the amount of pending stuff in my queue.


[...]



Best regards,
	Maxim Levitsky



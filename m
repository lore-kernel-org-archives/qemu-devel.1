Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773EEC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422272072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctNpDork"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422272072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJDNu-0007hn-CH
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDMw-00075X-TY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jJDMv-0002IE-FD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:39:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jJDMv-0002G4-Bf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585647575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESnME40JOUndFQ/+UEVi1P8WhwxUKc3L8+CEZM83aO4=;
 b=ctNpDork1Mdfs3hMLqpXWo0uwuvsmB32oGZkTNs/a03Vw7ZzRBJEcxIzNhdv3cBWNrmE4D
 2hXiO4bxwazmZRlzYIgf25AJq8TTCxdtEH2Mv4qnJCWpI8LrQIaALKE+Blz25XOS7DKq+z
 e+dwE1tIe01YOqr3BOAKNdenLcXMH6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-3LhwV75XNYen7Er7ZDXh4A-1; Tue, 31 Mar 2020 05:39:32 -0400
X-MC-Unique: 3LhwV75XNYen7Er7ZDXh4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7D2618A5502;
 Tue, 31 Mar 2020 09:39:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A4AE19C6A;
 Tue, 31 Mar 2020 09:39:28 +0000 (UTC)
Message-ID: <aa001f8b11a30b374e796694d743efb675e5dc25.camel@redhat.com>
Subject: Re: [PATCH v6 14/42] nvme: add missing mandatory features
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Tue, 31 Mar 2020 12:39:27 +0300
In-Reply-To: <20200331054145.wh6olabpkzuw4iwb@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-15-its@irrelevant.dk>
 <e589c8897067d387cae4b03dece27c60fa33041c.camel@redhat.com>
 <20200331054145.wh6olabpkzuw4iwb@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-03-31 at 07:41 +0200, Klaus Birkelund Jensen wrote:
> On Mar 25 12:41, Maxim Levitsky wrote:
> > On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Add support for returning a resonable response to Get/Set Features of
> > > mandatory features.
> > > 
> > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > Acked-by: Keith Busch <kbusch@kernel.org>
> > > ---
> > >  hw/block/nvme.c       | 60 ++++++++++++++++++++++++++++++++++++++++++-
> > >  hw/block/trace-events |  2 ++
> > >  include/block/nvme.h  |  6 ++++-
> > >  3 files changed, 66 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index ff8975cd6667..eb9c722df968 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -1058,6 +1069,19 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >          break;
> > >      case NVME_TIMESTAMP:
> > >          return nvme_get_feature_timestamp(n, cmd);
> > > +    case NVME_INTERRUPT_COALESCING:
> > > +        result = cpu_to_le32(n->features.int_coalescing);
> > > +        break;
> > > +    case NVME_INTERRUPT_VECTOR_CONF:
> > > +        if ((dw11 & 0xffff) > n->params.max_ioqpairs + 1) {
> > > +            return NVME_INVALID_FIELD | NVME_DNR;
> > > +        }
> > 
> > I still think that this should be >= since the interrupt vector is not zero based.
> > So if we have for example 3 IO queues, then we have 4 queues in total
> > which translates to irq numbers 0..3.
> > 
> 
> Yes you are right. The device will support max_ioqpairs + 1 IVs, so
> trying to access that would actually go 1 beyond the array.
> 
> Fixed.
> 
> > BTW the user of the device doesn't have to have 1:1 mapping between qid and msi interrupt index,
> > in fact when MSI is not used, all the queues will map to the same vector, which will be interrupt 0
> > from point of view of the device IMHO.
> > So it kind of makes sense IMHO to have num_irqs or something, even if it technically equals to number of queues.
> > 
> 
> Yeah, but the device will still *support* the N IVs, so they can still
> be configured even though they will not be used. So I don't think we
> need to introduce an additional parameter?

Yes and no.
I wasn't thinking to add a new parameter for number of supporter interrupt vectors,
but just to have an internal variable to represent it so that we could support in future
case where these are not equal.

Also from point of view of validating the users of this virtual nvme drive, I think it kind
of makes sense to allow having less supported IRQ vectors than IO queues, so to check
how userspace copes with it. It is valid after all to have same interrupt vector shared between
multiple queues.

In fact in theory (but that would complicate the implementation greatly) we should even support
case when number of submission queues is not equal to number of completion queues. Yes nobody does in real hardware,
and at least Linux nvme driver hard assumes 1:1 SQ/CQ mapping but still.

My nvme-mdev doesn't make this assumpiton (and neither any assumptions on interrupt vector counts) 
and allows the user to have any SQ/CQ mapping as far as the spec allows
(but it does hardcode maximum number of SQ/CQ supported)

BTW, I haven't looked at that but we should check that the virtual nvme drive can cope with using legacy
interrupt (that is MSI disabled) - nvme-mdev does support this and was tested with it.


> 
> > > @@ -1120,6 +1146,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  
> > >          break;
> > >      case NVME_VOLATILE_WRITE_CACHE:
> > > +        if (blk_enable_write_cache(n->conf.blk)) {
> > > +            blk_flush(n->conf.blk);
> > > +        }
> > 
> > (not your fault) but the blk_enable_write_cache function name is highly misleading,
> > since it doesn't enable anything but just gets the flag if the write cache is enabled.
> > It really should be called blk_get_enable_write_cache.
> > 
> 
> Agreed :)
> 
> > > @@ -1804,6 +1860,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> > >      id->cqes = (0x4 << 4) | 0x4;
> > >      id->nn = cpu_to_le32(n->num_namespaces);
> > >      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP);
> > > +
> > 
> > Unrelated whitespace change
> 
> Fixed.
> 
> > 
> > Best regards,
> > 	Maxim Levitsky
> > 
> > 
> > 
> > 

Best regards,
	Maxim Levitsky

> 
> 




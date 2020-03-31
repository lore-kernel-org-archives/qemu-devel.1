Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EC9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E99B206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E99B206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9iK-00034i-Cg
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ9eu-0006hL-Lz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ9et-0003HX-Dr
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:41:56 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48012)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ9en-0003ES-IQ; Tue, 31 Mar 2020 01:41:49 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 82726BF48F;
 Tue, 31 Mar 2020 05:41:48 +0000 (UTC)
Date: Tue, 31 Mar 2020 07:41:45 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 14/42] nvme: add missing mandatory features
Message-ID: <20200331054145.wh6olabpkzuw4iwb@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-15-its@irrelevant.dk>
 <e589c8897067d387cae4b03dece27c60fa33041c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e589c8897067d387cae4b03dece27c60fa33041c.camel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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

On Mar 25 12:41, Maxim Levitsky wrote:
> On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Add support for returning a resonable response to Get/Set Features of
> > mandatory features.
> > 
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Acked-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  hw/block/nvme.c       | 60 ++++++++++++++++++++++++++++++++++++++++++-
> >  hw/block/trace-events |  2 ++
> >  include/block/nvme.h  |  6 ++++-
> >  3 files changed, 66 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index ff8975cd6667..eb9c722df968 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1058,6 +1069,19 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >          break;
> >      case NVME_TIMESTAMP:
> >          return nvme_get_feature_timestamp(n, cmd);
> > +    case NVME_INTERRUPT_COALESCING:
> > +        result = cpu_to_le32(n->features.int_coalescing);
> > +        break;
> > +    case NVME_INTERRUPT_VECTOR_CONF:
> > +        if ((dw11 & 0xffff) > n->params.max_ioqpairs + 1) {
> > +            return NVME_INVALID_FIELD | NVME_DNR;
> > +        }
> I still think that this should be >= since the interrupt vector is not zero based.
> So if we have for example 3 IO queues, then we have 4 queues in total
> which translates to irq numbers 0..3.
> 

Yes you are right. The device will support max_ioqpairs + 1 IVs, so
trying to access that would actually go 1 beyond the array.

Fixed.

> BTW the user of the device doesn't have to have 1:1 mapping between qid and msi interrupt index,
> in fact when MSI is not used, all the queues will map to the same vector, which will be interrupt 0
> from point of view of the device IMHO.
> So it kind of makes sense IMHO to have num_irqs or something, even if it technically equals to number of queues.
> 

Yeah, but the device will still *support* the N IVs, so they can still
be configured even though they will not be used. So I don't think we
need to introduce an additional parameter?

> > @@ -1120,6 +1146,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >  
> >          break;
> >      case NVME_VOLATILE_WRITE_CACHE:
> > +        if (blk_enable_write_cache(n->conf.blk)) {
> > +            blk_flush(n->conf.blk);
> > +        }
> 
> (not your fault) but the blk_enable_write_cache function name is highly misleading,
> since it doesn't enable anything but just gets the flag if the write cache is enabled.
> It really should be called blk_get_enable_write_cache.
> 

Agreed :)

> > @@ -1804,6 +1860,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> >      id->cqes = (0x4 << 4) | 0x4;
> >      id->nn = cpu_to_le32(n->num_namespaces);
> >      id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP);
> > +
> Unrelated whitespace change

Fixed.

> 
> Best regards,
> 	Maxim Levitsky
> 
> 
> 
> 


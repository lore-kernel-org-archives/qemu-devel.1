Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC7EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7F120781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 05:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7F120781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ9js-00055H-PD
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 01:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jJ9ig-0003ww-5Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jJ9ie-0005bm-Vx
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 01:45:50 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jJ9ic-0005ZN-9f; Tue, 31 Mar 2020 01:45:46 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 1ADA9BF48F;
 Tue, 31 Mar 2020 05:45:45 +0000 (UTC)
Date: Tue, 31 Mar 2020 07:45:41 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v6 31/42] nvme: add check for prinfo
Message-ID: <20200331054541.55rakuvpl7zaeezo@apples.localdomain>
References: <20200316142928.153431-1-its@irrelevant.dk>
 <20200316142928.153431-32-its@irrelevant.dk>
 <9d3bad95342559566c391635d9d96e4b56dd08c7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d3bad95342559566c391635d9d96e4b56dd08c7.camel@redhat.com>
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

On Mar 25 12:57, Maxim Levitsky wrote:
> On Mon, 2020-03-16 at 07:29 -0700, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Check the validity of the PRINFO field.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c       | 50 ++++++++++++++++++++++++++++++++++++-------
> >  hw/block/trace-events |  1 +
> >  include/block/nvme.h  |  1 +
> >  3 files changed, 44 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 7d5340c272c6..0d2b5b45b0c5 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -505,6 +505,17 @@ static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len,
> >      return NVME_SUCCESS;
> >  }
> >  
> > +static inline uint16_t nvme_check_prinfo(NvmeCtrl *n, NvmeNamespace *ns,
> > +                                         uint16_t ctrl, NvmeRequest *req)
> > +{
> > +    if ((ctrl & NVME_RW_PRINFO_PRACT) && !(ns->id_ns.dps & DPS_TYPE_MASK)) {
> > +        trace_nvme_dev_err_prinfo(nvme_cid(req), ctrl);
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> 
> I refreshed my (still very limited) knowelege on the metadata
> and the protection info, and this is what I found:
> 
> I think that this is very far from complete, because we also have:
> 
> 1. PRCHECK. According to the spec it is independent of PRACT
>    And when some of it is set, 
>    together with enabled protection (the DPS field in namespace),
>    Then the 8 bytes of the protection info is checked (optionally using the
>    the EILBRT and ELBAT/ELBATM fields in the command and CRC of the data for the guard field)
> 
>    So this field should also be checked to be zero when protection is disabled
>    (I don't see an explicit requirement for that in the spec, but neither I see
>    such requirement for PRACT)
> 
> 2. The protection values to be written / checked ((E)ILBRT/(E)LBATM/(E)LBAT)
>    Same here, but also these should not be set when PRCHECK is not set for reads,
>    plus some are protection type specific.
> 
> 
> The spec does mention the 'Invalid Protection Information' error code which
> refers to invalid values in the PRINFO field.
> So this error code I think should be returned instead of the 'Invalid field'
> 
> Another thing to optionaly check is that the metadata pointer for separate metadata.
>  Is zero as long as we don't support metadata
> (again I don't see an explicit requirement for this in the spec, but it mentions:
> 
> "This field is valid only if the command has metadata that is not interleaved with
> the logical block data, as specified in the Format NVM command"
> 
> )
> 

I'm kinda inclined to just drop this patch. The spec actually says that
the PRACT and PRCHK fields are used only if the namespace is formatted
to use end-to-end protection information. Since we do not support that,
I don't think we even need to check it.

Any opinion on this?


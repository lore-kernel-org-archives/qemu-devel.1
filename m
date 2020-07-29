Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A36C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7A220809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="AeS8arTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7A220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0qqc-0006KE-Eh
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 14:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0qpD-0005gb-UY; Wed, 29 Jul 2020 14:29:12 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0qp7-0004ui-5U; Wed, 29 Jul 2020 14:29:11 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id A7213BF616;
 Wed, 29 Jul 2020 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596047343;
 bh=L4o6V1OcdHigBwsAgak/sF8sG3qasS1ugRe5JdKGcg8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AeS8arTkEsoz5dqlpA3IwDTaHDFbs7HmC2625mfHAu/3/xNbfzZYYKaLTzmcSIaPz
 NDcpZfhFjIfAnSr0yxNCvM14nc7dZTklEdoGvcmxud3fZdQAOuQlvgTZ4T6k7fNNk+
 zPfpe8ZhjIn2h3lPNOZ45bLCtssQXExldl7R8L4z7HLsATD7y/S4qkKKcrKG66naOK
 0j1JwXZQjHJJiK3aXIKjiQ8tqCAltlMpgooaHVVi4LcdYoW6sEU/zhNpiKzQsFUCT5
 2QQ9i7BhFQRpdV45B/aSqCoSC/y2IhobxrFi2JP0FLYNOCMLnVV9ADuC5kB5fCAd0p
 blyiUDkm1IY4Q==
Date: Wed, 29 Jul 2020 20:29:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 04/16] hw/block/nvme: remove redundant has_sg member
Message-ID: <20200729182901.GB213853@apples.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-5-its@irrelevant.dk>
 <20200729152934.GC14876@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729152934.GC14876@localhost.localdomain>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 30 00:29, Minwoo Im wrote:
> Klaus,
> 

Hi Minwoo,

Thanks for the reviews and welcome to the party! :)

> On 20-07-20 13:37:36, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Remove the has_sg member from NvmeRequest since it's redundant.
> > 
> > Also, make sure the request iov is destroyed at completion time.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  hw/block/nvme.c | 11 ++++++-----
> >  hw/block/nvme.h |  1 -
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index cb236d1c8c46..6a1a1626b87b 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -548,16 +548,20 @@ static void nvme_rw_cb(void *opaque, int ret)
> >          block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
> >          req->status = NVME_INTERNAL_DEV_ERROR;
> >      }
> > -    if (req->has_sg) {
> > +
> > +    if (req->qsg.nalloc) {
> 
> Personally, I prefer has_xxx or is_xxx to check whether the request is
> based on sg or iov as an inline function, but 'nalloc' is also fine to
> figure out the meaning of purpose here.
> 

What I really want to do is get rid of this duality with qsg and iovs at
some point. I kinda wanna get rid of the dma helpers and the qsg
entirely and do the DMA handling directly.

Maybe an `int flags` member in NvmeRequest would be better for this,
such as NVME_REQ_DMA etc.

> >          qemu_sglist_destroy(&req->qsg);
> >      }
> > +    if (req->iov.nalloc) {
> > +        qemu_iovec_destroy(&req->iov);
> > +    }
> > +
> 
> Maybe this can be in a separated commit?
> 

Yeah. I guess whenever a commit message includes "Also, ..." you really
should factor the change out ;)

I'll split it.

> Otherwise, It looks good to me.
> 
> Thanks,
> 

Does that mean I can add your R-b? :)


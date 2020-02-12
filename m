Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87C5C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE82E20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OatGmSvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE82E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rJi-0001rL-O9
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rIt-00011X-C0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j1rIs-0006mi-8g
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:39:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j1rIs-0006mL-57
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581511181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kIlcX1gAR9eNo5QzSBZoTxZEhr9K6l7i0inJKvugCNo=;
 b=OatGmSvNMN5WCRcS5wqcN9Sif8QefC65bS0S3l97AYPZjJjIonsgcDlEsS8D66CV1Tl8wy
 gDs92MBw2d8XMhk0TWoyjTcpdyGYQHKgVHDwRcYllgL0bholQhWTBN2+rDrR+aBbYS3/PP
 7DpqzmSkUdzkcLlkWd+EPhma7W2WPRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-FEhIANvEN9-kKj63KEQ51Q-1; Wed, 12 Feb 2020 07:39:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 615BB18CA245;
 Wed, 12 Feb 2020 12:39:35 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D92D360C87;
 Wed, 12 Feb 2020 12:39:16 +0000 (UTC)
Message-ID: <b5cc19ce019b0c8cada40fafe423d3c7b9a9b98c.camel@redhat.com>
Subject: Re: [PATCH v5 26/26] nvme: make lba data size configurable
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <k.jensen@samsung.com>, Keith Busch
 <kbusch@kernel.org>
Date: Wed, 12 Feb 2020 14:39:05 +0200
In-Reply-To: <20200206072421.h3vjwelfod2y7nax@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095232eucas1p2b3264104447a42882f10edb06608ece5@eucas1p2.samsung.com>
 <20200204095208.269131-27-k.jensen@samsung.com>
 <20200204164358.GC6823@redsun51.ssa.fujisawa.hgst.com>
 <20200206072421.h3vjwelfod2y7nax@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FEhIANvEN9-kKj63KEQ51Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Klaus Jensen <its@irrelevant.dk>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-02-06 at 08:24 +0100, Klaus Birkelund Jensen wrote:
> On Feb  5 01:43, Keith Busch wrote:
> > On Tue, Feb 04, 2020 at 10:52:08AM +0100, Klaus Jensen wrote:
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/nvme-ns.c | 2 +-
> > >  hw/block/nvme-ns.h | 4 +++-
> > >  hw/block/nvme.c    | 1 +
> > >  3 files changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> > > index 0e5be44486f4..981d7101b8f2 100644
> > > --- a/hw/block/nvme-ns.c
> > > +++ b/hw/block/nvme-ns.c
> > > @@ -18,7 +18,7 @@ static int nvme_ns_init(NvmeNamespace *ns)
> > >  {
> > >      NvmeIdNs *id_ns = &ns->id_ns;
> > >  
> > > -    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> > > +    id_ns->lbaf[0].ds = ns->params.lbads;
> > >      id_ns->nuse = id_ns->ncap = id_ns->nsze =
> > >          cpu_to_le64(nvme_ns_nlbas(ns));
> > >  
> > > diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> > > index b564bac25f6d..f1fe4db78b41 100644
> > > --- a/hw/block/nvme-ns.h
> > > +++ b/hw/block/nvme-ns.h
> > > @@ -7,10 +7,12 @@
> > >  
> > >  #define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
> > >      DEFINE_PROP_DRIVE("drive", _state, blk), \
> > > -    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
> > > +    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0), \
> > > +    DEFINE_PROP_UINT8("lbads", _state, _props.lbads, BDRV_SECTOR_BITS)
> > 
> > I think we need to validate the parameter is between 9 and 12 before
> > trusting it can be used safely.
> > 
> > Alternatively, add supported formats to the lbaf array and let the host
> > decide on a live system with the 'format' command.
> 
> The device does not yet support Format NVM, but we have a patch ready
> for that to be submitted with a new series when this is merged.
> 
> For now, while it does not support Format, I will change this patch such
> that it defaults to 9 (BRDV_SECTOR_BITS) and only accept 12 as an
> alternative (while always keeping the number of formats available to 1).
Looks like a good idea.

Best regards,
	Maxim Levitsky



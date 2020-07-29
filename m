Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E177FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29BC20672
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 18:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rxrc1vos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29BC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0r8I-0006ff-1l
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 14:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0r6u-00062L-QI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 14:47:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1k0r6q-0007jB-Hm
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 14:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596048443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8jNq/iftkf35emQZzh5zLuKSMiwvXjVtkORE6zeHhI=;
 b=Rxrc1vos3YTw1XCN/ZVbVUXC4ScQ8DpBQ/P1AoJMzuT/2+8hmFDCcE/m1MUWRkF5z/QqlS
 ZCeB4va0tiqzInRdXV2RIDZY3+cXsJ/ldm8akI4uVA95YeGix9v2qh3v9Quqg68TeJUPzB
 8EHdo3eBPF2kduOp4s2KPOrw+98Bdro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-tlpAF9jjMsu5UqhZ1QZp4A-1; Wed, 29 Jul 2020 14:47:22 -0400
X-MC-Unique: tlpAF9jjMsu5UqhZ1QZp4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EBD0101C8A6;
 Wed, 29 Jul 2020 18:47:20 +0000 (UTC)
Received: from starship (unknown [10.35.206.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20D6C69318;
 Wed, 29 Jul 2020 18:47:17 +0000 (UTC)
Message-ID: <71c29051d164917866980d857a8f6dbc235e3f09.camel@redhat.com>
Subject: Re: [PATCH v3 12/18] hw/block/nvme: support the get/set features
 select and save fields
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 29 Jul 2020 21:47:16 +0300
In-Reply-To: <20200729134856.GA181110@apples.localdomain>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-13-its@irrelevant.dk>
 <e8cbd8b2126ae35324d13f24a75f591a5a0b1e82.camel@redhat.com>
 <20200729134856.GA181110@apples.localdomain>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-07-29 at 15:48 +0200, Klaus Jensen wrote:
> On Jul 29 16:17, Maxim Levitsky wrote:
> > On Mon, 2020-07-06 at 08:12 +0200, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > Since the device does not have any persistent state storage, no
> > > features are "saveable" and setting the Save (SV) field in any Set
> > > Features command will result in a Feature Identifier Not Saveable status
> > > code.
> > > 
> > > Similarly, if the Select (SEL) field is set to request saved values, the
> > > devices will (as it should) return the default values instead.
> > > 
> > > Since this also introduces "Supported Capabilities", the nsid field is
> > > now also checked for validity wrt. the feature being get/set'ed.
> > > 
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >  hw/block/nvme.c       | 103 +++++++++++++++++++++++++++++++++++++-----
> > >  hw/block/trace-events |   4 +-
> > >  include/block/nvme.h  |  27 ++++++++++-
> > >  3 files changed, 119 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 2d85e853403f..df8b786e4875 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -1083,20 +1091,47 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >  {
> > >      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> > >      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> > > +    uint32_t nsid = le32_to_cpu(cmd->nsid);
> > >      uint32_t result;
> > >      uint8_t fid = NVME_GETSETFEAT_FID(dw10);
> > > +    NvmeGetFeatureSelect sel = NVME_GETFEAT_SELECT(dw10);
> > >      uint16_t iv;
> > >  
> > >      static const uint32_t nvme_feature_default[NVME_FID_MAX] = {
> > >          [NVME_ARBITRATION] = NVME_ARB_AB_NOLIMIT,
> > >      };
> > >  
> > > -    trace_pci_nvme_getfeat(nvme_cid(req), fid, dw11);
> > > +    trace_pci_nvme_getfeat(nvme_cid(req), fid, sel, dw11);
> > >  
> > >      if (!nvme_feature_support[fid]) {
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > >      }
> > >  
> > > +    if (nvme_feature_cap[fid] & NVME_FEAT_CAP_NS) {
> > > +        if (!nsid || nsid > n->num_namespaces) {
> > > +            /*
> > > +             * The Reservation Notification Mask and Reservation Persistence
> > > +             * features require a status code of Invalid Field in Command when
> > > +             * NSID is 0xFFFFFFFF. Since the device does not support those
> > > +             * features we can always return Invalid Namespace or Format as we
> > > +             * should do for all other features.
> > > +             */
> > > +            return NVME_INVALID_NSID | NVME_DNR;
> > > +        }
> > > +    }
> > > +
> > > +    switch (sel) {
> > > +    case NVME_GETFEAT_SELECT_CURRENT:
> > > +        break;
> > > +    case NVME_GETFEAT_SELECT_SAVED:
> > > +        /* no features are saveable by the controller; fallthrough */
> > > +    case NVME_GETFEAT_SELECT_DEFAULT:
> > > +        goto defaults;
> > 
> > I hate to say it, but while I have nothing against using 'goto' (unlike some types I met),
> > In this particular case it feels like it would be better to have  a separate function for
> > defaults, or have even have a a separate function per feature and have it return current/default/saved/whatever
> > value. The later would allow to have each feature self contained in its own function.
> > 
> > But on the other hand I see that you fail back to defaults for unchangeble features, which does make
> > sense. In other words, I don't have strong opinion against using goto here after all.
> > 
> > When feature code will be getting more features in the future (pun intended) you probably will have to split it,\
> > like I suggest to keep code complexity low.
> > 
> 
> Argh... I know you are right.
> 
> Since you are "accepting" the current state with your R-b and it already
> carries one from Dmitry I think I'll let this stay for now, but I will
> fix this in a follow up patch for sure.
Yep, this is exactly what I was thinking.

Best regards,
	Maxim Levitsky

> 
> > > @@ -926,6 +949,8 @@ typedef struct NvmeLBAF {
> > >      uint8_t     rp;
> > >  } NvmeLBAF;
> > >  
> > > +#define NVME_NSID_BROADCAST 0xffffffff
> > 
> > Cool, you probably want eventually to go over code and
> > change all places that use the number to the define.
> > (No need to do this now)
> > 
> 
> True. Noted :)
> 




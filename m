Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7C3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772F32075B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772F32075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jst5J-0007Qr-NA
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jst4a-0006wX-Nl; Tue, 07 Jul 2020 15:16:08 -0400
Received: from charlie.dont.surf ([128.199.63.193]:60816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jst4Y-0003eY-K1; Tue, 07 Jul 2020 15:16:08 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id E557CBF5EE;
 Tue,  7 Jul 2020 19:16:03 +0000 (UTC)
Date: Tue, 7 Jul 2020 21:15:59 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v4 1/2] nvme: indicate CMB support through controller
 capabilities register
Message-ID: <20200707191559.GA669353@apples.localdomain>
References: <20200701214858.28515-1-andrzej.jakowski@linux.intel.com>
 <20200701214858.28515-2-andrzej.jakowski@linux.intel.com>
 <a483e0a935a9c2d47232a9f7e653e950de525e68.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a483e0a935a9c2d47232a9f7e653e950de525e68.camel@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 15:16:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org, mreitz@redhat.com,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, kbusch@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul  7 19:27, Maxim Levitsky wrote:
> On Wed, 2020-07-01 at 14:48 -0700, Andrzej Jakowski wrote:
> > This patch sets CMBS bit in controller capabilities register when user
> > configures NVMe driver with CMB support, so capabilites are correctly
> > reported to guest OS.
> > 
> > Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> > Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c      | 2 +-
> >  include/block/nvme.h | 6 +++++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 1aee042d4c..9f11f3e9da 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1582,6 +1582,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
> >      NVME_CAP_SET_TO(n->bar.cap, 0xf);
> >      NVME_CAP_SET_CSS(n->bar.cap, 1);
> >      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
> > +    NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
> >  
> >      n->bar.vs = 0x00010200;
> >      n->bar.intmc = n->bar.intms = 0;
> > @@ -1591,7 +1592,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >  {
> >      NvmeCtrl *n = NVME(pci_dev);
> >      Error *local_err = NULL;
> > -
> >      int i;
> >  
> >      nvme_check_constraints(n, &local_err);
> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > index 1720ee1d51..14cf398dfa 100644
> > --- a/include/block/nvme.h
> > +++ b/include/block/nvme.h
> > @@ -35,6 +35,7 @@ enum NvmeCapShift {
> >      CAP_MPSMIN_SHIFT   = 48,
> >      CAP_MPSMAX_SHIFT   = 52,
> >      CAP_PMR_SHIFT      = 56,
> > +    CAP_CMB_SHIFT      = 57,
> >  };
> >  
> >  enum NvmeCapMask {
> > @@ -48,6 +49,7 @@ enum NvmeCapMask {
> >      CAP_MPSMIN_MASK    = 0xf,
> >      CAP_MPSMAX_MASK    = 0xf,
> >      CAP_PMR_MASK       = 0x1,
> > +    CAP_CMB_MASK       = 0x1,
> >  };
> >  
> >  #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MASK)
> > @@ -78,8 +80,10 @@ enum NvmeCapMask {
> >                                                             << CAP_MPSMIN_SHIFT)
> >  #define NVME_CAP_SET_MPSMAX(cap, val) (cap |= (uint64_t)(val & CAP_MPSMAX_MASK)\
> >                                                              << CAP_MPSMAX_SHIFT)
> > -#define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
> > +#define NVME_CAP_SET_PMRS(cap, val)   (cap |= (uint64_t)(val & CAP_PMR_MASK)   \
> >                                                              << CAP_PMR_SHIFT)
> > +#define NVME_CAP_SET_CMBS(cap, val)   (cap |= (uint64_t)(val & CAP_CMB_MASK)   \
> > +                                                           << CAP_CMB_SHIFT)
> >  
> >  enum NvmeCcShift {
> >      CC_EN_SHIFT     = 0,
> 
> 
> I wonder how this could have beeing forgotten. Hmm.
> I see that Linux kernel uses CMBSZ != for that.
> I guess this explains it.
> 
> Reviewed-by: Maxim Levitsky <mlevitsky@gmail.com>
> 

It is a v1.4 field. The CMB support was added when NVMe was at v1.2.
And the Linux kernel is also basically adhering to v1.3 wrt. CMB
support. In v1.4 the host actually needs to specifically enable the CMB
- and that is not something the kernel does currently IIRC.


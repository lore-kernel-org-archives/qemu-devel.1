Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9E5C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 124B920658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 07:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124B920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDkWk-00062a-SQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 03:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jDkQc-0004NM-BH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jDkQY-0001KY-Re
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 03:44:50 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jDkQU-0000Ha-S9; Mon, 16 Mar 2020 03:44:43 -0400
Received: from apples.localdomain (80-62-117-52-mobile.dk.customer.tdc.net
 [80.62.117.52])
 by charlie.dont.surf (Postfix) with ESMTPSA id 569A0BF5E1;
 Mon, 16 Mar 2020 07:44:41 +0000 (UTC)
Date: Mon, 16 Mar 2020 00:44:37 -0700
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v5 09/26] nvme: add temperature threshold feature
Message-ID: <20200316074437.uwrzruxpw7vfcwbt@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095221eucas1p1d5b1c9578d79e6bcc5714976bbe7dc11@eucas1p1.samsung.com>
 <20200204095208.269131-10-k.jensen@samsung.com>
 <9d2f45a97cce33a548ed98843e06b299b89b30e3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d2f45a97cce33a548ed98843e06b299b89b30e3.camel@redhat.com>
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Feb 12 11:31, Maxim Levitsky wrote:
> On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> > It might seem wierd to implement this feature for an emulated device,
> > but it is mandatory to support and the feature is useful for testing
> > asynchronous event request support, which will be added in a later
> > patch.
> 
> Absolutely but as the old saying is, rules are rules.
> At least, to the defense of the spec, making this mandatory
> forced the vendors to actually report some statistics about
> the device in neutral format as opposed to yet another
> vendor proprietary thing (I am talking about SMART log page).
> 
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> 
> I noticed that you sign off some patches with your @samsung.com email,
> and some with @cnexlabs.com
> Is there a reason for that?

Yeah. Some of this code was made while I was at CNEX Labs. I've since
moved to Samsung. But credit where credit's due.

> 
> 
> > ---
> >  hw/block/nvme.c      | 50 ++++++++++++++++++++++++++++++++++++++++++++
> >  hw/block/nvme.h      |  2 ++
> >  include/block/nvme.h |  7 ++++++-
> >  3 files changed, 58 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 81514eaef63a..f72348344832 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -45,6 +45,9 @@
> >  
> >  #define NVME_SPEC_VER 0x00010201
> >  #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
> > +#define NVME_TEMPERATURE 0x143
> > +#define NVME_TEMPERATURE_WARNING 0x157
> > +#define NVME_TEMPERATURE_CRITICAL 0x175
> >  
> >  #define NVME_GUEST_ERR(trace, fmt, ...) \
> >      do { \
> > @@ -798,9 +801,31 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
> >  static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >  {
> >      uint32_t dw10 = le32_to_cpu(cmd->cdw10);
> > +    uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> >      uint32_t result;
> >  
> >      switch (dw10) {
> > +    case NVME_TEMPERATURE_THRESHOLD:
> > +        result = 0;
> > +
> > +        /*
> > +         * The controller only implements the Composite Temperature sensor, so
> > +         * return 0 for all other sensors.
> > +         */
> > +        if (NVME_TEMP_TMPSEL(dw11)) {
> > +            break;
> > +        }
> > +
> > +        switch (NVME_TEMP_THSEL(dw11)) {
> > +        case 0x0:
> > +            result = cpu_to_le16(n->features.temp_thresh_hi);
> > +            break;
> > +        case 0x1:
> > +            result = cpu_to_le16(n->features.temp_thresh_low);
> > +            break;
> > +        }
> > +
> > +        break;
> >      case NVME_VOLATILE_WRITE_CACHE:
> >          result = blk_enable_write_cache(n->conf.blk);
> >          trace_nvme_dev_getfeat_vwcache(result ? "enabled" : "disabled");
> > @@ -845,6 +870,23 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> >  
> >      switch (dw10) {
> > +    case NVME_TEMPERATURE_THRESHOLD:
> > +        if (NVME_TEMP_TMPSEL(dw11)) {
> > +            break;
> > +        }
> > +
> > +        switch (NVME_TEMP_THSEL(dw11)) {
> > +        case 0x0:
> > +            n->features.temp_thresh_hi = NVME_TEMP_TMPTH(dw11);
> > +            break;
> > +        case 0x1:
> > +            n->features.temp_thresh_low = NVME_TEMP_TMPTH(dw11);
> > +            break;
> > +        default:
> > +            return NVME_INVALID_FIELD | NVME_DNR;
> > +        }
> > +
> > +        break;
> >      case NVME_VOLATILE_WRITE_CACHE:
> >          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> >          break;
> > @@ -1366,6 +1408,9 @@ static void nvme_init_state(NvmeCtrl *n)
> >      n->namespaces = g_new0(NvmeNamespace, n->num_namespaces);
> >      n->sq = g_new0(NvmeSQueue *, n->params.num_queues);
> >      n->cq = g_new0(NvmeCQueue *, n->params.num_queues);
> > +
> > +    n->temperature = NVME_TEMPERATURE;
> 
> This appears not to be used in the patch.
> I think you should move that to the next patch that
> adds the get log page support.
> 

Fixed.

> > +    n->features.temp_thresh_hi = NVME_TEMPERATURE_WARNING;
> >  }
> >  
> >  static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
> > @@ -1447,6 +1492,11 @@ static void nvme_init_ctrl(NvmeCtrl *n)
> >      id->acl = 3;
> >      id->frmw = 7 << 1;
> >      id->lpa = 1 << 0;
> > +
> > +    /* recommended default value (~70 C) */
> > +    id->wctemp = cpu_to_le16(NVME_TEMPERATURE_WARNING);
> > +    id->cctemp = cpu_to_le16(NVME_TEMPERATURE_CRITICAL);
> > +
> >      id->sqes = (0x6 << 4) | 0x6;
> >      id->cqes = (0x4 << 4) | 0x4;
> >      id->nn = cpu_to_le32(n->num_namespaces);
> > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > index a867bdfabafd..1518f32557a3 100644
> > --- a/hw/block/nvme.h
> > +++ b/hw/block/nvme.h
> > @@ -108,6 +108,7 @@ typedef struct NvmeCtrl {
> >      uint64_t    irq_status;
> >      uint64_t    host_timestamp;                 /* Timestamp sent by the host */
> >      uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
> > +    uint16_t    temperature;
> >  
> >      NvmeNamespace   *namespaces;
> >      NvmeSQueue      **sq;
> > @@ -115,6 +116,7 @@ typedef struct NvmeCtrl {
> >      NvmeSQueue      admin_sq;
> >      NvmeCQueue      admin_cq;
> >      NvmeIdCtrl      id_ctrl;
> > +    NvmeFeatureVal  features;
> >  } NvmeCtrl;
> >  
> >  static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > index d2f65e8fe496..ff31cb32117c 100644
> > --- a/include/block/nvme.h
> > +++ b/include/block/nvme.h
> > @@ -616,7 +616,8 @@ enum NvmeIdCtrlOncs {
> >  typedef struct NvmeFeatureVal {
> >      uint32_t    arbitration;
> >      uint32_t    power_mgmt;
> > -    uint32_t    temp_thresh;
> > +    uint16_t    temp_thresh_hi;
> > +    uint16_t    temp_thresh_low;
> >      uint32_t    err_rec;
> >      uint32_t    volatile_wc;
> >      uint32_t    num_queues;
> > @@ -635,6 +636,10 @@ typedef struct NvmeFeatureVal {
> >  #define NVME_INTC_THR(intc)     (intc & 0xff)
> >  #define NVME_INTC_TIME(intc)    ((intc >> 8) & 0xff)
> >  
> > +#define NVME_TEMP_THSEL(temp)  ((temp >> 20) & 0x3)
> > +#define NVME_TEMP_TMPSEL(temp) ((temp >> 16) & 0xf)
> > +#define NVME_TEMP_TMPTH(temp)  (temp & 0xffff)
> > +
> >  enum NvmeFeatureIds {
> >      NVME_ARBITRATION                = 0x1,
> >      NVME_POWER_MANAGEMENT           = 0x2,
> 
> 
> Best regards,
> 	Maxim Levitsky
> 


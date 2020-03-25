Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C69C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E329920714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYPUihEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E329920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH3HF-0005n8-1Y
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Bi-0004lf-39
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jH3Bf-0002j9-QS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:23:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jH3Bf-0002iG-MN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585131783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8k2x5Fr2vWkn/ncg3kYmZws37UwLYgW3/NvoyisFYDg=;
 b=JYPUihEtViTsd77+gP+5oQu6tFmQK1XvAZT0+pYisnlZ7Q26mqtbWIeDeeUXWcShKc6FuU
 5MtJMcqOAUO94GeMcjbpThmrLjQRZkcDWVRpW9ZwZysqcRBXxblRbXAJPnCrufWoCDuQ9k
 1NIDq/iUiSBeK44EkKXoTcHajEGp2wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-Sj0RBiB2OdexE5Y9wsP90Q-1; Wed, 25 Mar 2020 06:22:48 -0400
X-MC-Unique: Sj0RBiB2OdexE5Y9wsP90Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 336821005516;
 Wed, 25 Mar 2020 10:22:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.153])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABBAB94B42;
 Wed, 25 Mar 2020 10:22:44 +0000 (UTC)
Message-ID: <af3fde9d7ff209cf2022171600b851db1db149e9.camel@redhat.com>
Subject: Re: [PATCH v5 15/26] nvme: bump supported specification to 1.3
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Klaus Birkelund Jensen <its@irrelevant.dk>
Date: Wed, 25 Mar 2020 12:22:43 +0200
In-Reply-To: <20200316075053.xtx6nlnl3udyzal5@apples.localdomain>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095225eucas1p1e44b4de86afdf936e3c7f61359d529ce@eucas1p1.samsung.com>
 <20200204095208.269131-16-k.jensen@samsung.com>
 <fd16a4930f9dffc62cfed50b99539ffd134fbf78.camel@redhat.com>
 <20200316075053.xtx6nlnl3udyzal5@apples.localdomain>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

On Mon, 2020-03-16 at 00:50 -0700, Klaus Birkelund Jensen wrote:
> On Feb 12 12:35, Maxim Levitsky wrote:
> > On Tue, 2020-02-04 at 10:51 +0100, Klaus Jensen wrote:
> > > Add new fields to the Identify Controller and Identify Namespace data
> > > structures accoding to NVM Express 1.3d.
> > > 
> > > NVM Express 1.3d requires the following additional features:
> > >   - addition of the Namespace Identification Descriptor List (CNS 03h)
> > >     for the Identify command
> > >   - support for returning Command Sequence Error if a Set Features
> > >     command is submitted for the Number of Queues feature after any I/O
> > >     queues have been created.
> > >   - The addition of the Log Specific Field (LSP) in the Get Log Page
> > >     command.
> > > 
> > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > ---
> > >  hw/block/nvme.c       | 57 ++++++++++++++++++++++++++++++++++++++++---
> > >  hw/block/nvme.h       |  1 +
> > >  hw/block/trace-events |  3 ++-
> > >  include/block/nvme.h  | 20 ++++++++++-----
> > >  4 files changed, 71 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index 900732bb2f38..4acfc85b56a2 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -9,7 +9,7 @@
> > >   */
> > >  
> > >  /**
> > > - * Reference Specification: NVM Express 1.2.1
> > > + * Reference Specification: NVM Express 1.3d
> > >   *
> > >   *   https://nvmexpress.org/resources/specifications/
> > >   */
> > > @@ -43,7 +43,7 @@
> > >  #include "trace.h"
> > >  #include "nvme.h"
> > >  
> > > -#define NVME_SPEC_VER 0x00010201
> > > +#define NVME_SPEC_VER 0x00010300
> > >  #define NVME_MAX_QS PCI_MSIX_FLAGS_QSIZE
> > >  #define NVME_TEMPERATURE 0x143
> > >  #define NVME_TEMPERATURE_WARNING 0x157
> > > @@ -735,6 +735,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >      uint32_t dw12 = le32_to_cpu(cmd->cdw12);
> > >      uint32_t dw13 = le32_to_cpu(cmd->cdw13);
> > >      uint8_t  lid = dw10 & 0xff;
> > > +    uint8_t  lsp = (dw10 >> 8) & 0xf;
> > >      uint8_t  rae = (dw10 >> 15) & 0x1;
> > >      uint32_t numdl, numdu;
> > >      uint64_t off, lpol, lpou;
> > > @@ -752,7 +753,7 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > >      }
> > >  
> > > -    trace_nvme_dev_get_log(nvme_cid(req), lid, rae, len, off);
> > > +    trace_nvme_dev_get_log(nvme_cid(req), lid, lsp, rae, len, off);
> > >  
> > >      switch (lid) {
> > >      case NVME_LOG_ERROR_INFO:
> > > @@ -863,6 +864,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
> > >      cq = g_malloc0(sizeof(*cq));
> > >      nvme_init_cq(cq, n, prp1, cqid, vector, qsize + 1,
> > >          NVME_CQ_FLAGS_IEN(qflags));
> > 
> > Code alignment on that '('
> > > +
> > > +    n->qs_created = true;
> > 
> > Should be done also at nvme_create_sq
> 
> No, because you can't create a SQ without a matching CQ:
True, I missed that.

> 
>     if (unlikely(!cqid || nvme_check_cqid(n, cqid))) {
>         trace_nvme_dev_err_invalid_create_sq_cqid(cqid);
>         return NVME_INVALID_CQID | NVME_DNR;
>     }
> 
> 
> So if there is a matching cq, then qs_created = true.
> 
> > >      return NVME_SUCCESS;
> > >  }
> > >  
> > > @@ -924,6 +927,47 @@ static uint16_t nvme_identify_ns_list(NvmeCtrl *n, NvmeIdentify *c)
> > >      return ret;
> > >  }
> > >  
> > > +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
> > > +{
> > > +    static const int len = 4096;
> > 
> > The spec caps the Identify payload size to 4K,
> > thus this should go to nvme.h
> 
> Done.
> 
> > > +
> > > +    struct ns_descr {
> > > +        uint8_t nidt;
> > > +        uint8_t nidl;
> > > +        uint8_t rsvd2[2];
> > > +        uint8_t nid[16];
> > > +    };
> > 
> > This is also part of the spec, thus should
> > move to nvme.h
> > 
> 
> Done - and cleaned up.
Perfect, thanks!
> 
> > > +
> > > +    uint32_t nsid = le32_to_cpu(c->nsid);
> > > +    uint64_t prp1 = le64_to_cpu(c->prp1);
> > > +    uint64_t prp2 = le64_to_cpu(c->prp2);
> > > +
> > > +    struct ns_descr *list;
> > > +    uint16_t ret;
> > > +
> > > +    trace_nvme_dev_identify_ns_descr_list(nsid);
> > > +
> > > +    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> > > +        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
> > > +        return NVME_INVALID_NSID | NVME_DNR;
> > > +    }
> > > +
> > > +    /*
> > > +     * Because the NGUID and EUI64 fields are 0 in the Identify Namespace data
> > > +     * structure, a Namespace UUID (nidt = 0x3) must be reported in the
> > > +     * Namespace Identification Descriptor. Add a very basic Namespace UUID
> > > +     * here.
> > 
> > Some per namespace uuid qemu property will be very nice to have to have a uuid that
> > is at least somewhat unique.
> > Linux kernel I think might complain if it detects namespaces with duplicate uuids.
> 
> It will be "unique" per controller (because it's just the namespace id).
> The spec also says that it should be fixed for the lifetime of the
> namespace, but I'm not sure how to ensure that without keeping that
> state on disk somehow. I have a solution for this in a later series, but
> for now, I think this is ok.
> 
> But since we actually support multiple controllers, there certainly is
> an issue here. Maybe we can blend in some PCI id or something to make it
> unique across controllers.
IMHO, a qemu device property nicely shifts blame for this to an external management
program (e.g libvirt) which can store this in its XML file indeed for the
lifetime of the namespace

> 
> > 
> > > +     */
> > > +    list = g_malloc0(len);
> > > +    list->nidt = 0x3;
> > > +    list->nidl = 0x10;
> > 
> > Those should also be #defined in nvme.h
> 
> Fixed.
> 
> > > +    *(uint32_t *) &list->nid[12] = cpu_to_be32(nsid);
> > > +
> > > +    ret = nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2);
> > > +    g_free(list);
> > > +    return ret;
> > > +}
> > > +
> > >  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> > >  {
> > >      NvmeIdentify *c = (NvmeIdentify *)cmd;
> > > @@ -935,6 +979,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> > >          return nvme_identify_ctrl(n, c);
> > >      case 0x02:
> > >          return nvme_identify_ns_list(n, c);
> > > +    case 0x03:
> > 
> > The CNS values should be defined in nvme.h.
> 
> Fixed.
> 
> > > +        return nvme_identify_ns_descr_list(n, cmd);
> > >      default:
> > >          trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > > @@ -1133,6 +1179,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> > >          break;
> > >      case NVME_NUMBER_OF_QUEUES:
> > > +        if (n->qs_created) {
> > > +            return NVME_CMD_SEQ_ERROR | NVME_DNR;
> > > +        }
> > > +
> > >          if ((dw11 & 0xffff) == 0xffff || ((dw11 >> 16) & 0xffff) == 0xffff) {
> > >              return NVME_INVALID_FIELD | NVME_DNR;
> > >          }
> > > @@ -1267,6 +1317,7 @@ static void nvme_clear_ctrl(NvmeCtrl *n)
> > >  
> > >      n->aer_queued = 0;
> > >      n->outstanding_aers = 0;
> > > +    n->qs_created = false;
> > >  
> > >      blk_flush(n->conf.blk);
> > >      n->bar.cc = 0;
> > > diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> > > index 1e715ab1d75c..7ced5fd485a9 100644
> > > --- a/hw/block/nvme.h
> > > +++ b/hw/block/nvme.h
> > > @@ -97,6 +97,7 @@ typedef struct NvmeCtrl {
> > >      BlockConf    conf;
> > >      NvmeParams   params;
> > >  
> > > +    bool        qs_created;
> > >      uint32_t    page_size;
> > >      uint16_t    page_bits;
> > >      uint16_t    max_prp_ents;
> > > diff --git a/hw/block/trace-events b/hw/block/trace-events
> > > index f982ec1a3221..9e5a4548bde0 100644
> > > --- a/hw/block/trace-events
> > > +++ b/hw/block/trace-events
> > > @@ -41,6 +41,7 @@ nvme_dev_del_cq(uint16_t cqid) "deleted completion queue, sqid=%"PRIu16""
> > >  nvme_dev_identify_ctrl(void) "identify controller"
> > >  nvme_dev_identify_ns(uint32_t ns) "nsid %"PRIu32""
> > >  nvme_dev_identify_ns_list(uint32_t ns) "nsid %"PRIu32""
> > > +nvme_dev_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
> > >  nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx32""
> > >  nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16" fid 0x%"PRIx32" val 0x%"PRIx32""
> > >  nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
> > > @@ -48,7 +49,7 @@ nvme_dev_getfeat_numq(int result) "get feature number of queues, result=%d"
> > >  nvme_dev_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
> > >  nvme_dev_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
> > >  nvme_dev_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
> > > -nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
> > > +nvme_dev_get_log(uint16_t cid, uint8_t lid, uint8_t lsp, uint8_t rae, uint32_t len, uint64_t off) "cid %"PRIu16" lid 0x%"PRIx8" lsp 0x%"PRIx8" rae 0x%"PRIx8" len %"PRIu32" off %"PRIu64""
> > >  nvme_dev_process_aers(int queued) "queued %d"
> > >  nvme_dev_aer(uint16_t cid) "cid %"PRIu16""
> > >  nvme_dev_aer_aerl_exceeded(void) "aerl exceeded"
> > > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > > index 09419ed499d0..31eb9397d8c6 100644
> > > --- a/include/block/nvme.h
> > > +++ b/include/block/nvme.h
> > > @@ -550,7 +550,9 @@ typedef struct NvmeIdCtrl {
> > >      uint32_t    rtd3e;
> > >      uint32_t    oaes;
> > >      uint32_t    ctratt;
> > > -    uint8_t     rsvd100[156];
> > > +    uint8_t     rsvd100[12];
> > > +    uint8_t     fguid[16];
> > > +    uint8_t     rsvd128[128];
> > 
> > looks OK
> > >      uint16_t    oacs;
> > >      uint8_t     acl;
> > >      uint8_t     aerl;
> > > @@ -568,9 +570,15 @@ typedef struct NvmeIdCtrl {
> > >      uint8_t     tnvmcap[16];
> > >      uint8_t     unvmcap[16];
> > >      uint32_t    rpmbs;
> > > -    uint8_t     rsvd316[4];
> > > +    uint16_t    edstt;
> > > +    uint8_t     dsto;
> > > +    uint8_t     fwug;
> > 
> > looks OK
> > >      uint16_t    kas;
> > > -    uint8_t     rsvd322[190];
> > > +    uint16_t    hctma;
> > > +    uint16_t    mntmt;
> > > +    uint16_t    mxtmt;
> > > +    uint32_t    sanicap;
> > > +    uint8_t     rsvd332[180];
> > 
> > looks OK
> > >      uint8_t     sqes;
> > >      uint8_t     cqes;
> > >      uint16_t    maxcmd;
> > > @@ -691,19 +699,19 @@ typedef struct NvmeIdNs {
> > >      uint8_t     rescap;
> > >      uint8_t     fpi;
> > >      uint8_t     dlfeat;
> > > -    uint8_t     rsvd33;
> > >      uint16_t    nawun;
> > >      uint16_t    nawupf;
> > > +    uint16_t    nacwu;
> > 
> > Aha! Here you 'fix' the bug you had in patch 4.

I thought for a moment that you didn't fix this, but
after looking at V6, it is fixed.
I didn't get any feedback for patch 4, so I double checked this.

> > >      uint16_t    nabsn;
> > >      uint16_t    nabo;
> > >      uint16_t    nabspf;
> > > -    uint8_t     rsvd46[2];
> > > +    uint16_t    noiob;
> > >      uint8_t     nvmcap[16];
> > >      uint8_t     rsvd64[40];
> > >      uint8_t     nguid[16];
> > >      uint64_t    eui64;
> > >      NvmeLBAF    lbaf[16];
> > > -    uint8_t     res192[192];
> > > +    uint8_t     rsvd192[192];
> > 
> > And even do what I suggested with that field :-)
> > Please squash the changes.
> > >      uint8_t     vs[3712];
> > >  } NvmeIdNs;
> > >  
> > 
> > So I suggest you squash this set of changes with patch 4.
> > I also suggest you to split the other changes in this patch, 1 per feature added.
> > The tracing change can also be squashed with the other tracing patch you submitted.
> > 
> > In summary I would suggest you to have:
> > 
> > 1. patch that only adds all the fields from the 1.3d spec, and overall updates nvme.h
> > to be up to 1.3d spec
> > 
> > 2. patches that do refactoring, add more tracing (also form of refactoring, since tracing
> > isn't a functional thing)
> > 
> > 3. set of patches that implement all the 1.3d features.
> > 
> > 4. patch that only bumps the supported version right to 1.3d
> > 
> 
> Did this! :)

Thank you!

Best regards,
	Maxim Levitsky

> 







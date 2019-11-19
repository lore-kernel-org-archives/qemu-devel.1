Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5438BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8B922440
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8B922440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9iK-0006Gz-9u
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 15:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iX9hC-0005km-2J
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iX9hA-0007cx-TJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:01:54 -0500
Received: from charlie.dont.surf ([128.199.63.193]:37980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iX9h6-0007br-Je; Tue, 19 Nov 2019 15:01:48 -0500
Received: from apples.localdomain (ip-5-186-123-87.cgn.fibianet.dk
 [5.186.123.87])
 by charlie.dont.surf (Postfix) with ESMTPSA id 83A37BF614;
 Tue, 19 Nov 2019 20:01:46 +0000 (UTC)
Date: Tue, 19 Nov 2019 21:01:45 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 08/20] nvme: add support for the get log page command
Message-ID: <20191119200145.GB1022320@apples.localdomain>
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-9-its@irrelevant.dk>
 <CADSWDzsrzrnrLfowsdgZobtVgsga1oGXGpo0HyTUsKPVNzhx9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDzsrzrnrLfowsdgZobtVgsga1oGXGpo0HyTUsKPVNzhx9w@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 03:04:52PM +0000, Beata Michalska wrote:
> Hi Klaus,
> 
> 
> On Tue, 15 Oct 2019 at 11:45, Klaus Jensen <its@irrelevant.dk> wrote:
> > +    if (!nsid || (nsid != 0xffffffff && nsid > n->num_namespaces)) {
> > +        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
> > +        return NVME_INVALID_NSID | NVME_DNR;
> > +    }
> > +
> The LAP '0' bit is cleared now - which means there is no support
> for per-namespace data. So in theory, if that was the aim, this condition
> should check for the values different than 0x0 and 0xFFFFFFFF and either
> abort the command or treat that as request for controller specific data.
> 

This is fixed in v3 (that is, it just checks for values different from
0x0 and 0xffffffff).

> > +    switch (lid) {
> > +    case NVME_LOG_ERROR_INFO:
> > +        return nvme_error_info(n, cmd, len, off, req);
> > +    case NVME_LOG_SMART_INFO:
> > +        return nvme_smart_info(n, cmd, len, off, req);
> > +    case NVME_LOG_FW_SLOT_INFO:
> > +        return nvme_fw_log_info(n, cmd, len, off, req);
> > +    default:
> > +        trace_nvme_err_invalid_log_page(req->cid, lid);
> > +        return NVME_INVALID_LOG_ID | NVME_DNR;
> 
> The spec mentions the Invalid Field in Command  case processing
> command with an unsupported log id.
> 

Thanks. Fixed!

> > +    }
> > +}
> > +
> >  static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
> >  {
> >      n->cq[cq->cqid] = NULL;
> > @@ -812,6 +944,9 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >      uint32_t result;
> >
> >      switch (dw10) {
> > +    case NVME_TEMPERATURE_THRESHOLD:
> > +        result = cpu_to_le32(n->features.temp_thresh);
> > +        break;
> >      case NVME_VOLATILE_WRITE_CACHE:
> >          result = blk_enable_write_cache(n->conf.blk);
> >          trace_nvme_getfeat_vwcache(result ? "enabled" : "disabled");
> > @@ -856,6 +991,10 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >      uint32_t dw11 = le32_to_cpu(cmd->cdw11);
> >
> >      switch (dw10) {
> > +    case NVME_TEMPERATURE_THRESHOLD:
> > +        n->features.temp_thresh = dw11;
> > +        break;
> > +
> >      case NVME_VOLATILE_WRITE_CACHE:
> >          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> >          break;
> > @@ -884,6 +1023,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >          return nvme_del_sq(n, cmd);
> >      case NVME_ADM_CMD_CREATE_SQ:
> >          return nvme_create_sq(n, cmd);
> > +    case NVME_ADM_CMD_GET_LOG_PAGE:
> > +        return nvme_get_log(n, cmd, req);
> >      case NVME_ADM_CMD_DELETE_CQ:
> >          return nvme_del_cq(n, cmd);
> >      case NVME_ADM_CMD_CREATE_CQ:
> > @@ -923,6 +1064,7 @@ static void nvme_process_sq(void *opaque)
> >          QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
> >          memset(&req->cqe, 0, sizeof(req->cqe));
> >          req->cqe.cid = cmd.cid;
> > +        req->cid = le16_to_cpu(cmd.cid);
> 
> If I haven't missed anything this is being used only in one place
> for tracing - is it really worth to duplicate the cid here ?
> 

At this point in the series, yes - it is only used once. But it will be
used extensively for tracing in the later patches.

> > -    id->lpa = 1 << 0;
> > +    id->lpa = 1 << 2;
> 
> This sets the bit that states support for GLP command but clears the one
> that states support for per-namespace SMART/Heatld data - is that expected ?
> 

Yes, clearing the bit for per-namespace SMART/Health log page
information is intentional. There is no namespace specific information
defined in the namespace so the global and per-namespace log page
contains the same information.


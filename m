Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EF7C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 06:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130B721A49
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 06:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130B721A49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUltu-0001ci-6b
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 01:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iUltG-00017C-AQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 01:12:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iUltF-0002zI-69
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 01:12:30 -0500
Received: from charlie.dont.surf ([128.199.63.193]:55412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iUltA-0002tj-PT; Wed, 13 Nov 2019 01:12:25 -0500
Received: from apples.localdomain (212.27.19.17.bredband.3.dk [212.27.19.17])
 by charlie.dont.surf (Postfix) with ESMTPSA id 21B91BF448;
 Wed, 13 Nov 2019 06:12:19 +0000 (UTC)
Date: Wed, 13 Nov 2019 07:12:14 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 06/20] nvme: add support for the abort command
Message-ID: <20191113061214.GA452722@apples.localdomain>
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-7-its@irrelevant.dk>
 <CADSWDzt2gjQ6pvzm2A29hqiNAf1RSD=qTwjELLB3fTD4Yjbryg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDzt2gjQ6pvzm2A29hqiNAf1RSD=qTwjELLB3fTD4Yjbryg@mail.gmail.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 12, 2019 at 03:04:38PM +0000, Beata Michalska wrote:
> Hi Klaus
> 

Hi Beata,

Thank you very much for your thorough reviews! I'll start going through
them one by one :) You might have seen that I've posted a v3, but I will
make sure to consolidate between v2 and v3!

> On Tue, 15 Oct 2019 at 11:41, Klaus Jensen <its@irrelevant.dk> wrote:
> >
> > Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> > Section 5.1 ("Abort command").
> >
> > The Abort command is a best effort command; for now, the device always
> > fails to abort the given command.
> >
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > ---
> >  hw/block/nvme.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index daa2367b0863..84e4f2ea7a15 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -741,6 +741,18 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> >      }
> >  }
> >
> > +static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > +{
> > +    uint16_t sqid = le32_to_cpu(cmd->cdw10) & 0xffff;
> > +
> > +    req->cqe.result = 1;
> > +    if (nvme_check_sqid(n, sqid)) {
> > +        return NVME_INVALID_FIELD | NVME_DNR;
> > +    }
> > +
> Shouldn't we validate the CID as well ?
> 

According to the specification it is "implementation specific if/when a
controller chooses to complete the command when the command to abort is
not found".

I'm interpreting this to mean that, yes, an invalid command identifier
could be given in the command, but this implementation does not care
about that.

I still think the controller should check the validity of the submission
queue identifier though. It is a general invariant that the sqid should
be valid.

> > +    return NVME_SUCCESS;
> > +}
> > +
> >  static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
> >  {
> >      trace_nvme_setfeat_timestamp(ts);
> > @@ -859,6 +871,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >          trace_nvme_err_invalid_setfeat(dw10);
> >          return NVME_INVALID_FIELD | NVME_DNR;
> >      }
> > +
> >      return NVME_SUCCESS;
> >  }
> >
> > @@ -875,6 +888,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> >          return nvme_create_cq(n, cmd);
> >      case NVME_ADM_CMD_IDENTIFY:
> >          return nvme_identify(n, cmd);
> > +    case NVME_ADM_CMD_ABORT:
> > +        return nvme_abort(n, cmd, req);
> >      case NVME_ADM_CMD_SET_FEATURES:
> >          return nvme_set_feature(n, cmd, req);
> >      case NVME_ADM_CMD_GET_FEATURES:
> > @@ -1388,6 +1403,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >      id->ieee[2] = 0xb3;
> >      id->ver = cpu_to_le32(0x00010201);
> >      id->oacs = cpu_to_le16(0);
> > +    id->acl = 3;
> So we are setting the max number of concurrent commands
> but there is no logic to enforce that and wrap up with the
> status suggested by specification.
> 

That is true, but because the controller always completes the Abort
command immediately this cannot happen. If the controller did try to
abort executing commands, the Abort command would need to linger in the
controller state until a completion queue entry is posted for the
command to be aborted before the completion queue entry can be posted
for the Abort command. This takes up resources in the controller and is
the reason for the Abort Command Limit.

You could argue that we should set ACL to 0 then, but the specification
recommends a value of 3 and I do not see any harm in conveying a
"reasonable", though inconsequential, value.


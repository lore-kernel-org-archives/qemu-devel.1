Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4622CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B08206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B08206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZWW8-0002if-IH
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 03:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1iZWTM-0000cq-17
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1iZWON-0000J8-9j
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:40:16 -0500
Received: from charlie.dont.surf ([128.199.63.193]:49396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1iZWOL-0000Hb-Fp; Tue, 26 Nov 2019 03:40:13 -0500
Received: from apples.localdomain (unknown [194.62.217.57])
 by charlie.dont.surf (Postfix) with ESMTPSA id 32D2DBF533;
 Tue, 26 Nov 2019 08:40:12 +0000 (UTC)
Date: Tue, 26 Nov 2019 09:40:10 +0100
From: Klaus Birkelund <its@irrelevant.dk>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v2 12/20] nvme: bump supported specification version to 1.3
Message-ID: <20191126084010.GB225199@apples.localdomain>
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-13-its@irrelevant.dk>
 <CADSWDzt-YfwuxmxL=c7qQzac-Xby1azxAsGhAfviSRXz2FkNhg@mail.gmail.com>
 <20191118094856.GB812803@apples.localdomain>
 <CADSWDztth45nn0iAR3B1KpfjbZGKgqif1eKt-+c=v+bWHWFGrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDztth45nn0iAR3B1KpfjbZGKgqif1eKt-+c=v+bWHWFGrQ@mail.gmail.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 12:13:15PM +0000, Beata Michalska wrote:
> On Mon, 18 Nov 2019 at 09:48, Klaus Birkelund <its@irrelevant.dk> wrote:
> >
> > On Tue, Nov 12, 2019 at 03:05:06PM +0000, Beata Michalska wrote:
> > > Hi Klaus,
> > >
> > > On Tue, 15 Oct 2019 at 11:52, Klaus Jensen <its@irrelevant.dk> wrote:
> > > >
> > > > +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
> > > > +{
> > > > +    static const int len = 4096;
> > > > +
> > > > +    struct ns_descr {
> > > > +        uint8_t nidt;
> > > > +        uint8_t nidl;
> > > > +        uint8_t rsvd2[2];
> > > > +        uint8_t nid[16];
> > > > +    };
> > > > +
> > > > +    uint32_t nsid = le32_to_cpu(c->nsid);
> > > > +    uint64_t prp1 = le64_to_cpu(c->prp1);
> > > > +    uint64_t prp2 = le64_to_cpu(c->prp2);
> > > > +
> > > > +    struct ns_descr *list;
> > > > +    uint16_t ret;
> > > > +
> > > > +    trace_nvme_identify_ns_descr_list(nsid);
> > > > +
> > > > +    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> > > > +        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
> > > > +        return NVME_INVALID_NSID | NVME_DNR;
> > > > +    }
> > > > +
> > > In theory this should abort the command for inactive NSIDs as well.
> > > But I guess this will come later on.
> > >
> >
> > At this point in the series, the device does not support multiple
> > namespaces anyway and num_namespaces is always 1. But this has also been
> > reported seperately in relation the patch adding multiple namespaces and
> > is fixed in v3.
> >
> > > > +    list = g_malloc0(len);
> > > > +    list->nidt = 0x3;
> > > > +    list->nidl = 0x10;
> > > > +    *(uint32_t *) &list->nid[12] = cpu_to_be32(nsid);
> > > > +
> > > Might be worth to add some comment here -> as per the NGUID/EUI64 format.
> > > Also those are not specified currently in the namespace identity data structure.
> > >
> >
> > I'll add a comment for why the Namespace UUID is set to this value here.
> > The NGUID/EUI64 fields are not set in the namespace identity data
> > structure as they are not required. See the descriptions of NGUID and
> > EUI64. Here for NGUID:
> >
> >     "The controller shall specify a globally unique namespace identifier
> >     in this field, the EUI64 field, or a Namespace UUID in the Namespace
> >     Identification Descriptor..."
> >
> > Here, I chose to provide it in the Namespace Identification Descriptor
> > (by setting `list->nidt = 0x3`).
> >
> > > > +    ret = nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2);
> > > > +    g_free(list);
> > > > +    return ret;
> > > > +}
> > > > +
> > > >  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> > > >  {
> > > >      NvmeIdentify *c = (NvmeIdentify *)cmd;
> > > > @@ -934,7 +978,9 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> > > >      case 0x01:
> > > >          return nvme_identify_ctrl(n, c);
> > > >      case 0x02:
> > > > -        return nvme_identify_nslist(n, c);
> > > > +        return nvme_identify_ns_list(n, c);
> > > > +    case 0x03:
> > > > +        return nvme_identify_ns_descr_list(n, cmd);
> > > >      default:
> > > >          trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
> > > >          return NVME_INVALID_FIELD | NVME_DNR;
> > > > @@ -1101,6 +1147,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > > >          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> > > >          break;
> > > >      case NVME_NUMBER_OF_QUEUES:
> > > > +        if (n->qs_created > 2) {
> > > > +            return NVME_CMD_SEQ_ERROR | NVME_DNR;
> > > > +        }
> > > > +
> > > I am not sure this is entirely correct as the spec says:
> > > "if any I/O Submission and/or Completion Queues (...)"
> > > so it might be enough to have a single queue created
> > > for this command to be valid.
> > > Also I think that the condition here is to make sure that the number
> > > of queues requested is being set once at init phase. Currently this will
> > > allow the setting to happen if there is no active queue -> so at any
> > > point of time (provided the condition mentioned). I might be wrong here
> > > but it seems that what we need is a single status saying any queue
> > > has been created prior to the Set Feature command at all
> > >
> >
> > Internally, the admin queue pair is counted in qs_created, which is the
> > reason for checking if is above 2. The admin queues are created when the
> > controller is enabled (mmio write to the EN register in CC).
> >
> > I'll add a comment about that - I see why it is unclear.
> >
> 
> Ok, so indeed I have missed the fact that the admin queues are being tracked by
> 'qs_created'. Still, I might be wrong, but, it is enough to create I/O
> submission queue and delete it and the code will allow the command to proceed
> Whereas the spec says :
> "If a Set Features command is issued for this feature after creation of
> any I/O Submission and/or I/O Completion Queues, then the Set Features
> command shall fail with status code of Command Sequence Error"
> 
> I might be misreading it though but it is not entirely clear to me whether
> this is : at least one queue create ... or created and in use.
> 
> But I guess that is really minor.
> 
 
Ohh! I see. Yes you are right. "This feature shall only be issued during
initialization prior to creation of any I/O Submission and/or Completion
Queues.".

To me it looks like the controller shall not allow the Set Feature
command again until after a controller reset. Then we also don't need
the counter, but just a flag to indicate if any I/O queue has been
configured.

I've fixed that up.


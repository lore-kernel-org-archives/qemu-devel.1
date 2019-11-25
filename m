Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C206C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3582082F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/zsGW4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3582082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDPu-0003YP-1O
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iZDMY-0007Hq-Cq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iZDFD-0004px-Ch
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:13:35 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:40542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iZDFD-0004pA-5h
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:13:31 -0500
Received: by mail-il1-x142.google.com with SMTP id v17so10090344ilg.7
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 04:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xmleSPyMb1MUnSE32nutsUFCCqPmuWYXqHUkJ+tfNOU=;
 b=q/zsGW4WMvwdBpcuRQD/9G5H7IiJ1aQhCM0jbHYdVeibZ/OSUUugtsfeHjcTLHHKp5
 HNaleIqxg+/JxZTLGNpmQssqQVza8PC3wV91j4dC5XPhPsvtCwvvVdJS4A4T14ky2Cg+
 4CbQQETqimMbfXHwTTAfhrgi8lsDRTGeLsWxzWz9adWjUB3D2L6VzLHVUi6cVI1ud/6C
 hILxH08/6NceNVAxbTi3r+JA0a02CP0QVc6C87/ggGkTu0YQWfdTDA1e2hugfe4sEhfO
 6/xoSSBnj8nGnPpvAqk/KqUmxLtgtZqzuxsFvCmjbxbJIe3+UASeSBR3XPjO1BkjlrdN
 gQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xmleSPyMb1MUnSE32nutsUFCCqPmuWYXqHUkJ+tfNOU=;
 b=AI5LdiKorhjM5oOstuF16q3brjptRHV6ImW0mEb7G8qZ01k6/Vibonza2bT5XTbMm2
 dKMdKR/j1IzNtVGJJ+omxBZq0cNOhY5OL9NxD5NI50cucNgl9+MrQqXpi8CTSKzRqv+k
 TNZD3Hu7rPxNgrL1y5k4aiFECG8OPEY3OqA+8ALUEKBKhao6qq1BM1hLeug1YpZ/2Tsk
 l4KgCnlBmExGLHaW0fN29B++O7hHd39pcCTajEHitn2axAOOLFOD62G0QC6hIWhsuBaz
 zKtoaNjYofeZzv1PjI6u5KJjzwbhIDZUjAhaxqabyZ32Imte6aKuENGmbyLpWohPDrYZ
 lKAg==
X-Gm-Message-State: APjAAAVrr5FcKjJ/gLTJU3NRSUp9lrT1qaOiWh0rjRLYjLf2ZIOoLzgX
 NfZeN7whoW9lvSvfhH91wv5TQkc9Ummav3x6YjIYPQ==
X-Google-Smtp-Source: APXvYqxR2n0t/ESzQcYPNCgMJWakCPAeWP+ZH9dur1xNgh/w+9ivEJp9WGzThf3T4Pm7wuehx1Wwqnv2afmN6Ii2TDw=
X-Received: by 2002:a92:ad0f:: with SMTP id w15mr11406527ilh.307.1574684006950; 
 Mon, 25 Nov 2019 04:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-13-its@irrelevant.dk>
 <CADSWDzt-YfwuxmxL=c7qQzac-Xby1azxAsGhAfviSRXz2FkNhg@mail.gmail.com>
 <20191118094856.GB812803@apples.localdomain>
In-Reply-To: <20191118094856.GB812803@apples.localdomain>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Mon, 25 Nov 2019 12:13:15 +0000
Message-ID: <CADSWDztth45nn0iAR3B1KpfjbZGKgqif1eKt-+c=v+bWHWFGrQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] nvme: bump supported specification version to 1.3
To: Klaus Birkelund <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paul Durrant <Paul.Durrant@citrix.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 09:48, Klaus Birkelund <its@irrelevant.dk> wrote:
>
> On Tue, Nov 12, 2019 at 03:05:06PM +0000, Beata Michalska wrote:
> > Hi Klaus,
> >
> > On Tue, 15 Oct 2019 at 11:52, Klaus Jensen <its@irrelevant.dk> wrote:
> > >
> > > +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeCmd *c)
> > > +{
> > > +    static const int len = 4096;
> > > +
> > > +    struct ns_descr {
> > > +        uint8_t nidt;
> > > +        uint8_t nidl;
> > > +        uint8_t rsvd2[2];
> > > +        uint8_t nid[16];
> > > +    };
> > > +
> > > +    uint32_t nsid = le32_to_cpu(c->nsid);
> > > +    uint64_t prp1 = le64_to_cpu(c->prp1);
> > > +    uint64_t prp2 = le64_to_cpu(c->prp2);
> > > +
> > > +    struct ns_descr *list;
> > > +    uint16_t ret;
> > > +
> > > +    trace_nvme_identify_ns_descr_list(nsid);
> > > +
> > > +    if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
> > > +        trace_nvme_err_invalid_ns(nsid, n->num_namespaces);
> > > +        return NVME_INVALID_NSID | NVME_DNR;
> > > +    }
> > > +
> > In theory this should abort the command for inactive NSIDs as well.
> > But I guess this will come later on.
> >
>
> At this point in the series, the device does not support multiple
> namespaces anyway and num_namespaces is always 1. But this has also been
> reported seperately in relation the patch adding multiple namespaces and
> is fixed in v3.
>
> > > +    list = g_malloc0(len);
> > > +    list->nidt = 0x3;
> > > +    list->nidl = 0x10;
> > > +    *(uint32_t *) &list->nid[12] = cpu_to_be32(nsid);
> > > +
> > Might be worth to add some comment here -> as per the NGUID/EUI64 format.
> > Also those are not specified currently in the namespace identity data structure.
> >
>
> I'll add a comment for why the Namespace UUID is set to this value here.
> The NGUID/EUI64 fields are not set in the namespace identity data
> structure as they are not required. See the descriptions of NGUID and
> EUI64. Here for NGUID:
>
>     "The controller shall specify a globally unique namespace identifier
>     in this field, the EUI64 field, or a Namespace UUID in the Namespace
>     Identification Descriptor..."
>
> Here, I chose to provide it in the Namespace Identification Descriptor
> (by setting `list->nidt = 0x3`).
>
> > > +    ret = nvme_dma_read_prp(n, (uint8_t *) list, len, prp1, prp2);
> > > +    g_free(list);
> > > +    return ret;
> > > +}
> > > +
> > >  static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> > >  {
> > >      NvmeIdentify *c = (NvmeIdentify *)cmd;
> > > @@ -934,7 +978,9 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> > >      case 0x01:
> > >          return nvme_identify_ctrl(n, c);
> > >      case 0x02:
> > > -        return nvme_identify_nslist(n, c);
> > > +        return nvme_identify_ns_list(n, c);
> > > +    case 0x03:
> > > +        return nvme_identify_ns_descr_list(n, cmd);
> > >      default:
> > >          trace_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > > @@ -1101,6 +1147,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >          blk_set_enable_write_cache(n->conf.blk, dw11 & 1);
> > >          break;
> > >      case NVME_NUMBER_OF_QUEUES:
> > > +        if (n->qs_created > 2) {
> > > +            return NVME_CMD_SEQ_ERROR | NVME_DNR;
> > > +        }
> > > +
> > I am not sure this is entirely correct as the spec says:
> > "if any I/O Submission and/or Completion Queues (...)"
> > so it might be enough to have a single queue created
> > for this command to be valid.
> > Also I think that the condition here is to make sure that the number
> > of queues requested is being set once at init phase. Currently this will
> > allow the setting to happen if there is no active queue -> so at any
> > point of time (provided the condition mentioned). I might be wrong here
> > but it seems that what we need is a single status saying any queue
> > has been created prior to the Set Feature command at all
> >
>
> Internally, the admin queue pair is counted in qs_created, which is the
> reason for checking if is above 2. The admin queues are created when the
> controller is enabled (mmio write to the EN register in CC).
>
> I'll add a comment about that - I see why it is unclear.
>

Ok, so indeed I have missed the fact that the admin queues are being tracked by
'qs_created'. Still, I might be wrong, but, it is enough to create I/O
submission queue and delete it and the code will allow the command to proceed
Whereas the spec says :
"If a Set Features command is issued for this feature after creation of
any I/O Submission and/or I/O Completion Queues, then the Set Features
command shall fail with status code of Command Sequence Error"

I might be misreading it though but it is not entirely clear to me whether
this is : at least one queue create ... or created and in use.

But I guess that is really minor.

BR
Beata


> >
> > Small note: this patch seems to be introducing more changes
> > than specified in the commit message and especially the subject. Might
> > be worth to extend it a bit.
> >
>
> You are right. I'll split it up.


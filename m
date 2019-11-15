Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B371C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658EE20740
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 12:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QE9H4hQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658EE20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVaOw-0008AY-Am
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 07:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iVaD5-0004LF-4j
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iVaD2-0007ya-Ta
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:56:18 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iVaD1-0007y1-AA
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 06:56:15 -0500
Received: by mail-io1-xd43.google.com with SMTP id j20so10103093ioo.11
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 03:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0IMemjzD8sNr2RjGjur7l8zNaeE4KNQ5qCbMx1IMxtM=;
 b=QE9H4hQ9zjZF+mu2Zn+gXAmhUx7mSOBuIkMMuY9GAgYu9Aeao4p8mzWVA+PR0GXToV
 3vaKDz7j7Lhp66IZXevUb7RVNf3UAQwOH0pPZ2FyUDRnLTWpb8ypvnDoh9W+H0o8huFW
 pfzVhOvdp3GVRWZWYu6c5V6xT3Q6nf+Hksa52jbQiEzU8qGVYUutV0KIZhd/4Zi/kVhg
 5ZcMlcFZ+3oMaXeNz+qCk6Rldm7Y1S9BnzRR3pJkSlw0hx6FUoQ/nt4ca2r9xCE2KlyV
 ppZK7Z9hb/44KAWSRxk2J2BY4UJ2ZhMZSxBDgAl/h4pulIBwskXModY4rqV+wvAq2WLK
 lVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0IMemjzD8sNr2RjGjur7l8zNaeE4KNQ5qCbMx1IMxtM=;
 b=X/1uVaY1MtReklHjWwHkccPGaLIgiYQJc58qP8YMbYp62ksi/dlYvpnM+cIdxvOzb5
 CPaghbWvB2ufsZvF1AQBkmkrn/dVt8WpYXnYOiReSzAxguVwphxvcTaBYJlCtkjXVDwt
 A7KWFlgcN4E5hLL/aBlbisMqgWKJc331R1Js1K87Vbwz78/Z67jKzMAd7ERV00XDXanV
 OJJmdN2M6DjnmM3K3fGuX/YzfhXc9CDmG3/6G5Vk8PvKMPnFZBcl/kvJMLsBntDOlDPD
 aFwhSVPyRfnILlrvaQtkvie8S3BMLmdo/G2AnqJuoUd5D4wnQNnF7S6vGnBn0PwT6Yxb
 iWSQ==
X-Gm-Message-State: APjAAAV1oiBAmPPII/bKWStAlDBL7Zj+Nf3aPOgs9UXGt57JFUAIMlIE
 3XcjknnniKvPT+y+D1QjvFL+D4vjrrKK/73N7INnNQ==
X-Google-Smtp-Source: APXvYqx4mixFa1jrCZuBk8/trzudGfNPNYJypdLhqOIIo8FZ15hLjDRe6wNFWPoWoxzSjwNzR4+o7G68IDy0R+R4Ofs=
X-Received: by 2002:a05:6638:73a:: with SMTP id
 j26mr274914jad.116.1573818971639; 
 Fri, 15 Nov 2019 03:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-7-its@irrelevant.dk>
 <CADSWDzt2gjQ6pvzm2A29hqiNAf1RSD=qTwjELLB3fTD4Yjbryg@mail.gmail.com>
 <20191113061214.GA452722@apples.localdomain>
In-Reply-To: <20191113061214.GA452722@apples.localdomain>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Fri, 15 Nov 2019 11:56:00 +0000
Message-ID: <CADSWDztYzebjF0C9hh+OhTaFJT8aPCKvu+bY8xTi+4fQBm_=aA@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] nvme: add support for the abort command
To: Klaus Birkelund <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

Hi Klaus,

On Wed, 13 Nov 2019 at 06:12, Klaus Birkelund <its@irrelevant.dk> wrote:
>
> On Tue, Nov 12, 2019 at 03:04:38PM +0000, Beata Michalska wrote:
> > Hi Klaus
> >
>
> Hi Beata,
>
> Thank you very much for your thorough reviews! I'll start going through
> them one by one :) You might have seen that I've posted a v3, but I will
> make sure to consolidate between v2 and v3!
>
> > On Tue, 15 Oct 2019 at 11:41, Klaus Jensen <its@irrelevant.dk> wrote:
> > >
> > > Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> > > Section 5.1 ("Abort command").
> > >
> > > The Abort command is a best effort command; for now, the device always
> > > fails to abort the given command.
> > >
> > > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > > ---
> > >  hw/block/nvme.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index daa2367b0863..84e4f2ea7a15 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -741,6 +741,18 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
> > >      }
> > >  }
> > >
> > > +static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > > +{
> > > +    uint16_t sqid = le32_to_cpu(cmd->cdw10) & 0xffff;
> > > +
> > > +    req->cqe.result = 1;
> > > +    if (nvme_check_sqid(n, sqid)) {
> > > +        return NVME_INVALID_FIELD | NVME_DNR;
> > > +    }
> > > +
> > Shouldn't we validate the CID as well ?
> >
>
> According to the specification it is "implementation specific if/when a
> controller chooses to complete the command when the command to abort is
> not found".
>
> I'm interpreting this to mean that, yes, an invalid command identifier
> could be given in the command, but this implementation does not care
> about that.
>
> I still think the controller should check the validity of the submission
> queue identifier though. It is a general invariant that the sqid should
> be valid.
>
> > > +    return NVME_SUCCESS;
> > > +}
> > > +
> > >  static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
> > >  {
> > >      trace_nvme_setfeat_timestamp(ts);
> > > @@ -859,6 +871,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >          trace_nvme_err_invalid_setfeat(dw10);
> > >          return NVME_INVALID_FIELD | NVME_DNR;
> > >      }
> > > +
> > >      return NVME_SUCCESS;
> > >  }
> > >
> > > @@ -875,6 +888,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> > >          return nvme_create_cq(n, cmd);
> > >      case NVME_ADM_CMD_IDENTIFY:
> > >          return nvme_identify(n, cmd);
> > > +    case NVME_ADM_CMD_ABORT:
> > > +        return nvme_abort(n, cmd, req);
> > >      case NVME_ADM_CMD_SET_FEATURES:
> > >          return nvme_set_feature(n, cmd, req);
> > >      case NVME_ADM_CMD_GET_FEATURES:
> > > @@ -1388,6 +1403,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> > >      id->ieee[2] = 0xb3;
> > >      id->ver = cpu_to_le32(0x00010201);
> > >      id->oacs = cpu_to_le16(0);
> > > +    id->acl = 3;
> > So we are setting the max number of concurrent commands
> > but there is no logic to enforce that and wrap up with the
> > status suggested by specification.
> >
>
> That is true, but because the controller always completes the Abort
> command immediately this cannot happen. If the controller did try to
> abort executing commands, the Abort command would need to linger in the
> controller state until a completion queue entry is posted for the
> command to be aborted before the completion queue entry can be posted
> for the Abort command. This takes up resources in the controller and is
> the reason for the Abort Command Limit.
>
> You could argue that we should set ACL to 0 then, but the specification
> recommends a value of 3 and I do not see any harm in conveying a
> "reasonable", though inconsequential, value.

Could we  potentially add some comment describing the above ?

BR
Beata


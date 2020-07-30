Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80482C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 00:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433AF2072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 00:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GSkhymGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433AF2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0wXw-0005i6-Hh
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 20:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1k0wXC-0005Cm-QO
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 20:34:58 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:53603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im@samsung.com>)
 id 1k0wX9-0002vv-Bu
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 20:34:58 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20200730003446epoutp017b4cd1cec1b7a38f810ad5633550094e~mYI9cDqzU1667216672epoutp01X
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 00:34:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20200730003446epoutp017b4cd1cec1b7a38f810ad5633550094e~mYI9cDqzU1667216672epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1596069286;
 bh=Da5osd5voZNtNKvp4lTPZzulryLag+UzATYrCVUOpwg=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=GSkhymGiDTm+G7hrCp1RNqzt++X62cN4pfC1yXw8+L8a1l7f+hzTMT98BAsHuAaRD
 //FUXhwZRtorSJX3moImbxf/oV6jKQDqeLnWAqg+IOSId6Xc50tDmJmUHaeoB7kf1H
 TEq22FfWxpAeOIfX5M0gWQYx+9/Kd4dXgNyibDCo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20200730003445epcas2p4bc77c70a65166f90805805b900d69431~mYI8sDy-j1690316903epcas2p4T;
 Thu, 30 Jul 2020 00:34:45 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.189]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4BHBJ36kT6zMqYm0; Thu, 30 Jul
 2020 00:34:43 +0000 (GMT)
X-AuditID: b6c32a46-519ff700000049ba-20-5f2215a277bb
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 D0.36.18874.2A5122F5; Thu, 30 Jul 2020 09:34:42 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 04/16] hw/block/nvme: remove redundant has_sg member
From: Minwoo Im <minwoo.im@samsung.com>
To: Klaus Jensen <its@irrelevant.dk>, Minwoo Im <minwoo.im.dev@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20200729182901.GB213853@apples.localdomain>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200730003442epcms2p55bbcbd6a06be8118ad43b83697ee8193@epcms2p5>
Date: Thu, 30 Jul 2020 09:34:42 +0900
X-CMS-MailID: 20200730003442epcms2p55bbcbd6a06be8118ad43b83697ee8193
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmqe4iUaV4g4WvjSz2H/zGanGycQ+r
 xaRD1xgtllxMtfjVyW3x7PQBZot5t5QtZr1rZ7M43ruDxYHTY+esu+we53acZ/fYtKqTzePJ
 tc1MHu/3XWXz6NuyijGALSrHJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8x
 N9VWycUnQNctMwfoJiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgaFhgV5xYm5x
 aV66XnJ+rpWhgYGRKVBlQk7GhlsrWQoOiFa83rGLrYHxsEAXIyeHhICJxMd5rexdjFwcQgI7
 GCWW/2sHcjg4eAUEJf7uEAapERbwkFix/SkzSFhIQF7ixysDiLCmxLvdZ1hBbDYBdYmGqa9Y
 QGwRAU+Ju6umsYCMZBaYyyTxcdsedohdvBIz2p+yQNjSEtuXb2UEsTkFLCUaWh8wQ8Q1JH4s
 64WyRSVurn7LDmO/PzafEcIWkWi9dxaqRlDiwc/dUHFJiW+/trKC3Ckh0Mwo8ccZItzAKHF9
 vjiEbS7x+/5usJt5BXwlLvd/ARvDIqAqseXnVajTXCQePNkHNpIZ6N3tb+eAvc4M9O/6XfoQ
 05Uljtxigajgk+g4/BfuwR3znjBB2MoSHw8dYoY5bPml12wQtofEiYWzmScwKs5CBPMsJLtm
 IexawMi8ilEstaA4Nz212KjACDlmNzGCE6eW2w7GKW8/6B1iZOJgPMQowcGsJMLbzqUQL8Sb
 klhZlVqUH19UmpNafIjRFOjLicxSosn5wNSdVxJvaGpkZmZgaWphamZkoSTOW694IU5IID2x
 JDU7NbUgtQimj4mDU6qBST3q7as5jgm9r5ol2vuvh29btiJlgvv+/fs8rtwokcxqrpt6UjpY
 LHiD902Jjkd1l6+zXyifMfXjvE1vvywW14h7P9tf6V2aaULdg7mvN3kkv3kfZ6+yrFUr1mhh
 yWaH6Yd2sLfzOlYbagps1khWmPm9r9jT5s6c78f8guc6vU1Vbqs8t/te1+PaM+0LP6i9mWGe
 ZpX39kRKQN7tmhPffi7osVoy8zL7rZ6J8Y475NNWnXz/pNtSSNY46vmiGjnZfnOejZwuSwQU
 P7X9PrxZzm1P6w7ZMrla5rjomBMnXigbsZsr5rm8/ZXU9HSOZNgyzUtdO3o9qyeXyLEpnqhR
 FJU4tSph7tdIhxBJua/BSizFGYmGWsxFxYkAgN949SUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200729182946epcas2p1bef465a70c1a815654a07814aa379dc3
References: <20200729182901.GB213853@apples.localdomain>
 <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-5-its@irrelevant.dk>
 <20200729152934.GC14876@localhost.localdomain>
 <CGME20200729182946epcas2p1bef465a70c1a815654a07814aa379dc3@epcms2p5>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=minwoo.im@samsung.com; helo=mailout1.samsung.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 20:34:47
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: minwoo.im@samsung.com
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Birkelund Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Minwoo Im <minwoo.im@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Qemu-devel <qemu-devel-bounces+minwoo.im=samsung.com@nongnu.org> On
> Behalf Of Klaus Jensen
> Sent: Thursday, July 30, 2020 3:29 AM
> To: Minwoo Im <minwoo.im.dev@gmail.com>
> Cc: Kevin Wolf <kwolf@redhat.com>; qemu-block@nongnu.org; Klaus Jensen
> <k.jensen@samsung.com>; qemu-devel@nongnu.org; Max Reitz <mreitz@redhat.com>;
> Keith Busch <kbusch@kernel.org>
> Subject: Re: [PATCH 04/16] hw/block/nvme: remove redundant has_sg member
> 
> On Jul 30 00:29, Minwoo Im wrote:
> > Klaus,
> >
> 
> Hi Minwoo,
> 
> Thanks for the reviews and welcome to the party! :)
> 
> > On 20-07-20 13:37:36, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > >
> > > Remove the has_sg member from NvmeRequest since it's redundant.
> > >
> > > Also, make sure the request iov is destroyed at completion time.
> > >
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  hw/block/nvme.c | 11 ++++++-----
> > >  hw/block/nvme.h |  1 -
> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index cb236d1c8c46..6a1a1626b87b 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -548,16 +548,20 @@ static void nvme_rw_cb(void *opaque, int ret)
> > >          block_acct_failed(blk_get_stats(n->conf.blk), &req->acct);
> > >          req->status = NVME_INTERNAL_DEV_ERROR;
> > >      }
> > > -    if (req->has_sg) {
> > > +
> > > +    if (req->qsg.nalloc) {
> >
> > Personally, I prefer has_xxx or is_xxx to check whether the request is
> > based on sg or iov as an inline function, but 'nalloc' is also fine to
> > figure out the meaning of purpose here.
> >
> 
> What I really want to do is get rid of this duality with qsg and iovs at
> some point. I kinda wanna get rid of the dma helpers and the qsg
> entirely and do the DMA handling directly.
> 
> Maybe an `int flags` member in NvmeRequest would be better for this,
> such as NVME_REQ_DMA etc.

That looks better, but it looks like this is out of scope of this series.
Anyway, Please take my tag for this patch.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

> 
> > >          qemu_sglist_destroy(&req->qsg);
> > >      }
> > > +    if (req->iov.nalloc) {
> > > +        qemu_iovec_destroy(&req->iov);
> > > +    }
> > > +
> >
> > Maybe this can be in a separated commit?
> >
> 
> Yeah. I guess whenever a commit message includes "Also, ..." you really
> should factor the change out ;)
> 
> I'll split it.
> 
> > Otherwise, It looks good to me.
> >
> > Thanks,
> >
> 
> Does that mean I can add your R-b? :)



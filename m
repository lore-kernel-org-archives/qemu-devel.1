Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D215CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2012071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 04:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F2012071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDgTc-0000sy-S3
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 00:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDgT3-0000SS-MJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:03:21 -0400
Received: from relay64.bu.edu ([128.197.228.104]:53056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kDgT1-0002xM-FQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 00:03:20 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 08342bF6000995
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 3 Sep 2020 00:02:41 -0400
Date: Thu, 3 Sep 2020 00:02:37 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] net: forbid the reentrant RX
Message-ID: <20200903040237.cuvg6vrm4aqc3idr@mozz.bu.edu>
References: <20200722085747.6514-1-jasowang@redhat.com>
 <0fd8eb52-6410-1bbd-2462-598c6fcebeb9@redhat.com>
 <20200902155614.aubuw5ygll35p3vp@mozz.bu.edu>
 <9a6be1f3-84dd-d710-1a18-50e7972c30a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a6be1f3-84dd-d710-1a18-50e7972c30a2@redhat.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:03:17
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: dmitry.fleytman@gmail.com, mst@redhat.com, liq3ea@gmail.com, liq3ea@163.com,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, stefanha@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200903 1156, Jason Wang wrote:
> 
> On 2020/9/2 下午11:56, Alexander Bulekov wrote:
> > On 200728 1200, Jason Wang wrote:
> > > On 2020/7/22 下午4:57, Jason Wang wrote:
> > > > The memory API allows DMA into NIC's MMIO area. This means the NIC's
> > > > RX routine must be reentrant. Instead of auditing all the NIC, we can
> > > > simply detect the reentrancy and return early. The queue->delivering
> > > > is set and cleared by qemu_net_queue_deliver() for other queue helpers
> > > > to know whether the delivering in on going (NIC's receive is being
> > > > called). We can check it and return early in qemu_net_queue_flush() to
> > > > forbid reentrant RX.
> > > > 
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >    net/queue.c | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/net/queue.c b/net/queue.c
> > > > index 0164727e39..19e32c80fd 100644
> > > > --- a/net/queue.c
> > > > +++ b/net/queue.c
> > > > @@ -250,6 +250,9 @@ void qemu_net_queue_purge(NetQueue *queue, NetClientState *from)
> > > >    bool qemu_net_queue_flush(NetQueue *queue)
> > > >    {
> > > > +    if (queue->delivering)
> > > > +        return false;
> > > > +
> > > >        while (!QTAILQ_EMPTY(&queue->packets)) {
> > > >            NetPacket *packet;
> > > >            int ret;
> > > 
> > > Queued for rc2.
> > > 
> > > Thanks
> > > 
> > Hi Jason,
> > I don't think this ever made it in. Are there any remaining problems?
> > Thanks
> > -Alex
> 
> 
> Hi Alex:
> 
> It should have been merged:
> 
> https://git.qemu.org/?p=qemu.git;a=commit;h=22dc8663d9fc7baa22100544c600b6285a63c7a3
> 
> Thanks
> 

Ah. I missed only 1/2 was queued. I guess the e1000 patch didn't make
the cut..
Thanks
-Alex

> 
> > 
> 


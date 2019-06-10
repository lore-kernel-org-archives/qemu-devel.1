Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BEC31E41
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8852921726
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8852921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMfz-0002C7-Nt
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 11:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55633)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1haMeW-0001aw-IB
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1haMeV-00045O-En
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:56:08 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1haMeU-0003tw-A9
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:56:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id o19so3213194uap.13
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 08:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7ZhX/TqkI2jBRtdjnfLMzlM6SsE9c/EC2fTs4Tvc2t4=;
 b=BP2z02uLFmo9/LNEYNqCJBI/Op5qTl2fJyMhGsTXl8ECAMsycoTo4JgUvbpH1MLWYV
 d9OLJfiPa8L3zl6X743M7dVDDD4V1ku77OF5nwRBALtfYqzQrwzxW2nkedachxMLmnhU
 vfJCdoy7bhR1CfbSGyLJDTZzVm9yLEo/8+ISXi9pWXZaIa71ndjLIiEeiSRbHWTpv1NW
 hZ9PAa+MJzOIFoSzKSptXzXMPLIPLwCtFoAKrAqzAta8/j9GPT4wi+083xml0m8JtUz6
 NU58vxlhSqWzlOpPQtCcs2HSDeNOkFiuxpICJGH2m8WIr618AFLMcT4ERunxk0Jtigyx
 28vA==
X-Gm-Message-State: APjAAAV/urtFOOy4Mco7nRoDIx4ers3vQi0N4yIN7Egj3jVXe7AhS+gP
 FhphMgPEbDkVvgzoxeJY0MtrbQ==
X-Google-Smtp-Source: APXvYqzFrtyMcE3mpcGV+FCZarQzhjG/aJZVf2IMC4VUlvqnxy2p444VAVwJ2RNJJcU+7fIiVgVnFQ==
X-Received: by 2002:ab0:2a4e:: with SMTP id p14mr27618006uar.138.1560182146062; 
 Mon, 10 Jun 2019 08:55:46 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id e7sm2660076vsc.28.2019.06.10.08.55.44
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 10 Jun 2019 08:55:44 -0700 (PDT)
Date: Mon, 10 Jun 2019 11:55:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190610114708-mutt-send-email-mst@kernel.org>
References: <449c062f-373c-b310-ccc6-f14c702c8f19@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <449c062f-373c-b310-ccc6-f14c702c8f19@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.68
Subject: Re: [Qemu-devel] [QUESTION] How to reduce network latency to
 improve netperf TCP_RR drastically?
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
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 04, 2019 at 03:10:43PM +0800, Like Xu wrote:
> Hi Michael，
> 
> At https://www.linux-kvm.org/page/NetworkingTodo, there is an entry for
> network latency saying:
> 
> ---
> reduce networking latency:
>  allow handling short packets from softirq or VCPU context
>  Plan:
>    We are going through the scheduler 3 times
>    (could be up to 5 if softirqd is involved)
>    Consider RX: host irq -> io thread -> VCPU thread ->
>    guest irq -> guest thread.
>    This adds a lot of latency.
>    We can cut it by some 1.5x if we do a bit of work
>    either in the VCPU or softirq context.
>  Testing: netperf TCP RR - should be improved drastically
>           netperf TCP STREAM guest to host - no regression
>  Contact: MST
> ---
> 
> I am trying to make some contributions to improving netperf TCP_RR.
> Could you please share more ideas or plans or implemental details to make it
> happen?
> 
> Thanks,
> Like Xu


So some of this did happen. netif_receive_skb is now called
directly from tun_get_user.

Question is about the rx/tun_put_user path now.

If the vhost thread is idle, there's a single packet
outstanding then maybe we can forward the packet to userspace
directly from BH without waking up the thread.

For this to work we need to map some userspace memory into kernel
ahead of the time. For example, maybe it can happen when
guest adds RX buffers? Copying Jason who's looking into
memory mapping matters.

-- 
MST


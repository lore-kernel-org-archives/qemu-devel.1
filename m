Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F00C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEA520578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SlqXQH6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEA520578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52173 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO63H-0003Zy-AP
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 15:46:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgg@ziepe.ca>) id 1hO60g-00024n-Nd
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgg@ziepe.ca>) id 1hO5zc-0004ze-SN
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:44:17 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:34169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jgg@ziepe.ca>) id 1hO5zc-0004yS-8v
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:43:12 -0400
Received: by mail-qt1-x842.google.com with SMTP id j6so20519005qtq.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=Ee/vWvn/Ifzj7Fj8CJW5WypvdZbF3rI74RwswfNy3s8=;
	b=SlqXQH6cdfmDcoXK151NvgNOEL8C9rtVLRGZYegxJ5pRaiMErghgNSEUNcm8XOgnBm
	Q7Olw9WbgFBUGU2iDCkwi5y4P6LbPvssY/y8G7sAy2o/IDwVIW3UNJk3oNH5uTnEQBe6
	xnWNiXRxQs3KTm02xrq9ERvEvl5ab/N6pff2NY2lmzVtA6niaZiWeWugHSt5nXVR8rAP
	HfJg3A/UXegsz8XhYGpG7nzAqlNS2FaltaSNlZrWib25/KUPpoCEj3wQ43V8sDx7W81w
	TwgyJAj04iwS6mmd+p6VlrrTRvtd2PQDCDNh26OQvcQ/YuDQgItrhSo51NDIJloaDsLp
	l6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=Ee/vWvn/Ifzj7Fj8CJW5WypvdZbF3rI74RwswfNy3s8=;
	b=mK02trex6lqRZqmV1epzOc5fYSdQN9tM569UFfwSIeoYpGnUDLUuD3nGqZlj6QBPwM
	0Va2QtEJGGwCUx58djB+jI+PujeZQWxMTwJ6TiDRz08w8OnQoL0/dnQga8tgnaif8MMq
	l6AiRJH4Jc1QesJYkSsO8hSvb9a4KLHzPoIeT1Jd8E34TlN8lOOTwIDxvcgOgCdnRJis
	toGXo7ZdA2OSeoVwFmUnsMfadtVD73HQY68o4I4fHVPwrBhOht3JNQza3VQq5gzNYxNs
	1tQ6/xeOuSHyP6HVFK/3A5yBkqUqeprmkOuW8Nr9Pda8c0XVQZizmqDhG14ARZ4zmi4W
	EKhg==
X-Gm-Message-State: APjAAAWN38y60gEwae7vN3z8BSCnK8Fh2xZ100g9Ti5AmnYHItPj1OaG
	axPC/aetubCTGHUn+1f0dLpBOg==
X-Google-Smtp-Source: APXvYqw3KSJ3ehNU8RQ0M4ocEOtB2IpJ3gJQrhf2sWV4FOnrdHCkkwNpNrnHzJv7qop0/fuwyZ7GaA==
X-Received: by 2002:ac8:2a10:: with SMTP id k16mr28126307qtk.220.1557258190850;
	Tue, 07 May 2019 12:43:10 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.49.251]) by smtp.gmail.com with ESMTPSA id
	n21sm7704457qkk.30.2019.05.07.12.43.09
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 07 May 2019 12:43:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hO5zY-0007dD-NA; Tue, 07 May 2019 16:43:08 -0300
Date: Tue, 7 May 2019 16:43:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190507194308.GK6201@ziepe.ca>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190415103546.GA6854@lap1>
	<e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
	<20190422164527.GF21588@ziepe.ca> <20190430171350.GA2763@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430171350.GA2763@lap1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mst@redhat.com, linux-rdma@vger.kernel.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org, Hannes Reinecke <hare@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 30, 2019 at 08:13:54PM +0300, Yuval Shaia wrote:
> On Mon, Apr 22, 2019 at 01:45:27PM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 19, 2019 at 01:16:06PM +0200, Hannes Reinecke wrote:
> > > On 4/15/19 12:35 PM, Yuval Shaia wrote:
> > > > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > > > > 
> > > > > > Data center backends use more and more RDMA or RoCE devices and more and
> > > > > > more software runs in virtualized environment.
> > > > > > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> > > > > > 
> > > > > > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > > > > > technology and also because the Virtio specification
> > > > > > allows Hardware Vendors to support Virtio protocol natively in order to
> > > > > > achieve bare metal performance.
> > > > > > 
> > > > > > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > > > > > Virtio Specification and a look forward on possible implementation
> > > > > > techniques.
> > > > > > 
> > > > > > Open issues/Todo list:
> > > > > > List is huge, this is only start point of the project.
> > > > > > Anyway, here is one example of item in the list:
> > > > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
> > > > > >    in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> > > > > >    that this is reasonable so one option is to have one for all and
> > > > > >    multiplex the traffic on it. This is not good approach as by design it
> > > > > >    introducing an optional starvation. Another approach would be multi
> > > > > >    queues and round-robin (for example) between them.
> > > > > > 
> > > Typically there will be a one-to-one mapping between QPs and CPUs (on the
> > > guest). 
> > 
> > Er we are really overloading words here.. The typical expectation is
> > that a 'RDMA QP' will have thousands and thousands of instances on a
> > system.
> > 
> > Most likely I think mapping 1:1 a virtio queue to a 'RDMA QP, CQ, SRQ,
> > etc' is a bad idea...
> 
> We have three options, no virtqueue for QP, 1 to 1 or multiplexing. What
> would be your vote on that?
> I think you are for option #1, right? but in this case there is actually no
> use of having a virtio-driver, isn't it?

The virtio driver is supposed to be a standard, like a hardware
standard, for doing the operation.

It doesn't mean that every single element under the driver needs to
use the virtio format QP.

Jason


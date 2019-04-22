Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C57FC282E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6435320643
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 20:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b8mkprCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6435320643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIfAP-0003EA-My
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 16:03:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgg@ziepe.ca>) id 1hIcDp-00019C-1f
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgg@ziepe.ca>) id 1hIc4R-0000eN-Mj
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:45:32 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:44099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jgg@ziepe.ca>) id 1hIc4R-0000cQ-Dt
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 12:45:31 -0400
Received: by mail-qt1-x844.google.com with SMTP id s10so2003947qtc.11
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=4NzYQqRLdnn8r9f9n02CWXUqlnA+QbU9aQyHHuPyvzQ=;
	b=b8mkprCHaioqeLtB86WA2Jsl0SAvHGGIfiWgRTU76i7ouur/sfLdcbnFDrtiXwO5cq
	8kJPPNHcvoNu05mWQhQuzCD0cFRrRu3Vt9e7/GLbqWBt5qMk6vTs/wHyLdZK10dXqkff
	jlsgcspHEshZVZIgZoyg46cq09Loluvuwsp4yCZg1jgZ/0rHfRTto8TiBtCCmTGtvNRw
	/O7RW6aVTaI0gk6wJGpDUSL2dLvOWl3HcDNpDwReVhQ8++i6LSEJFp/kbvniRpZFKj+L
	D20//ZekX3q5Wa9FoJ5EfwjfeKOaVWuf+zfObVqMB4ZCnenz93Vnb2IHhzR5NExStqCp
	Bj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=4NzYQqRLdnn8r9f9n02CWXUqlnA+QbU9aQyHHuPyvzQ=;
	b=tjycKmyJdKLqBAjeJ/EzLxyHl485vRhLDpG6lwtlyT6sIHzmFNeTwUd3/GGbHVrvG2
	6N0sKE5cFlVoeudiZz13lEV5B4navgR4eC5JrnebLre8fd5rfM69jo/2hHGeeOxMDIgS
	hx2KozgjiFPBdvfmZKEyLqFEDMgBlDO9zfEbqwwe+BSGPiPRXIQJFrzBVDZWJT5rnGw2
	rnP10CdYbu95WyvIRtBJYyMw7whxeAQ2vVK9Wf38IIlY0W8FgJzYv6BhsdLrzzzN7g6L
	Jw1wy7EcjhYfncFyLVdsnOLk+T1cQvfYlEX1ZP72X10ZvujExZ1boZyLbJ0/zZ40sYMu
	4M/Q==
X-Gm-Message-State: APjAAAXexJrGhtpE3XEnCo1PasWYtHf7IwkfAMckMI/DR/Hx5Oa75e64
	AVKng55hRicdEeDsQw/lNiSstQ==
X-Google-Smtp-Source: APXvYqzuo0eKUnFoKd6Pahq3mvVlczlkr8XDb9DqDm7qA/S8xAgraDKHRQWuBfagWrerJtRh/ivlIA==
X-Received: by 2002:a0c:ba10:: with SMTP id w16mr16723883qvf.115.1555951529758;
	Mon, 22 Apr 2019 09:45:29 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.49.251]) by smtp.gmail.com with ESMTPSA id
	t129sm6414071qkc.24.2019.04.22.09.45.28
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 22 Apr 2019 09:45:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hIc4N-0001la-UY; Mon, 22 Apr 2019 13:45:27 -0300
Date: Mon, 22 Apr 2019 13:45:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Hannes Reinecke <hare@suse.de>
Message-ID: <20190422164527.GF21588@ziepe.ca>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190415103546.GA6854@lap1>
	<e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::844
X-Mailman-Approved-At: Mon, 22 Apr 2019 16:02:54 -0400
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
	Yuval Shaia <yuval.shaia@oracle.com>,
	virtualization@lists.linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422164527.uECuL1H6yvhifPC-ii4_OfewRvMTs1__CJiRj2Scf4g@z>

On Fri, Apr 19, 2019 at 01:16:06PM +0200, Hannes Reinecke wrote:
> On 4/15/19 12:35 PM, Yuval Shaia wrote:
> > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > > 
> > > > Data center backends use more and more RDMA or RoCE devices and more and
> > > > more software runs in virtualized environment.
> > > > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> > > > 
> > > > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > > > technology and also because the Virtio specification
> > > > allows Hardware Vendors to support Virtio protocol natively in order to
> > > > achieve bare metal performance.
> > > > 
> > > > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > > > Virtio Specification and a look forward on possible implementation
> > > > techniques.
> > > > 
> > > > Open issues/Todo list:
> > > > List is huge, this is only start point of the project.
> > > > Anyway, here is one example of item in the list:
> > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
> > > >    in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> > > >    that this is reasonable so one option is to have one for all and
> > > >    multiplex the traffic on it. This is not good approach as by design it
> > > >    introducing an optional starvation. Another approach would be multi
> > > >    queues and round-robin (for example) between them.
> > > > 
> Typically there will be a one-to-one mapping between QPs and CPUs (on the
> guest). 

Er we are really overloading words here.. The typical expectation is
that a 'RDMA QP' will have thousands and thousands of instances on a
system.

Most likely I think mapping 1:1 a virtio queue to a 'RDMA QP, CQ, SRQ,
etc' is a bad idea...

> However, I'm still curious about the overall intent of this driver. Where
> would the I/O be routed _to_ ?
> It's nice that we have a virtualized driver, but this driver is
> intended to do I/O (even if it doesn't _do_ any I/O ATM :-)
> And this I/O needs to be send to (and possibly received from)
> something.

As yet I have never heard of public RDMA HW that could be coupled to a
virtio scheme. All HW defines their own queue ring buffer formats
without standardization.

> If so, wouldn't it be more efficient to use vfio, either by using SR-IOV or
> by using virtio-mdev?

Using PCI pass through means the guest has to have drivers for the
device. A generic, perhaps slower, virtio path has some appeal in some
cases.

> If so, how would we route the I/O from one guest to the other?
> Shared memory? Implementing a full-blown RDMA switch in qemu?

RoCE rides over the existing ethernet switching layer quemu plugs
into

So if you built a shared memory, local host only, virtio-rdma then
you'd probably run through the ethernet switch upon connection
establishment to match the participating VMs.

Jason


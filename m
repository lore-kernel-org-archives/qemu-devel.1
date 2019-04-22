Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B7C282E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 06:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1983F20811
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 06:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiEa/cjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1983F20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIS1k-0001A0-1c
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 02:02:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leon@kernel.org>) id 1hIS0e-0000f3-RK
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 02:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leon@kernel.org>) id 1hIS0R-0006VD-1k
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 02:00:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <leon@kernel.org>) id 1hIS0Q-0006TZ-5M
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 02:00:42 -0400
Received: from localhost (unknown [77.138.135.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id E33C220811;
	Mon, 22 Apr 2019 06:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555912839;
	bh=NIDetymJ85EI2jGq8QnvX4wyY4wtl6QtqgYnOgeyMRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiEa/cjHFkVw+tBR+nEKsShBLHImm2YhFvKxwlzMxfmno9At6fEob4NU8RY/VDnQl
	BUuF1y4atX+BmHnzn+Oq6nf5PPiAJGanaZiOPS+XMuIWrbaFGR4nSBV7ri0jl6wvWy
	2J4LCJCooUxIcQ+JKQtVluVjEdEZFH/chbjyWLxk=
Date: Mon, 22 Apr 2019 09:00:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Message-ID: <20190422060034.GA27901@mtr-leonro.mtl.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190415103546.GA6854@lap1>
	<e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <e73e03c2-ea2b-6ffc-cd23-e8e44d42ce80@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
	virtualization@lists.linux-foundation.org, jgg@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422060034.44N2fuGtsfiHWx6Y9XgoXYZJMZ5sO_8ty0bMVB-3Ojw@z>

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
> guest). So while one would need to be prepared to support quite some QPs,
> the expectation is that the actual number of QPs used will be rather low.
> In a similar vein, multiplexing QPs would be defeating the purpose, as the
> overall idea was to have _independent_ QPs to enhance parallelism.
>
> > > > Expectations from this posting:
> > > > In general, any comment is welcome, starting from hey, drop this as it is a
> > > > very bad idea, to yeah, go ahead, we really want it.
> > > > Idea here is that since it is not a minor effort i first want to know if
> > > > there is some sort interest in the community for such device.
> > >
> > > My first reaction is: Sounds sensible, but it would be good to have a
> > > spec for this :)
> > >
> > > You'll need a spec if you want this to go forward anyway, so at least a
> > > sketch would be good to answer questions such as how many virtqueues
> > > you use for which purpose, what is actually put on the virtqueues,
> > > whether there are negotiable features, and what the expectations for
> > > the device and the driver are. It also makes it easier to understand
> > > how this is supposed to work in practice.
> > >
> > > If folks agree that this sounds useful, the next step would be to
> > > reserve an id for the device type.
> >
> > Thanks for the tips, will sure do that, it is that first i wanted to make
> > sure there is a use case here.
> >
> > Waiting for any feedback from the community.
> >
> I really do like the ides; in fact, it saved me from coding a similar thing
> myself :-)
>
> However, I'm still curious about the overall intent of this driver. Where
> would the I/O be routed _to_ ?
> It's nice that we have a virtualized driver, but this driver is
> intended to do I/O (even if it doesn't _do_ any I/O ATM :-)
> And this I/O needs to be send to (and possibly received from)
> something.
>
> So what exactly is this something?
> An existing piece of HW on the host?
> If so, wouldn't it be more efficient to use vfio, either by using SR-IOV or
> by using virtio-mdev?
>
> Another guest?
> If so, how would we route the I/O from one guest to the other?
> Shared memory? Implementing a full-blown RDMA switch in qemu?
>
> Oh, and I would _love_ to have a discussion about this at KVM Forum.
> Maybe I'll manage to whip up guest-to-guest RDMA connection using ivshmem
> ... let's see.

Following success in previous years to transfer ideas into code,
we started to prepare RDMA miniconference in LPC 2019, which will
be co-located with Kernel Summit and networking track.

I'm confident that such broad audience of kernel developers
will be good fit for such discussion.

Previous years:
2016: https://www.spinics.net/lists/linux-rdma/msg43074.html
2017: https://lwn.net/Articles/734163/
2018: It was so full in audience and intensive that I failed to
summarize it :(

Thanks

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke            Teamlead Storage & Networking
> hare@suse.de                              +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N??rnberg
> GF: Felix Imend??rffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG N??rnberg)


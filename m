Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F95C282CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5E12084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f40CHURm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5E12084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvc4-0008UE-N3
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:49:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <devesh.sharma@broadcom.com>) id 1hEsrM-0006cw-8z
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <devesh.sharma@broadcom.com>) id 1hEsrL-0004de-6e
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:52:36 -0400
Received: from mail-it1-x136.google.com ([2607:f8b0:4864:20::136]:36833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <devesh.sharma@broadcom.com>)
	id 1hEsrK-0004cQ-U2
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 05:52:35 -0400
Received: by mail-it1-x136.google.com with SMTP id y10so14527189itc.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=DjCa5nIKBdW5AL83z/3obgyQ8RG/rILlNLJO5hGO6LM=;
	b=f40CHURm9qtTBzNwMbAlcGDklHzHpNpPLSQH3dJGNtlaw+V/eQ17dsjCx4QDhsGoAI
	fcopmf4We1TSb6RFxZrNosVAI92piAa5VLlCqd8Y/aveqPMjaERMzgVGHoh+K/IoGf6s
	FoD7DOBodWhSI8Fvre46u/6agSJb4YtTpDxis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=DjCa5nIKBdW5AL83z/3obgyQ8RG/rILlNLJO5hGO6LM=;
	b=AwLz6VYV/oX0rKGW4ylcfbBF3iJ8KEl7xiHtNrkqtjerqivEtdgNuvOMJMLak6bhtC
	xFSA5LIBY9qsF79hjv3bAYaEaKAlyD/tXrl2WN7SlHr/3RqIloFZ3MfjrHIl+2utZEzm
	y6QICVhuciOHWREXUR0A3eHcx0NGIpuIMschcb+oSNhZabOKUaGhVE2nK/FIHejhrvhH
	qESu0YWP6TzXLYUQYnssq6VvnKItxqIVxOD7zibmch94WXV5Cf4rwbUZhF/MIBHlNrB1
	SIYsR4kh/xddEC9DN8Szf0+95oRvVWz2YQaR8PiSi9O1iP1lS4U3DHH7WijYsqzksj1W
	T3XQ==
X-Gm-Message-State: APjAAAXiydowM6RAT//vw3ymoObS5BvIM6SXU575IPu9QubNHoGBOEgR
	quKs27ERVDvoBv9MwlDYadA0c7ONcG+LiH11U4YZxw==
X-Google-Smtp-Source: APXvYqxTCzbc+LdEbtMCZYCMG0qato3LV+Ty6F+0BGp33E16o7bJ+QtN8ZuKve4kdhDDOImFpkgyZoGtae66gZs82j8=
X-Received: by 2002:a02:ad05:: with SMTP id s5mr37819617jan.71.1555062752993; 
	Fri, 12 Apr 2019 02:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190411172402.GA14509@mellanox.com>
	<20190411173419.GB6259@lap1> <20190411174124.GA6428@lap1>
In-Reply-To: <20190411174124.GA6428@lap1>
Date: Fri, 12 Apr 2019 15:21:56 +0530
Message-ID:
 <CANjDDBj0rqZEmHzMH+2461_DvjV5K4hT=hJ_usBuucV4Xwh84g@mail.gmail.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::136
X-Mailman-Approved-At: Fri, 12 Apr 2019 08:38:38 -0400
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
From: Devesh Sharma via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Devesh Sharma <devesh.sharma@broadcom.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Cornelia Huck <cohuck@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>,
	Jason Gunthorpe <jgg@mellanox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412095156.5S__Yuc_RjKbuICpCCW9cKOT56vRjtb63jbfOK7bcF8@z>

On Thu, Apr 11, 2019 at 11:11 PM Yuval Shaia <yuval.shaia@oracle.com> wrote:
>
> On Thu, Apr 11, 2019 at 08:34:20PM +0300, Yuval Shaia wrote:
> > On Thu, Apr 11, 2019 at 05:24:08PM +0000, Jason Gunthorpe wrote:
> > > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > > >
> > > > > Data center backends use more and more RDMA or RoCE devices and more and
> > > > > more software runs in virtualized environment.
> > > > > There is a need for a standard to enable RDMA/RoCE on Virtual Machines.
> > > > >
> > > > > Virtio is the optimal solution since is the de-facto para-virtualizaton
> > > > > technology and also because the Virtio specification
> > > > > allows Hardware Vendors to support Virtio protocol natively in order to
> > > > > achieve bare metal performance.
> > > > >
> > > > > This RFC is an effort to addresses challenges in defining the RDMA/RoCE
> > > > > Virtio Specification and a look forward on possible implementation
> > > > > techniques.
> > > > >
> > > > > Open issues/Todo list:
> > > > > List is huge, this is only start point of the project.
> > > > > Anyway, here is one example of item in the list:
> > > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This means that
> > > > >   in order to support for example 32K QPs we will need 64K VirtQ. Not sure
> > > > >   that this is reasonable so one option is to have one for all and
> > > > >   multiplex the traffic on it. This is not good approach as by design it
> > > > >   introducing an optional starvation. Another approach would be multi
> > > > >   queues and round-robin (for example) between them.
> > > > >
> > > > > Expectations from this posting:
> > > > > In general, any comment is welcome, starting from hey, drop this as it is a
> > > > > very bad idea, to yeah, go ahead, we really want it.
> > > > > Idea here is that since it is not a minor effort i first want to know if
> > > > > there is some sort interest in the community for such device.
> > > >
> > > > My first reaction is: Sounds sensible, but it would be good to have a
> > > > spec for this :)
> > >
> > > I'm unclear why you'd want to have a virtio queue for anything other
> > > that some kind of command channel.
> > >
> > > I'm not sure a QP or CQ benefits from this??
> >
> > Virtqueue is a standard mechanism to pass data from guest to host. By
>
> And vice versa (CQ?)
>
> > saying that - it really sounds like QP send and recv rings. So my thought
> > is to use a standard way for rings. As i've learned this is how it is used
> > by other virtio devices ex virtio-net.
> >
> > >
> > > Jason
> >
I would like to ask more basic question, how virtio queue will glue
with actual h/w qps? I may be to naive though.

-Regards
Devesh


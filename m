Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD320C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98BA21479
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 13:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98BA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTRix-0005WE-V8
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 09:56:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTRfa-0002uZ-PB
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hTRfZ-0005ks-JJ
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hTRfZ-0005Wa-Bw
	for qemu-devel@nongnu.org; Wed, 22 May 2019 09:52:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6F37C05CDFC;
	Wed, 22 May 2019 13:52:09 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5179E17519;
	Wed, 22 May 2019 13:52:06 +0000 (UTC)
Date: Wed, 22 May 2019 14:52:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190522135203.GE2666@work-vm>
References: <CAFEAcA-vSebWjhbFTdfOSGHJtr8-a+DKG22JU3tS-1OoGR=VXQ@mail.gmail.com>
	<20190522125348.GH27900@stefanha-x1.localdomain>
	<95f2e1c8-5307-9aa0-601a-e4ee53c199fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f2e1c8-5307-9aa0-601a-e4ee53c199fb@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 22 May 2019 13:52:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] is anybody experimenting with the idea of rust
 code in QEMU?
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 22/05/19 14:53, Stefan Hajnoczi wrote:
> > On Tue, May 21, 2019 at 03:39:40PM +0100, Peter Maydell wrote:
> >> Hi; I have on my todo list the idea of some experimentation/prototyping
> >> of whether being able to write some components of QEMU in Rust would
> >> be (a) feasible (b) beneficial (c) fun to play around with even if
> >> it is likely that it doesn't go anywhere :-)
> >>
> >> I know Paolo has had a look at how you might write some makefiles
> >> to integrate rust into a C program (https://github.com/bonzini/rust-and-c/).
> >> Has anybody else been doing anything in this general area ?
> >>
> >> (I went to two good talks locally recently about rust-vmm and Amazon's
> >> 'firecracker' VMM by Andreea Florescu and Diana Popa -- I
> >> definitely plan to look at rust-vmm as part of this.)
> > 
> > There are some in-development vhost-user device backends in Rust.
> > Sergio Lopez is working on a vhost-user-blk implementation.  David
> > Gilbert is working on a vhost-user-fs implementation.
> > 
> > I think mixing Rust and C code in the main QEMU binary itself is
> > probably more trouble than it's worth.  Think boilerplate, duplication,
> > coming up with safe Rust APIs for QEMU's unsafe APIs.
> 
> This is true.  The case I was playing with is where the QEMU APIs have a
> more or less direct mapping to rust-vmm APIs and only have a limited
> number of dependencies on other C APIs.  This way, you can either write
> a Rust binding to the C code, or rewrite the C code in Rust with tiny C
> wrapper APIs on top.
> 
> For example, the memory API (more or less) depends only on RCU and maps
> to rust-vmm/vm-memory, and virtqueue processing in rust-vmm/vm-virtio
> depends only on the memory API.

The other place might be places where we're autogenerating the C
interfaces anyway - e.g. we could autogenerate rust bindings for qapi.

Dave

> Thanks,
> 
> Paolo
> 
> > I'm more interested in using Rust for separate processes that can be
> > written from scratch.
> > 
> > Stefan
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


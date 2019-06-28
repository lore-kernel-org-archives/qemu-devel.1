Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C458C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600EF208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600EF208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqJd-0001Yl-M8
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 08:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37281)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hgq7M-0005t8-Ob
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hgq7L-0005NP-GH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:36:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hgq7L-0005II-8P
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 210EA308339A;
 Fri, 28 Jun 2019 11:18:41 +0000 (UTC)
Received: from work-vm (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 343DA1001B17;
 Fri, 28 Jun 2019 11:18:40 +0000 (UTC)
Date: Fri, 28 Jun 2019 12:18:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190628111837.GA2987@work-vm>
References: <CAMzgYoMG1ic-5yiS2ehnDLna+UKgCtMBcSVNmKQx1oxRZqT=yQ@mail.gmail.com>
 <20190624184133.GW2726@work-vm>
 <CAMzgYoOjCNYvadBT0PPorG0wOX3Ymvd5x_1NzW1SH2te1JfN-Q@mail.gmail.com>
 <20190628093828.GD3316@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628093828.GD3316@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 28 Jun 2019 11:18:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [GSoC] Help needed in implementing live migration
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Thu, Jun 27, 2019 at 05:02:33AM +0530, Sukrit Bhatnagar wrote:
> > On Tue, 25 Jun 2019 at 00:11, Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > >
> > > * Sukrit Bhatnagar (skrtbhtngr@gmail.com) wrote:
> > > > Hi David,
> > > >
> > > > I am Sukrit, GSoC participant working on PVRDMA live migration.
> > > > We had a short chat about vmxnet3 migration about a week ago
> > > > on the IRC channel.
> > > >
> > > > I am facing an issue while doing migration of the pvrdma device.
> > > > While loading the device state, we need to perform a few dma
> > > > mappings on the destination. But on the destination, the migration
> > > > fails due a BounceBuffer being locked (in_use). This global
> > > > BounceBuffer is used in address_space_map/unmap functions
> > > > which the rdma_pci_dma_map/unmap calls.
> > > > Essentially, we need a way to remap guest physical address on
> > > > the destination after migration.
> > > >
> > > > I had posted an RFC a while ago on the list:
> > > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04924.html
> > > > https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg04923.html
> > > >
> > > > My mentors (Marcel and Yuval) told me to ask you for help
> > > > regarding this. It would be really great if you can guide me in
> > > > finding a workaround for this.
> > >
> > > Hi,
> > >   I'll have a look; I need to get some other things finished first.
> > 
> > Adding cc: qemu-devel, sorry for the private email.
> 
> I haven't looked deeply but it's surprising that you're hitting
> BounceBuffer.  My understanding is that's an old mechanism for
> supporting exotic things like DMAing to/from device MMIO registers.
> 
> Modern machines and guest software usually don't do this.  I wonder why
> you're hitting this case.
> 
> If you look at the BounceBuffer code there's an API to register a
> callback (cpu_register_map_client()).  That's how the case of multiple
> BounceBuffers is supposed to be handled.
> 
> Can you double-check your code and figure out how it got here?  I don't
> think it should be taking this path.

Looking at address_space_map I see it uses bounce buffers if
!memory_access_is_direct, and that seems to be a check to see if
the memory region is actually a normal block of RAM.

Dave

> Stefan


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


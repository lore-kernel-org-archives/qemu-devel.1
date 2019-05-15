Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F0DC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5D12089E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5D12089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33491 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQpW7-0000sg-Sf
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 04:44:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQpVI-0000bb-Sn
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQpVH-00047a-Ht
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:43:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQpVH-000475-9l
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:43:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85791307D977;
	Wed, 15 May 2019 08:43:10 +0000 (UTC)
Received: from redhat.com (ovpn-112-73.ams2.redhat.com [10.36.112.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 72E0564425;
	Wed, 15 May 2019 08:42:45 +0000 (UTC)
Date: Wed, 15 May 2019 09:42:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190515084243.GC10067@redhat.com>
References: <155786484688.13873.6037015630912983760.stgit@gimli.home>
	<20190515061503.GF16681@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515061503.GF16681@xz-x1>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 15 May 2019 08:43:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] q35: Revert to kernel irqchip
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 02:15:03PM +0800, Peter Xu wrote:
> On Tue, May 14, 2019 at 02:14:41PM -0600, Alex Williamson wrote:
> > Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
> > the default for the pc-q35-4.0 machine type to use split irqchip, which
> > turned out to have disasterous effects on vfio-pci INTx support.  KVM
> > resampling irqfds are registered for handling these interrupts, but
> > these are non-functional in split irqchip mode.  We can't simply test
> > for split irqchip in QEMU as userspace handling of this interrupt is a
> > significant performance regression versus KVM handling (GeForce GPUs
> > assigned to Windows VMs are non-functional without forcing MSI mode or
> > re-enabling kernel irqchip).
> > 
> > The resolution is to revert the change in default irqchip mode in the
> > pc-q35-4.1 machine and create a pc-q35-4.0.1 machine for the 4.0-stable
> > branch.  The qemu-q35-4.0 machine type should not be used in vfio-pci
> > configurations for devices requiring legacy INTx support without
> > explicitly modifying the VM configuration to use kernel irqchip.
> > 
> > Link: https://bugs.launchpad.net/qemu/+bug/1826422
> > Fixes: b2fc91db8447 ("q35: set split kernel irqchip as default")
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> Hi, Alex,
> 
> I have two (probably naive) questions about the patch, possibly due to
> lack of context of previous discussions so please let me know if
> there's any upstream discussion that I can read.
> 
> Firstly, could I ask why we need this 4.0.1 machine type specific for
> fixing this problem?  Asked because this seems to be the first time
> QEMU introduces the X.Y.Z machine type in master.  Could it be somehow
> delayed to the release of QEMU 4.1?  From the planning page I see that
> it's releasing on Aug 06th/13th, a bit far away but not really that
> much imho.  I'm perfectly fine with this, but I just want to make sure
> I have the correct understanding of the motivations.


> The second question is about our previous decision to introduce QEMU
> 4.1 machine type before it's released (which is not related to the
> patch at all).  Is it really correct to do so before releasing of 4.1?
> So now even with a development QEMU 4.0 branch the user will be able
> to create 4.1 machines using "-M pc-q35-4.1", then what if the user
> migrated a real 4.1 machine (with the to-be-released QEMU 4.1 binary)
> to some 4.1 machine that was run with such an old 4.0 QEMU binary?
> The problem is we can add more compatible properties into
> pc_q35_4_1_machine_options and future pc_compat_4_1 array before QEMU
> 4.1 is finally released and then "-M pc-q35-4.1" will actually have
> different combination of properties IMHO, which seems to break
> compatibility.  Am I wrong somewhere?

You are correct - we can't release a pc-q35-4.1 machine type to stable
because this machine type may change arbitrarily again before release.

Alex's suggestion of a pc-q35-4.0.1 is best thought of as releasing
a point in time snapshot of the pc-q35-4.1 machine type to stable.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


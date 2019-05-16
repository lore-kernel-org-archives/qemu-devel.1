Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B161EC04E84
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 02:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DF820862
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 02:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DF820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR5me-0005ry-HV
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 22:06:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hR5lk-0005N2-KN
	for qemu-devel@nongnu.org; Wed, 15 May 2019 22:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hR5lg-0001Ox-Dj
	for qemu-devel@nongnu.org; Wed, 15 May 2019 22:05:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>)
	id 1hR5lg-0001Ok-7d; Wed, 15 May 2019 22:05:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69EC3307D913;
	Thu, 16 May 2019 02:05:11 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 416F126552;
	Thu, 16 May 2019 02:05:03 +0000 (UTC)
Date: Thu, 16 May 2019 10:05:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190516020501.GJ16681@xz-x1>
References: <155785983236.11040.9618506134214930578.stgit@gimli.home>
	<20190514142203.430c106e@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190514142203.430c106e@x1.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 16 May 2019 02:05:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0.1] q35: Revert to kernel irqchip
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
	ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
	qemu-stable@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 02:22:03PM -0600, Alex Williamson wrote:
> On Tue, 14 May 2019 13:03:31 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
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
> > The resolution is to revert the change in default irqchip mode with a
> > new pc-q35-4.0.1 machine type for qemu-stable while the development
> > branch makes the same change in the pc-q35-4.1 machine type.  The
> > qemu-q35-4.0 machine type should not be used in vfio-pci configurations
> > for devices requiring legacy INTx support without explicitly modifying
> > the VM configuration to use KVM irqchip.  This new 4.0.1 machine type
> > makes this change automatically.
> > 
> > Link: https://bugs.launchpad.net/qemu/+bug/1826422
> > Link: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03305.html
> 
> This link is superseded by a v2 of the mainline patch:
> 
> Link: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03338.html
> 
> I believe this patch is still the proper stable backport though.  Also
> to clarify, this patch should be gated on mainline acceptance of the
> link above, but clearly there's no clean cherry-pick between mainline
> and stable for this, so I'm proposing them in parallel.  Thanks,

Agreed.  As long as the 4.1 patch can be accepted, this should be the
correct patch for 4.0-stable AFAICT:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


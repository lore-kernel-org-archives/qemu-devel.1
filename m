Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD48C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 20:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BFC20771
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 20:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="h/tbGv4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BFC20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMHck-000831-2z
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 16:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jMHc0-0007dw-5D
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 16:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jMHbw-0003YQ-Cg
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 16:47:49 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:41018)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jMHbv-0003Uu-JR
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 16:47:48 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 71CEB2E158F;
 Wed,  8 Apr 2020 23:47:44 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 5J1CIixtZz-lhMmwwQx; Wed, 08 Apr 2020 23:47:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1586378864; bh=p8zs0OXbWCYkFsM3uJGn+I7Ln3YzK2mSg0sscPUkOL0=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=h/tbGv4Ma6hoKyzwAmD+TRdNAF0Fv7R+qVGGg9YlRRShjSvhZQ2fxB34xHfBm5O6X
 +p3LWZuhSDgV97ED+N2cqwdC5WeDcajeAdtGmWDVtWcoCbq6NMICDJKENweTkKRUFy
 ebpTqt/7ojvCL9kDbZ3KJTu1nq9FFVvc5h+Nvgh0=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8210::1:b])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 jogaq5afqf-lhW4QIbw; Wed, 08 Apr 2020 23:47:43 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Wed, 8 Apr 2020 23:47:42 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200408204742.GA709224@rvkaganb>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Jon Doron <arilou@gmail.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 QEMU <qemu-devel@nongnu.org>,
 Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Liran Alon <liran.alon@oracle.com>
References: <76017793-735b-4bb5-0e69-ecded78af54d@maciej.szmigiero.name>
 <CAP7QCog_EmLJ=O8Xi9Tc4Jst1=z62DXim9ScCyoPv7WugrSyOw@mail.gmail.com>
 <CAP7QCogMdUis-=KsC--0ar2Zt2Vwcpn4HS+qCxPn5khtDTu+mA@mail.gmail.com>
 <9b9c42d3-af9e-25e9-210e-c58ee5975941@maciej.szmigiero.name>
 <472544e7-498a-4e28-06e9-83c102d6436b@maciej.szmigiero.name>
 <20200406073246.GA7707@rvkaganb>
 <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
 <20200407185608.GA178651@rvkaganb>
 <8c278ea8-81c5-7458-8979-c319470440d7@maciej.szmigiero.name>
 <20200408041639.GA7606@jondnuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408041639.GA7606@jondnuc>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
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
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 QEMU <qemu-devel@nongnu.org>, Liran Alon <liran.alon@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 08, 2020 at 07:16:39AM +0300, Jon Doron wrote:
> On 07/04/2020, Maciej S. Szmigiero wrote:
> > On 07.04.2020 20:56, Roman Kagan wrote:
> > > On Mon, Apr 06, 2020 at 11:20:39AM +0300, Jon Doron wrote:
> > > > Well I want it to be merged in :-)
> > > 
> > > Hmm I'm curious why, it has little to offer over virtio.
> > > 
> > > Anyway the series you've posted seems to be based on a fairly old
> > > version.
> > > 
> > > The one in openvz repo is more recent.  It's still in need for
> > > improvement, too, but should be testable at least.
> 
> Well I have implemented the hyperv synthetic kernel debugger interface, but
> on Windows 10 it requires to have a working VMBus (it's not really using it,
> but without a function vmbus that will answer to the initiate contact then
> the kdnet will simply be stuck in a loop.

I see, thanks, I've never heard of this before.

> With the synthetic kernel debugger interface you can debug older OS (Win7 up
> to latest Win10). The benefit is that its much faster than all other
> interfaces.

I guess you compare it to debugging via serial port.  I wonder where the
difference comes from?  I thought the transport didn't require any
significant throughput, and latency-wise the (emulated) serial port was
just as good as any other.  Am I missing something?

Thanks,
Roman.

> In addition to that Michael Kelley from Microsoft has informed us that
> Microsoft might be dropped the synthetic kernel debugger interface sometime
> in the future, and it seems like the new mode is simply to use hvnet device
> for the communication (which is again much faster).
> 
> Cheers,
> -- Jon.
> > 
> > Isn't the one at
> > https://src.openvz.org/projects/UP/repos/qemu/commits?until=refs%2Fheads%2Fvmbus
> > the latest one?
> > 
> > It seems to be last changed in October 2019 - is there a
> > later one?
> > 
> > > Thanks,
> > > Roman.
> > 
> > Thanks,
> > Maciej


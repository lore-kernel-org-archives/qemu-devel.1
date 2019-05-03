Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E8C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEBC2075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 18:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEBC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMd9e-0007UN-IA
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 14:43:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMd8Z-00070a-Fg
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMd8X-00024l-6T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:42:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMd8W-00023P-09
	for qemu-devel@nongnu.org; Fri, 03 May 2019 14:42:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1757681F11
	for <qemu-devel@nongnu.org>; Fri,  3 May 2019 18:42:19 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5876A5D9C4;
	Fri,  3 May 2019 18:42:07 +0000 (UTC)
Date: Fri, 3 May 2019 15:42:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190503184206.GU28722@habkost.net>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home>
	<20190429145556.GA28722@habkost.net>
	<20190429092212.3b03e4bb@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190429092212.3b03e4bb@x1.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 03 May 2019 18:42:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] q35: set split kernel irqchip as
 default
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503184206.H01F0jm8KWNgn1KgSM-q_M2qzzN9HS09ou4GnvbUJ3A@z>

On Mon, Apr 29, 2019 at 09:22:12AM -0600, Alex Williamson wrote:
[...]
> > > What's a good 4.0.1 strategy to resolve this?  Re-instate KVM irqchip
> > > as the Q35 default?  I can't see that simply switching to current QEMU
> > > handling is a viable option for performance?  What about 4.1?  We could
> > > certainly improve EOI support in QEMU, there's essentially no support
> > > currently, but it seems like an uphill battle for an iothread based
> > > userspace ioapic to ever compare to KVM handling?  Thanks,  
> > 
> > irqchip=split and irqchip=kernel aren't guest ABI compatible, are
> > they?  That would make it impossible to fix this in pc-q35-4.0
> > for a 4.0.1 update.
> 
> I suppose it would require a pc-q35-4.0.1 machine type :-\  Thanks,

I wonder if it's possible to untangle this and make the irqchip
option stop affecting guest ABI on 4.1+ machine-types?  This way
QEMU could choose smarter defaults in the future without the
compatibility code hassle.

-- 
Eduardo


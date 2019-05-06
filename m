Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077A6C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 21:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1543206BF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 21:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1543206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34085 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNkz5-0006pz-39
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 17:17:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hNky8-0006Vr-IX
	for qemu-devel@nongnu.org; Mon, 06 May 2019 17:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hNky7-00016g-I6
	for qemu-devel@nongnu.org; Mon, 06 May 2019 17:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hNky7-00016I-Bq
	for qemu-devel@nongnu.org; Mon, 06 May 2019 17:16:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B04C36961
	for <qemu-devel@nongnu.org>; Mon,  6 May 2019 21:16:14 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B17661001DFA;
	Mon,  6 May 2019 21:16:06 +0000 (UTC)
Date: Mon, 6 May 2019 18:16:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190506211605.GH28722@habkost.net>
References: <20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home>
	<20190429145556.GA28722@habkost.net>
	<20190429092212.3b03e4bb@x1.home>
	<20190503184206.GU28722@habkost.net> <20190505090643.GK29750@xz-x1>
	<0898c1e5-8174-8863-d754-bfd19cbaedfa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0898c1e5-8174-8863-d754-bfd19cbaedfa@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 06 May 2019 21:16:14 +0000 (UTC)
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
Cc: Igor Mammedov <imammedo@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 06, 2019 at 11:13:28AM -0500, Paolo Bonzini wrote:
> On 05/05/19 04:06, Peter Xu wrote:
> >> I wonder if it's possible to untangle this and make the irqchip
> >> option stop affecting guest ABI on 4.1+ machine-types?  This way
> >> QEMU could choose smarter defaults in the future without the
> >> compatibility code hassle.
> > Hi, Eduardo,
> > 
> > Do you mean to enable IOMMU IR for kernel-irqchip=on?  If so, I would
> > say it's not trivial...  The major issue is that we probably need to
> > explicitly kick QEMU for every kernel IOAPIC setups since QEMU is the
> > only one who knows everything about interrupt remapping, while KVM
> > don't even have such a mechanism so far.
> 
> Right, it's not easy and it would be anyway possible only on kernels.
> There would have to be a mechanism to setup IOAPIC->MSI routes, similar
> to irqchip=split, and as Peter mentions an MMIO exit on writes to the
> routing table.

I don't mean we necessarily should enable IR for
kernel-irqchip=on too.  I'd just prefer the default setting to
not depend on the kernel-irqchip option.

x86-iommu could either have intremap=on as the default (and
refuse to run with kernel-irqchip=on without explicit
intremap=off), or simply default to intremap=off.

But as Paolo indicated elsewhere, this is not the only guest ABI
difference between "on" and "split".  Probably it's not worth the
hassle to try to to untangle this.

-- 
Eduardo


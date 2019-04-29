Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80617C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5556420656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5556420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL88i-0004cK-KP
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:24:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hL87H-0003hd-D3
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hL87G-0004Po-2F
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hL87F-000427-P1
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:22:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5DC7C044CDB
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 15:22:19 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BE8917791;
	Mon, 29 Apr 2019 15:22:12 +0000 (UTC)
Date: Mon, 29 Apr 2019 09:22:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190429092212.3b03e4bb@x1.home>
In-Reply-To: <20190429145556.GA28722@habkost.net>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home>
	<20190429145556.GA28722@habkost.net>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 29 Apr 2019 15:22:19 +0000 (UTC)
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
Message-ID: <20190429152212.ny3dWHuxeP0ODr0Vd5kQQf_9_rO76TcX5nlyypuqujs@z>

On Mon, 29 Apr 2019 11:55:56 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Apr 29, 2019 at 08:21:06AM -0600, Alex Williamson wrote:
> > On Sat, 27 Apr 2019 10:09:51 +0200
> > Paolo Bonzini <pbonzini@redhat.com> wrote:
> >   
> > > On 27/04/19 07:29, Paolo Bonzini wrote:  
> > > >     
> > > >>> In my testing it looks like KVM advertises supporting the KVM_IRQFD
> > > >>> resample feature, but vfio never gets the unmask notification, so the
> > > >>> device remains with DisINTx set and no further interrupts are
> > > >>> generated.  Do we expect KVM's IRQFD with resampler to work in the
> > > >>> split IRQ mode?  We can certainly hope that "high performance" devices
> > > >>> use MSI or MSI/X, but this would be quite a performance regression with
> > > >>> split mode if our userspace bypass for INTx goes away.  Thanks,    
> > > >>
> > > >> arch/x86/kvm/lapic.c:kvm_ioapic_send_eoi() dumps to userspace before
> > > >> kvm_ioapic_update_eoi() can handle the irq_ack_notifier_list via
> > > >> kvm_notify_acked_gsi(),    
> > > > 
> > > > That wouldn't help because kvm_ioapic_update_eoi would not even be
> > > > able to access vcpu->kvm->arch.vioapic (it's NULL).
> > > > 
> > > > The following untested patch would signal the resamplefd in kvm_ioapic_send_eoi,
> > > > before requesting the exit to userspace.  However I am not sure how QEMU
> > > > sets up the VFIO eventfds: if I understand correctly, when VFIO writes again to
> > > > the irq eventfd, the interrupt request would not reach the userspace IOAPIC, but
> > > > only the in-kernel LAPIC.  That would be incorrect, and if my understanding is
> > > > correct we need to trigger resampling from hw/intc/ioapic.c.    
> > > 
> > > Actually it's worse: because you're bypassing IOAPIC when raising the
> > > irq, the IOAPIC's remote_irr for example will not be set.  So split
> > > irqchip currently must disable the intx fast path completely.
> > > 
> > > I guess we could also reimplement irqfd and resamplefd in the userspace
> > > IOAPIC, and run the listener in a separate thread (using "-object
> > > iothread" on the command line and AioContext in the code).  
> > 
> > This sounds like a performance regression vs KVM irqchip any way we
> > slice it.  Was this change a mistake?  Without KVM support, the
> > universal support in QEMU kicks in, where device mmaps are disabled
> > when an INTx occurs, forcing trapped access to the device, and we
> > assume that the next access is in response to an interrupt and trigger
> > our own internal EOI and re-enable mmaps.  A timer acts as a
> > catch-all.  Needless to say, this is functional but not fast.  It would
> > be a massive performance regression for devices depending on INTx and
> > previously using the KVM bypass to switch to this.  INTx is largely
> > considered a legacy interrupt, so non-x86 archs don't encounter it as
> > often, S390 even explicitly disables INTx support.  ARM and POWER
> > likely just don't see a lot of these devices, but nearly all devices
> > (except SR-IOV VFs) on x86 expect an INTx fallback mode and some
> > drivers may run the device in INTx for compatibility.  This split
> > irqchip change was likely fine for "enterprise" users concerned only
> > with modern high speed devices, but very much not for device assignment
> > used for compatibility use cases or commodity hardware users.
> > 
> > What's a good 4.0.1 strategy to resolve this?  Re-instate KVM irqchip
> > as the Q35 default?  I can't see that simply switching to current QEMU
> > handling is a viable option for performance?  What about 4.1?  We could
> > certainly improve EOI support in QEMU, there's essentially no support
> > currently, but it seems like an uphill battle for an iothread based
> > userspace ioapic to ever compare to KVM handling?  Thanks,  
> 
> irqchip=split and irqchip=kernel aren't guest ABI compatible, are
> they?  That would make it impossible to fix this in pc-q35-4.0
> for a 4.0.1 update.

I suppose it would require a pc-q35-4.0.1 machine type :-\  Thanks,

Alex


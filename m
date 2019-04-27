Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD50C43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 08:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C65A206E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 08:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C65A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKIQE-0004GG-2A
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 04:10:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hKIPO-0003pD-51
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 04:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hKIPM-0000uF-Te
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 04:10:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hKIPM-0000sL-LX
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 04:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DF5F316EB7F
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 08:10:02 +0000 (UTC)
Received: from [10.36.112.15] (unknown [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DCCE7171F6;
	Sat, 27 Apr 2019 08:09:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
	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
	uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
Date: Sat, 27 Apr 2019 10:09:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Sat, 27 Apr 2019 08:10:02 +0000 (UTC)
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427080951.E0B56lc9PX1V0sLC7RpAgfo2pHyW94SzBbpEcITe96M@z>

On 27/04/19 07:29, Paolo Bonzini wrote:
> 
>>> In my testing it looks like KVM advertises supporting the KVM_IRQFD
>>> resample feature, but vfio never gets the unmask notification, so the
>>> device remains with DisINTx set and no further interrupts are
>>> generated.  Do we expect KVM's IRQFD with resampler to work in the
>>> split IRQ mode?  We can certainly hope that "high performance" devices
>>> use MSI or MSI/X, but this would be quite a performance regression with
>>> split mode if our userspace bypass for INTx goes away.  Thanks,
>>
>> arch/x86/kvm/lapic.c:kvm_ioapic_send_eoi() dumps to userspace before
>> kvm_ioapic_update_eoi() can handle the irq_ack_notifier_list via
>> kvm_notify_acked_gsi(),
> 
> That wouldn't help because kvm_ioapic_update_eoi would not even be
> able to access vcpu->kvm->arch.vioapic (it's NULL).
> 
> The following untested patch would signal the resamplefd in kvm_ioapic_send_eoi,
> before requesting the exit to userspace.  However I am not sure how QEMU
> sets up the VFIO eventfds: if I understand correctly, when VFIO writes again to
> the irq eventfd, the interrupt request would not reach the userspace IOAPIC, but
> only the in-kernel LAPIC.  That would be incorrect, and if my understanding is
> correct we need to trigger resampling from hw/intc/ioapic.c.

Actually it's worse: because you're bypassing IOAPIC when raising the
irq, the IOAPIC's remote_irr for example will not be set.  So split
irqchip currently must disable the intx fast path completely.

I guess we could also reimplement irqfd and resamplefd in the userspace
IOAPIC, and run the listener in a separate thread (using "-object
iothread" on the command line and AioContext in the code).

Paolo

> 
> Something like:
> 
> 1) VFIO uses kvm_irqchip_add_irqfd_notifier_gsi instead of KVM_IRQFD directly
> 
> 2) add a NotifierList in kvm_irqchip_assign_irqfd
> 
> 3) if kvm_irqchip_is_split(), register a corresponding Notifier in ioapic.c which
> stores the resamplefd as an EventNotifier*
> 
> 4) ioapic_eoi_broadcast writes to the resamplefd
> 
> BTW, how do non-x86 platforms handle intx resampling?
> 
> Paolo
> 
> ---- 8< -----
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH WIP] kvm: lapic: run ack notifiers for userspace IOAPIC routes
> 
> diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
> index ea1a4e0297da..be337e06e3fd 100644
> --- a/arch/x86/kvm/ioapic.h
> +++ b/arch/x86/kvm/ioapic.h
> @@ -135,4 +135,6 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu,
>  			   ulong *ioapic_handled_vectors);
>  void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
>  			    ulong *ioapic_handled_vectors);
> +void kvm_notify_userspace_ioapic_routes(struct kvm *kvm, int vector);
> +
>  #endif
> diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> index 3cc3b2d130a0..46ea79a0dd8a 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -435,6 +435,34 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
>  	srcu_read_unlock(&kvm->irq_srcu, idx);
>  }
>  
> +void kvm_notify_userspace_ioapic_routes(struct kvm *kvm, int vector)
> +{
> +        struct kvm_kernel_irq_routing_entry *entry;
> +        struct kvm_irq_routing_table *table;
> +        u32 i, nr_ioapic_pins;
> +        int idx;
> +
> +        idx = srcu_read_lock(&kvm->irq_srcu);
> +        table = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
> +        nr_ioapic_pins = min_t(u32, table->nr_rt_entries,
> +                               kvm->arch.nr_reserved_ioapic_pins);
> +
> +	for (i = 0; i < nr_ioapic_pins; i++) {
> +                hlist_for_each_entry(entry, &table->map[i], link) {
> +                        struct kvm_lapic_irq irq;
> +
> +                        if (entry->type != KVM_IRQ_ROUTING_MSI)
> +                                continue;
> +
> +			kvm_set_msi_irq(kvm, entry, &irq);
> +			if (irq.level && irq.vector == vector)
> +				kvm_notify_acked_gsi(kvm, i);
> +		}
> +	}
> +
> +	srcu_read_unlock(&kvm->irq_srcu, idx);
> +}
> +
>  void kvm_arch_irq_routing_update(struct kvm *kvm)
>  {
>  	kvm_hv_irq_routing_update(kvm);
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 9f089e2e09d0..8f8e76d77925 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1142,6 +1142,7 @@ static bool kvm_ioapic_handles_vector(struct kvm_lapic *apic, int vector)
>  
>  static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
>  {
> +	struct kvm_vcpu *vcpu = apic->vcpu;
>  	int trigger_mode;
>  
>  	/* Eoi the ioapic only if the ioapic doesn't own the vector. */
> @@ -1149,9 +1150,10 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
>  		return;
>  
>  	/* Request a KVM exit to inform the userspace IOAPIC. */
> -	if (irqchip_split(apic->vcpu->kvm)) {
> -		apic->vcpu->arch.pending_ioapic_eoi = vector;
> -		kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT, apic->vcpu);
> +	if (irqchip_split(vcpu->kvm)) {
> +		kvm_notify_userspace_ioapic_routes(vcpu->kvm, vector);
> +		vcpu->arch.pending_ioapic_eoi = vector;
> +		kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT, vcpu);
>  		return;
>  	}
>  
> @@ -1160,7 +1162,7 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
>  	else
>  		trigger_mode = IOAPIC_EDGE_TRIG;
>  
> -	kvm_ioapic_update_eoi(apic->vcpu, vector, trigger_mode);
> +	kvm_ioapic_update_eoi(vcpu, vector, trigger_mode);
>  }
>  
>  static int apic_set_eoi(struct kvm_lapic *apic)
> 
> 
>> so it looks like KVM really ought to return an
>> error when trying to register a resample IRQFD when irqchip_split(),
>> but do we have better options?  EOI handling in QEMU is pretty much
>> non-existent and even if it was in place, it's a big performance
>> regression for vfio INTx handling.  Is a split irqchip that retains
>> performant resampling (EOI) support possible?  Thanks,



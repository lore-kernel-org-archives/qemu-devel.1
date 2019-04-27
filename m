Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3EFC43218
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 05:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0B0206A3
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 05:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0B0206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55877 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKFuY-00087Y-Ey
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 01:30:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hKFtj-0007l5-0a
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 01:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hKFth-0004nh-Oq
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 01:29:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hKFth-0004kr-GR
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 01:29:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9058E9517
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 05:29:11 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B01245D717
	for <qemu-devel@nongnu.org>; Sat, 27 Apr 2019 05:29:11 +0000 (UTC)
Received: from zmail18.collab.prod.int.phx2.redhat.com
	(zmail18.collab.prod.int.phx2.redhat.com [10.5.83.21])
	by colo-mx.corp.redhat.com (Postfix) with ESMTP id 852C6181AC42;
	Sat, 27 Apr 2019 05:29:11 +0000 (UTC)
Date: Sat, 27 Apr 2019 01:29:10 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190426150236.1af2ff08@x1.home>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [93.56.166.5, 10.4.196.12, 10.5.100.50, 10.4.195.9]
Thread-Topic: q35: set split kernel irqchip as default
Thread-Index: 8U9aWUPoyFMbg/qZpsQWsONj+NHFjg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Sat, 27 Apr 2019 05:29:11 +0000 (UTC)
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
Message-ID: <20190427052910.XTeK4rDkcoJaUSsIxCGlwmc7FAPeOQ3gk1lSLYRDkGs@z>


> > In my testing it looks like KVM advertises supporting the KVM_IRQFD
> > resample feature, but vfio never gets the unmask notification, so the
> > device remains with DisINTx set and no further interrupts are
> > generated.  Do we expect KVM's IRQFD with resampler to work in the
> > split IRQ mode?  We can certainly hope that "high performance" devices
> > use MSI or MSI/X, but this would be quite a performance regression with
> > split mode if our userspace bypass for INTx goes away.  Thanks,
> 
> arch/x86/kvm/lapic.c:kvm_ioapic_send_eoi() dumps to userspace before
> kvm_ioapic_update_eoi() can handle the irq_ack_notifier_list via
> kvm_notify_acked_gsi(),

That wouldn't help because kvm_ioapic_update_eoi would not even be
able to access vcpu->kvm->arch.vioapic (it's NULL).

The following untested patch would signal the resamplefd in kvm_ioapic_send_eoi,
before requesting the exit to userspace.  However I am not sure how QEMU
sets up the VFIO eventfds: if I understand correctly, when VFIO writes again to
the irq eventfd, the interrupt request would not reach the userspace IOAPIC, but
only the in-kernel LAPIC.  That would be incorrect, and if my understanding is
correct we need to trigger resampling from hw/intc/ioapic.c.

Something like:

1) VFIO uses kvm_irqchip_add_irqfd_notifier_gsi instead of KVM_IRQFD directly

2) add a NotifierList in kvm_irqchip_assign_irqfd

3) if kvm_irqchip_is_split(), register a corresponding Notifier in ioapic.c which
stores the resamplefd as an EventNotifier*

4) ioapic_eoi_broadcast writes to the resamplefd

BTW, how do non-x86 platforms handle intx resampling?

Paolo

---- 8< -----
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH WIP] kvm: lapic: run ack notifiers for userspace IOAPIC routes

diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index ea1a4e0297da..be337e06e3fd 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -135,4 +135,6 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu,
 			   ulong *ioapic_handled_vectors);
 void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
 			    ulong *ioapic_handled_vectors);
+void kvm_notify_userspace_ioapic_routes(struct kvm *kvm, int vector);
+
 #endif
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 3cc3b2d130a0..46ea79a0dd8a 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -435,6 +435,34 @@ void kvm_scan_ioapic_routes(struct kvm_vcpu *vcpu,
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 }
 
+void kvm_notify_userspace_ioapic_routes(struct kvm *kvm, int vector)
+{
+        struct kvm_kernel_irq_routing_entry *entry;
+        struct kvm_irq_routing_table *table;
+        u32 i, nr_ioapic_pins;
+        int idx;
+
+        idx = srcu_read_lock(&kvm->irq_srcu);
+        table = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
+        nr_ioapic_pins = min_t(u32, table->nr_rt_entries,
+                               kvm->arch.nr_reserved_ioapic_pins);
+
+	for (i = 0; i < nr_ioapic_pins; i++) {
+                hlist_for_each_entry(entry, &table->map[i], link) {
+                        struct kvm_lapic_irq irq;
+
+                        if (entry->type != KVM_IRQ_ROUTING_MSI)
+                                continue;
+
+			kvm_set_msi_irq(kvm, entry, &irq);
+			if (irq.level && irq.vector == vector)
+				kvm_notify_acked_gsi(kvm, i);
+		}
+	}
+
+	srcu_read_unlock(&kvm->irq_srcu, idx);
+}
+
 void kvm_arch_irq_routing_update(struct kvm *kvm)
 {
 	kvm_hv_irq_routing_update(kvm);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 9f089e2e09d0..8f8e76d77925 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1142,6 +1142,7 @@ static bool kvm_ioapic_handles_vector(struct kvm_lapic *apic, int vector)
 
 static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
 {
+	struct kvm_vcpu *vcpu = apic->vcpu;
 	int trigger_mode;
 
 	/* Eoi the ioapic only if the ioapic doesn't own the vector. */
@@ -1149,9 +1150,10 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
 		return;
 
 	/* Request a KVM exit to inform the userspace IOAPIC. */
-	if (irqchip_split(apic->vcpu->kvm)) {
-		apic->vcpu->arch.pending_ioapic_eoi = vector;
-		kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT, apic->vcpu);
+	if (irqchip_split(vcpu->kvm)) {
+		kvm_notify_userspace_ioapic_routes(vcpu->kvm, vector);
+		vcpu->arch.pending_ioapic_eoi = vector;
+		kvm_make_request(KVM_REQ_IOAPIC_EOI_EXIT, vcpu);
 		return;
 	}
 
@@ -1160,7 +1162,7 @@ static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
 	else
 		trigger_mode = IOAPIC_EDGE_TRIG;
 
-	kvm_ioapic_update_eoi(apic->vcpu, vector, trigger_mode);
+	kvm_ioapic_update_eoi(vcpu, vector, trigger_mode);
 }
 
 static int apic_set_eoi(struct kvm_lapic *apic)


> so it looks like KVM really ought to return an
> error when trying to register a resample IRQFD when irqchip_split(),
> but do we have better options?  EOI handling in QEMU is pretty much
> non-existent and even if it was in place, it's a big performance
> regression for vfio INTx handling.  Is a split irqchip that retains
> performant resampling (EOI) support possible?  Thanks,


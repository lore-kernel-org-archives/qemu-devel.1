Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A1C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C4020828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C4020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvjj-0002UQ-N3
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37361)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgvgs-0000nv-0r
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgvgp-0005ZV-Ja
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hgvgp-0005X2-7o; Fri, 28 Jun 2019 14:33:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CEA83007E6A;
 Fri, 28 Jun 2019 18:33:28 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9441760920;
 Fri, 28 Jun 2019 18:33:23 +0000 (UTC)
Date: Fri, 28 Jun 2019 15:33:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Like Xu <like.xu@linux.intel.com>
Message-ID: <20190628183321.GE1862@habkost.net>
References: <20190518205428.90532-1-like.xu@linux.intel.com>
 <20190518205428.90532-7-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518205428.90532-7-like.xu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 28 Jun 2019 18:33:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] fixup! hw/s390x: Replace global smp variables
 with machine smp properties
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair23@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 19, 2019 at 04:54:24AM +0800, Like Xu wrote:
> The global smp variables in s390x are replaced with smp machine properties.
> 
> A local variable of the same name would be introduced in the declaration
> phase if it's used widely in the context OR replace it on the spot if it's
> only used once. No semantic changes.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>

I'm applying the following fixup to address s390x build failures
on machine-next.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/s390x/kvm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 0267c6c2f6..6e814c230b 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -119,8 +119,8 @@
  * Needs to be big enough to contain max_cpus emergency signals
  * and in addition NR_LOCAL_IRQS interrupts
  */
-#define VCPU_IRQ_BUF_SIZE (sizeof(struct kvm_s390_irq) * \
-                           (max_cpus + NR_LOCAL_IRQS))
+#define VCPU_IRQ_BUF_SIZE(max_cpus) (sizeof(struct kvm_s390_irq) * \
+                                     (max_cpus + NR_LOCAL_IRQS))
 
 static CPUWatchpoint hw_watchpoint;
 /*
@@ -362,9 +362,10 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
 
 int kvm_arch_init_vcpu(CPUState *cs)
 {
+    unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
     S390CPU *cpu = S390_CPU(cs);
     kvm_s390_set_cpu_state(cpu, cpu->env.cpu_state);
-    cpu->irqstate = g_malloc0(VCPU_IRQ_BUF_SIZE);
+    cpu->irqstate = g_malloc0(VCPU_IRQ_BUF_SIZE(max_cpus));
     return 0;
 }
 
@@ -1950,9 +1951,10 @@ int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
 
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
 {
+    unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
     struct kvm_s390_irq_state irq_state = {
         .buf = (uint64_t) cpu->irqstate,
-        .len = VCPU_IRQ_BUF_SIZE,
+        .len = VCPU_IRQ_BUF_SIZE(max_cpus),
     };
     CPUState *cs = CPU(cpu);
     int32_t bytes;
-- 
2.18.0.rc1.1.g3f1ff2140

-- 
Eduardo


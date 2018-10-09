Received: from eggs.gnu.org ([2001:4830:134:3::10]:48605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9rlI-0002bT-0n
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1g9rlA-0006kV-4z
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:09:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1g9rl9-0006SG-S7
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:09:11 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Date: Tue,  9 Oct 2018 15:08:52 +0200
Message-Id: <20181009130853.6412-2-vkuznets@redhat.com>
In-Reply-To: <20181009130853.6412-1-vkuznets@redhat.com>
References: <20181009130853.6412-1-vkuznets@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] linux-headers: update to pre-4.20
 (kvm/queue)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

This brings us three new defines: KVM_CAP_ARM_INJECT_SERROR_ESR,
KVM_CAP_MSR_PLATFORM_INFO and KVM_CAP_HYPERV_SEND_IPI.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 linux-headers/linux/kvm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 66790724f1..711f5a2c8e 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -951,6 +951,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_HYPERV_TLBFLUSH 155
 #define KVM_CAP_S390_HPAGE_1M 156
 #define KVM_CAP_NESTED_STATE 157
+#define KVM_CAP_ARM_INJECT_SERROR_ESR 158
+#define KVM_CAP_MSR_PLATFORM_INFO 159
+#define KVM_CAP_HYPERV_SEND_IPI 160
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.17.1

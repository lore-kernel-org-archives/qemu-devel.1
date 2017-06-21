Received: from eggs.gnu.org ([2001:4830:134:3::10]:35072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRb-0006ck-OC
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRZ-0004Rw-3n
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:27 -0400
Received: from mail-eopbgr30135.outbound.protection.outlook.com
	([40.107.3.135]:58272
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiRY-0004RY-PP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:25 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:07 +0300
Message-Id: <20170621162424.10462-7-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 06/23] [not to commit] add new
 hyperv-related caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

Add two hyperv-related caps
[they should arrive through the usual kernel header harvesting; this
patch allows to build QEMU before that happens].

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 linux-headers/linux/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index d2892da..d7f532f 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -895,6 +895,8 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_SPAPR_TCE_VFIO 142
 #define KVM_CAP_X86_GUEST_MWAIT 143
 #define KVM_CAP_ARM_USER_IRQ 144
+#define KVM_CAP_HYPERV_SYNIC2 145
+#define KVM_CAP_HYPERV_VP_INDEX 146
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.9.4

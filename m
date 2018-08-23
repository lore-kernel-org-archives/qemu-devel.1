Received: from eggs.gnu.org ([2001:4830:134:3::10]:35455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fskY6-0001vi-8Y
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fskY3-0000r6-U5
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:00:58 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:17672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1fskY3-0000lt-Ip
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:00:55 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Fri, 24 Aug 2018 00:14:46 +0800
Message-Id: <1535040889-52782-2-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1535040889-52782-1-git-send-email-peng.hao2@zte.com.cn>
References: <1535040889-52782-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V3 1/4] target-i386: introduce coalesced_pio
 kvm header update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com, ehabkost@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn, Peng Hao <peng.hao2@zte.com.cn>

add coalesced_pio's struct and KVM_CAP_COALESCED_PIO.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 linux-headers/linux/kvm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 98f389a..747b473 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -420,13 +420,13 @@ struct kvm_run {
 struct kvm_coalesced_mmio_zone {
 	__u64 addr;
 	__u32 size;
-	__u32 pad;
+	__u32 pio;
 };
 
 struct kvm_coalesced_mmio {
 	__u64 phys_addr;
 	__u32 len;
-	__u32 pad;
+	__u32 pio;
 	__u8  data[8];
 };
 
@@ -949,6 +949,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_GET_MSR_FEATURES 153
 #define KVM_CAP_HYPERV_EVENTFD 154
 #define KVM_CAP_HYPERV_TLBFLUSH 155
+#define KVM_CAP_COALESCED_PIO 156
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYN-0003yY-4O
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYM-0001iu-Fy
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0aYM-0001ih-9h
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:53:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D42E4ACCB
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 21:53:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  6 Oct 2017 18:52:41 -0300
Message-Id: <20171006215244.27104-5-ehabkost@redhat.com>
In-Reply-To: <20171006215244.27104-1-ehabkost@redhat.com>
References: <20171006215244.27104-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/7] kvm: Define KVM_FEAT_* even if CONFIG_KVM
 is not defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

This will allow us to avoid #ifdefs in code that use those macros
in target/i386/cpu.c.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm_i386.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 1de9876cd9..8984cb02a1 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -36,6 +36,15 @@
  */
 #define KVM_CPUID_FEATURES       0
 
+#define KVM_FEATURE_CLOCKSOURCE  0
+#define KVM_FEATURE_NOP_IO_DELAY 0
+#define KVM_FEATURE_MMU_OP       0
+#define KVM_FEATURE_CLOCKSOURCE2 0
+#define KVM_FEATURE_ASYNC_PF     0
+#define KVM_FEATURE_STEAL_TIME   0
+#define KVM_FEATURE_PV_EOI       0
+#define KVM_FEATURE_PV_UNHALT    0
+
 #endif  /* CONFIG_KVM */
 
 bool kvm_allows_irq0_override(void);
-- 
2.13.6

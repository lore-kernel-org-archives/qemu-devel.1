Received: from eggs.gnu.org ([2001:4830:134:3::10]:60616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1fZvz4-00074Z-7h
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1fZvyz-0005f4-D9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:23:02 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:39071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1fZvyz-0005eo-6h
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:22:57 -0400
Received: by mail-pl0-x243.google.com with SMTP id s24-v6so7736702plq.6
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 03:22:56 -0700 (PDT)
From: Wanpeng Li <kernellwp@gmail.com>
Date: Mon,  2 Jul 2018 18:22:51 +0800
Message-Id: <1530526971-1812-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target-i386: adds PV_SEND_IPI CPUID feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

From: Wanpeng Li <wanpengli@tencent.com>

Adds PV_SEND_IPI CPUID feature bit.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1e6a7d0..24e425a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -870,7 +870,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
-            NULL, "kvm-pv-tlb-flush", NULL, NULL,
+            NULL, "kvm-pv-tlb-flush", NULL, "kvm-pv-ipi",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.7.4

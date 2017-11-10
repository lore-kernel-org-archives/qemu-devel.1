Received: from eggs.gnu.org ([2001:4830:134:3::10]:42281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eD40i-0004zb-61
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 02:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1eD40f-0004ye-1z
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 02:45:56 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:44100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1eD40e-0004w4-SL
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 02:45:52 -0500
Received: by mail-pg0-x241.google.com with SMTP id j3so6836136pga.1
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 23:45:52 -0800 (PST)
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu,  9 Nov 2017 23:45:47 -0800
Message-Id: <1510299947-11287-1-git-send-email-wanpeng.li@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target-i386: adds PV_TLB_FLUSH CPUID feature
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Wanpeng Li <wanpeng.li@hotmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Wanpeng Li <wanpeng.li@hotmail.com>

Adds PV_TLB_FLUSH CPUID feature bit.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6f21a5e..ecebc5a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -347,7 +347,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             "kvmclock", "kvm-nopiodelay", "kvm-mmu", "kvmclock",
             "kvm-asyncpf", "kvm-steal-time", "kvm-pv-eoi", "kvm-pv-unhalt",
-            NULL, NULL, NULL, NULL,
+            NULL, "kvm-pv-tlb-flush", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.7.4

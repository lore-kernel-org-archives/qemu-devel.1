Received: from eggs.gnu.org ([2001:4830:134:3::10]:34519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6z-0003Qj-E5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6y-0003qU-Od
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6y-0003pw-IQ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:16 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:47 -0300
Message-Id: <20170717185051.18740-12-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 11/15] i386: Update comment about XSAVES on
 Skylake-Client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 71983ef..e702691 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1331,7 +1331,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
             CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX,
         /* Missing: XSAVES (not supported by some Linux versions,
-         * including v4.1 to v4.6).
+         * including v4.1 to v4.12).
          * KVM doesn't yet expose any XSAVES state save component,
          * and the only one defined in Skylake (processor tracing)
          * probably will block migration anyway.
-- 
2.9.4

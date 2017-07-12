Received: from eggs.gnu.org ([2001:4830:134:3::10]:42366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVKNz-00022K-C7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dVKNy-0004KK-Jm
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dVKNy-0004It-Dc
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:21:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 12 Jul 2017 13:20:57 -0300
Message-Id: <20170712162058.10538-4-ehabkost@redhat.com>
In-Reply-To: <20170712162058.10538-1-ehabkost@redhat.com>
References: <20170712162058.10538-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] target/i386: Define CPUID_MODEL_ID_SZ macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>

Document cpu_x86_fill_model_id() and define CPUID_MODEL_ID_SZ to
help callers use the right buffer size.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a667d5d..e2cd157 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1537,6 +1537,17 @@ static bool lmce_supported(void)
     return !!(mce_cap & MCG_LMCE_P);
 }
 
+#define CPUID_MODEL_ID_SZ 48
+
+/**
+ * cpu_x86_fill_model_id:
+ * Get CPUID model ID string from host CPU.
+ *
+ * @str should have at least CPUID_MODEL_ID_SZ bytes
+ *
+ * The function does NOT add a null terminator to the string
+ * automatically.
+ */
 static int cpu_x86_fill_model_id(char *str)
 {
     uint32_t eax = 0, ebx = 0, ecx = 0, edx = 0;
-- 
2.9.4

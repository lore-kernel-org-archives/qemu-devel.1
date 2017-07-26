Received: from eggs.gnu.org ([2001:4830:134:3::10]:59508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRB9-0003xp-TE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1daRB9-0003o6-5n
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:37:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1daRB8-0003nb-Vb
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 14:37:03 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 26 Jul 2017 15:36:45 -0300
Message-Id: <20170726183646.14088-3-ehabkost@redhat.com>
In-Reply-To: <20170726183646.14088-1-ehabkost@redhat.com>
References: <20170726183646.14088-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] target/i386: Define CPUID_MODEL_ID_SZ macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Document cpu_x86_fill_model_id() and define CPUID_MODEL_ID_SZ to
help callers use the right buffer size.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170712162058.10538-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 156dc95..8558c60 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1585,6 +1585,17 @@ static bool lmce_supported(void)
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuV-0005PY-9k
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuT-00006H-Ka
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuT-00005g-FR
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:53 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:30 +0100
Message-Id: <1516203816-19374-19-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 18/24] hppa: cpu: add TARGET_DEFAULT_CPU_TYPE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>

It will be used to drop a bunch of ifdefs *-user/main.c that
set default cpu_model in favor of using type names directly.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <rth@twiddle.net>
---
 target/hppa/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8d14077..04625f7 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -113,6 +113,7 @@ static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 void hppa_translate_init(void);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_HPPA_CPU, cpu_model)
+#define TARGET_DEFAULT_CPU_TYPE TYPE_HPPA_CPU
 
 void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
-- 
2.7.4

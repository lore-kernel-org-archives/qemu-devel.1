Received: from eggs.gnu.org ([2001:4830:134:3::10]:55667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfT-00086v-WE
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1edtfP-0002H9-Gb
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:10:55 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue, 23 Jan 2018 09:08:20 +0100
Message-Id: <1516694904-64879-22-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 21/25] hppa: cpu: add CPU_RESOLVING_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>

it will be used for providing to cpu name resolving class for
parsing cpu model for system and user emulation code.

Along with change add target to null-machine test, so
that when switch to CPU_RESOLVING_TYPE happens,
test would ensure that null-mchine usecase still works.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Richard Henderson <rth@twiddle.net>
---
 target/hppa/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 8d14077..b92ae3f 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -113,6 +113,7 @@ static inline int cpu_mmu_index(CPUHPPAState *env, bool ifetch)
 void hppa_translate_init(void);
 
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_HPPA_CPU, cpu_model)
+#define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
 void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 
-- 
2.7.4

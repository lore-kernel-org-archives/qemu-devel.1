Received: from eggs.gnu.org ([2001:4830:134:3::10]:33526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QA-0004BZ-BQ
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90Q9-0007Ax-9w
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:26 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:46678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90Q9-0007Ag-5h
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:25 -0400
Received: by mail-qk0-x243.google.com with SMTP id k123so14527625qke.3
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 20:07:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 00:05:49 -0300
Message-Id: <20171030030553.21259-2-f4bug@amsat.org>
In-Reply-To: <20171030030553.21259-1-f4bug@amsat.org>
References: <20171030030553.21259-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/5] accel/tcg: add missing target-independent
 stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

missing since 44eff67341:

    LINK    x86_64-softmmu/qemu-system-x86_64
  exec.o: In function `tlb_reset_dirty_range_all':
  exec.c:1070: undefined reference to `tlb_reset_dirty'
  exec.o: In function `tcg_commit':
  exec.c:2704: undefined reference to `cpu_reloading_memory_map'
  cpus.o: In function `tcg_cpu_exec':
  cpus.c:1270: undefined reference to `cpu_exec'
  cpus.o: In function `qemu_tcg_rr_cpu_thread_fn':
  cpus.c:1374: undefined reference to `cpu_exec_step_atomic'
  cpus.o: In function `qemu_tcg_cpu_thread_fn':
  cpus.c:1490: undefined reference to `cpu_exec_step_atomic'
  cpus.o: In function `qemu_tcg_init_vcpu':
  cpus.c:1675: undefined reference to `parallel_cpus'

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 accel/stubs/tcg-stub.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 5dd480b1a2..74ce45ea07 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -17,6 +17,25 @@
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 
+bool parallel_cpus;
+
 void tb_flush(CPUState *cpu)
 {
 }
+
+void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
+{
+}
+
+int cpu_exec(CPUState *cpu)
+{
+    return -1;
+}
+
+void cpu_exec_step_atomic(CPUState *cpu)
+{
+}
+
+void cpu_reloading_memory_map(void)
+{
+}
-- 
2.15.0.rc2

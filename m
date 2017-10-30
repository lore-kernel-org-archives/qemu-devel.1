Received: from eggs.gnu.org ([2001:4830:134:3::10]:33610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QK-0004I4-Ts
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QK-0007LR-2Z
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:36 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:48607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QJ-0007Kw-VM
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:36 -0400
Received: by mail-qt0-x244.google.com with SMTP id f8so14727086qta.5
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 20:07:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 00:05:52 -0300
Message-Id: <20171030030553.21259-5-f4bug@amsat.org>
In-Reply-To: <20171030030553.21259-1-f4bug@amsat.org>
References: <20171030030553.21259-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/5] accel/tcg: add a stub for tcg_region_init()
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

missing since e8feb96fcc:

    LINK    x86_64-softmmu/qemu-system-x86_64
  cpus.o: In function `qemu_tcg_init_vcpu':
  cpus.c:1677: undefined reference to `tcg_region_init'

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 accel/stubs/tcg-stub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 74ce45ea07..842a9cd352 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -39,3 +39,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
 void cpu_reloading_memory_map(void)
 {
 }
+
+void tcg_region_init(void)
+{
+}
-- 
2.15.0.rc2

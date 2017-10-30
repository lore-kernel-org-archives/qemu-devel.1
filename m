Received: from eggs.gnu.org ([2001:4830:134:3::10]:33643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QO-0004Kj-UO
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QO-0007OL-2p
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:40 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:49520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90QN-0007Ne-UW
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:40 -0400
Received: by mail-qk0-x242.google.com with SMTP id q83so14509835qke.6
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 20:07:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 00:05:53 -0300
Message-Id: <20171030030553.21259-6-f4bug@amsat.org>
In-Reply-To: <20171030030553.21259-1-f4bug@amsat.org>
References: <20171030030553.21259-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/5] accel/tcg: add a stub for
 tcg_register_thread()
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

missing since 3468b59e18:

    LINK    x86_64-softmmu/qemu-system-x86_64
  cpus.o: In function `qemu_tcg_rr_cpu_thread_fn':
  cpus.c:1310: undefined reference to `tcg_register_thread'
  cpus.o: In function `qemu_tcg_cpu_thread_fn':
  cpus.c:1458: undefined reference to `tcg_register_thread'

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 accel/stubs/tcg-stub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 842a9cd352..8ec3885594 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -43,3 +43,7 @@ void cpu_reloading_memory_map(void)
 void tcg_region_init(void)
 {
 }
+
+void tcg_register_thread(void)
+{
+}
-- 
2.15.0.rc2

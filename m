Received: from eggs.gnu.org ([2001:4830:134:3::10]:45706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NR-0005m8-30
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NQ-0006Qd-7d
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:45 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55966)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1fQ9NP-0006QC-VH
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:39:44 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 05 Jun 2018 13:39:42 +0300
Message-ID: <152819518295.30857.8519946393746431063.stgit@pasha-ThinkPad-T60>
In-Reply-To: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v2 5/7] plugins: add plugin template
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This is a template of the QEMU plugin. It includes empty functions that
plugins may implement.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 plugins/template/Makefile   |   19 +++++++++++++++++++
 plugins/template/template.c |   19 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 plugins/template/Makefile
 create mode 100644 plugins/template/template.c

diff --git a/plugins/template/Makefile b/plugins/template/Makefile
new file mode 100644
index 0000000..b9d10da
--- /dev/null
+++ b/plugins/template/Makefile
@@ -0,0 +1,19 @@
+CFLAGS += -I../include -fno-PIE -fPIC -O3
+LDFLAGS += -shared
+# TODO: Windows
+DSOSUF := .so
+
+NAME:= template
+BIN := $(NAME)$(DSOSUF)
+
+FILES := template.o
+
+%.o: %.c
+	$(CC) -c -o $@ $< $(CFLAGS)
+
+all: $(FILES)
+	$(CC) $(LDFLAGS) -o $(BIN) $(FILES)
+
+clean:
+	rm $(FILES)
+	rm $(BIN)
diff --git a/plugins/template/template.c b/plugins/template/template.c
new file mode 100644
index 0000000..fed1053
--- /dev/null
+++ b/plugins/template/template.c
@@ -0,0 +1,19 @@
+#include <stdint.h>
+#include <stdio.h>
+#include "plugins.h"
+
+bool plugin_init(const char *args)
+{
+    printf("template plugin loaded successfully\n");
+    return true;
+}
+
+bool plugin_needs_before_insn(uint64_t pc, void *cpu)
+{
+    return true;
+}
+
+void plugin_before_insn(uint64_t pc, void *cpu)
+{
+    printf("executing instruction at %lx\n", pc);
+}

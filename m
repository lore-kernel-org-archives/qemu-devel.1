Received: from eggs.gnu.org ([2001:4830:134:3::10]:43915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fnxi9-0005vS-QU
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fnxi9-0003ZI-1M
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:03:33 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Thu,  9 Aug 2018 23:01:33 -0400
Message-Id: <20180810030139.25916-2-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
References: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 1/7] tests/tcg: add a simple s390x test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com, richard.henderson@linaro.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>

Copied from alpha.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 tests/tcg/s390x/Makefile.target | 3 +++
 tests/tcg/s390x/hello-s390x.c   | 7 +++++++
 2 files changed, 10 insertions(+)
 create mode 100644 tests/tcg/s390x/Makefile.target
 create mode 100644 tests/tcg/s390x/hello-s390x.c

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
new file mode 100644
index 0000000000..9f4076901f
--- /dev/null
+++ b/tests/tcg/s390x/Makefile.target
@@ -0,0 +1,3 @@
+VPATH+=$(SRC_PATH)/tests/tcg/s390x
+CFLAGS+=-march=zEC12 -m64
+TESTS+=hello-s390x
diff --git a/tests/tcg/s390x/hello-s390x.c b/tests/tcg/s390x/hello-s390x.c
new file mode 100644
index 0000000000..3dc0a05f2b
--- /dev/null
+++ b/tests/tcg/s390x/hello-s390x.c
@@ -0,0 +1,7 @@
+#include <unistd.h>
+
+int main(void)
+{
+    write(1, "hello\n", 6);
+    return 0;
+}
-- 
2.18.0
